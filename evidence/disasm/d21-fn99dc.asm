0x1003199dc  sub                          sp, sp, #0x50
0x1003199e0  stp                          x20, x19, [sp, #0x30]
0x1003199e4  stp                          x29, x30, [sp, #0x40]
0x1003199e8  add                          x29, sp, #0x40
0x1003199ec  mov                          x19, x0
0x1003199f0  adrp                         x0, #0x100642000
0x1003199f4  add                          x0, x0, #0x363
0x1003199f8  mov                          w1, #0xf
0x1003199fc  bl                           #0x100582964
0x100319a00  str                          x0, [sp, #0x18]
0x100319a04  adrp                         x8, #0x1006b8000
0x100319a08  ldr                          x8, [x8, #0x358]
0x100319a0c  str                          x8, [sp, #0x10]
0x100319a10  add                          x8, sp, #0x20
0x100319a14  add                          x1, sp, #0x18
0x100319a18  add                          x2, sp, #0x10
0x100319a1c  mov                          x0, x19
0x100319a20  bl                           #0x1000c32e4
0x100319a24  sub                          x8, x29, #0x18
0x100319a28  add                          x0, sp, #0x20
0x100319a2c  bl                           #0x100582940
0x100319a30  ldr                          x0, [sp, #0x20]
0x100319a34  ldr                          w8, [x0]
0x100319a38  cmn                          w8, #1
0x100319a3c  b.eq                         #0x100319a64
0x100319a40  cbz                          w8, #0x100319a58
0x100319a44  mov                          w8, #-1
0x100319a48  ldaddal                      w8, w8, [x0]
0x100319a4c  cmp                          w8, #1
0x100319a50  b.ne                         #0x100319a64
0x100319a54  ldr                          x0, [sp, #0x20]
0x100319a58  mov                          w1, #2
0x100319a5c  mov                          w2, #8
0x100319a60  bl                           #0x10057f190
0x100319a64  ldr                          x0, [sp, #0x10]
0x100319a68  ldr                          w8, [x0]
0x100319a6c  cmn                          w8, #1
0x100319a70  b.eq                         #0x100319a98
0x100319a74  cbz                          w8, #0x100319a8c
0x100319a78  mov                          w8, #-1
0x100319a7c  ldaddal                      w8, w8, [x0]
0x100319a80  cmp                          w8, #1
0x100319a84  b.ne                         #0x100319a98
0x100319a88  ldr                          x0, [sp, #0x10]
0x100319a8c  mov                          w1, #2
0x100319a90  mov                          w2, #8
0x100319a94  bl                           #0x10057f190
0x100319a98  ldr                          x0, [sp, #0x18]
0x100319a9c  ldr                          w8, [x0]
0x100319aa0  cmn                          w8, #1
0x100319aa4  b.eq                         #0x100319acc
0x100319aa8  cbz                          w8, #0x100319ac0
0x100319aac  mov                          w8, #-1
0x100319ab0  ldaddal                      w8, w8, [x0]
0x100319ab4  cmp                          w8, #1
0x100319ab8  b.ne                         #0x100319acc
0x100319abc  ldr                          x0, [sp, #0x18]
0x100319ac0  mov                          w1, #2
0x100319ac4  mov                          w2, #8
0x100319ac8  bl                           #0x10057f190
0x100319acc  ldur                         x8, [x29, #-0x18]
0x100319ad0  ldr                          x9, [x8, #0x10]
0x100319ad4  ldr                          w1, [x8, #4]
0x100319ad8  adrp                         x2, #0x100633000
0x100319adc  add                          x2, x2, #0x643
0x100319ae0  add                          x0, x8, x9
0x100319ae4  mov                          w3, #-1
0x100319ae8  mov                          w4, #1
0x100319aec  bl                           #0x1005828f8
0x100319af0  cbz                          w0, #0x100319be0
0x100319af4  adrp                         x0, #0x100642000
0x100319af8  add                          x0, x0, #0x373
0x100319afc  mov                          w1, #8
0x100319b00  bl                           #0x100582964
0x100319b04  str                          x0, [sp, #0x18]
0x100319b08  add                          x0, sp, #0x20
0x100319b0c  add                          x1, sp, #0x18
0x100319b10  mov                          x2, #0
0x100319b14  bl                           #0x1005815a8
0x100319b18  ldr                          x0, [sp, #0x18]
0x100319b1c  ldr                          w8, [x0]
0x100319b20  cmn                          w8, #1
0x100319b24  b.eq                         #0x100319b4c
0x100319b28  cbz                          w8, #0x100319b40
0x100319b2c  mov                          w8, #-1
