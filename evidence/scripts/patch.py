#!/usr/bin/env python3
"""Patch prl_disp_service (Parallels Desktop 27.0.3, arm64) licensing gates.

P1 @ 0x100279b88: NOP the branch that logs "Signature check failed for license info"
                  and returns PRL_ERR_JLIC_SIGNATURE_CHECK_ERROR -> any license
                  signature is accepted.
P2 @ 0x100279b3c: force the public license-state getter to return 0 ("valid") —
                  callers treat 0 as success (verified across 29 call sites).
"""
import os
import shutil
import struct
import sys

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM

SVC = ("/home/ubuntu/reverse/parallels/work/Parallels Desktop 27/Parallels Desktop.app/"
       "Contents/MacOS/Parallels Service.app/Contents/MacOS/prl_disp_service")

P1_VM = 0x100279b88
P2_VM = 0x100279b3c

NOP = b"\x1f\x20\x03\xd5"
MOV_W0_0_RET = b"\x00\x00\x80\x52\xc0\x03\x5f\xd6"  # mov w0, #0 ; ret


def text_segment(data):
    ncmds = struct.unpack("<I", data[16:20])[0]
    off = 32
    for _ in range(ncmds):
        cmd, size = struct.unpack("<II", data[off:off + 8])
        if cmd == 0x19:
            segname = bytes(data[off + 8:off + 24]).rstrip(b"\0")
            vmaddr, vmsize, fileoff, filesize = struct.unpack("<QQQQ", data[off + 24:off + 56])
            if segname == b"__TEXT":
                return vmaddr, fileoff, filesize
        off += size
    raise SystemExit("__TEXT segment not found")


def vm_to_off(vm, text):
    return text[1] + (vm - text[0])


def disasm_one(data, vm, text):
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    fo = vm_to_off(vm, text)
    insn = next(md.disasm(bytes(data[fo:fo + 4]), vm))
    return "%s %s" % (insn.mnemonic, insn.op_str)


def main():
    data = bytearray(open(SVC, "rb").read())
    text = text_segment(data)

    got1 = disasm_one(data, P1_VM, text)
    got2 = disasm_one(data, P2_VM, text)
    print("P1 before: %#x  %s" % (P1_VM, got1))
    print("P2 before: %#x  %s" % (P2_VM, got2))
    if not got1.startswith("tbz w0, #0,"):
        raise SystemExit("P1 site does not match expected tbz")
    if got2 != "ldrb w8, [x0, #0x38]":
        raise SystemExit("P2 site does not match expected ldrb")

    if not os.path.exists(SVC + ".orig"):
        shutil.copyfile(SVC, SVC + ".orig")
        print("backup written:", SVC + ".orig")

    fo1 = vm_to_off(P1_VM, text)
    data[fo1:fo1 + 4] = NOP
    fo2 = vm_to_off(P2_VM, text)
    data[fo2:fo2 + 8] = MOV_W0_0_RET
    with open(SVC, "wb") as fh:
        fh.write(data)

    d2 = open(SVC, "rb").read()
    print("P1 after : %#x  %s" % (P1_VM, disasm_one(d2, P1_VM, text)))
    print("P2 after : %#x  %s | %#x  %s" %
          (P2_VM, disasm_one(d2, P2_VM, text),
           P2_VM + 4, disasm_one(d2, P2_VM + 4, text)))

    import lief
    fb = lief.MachO.parse(SVC)
    ok = fb is not None and len(list(fb)) > 0
    print("lief parse ok:", ok)
    if not ok:
        raise SystemExit("patched file failed to parse")

    import hashlib
    for p in (SVC + ".orig", SVC):
        h = hashlib.sha256(open(p, "rb").read()).hexdigest()
        print("%s  sha256=%s" % (os.path.basename(p), h))


main()
