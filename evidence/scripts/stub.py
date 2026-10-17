#!/usr/bin/env python3
"""Resolve Mach-O dyld stub (adrp x16; ldr x16, [x16, #imm]; br x16) -> imported symbol name."""
import sys, struct
import lief


def load(binpath):
    b = lief.MachO.parse(binpath).at(0)
    segs = [(s.virtual_address, s.file_offset, s.file_size) for s in b.segments]
    data = open(binpath, 'rb').read()
    syms = {}
    for bd in b.bindings:
        try:
            if bd.address is not None and bd.symbol is not None:
                syms[bd.address] = bd.symbol.name
        except Exception:
            pass
    return b, segs, data, syms


def foff(segs, vm):
    for va, fo, sz in segs:
        if va <= vm < va + sz:
            return fo + (vm - va)
    return None


def rd(segs, data, vm, n):
    fo = foff(segs, vm)
    return data[fo:fo + n] if fo is not None else b''


def stubname(segs, data, syms, addr):
    if len(rd(segs, data, addr, 8)) < 8:
        return 'out-of-range'
    w0, w1 = struct.unpack('<II', rd(segs, data, addr, 8))
    if (w0 & 0x9f000000) != 0x90000000:
        return 'not-a-stub(%#x)' % w0
    immhi = (w0 >> 5) & 0x7ffff
    immlo = (w0 >> 29) & 3
    page = ((immhi << 2) | immlo) << 12
    val = (addr & ~0xfff) + page
    imm12 = (w1 >> 10) & 0xfff
    slot = val + imm12 * 8
    return syms.get(slot, 'unknown-slot@%#x' % slot)


if __name__ == '__main__':
    b, segs, data, syms = load(sys.argv[1])
    for a in sys.argv[2:]:
        vm = int(a, 16)
        print('%#x %s' % (vm, stubname(segs, data, syms, vm)))
