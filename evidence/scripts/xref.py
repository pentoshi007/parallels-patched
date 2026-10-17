#!/usr/bin/env python3
"""Mach-O xref finder + disassembler for arm64 / x86_64 slices.

Usage:
  xref.py find <binary> <arm64|x86_64> <specfile>
      specfile lines: "<file_offset_hex> <label>"  (offsets from `strings -t x`)
      prints: label, target vmaddr, and matching instruction sites (vmaddr, text)
  xref.py disasm <binary> <arm64|x86_64> <start_vmaddr_hex> <end_vmaddr_hex>
  xref.py slices <binary>
"""
import sys, struct
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM, CS_ARCH_X86, CS_MODE_64

CPU = {12: 'arm', 16777228: 'arm64', 7: 'x86', 16777223: 'x86_64'}
IMAGEBASE = 0x100000000


def parse_slices(data):
    magic = data[:4]
    if magic in (b'\xca\xfe\xba\xbe', b'\xca\xfe\xba\xbf'):
        fat64 = magic == b'\xca\xfe\xba\xbf'
        n = struct.unpack('>I', data[4:8])[0]
        out, off = [], 8
        for _ in range(n):
            cpuC, sub, o, sz = struct.unpack('>iiII', data[off:off + 16])
            out.append({'cpu': cpuC, 'base': o, 'size': sz})
            off += 32 if fat64 else 20
        return out
    if magic in (b'\xcf\xfa\xed\xfe', b'\xfe\xed\xfa\xcf'):
        cpuC = struct.unpack('<i' if magic[0] == 0xcf else '>i', data[4:8])[0]
        return [{'cpu': cpuC, 'base': 0, 'size': len(data)}]
    raise ValueError('not macho: ' + repr(magic))


def slice_segments(data, base):
    magic = data[base:base + 4]
    if magic not in (b'\xcf\xfa\xed\xfe', b'\xfe\xed\xfa\xcf'):
        raise ValueError('slice not thin64')
    le = magic[0] == 0xcf
    e = '<' if le else '>'
    (ncmds,) = struct.unpack(e + 'I', data[base + 16:base + 20])
    off = base + 32
    segs = []
    for _ in range(ncmds):
        cmd, cmdsize = struct.unpack(e + 'II', data[off:off + 8])
        if cmd == 0x19:
            segname = data[off + 8:off + 24].rstrip(b'\0').decode()
            vmaddr, vmsize, fileoff, filesize = struct.unpack(e + 'QQQQ', data[off + 24:off + 56])
            nsects = struct.unpack(e + 'I', data[off + 64:off + 68])[0]
            sects = []
            so = off + 72
            for _s in range(nsects):
                sname = data[so:so + 16].rstrip(b'\0').decode()
                saddr, ssize, soff = struct.unpack(e + 'QQI', data[so + 32:so + 52])
                sflags = struct.unpack(e + 'I', data[so + 64:so + 68])[0]
                sects.append({'name': sname, 'addr': saddr, 'size': ssize,
                              'off': soff, 'flags': sflags})
                so += 80
            segs.append({'name': segname, 'vmaddr': vmaddr, 'vmsize': vmsize,
                         'fileoff': fileoff, 'filesize': filesize, 'sects': sects})
        off += cmdsize
    return segs


def find_seg(segs, foff):
    for s in segs:
        if s['fileoff'] <= foff < s['fileoff'] + s['filesize']:
            return s
    raise ValueError('file offset %#x not in any segment' % foff)


def foff_to_vm(segs, foff):
    s = find_seg(segs, foff)
    return s['vmaddr'] + (foff - s['fileoff'])


def vm_to_foff(segs, vm):
    for s in segs:
        if s['vmaddr'] <= vm < s['vmaddr'] + s['vmsize']:
            return s['fileoff'] + (vm - s['vmaddr'])
    raise ValueError('vm %#x not in any segment' % vm)


def read_ptr(data, segs, vm):
    fo = vm_to_foff(segs, vm)
    return struct.unpack('<Q', data[fo:fo + 8])[0]


def pick_slice(data, want):
    slices = parse_slices(data)
    key = {'arm64': 16777228, 'x86_64': 16777223}.get(want)
    for s in slices:
        if s['cpu'] == key:
            return s
    raise SystemExit('cpu %s not present; slices: %s' % (want, [CPU.get(s['cpu'], s['cpu']) for s in slices]))


def code_sections(segs):
    out = []
    for s in segs:
        for sec in s['sects']:
            if sec['name'] == '__text' and s['name'] == '__TEXT':
                out.append((s, sec))
    return out


def find_arm64(data, segs, targets):
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail = True
    found = {t: [] for t in targets}
    for seg, sec in code_sections(segs):
        code = data[sec['off']:sec['off'] + sec['size']]
        page = {}
        for insn in md.disasm(code, sec['addr']):
            ops = insn.operands
            if insn.id == 0:  # ARM64_INS_ADRP
                pass
            if len(ops) == 2 and insn.mnemonic == 'adrp':
                page[ops[0].reg] = ops[1].imm & ~0xfff
            elif len(ops) == 3 and insn.mnemonic == 'add':
                o0, o1, o2 = ops
                if o1.type == 1 and o1.reg in page and o2.type == 2:
                    a = page[o1.reg] + o2.imm
                    if a in found:
                        found[a].append((insn.address, insn.mnemonic + ' ' + insn.op_str))
            elif len(ops) == 2 and insn.mnemonic in ('ldr', 'ldrb', 'ldrh'):
                o0, o1 = ops
                if o1.type == 3 and o1.mem.base in page:
                    a = page[o1.mem.base] + o1.mem.disp
                    if 0 < a:
                        try:
                            pv = read_ptr(data, segs, a)
                        except Exception:
                            pv = 0
                        if pv in found:
                            found[pv].append((insn.address, insn.mnemonic + ' ' + insn.op_str + '  ; -> ' + hex(pv)))
            elif len(ops) == 2 and insn.mnemonic == 'adr':
                a = ops[1].imm
                if a in found:
                    found[a].append((insn.address, insn.mnemonic + ' ' + insn.op_str))
    return found


def find_x86_64(data, segs, targets):
    md = Cs(CS_ARCH_X86, CS_MODE_64)
    md.detail = True
    found = {t: [] for t in targets}
    RIP = 41
    for seg, sec in code_sections(segs):
        code = data[sec['off']:sec['off'] + sec['size']]
        for insn in md.disasm(code, sec['addr']):
            for op in insn.operands:
                if op.type == 3 and op.mem.base == RIP:
                    a = insn.address + insn.size + op.mem.disp
                    if a in found:
                        found[a].append((insn.address, insn.mnemonic + ' ' + insn.op_str))
    return found


def cmd_find(binpath, arch, specfile):
    data = open(binpath, 'rb').read()
    sl = pick_slice(data, arch)
    segs = slice_segments(data, sl['base'])
    targets = {}
    for line in open(specfile):
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        offs, label = line.split(None, 1)
        foff = int(offs, 16)
        rel = foff - sl['base']
        if not (0 <= rel < sl['size']):
            print('%-40s SKIP (outside slice): file_off=%#x' % (label, foff))
            continue
        vm = foff_to_vm(segs, rel)
        targets[vm] = label
    fn = find_arm64 if arch == 'arm64' else find_x86_64
    found = fn(data, segs, targets)
    for vm, label in targets.items():
        print('%-40s vm=%#x  xrefs=%d' % (label, vm, len(found[vm])))
        for addr, txt in found[vm][:12]:
            print('    %#x  %s' % (addr, txt))


def cmd_disasm(binpath, arch, start, end):
    data = open(binpath, 'rb').read()
    sl = pick_slice(data, arch)
    segs = slice_segments(data, sl['base'])
    fo = vm_to_foff(segs, start) + sl['base']
    sz = end - start
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM) if arch == 'arm64' else Cs(CS_ARCH_X86, CS_MODE_64)
    for insn in md.disasm(data[fo:fo + sz], start):
        print('%#x  %-28s %s' % (insn.address, insn.mnemonic, insn.op_str))


def cmd_slices(binpath):
    data = open(binpath, 'rb').read()
    for s in parse_slices(data):
        print('%-8s base=%#x size=%#x' % (CPU.get(s['cpu'], s['cpu']), s['base'], s['size']))


def cmd_callers(binpath, arch, addr):
    data = open(binpath, 'rb').read()
    sl = pick_slice(data, arch)
    segs = slice_segments(data, sl['base'])
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM) if arch == 'arm64' else Cs(CS_ARCH_X86, CS_MODE_64)
    md.detail = True
    hits = []
    for seg, sec in code_sections(segs):
        code = data[sec['off']:sec['off'] + sec['size']]
        for insn in md.disasm(code, sec['addr']):
            if arch == 'arm64' and insn.mnemonic in ('bl', 'b') and insn.operands and \
                    insn.operands[0].type == 2 and insn.operands[0].imm == addr:
                hits.append((insn.address, insn.mnemonic))
            elif arch == 'x86_64' and insn.mnemonic == 'call' and insn.operands and \
                    insn.operands[0].type == 2 and insn.operands[0].imm == addr:
                hits.append((insn.address, insn.mnemonic))
    print('%d callers of %#x' % (len(hits), addr))
    for a, m in hits[:40]:
        print('   %#x %s' % (a, m))


def cmd_funcat(binpath, addr):
    import lief
    b = lief.MachO.parse(binpath)
    for bind in b:
        fs = getattr(bind, 'function_starts', None)
        if fs is None:
            continue
        funcs = []
        for f in fs.functions:
            a = f if isinstance(f, int) else getattr(f, 'address', None)
            if a is not None:
                funcs.append(int(a))
        funcs.sort()
        if not funcs:
            continue
        tfo = tva = None
        for s in bind.segments:
            if s.name == '__TEXT':
                tfo, tva = s.file_offset, s.virtual_address
        if tfo is None:
            continue
        vm_funcs = [f - tfo + tva for f in funcs]
        prev = [a for a in vm_funcs if a <= addr]
        if prev:
            nxt = [a for a in vm_funcs if a > addr]
            print('cpu=%s func_start=%#x next=%#x starts_total=%d' %
                  (bind.header.cpu_type, prev[-1], nxt[0] if nxt else 0, len(funcs)))
            break


def main():
    cmd = sys.argv[1]
    if cmd == 'find':
        cmd_find(sys.argv[2], sys.argv[3], sys.argv[4])
    elif cmd == 'disasm':
        cmd_disasm(sys.argv[2], sys.argv[3], int(sys.argv[4], 16), int(sys.argv[5], 16))
    elif cmd == 'callers':
        cmd_callers(sys.argv[2], sys.argv[3], int(sys.argv[4], 16))
    elif cmd == 'funcat':
        cmd_funcat(sys.argv[2], int(sys.argv[3], 16))
    elif cmd == 'slices':
        cmd_slices(sys.argv[2])
    else:
        raise SystemExit(__doc__)


main()
