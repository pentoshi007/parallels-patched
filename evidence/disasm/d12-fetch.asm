0x10027a0b8  sub                          sp, sp, #0x70
0x10027a0bc  stp                          x24, x23, [sp, #0x30]
0x10027a0c0  stp                          x22, x21, [sp, #0x40]
0x10027a0c4  stp                          x20, x19, [sp, #0x50]
0x10027a0c8  stp                          x29, x30, [sp, #0x60]
0x10027a0cc  add                          x29, sp, #0x60
0x10027a0d0  mov                          x21, x1
0x10027a0d4  mov                          x20, x0
0x10027a0d8  mov                          x19, x8
0x10027a0dc  cbz                          x1, #0x10027a0f0
0x10027a0e0  mov                          x0, x21
0x10027a0e4  bl                           #0x1005871f4
0x10027a0e8  mov                          x1, x0
0x10027a0ec  b                            #0x10027a0f4
0x10027a0f0  mov                          w1, #-1
0x10027a0f4  mov                          x0, x21
0x10027a0f8  bl                           #0x100582964
0x10027a0fc  str                          x0, [sp, #0x18]
0x10027a100  mov                          w8, #-0x80000000
0x10027a104  str                          w8, [sp, #0x10]
0x10027a108  str                          xzr, [sp, #8]
0x10027a10c  ldr                          x8, [x20, #0x10]
0x10027a110  ldr                          x21, [x8, #0x10]
0x10027a114  cbz                          x21, #0x10027a158
0x10027a118  mov                          x20, #0
0x10027a11c  mov                          w22, #8
0x10027a120  mov                          w23, #0x10
0x10027a124  add                          x0, x21, #0x18
0x10027a128  add                          x1, sp, #0x18
0x10027a12c  bl                           #0x1005863fc
0x10027a130  cmp                          w0, #0
0x10027a134  csel                         x8, x23, x22, ne
0x10027a138  csel                         x20, x20, x21, ne
0x10027a13c  ldr                          x21, [x21, x8]
0x10027a140  cbnz                         x21, #0x10027a124
0x10027a144  cbz                          x20, #0x10027a158
0x10027a148  add                          x0, sp, #0x18
0x10027a14c  add                          x1, x20, #0x18
0x10027a150  bl                           #0x1005863fc
0x10027a154  cbz                          w0, #0x10027a15c
0x10027a158  mov                          x20, #0
0x10027a15c  add                          x8, x20, #0x20
0x10027a160  add                          x9, sp, #8
0x10027a164  cmp                          x20, #0
0x10027a168  csel                         x1, x9, x8, eq
0x10027a16c  add                          x0, sp, #0x20
0x10027a170  bl                           #0x100582e80
0x10027a174  add                          x0, sp, #0x20
0x10027a178  mov                          x8, x19
0x10027a17c  bl                           #0x100585d48
0x10027a180  add                          x0, sp, #0x20
0x10027a184  bl                           #0x100582ec8
0x10027a188  add                          x0, sp, #8
0x10027a18c  bl                           #0x100582ec8
0x10027a190  ldr                          x0, [sp, #0x18]
0x10027a194  ldr                          w8, [x0]
0x10027a198  cmn                          w8, #1
0x10027a19c  b.eq                         #0x10027a1c4
0x10027a1a0  cbz                          w8, #0x10027a1b8
0x10027a1a4  mov                          w8, #-1
0x10027a1a8  ldaddal                      w8, w8, [x0]
0x10027a1ac  cmp                          w8, #1
0x10027a1b0  b.ne                         #0x10027a1c4
0x10027a1b4  ldr                          x0, [sp, #0x18]
0x10027a1b8  mov                          w1, #2
0x10027a1bc  mov                          w2, #8
0x10027a1c0  bl                           #0x10057f190
0x10027a1c4  ldp                          x29, x30, [sp, #0x60]
0x10027a1c8  ldp                          x20, x19, [sp, #0x50]
0x10027a1cc  ldp                          x22, x21, [sp, #0x40]
0x10027a1d0  ldp                          x24, x23, [sp, #0x30]
0x10027a1d4  add                          sp, sp, #0x70
0x10027a1d8  ret                          
0x10027a1dc  mov                          x19, x0
0x10027a1e0  add                          x0, sp, #0x20
0x10027a1e4  bl                           #0x100582ec8
0x10027a1e8  b                            #0x10027a1f0
0x10027a1ec  mov                          x19, x0
0x10027a1f0  add                          x0, sp, #8
0x10027a1f4  bl                           #0x100582ec8
0x10027a1f8  add                          x0, sp, #0x18
0x10027a1fc  bl                           #0x100009fbc
0x10027a200  mov                          x0, x19
0x10027a204  bl                           #0x10057f058
0x10027a208  sub                          sp, sp, #0x60
0x10027a20c  stp                          x20, x19, [sp, #0x40]
0x10027a210  stp                          x29, x30, [sp, #0x50]
0x10027a214  add                          x29, sp, #0x50
0x10027a218  mov                          x19, x0
0x10027a21c  add                          x0, sp, #0x28
0x10027a220  mov                          x1, x19
0x10027a224  mov                          w2, #3
0x10027a228  bl                           #0x10027a494
0x10027a22c  adrp                         x8, #0x1006ef000
0x10027a230  ldr                          x1, [x8, #0x6d0]
0x10027a234  add                          x0, sp, #0x28
0x10027a238  bl                           #0x10027a358
0x10027a23c  adrp                         x8, #0x1006ef000
0x10027a240  ldr                          x1, [x8, #0x6d8]
0x10027a244  add                          x0, sp, #0x28
0x10027a248  bl                           #0x10027a358
0x10027a24c  add                          x0, sp, #0x28
0x10027a250  bl                           #0x10027a8b4
0x10027a254  tbz                          w0, #0, #0x10027a2fc
0x10027a258  add                          x0, sp, #8
0x10027a25c  bl                           #0x10057f6ac
0x10027a260  ldr                          x8, [sp, #0x10]
0x10027a264  ldr                          q0, [x19, #0x20]
0x10027a268  adrp                         x9, #0x1006b8000
0x10027a26c  ldr                          x9, [x9, #0x358]
0x10027a270  stp                          x8, x9, [x19, #0x20]
0x10027a274  stur                         q0, [sp, #0x10]
0x10027a278  ldr                          x0, [x19, #0x30]
0x10027a27c  str                          x9, [x19, #0x30]
0x10027a280  str                          x0, [sp, #0x20]
0x10027a284  ldr                          w8, [x0]
0x10027a288  cmn                          w8, #1
0x10027a28c  b.eq                         #0x10027a2b4
0x10027a290  cbz                          w8, #0x10027a2a8
0x10027a294  mov                          w8, #-1
0x10027a298  ldaddal                      w8, w8, [x0]
0x10027a29c  cmp                          w8, #1
0x10027a2a0  b.ne                         #0x10027a2b4
0x10027a2a4  ldr                          x0, [sp, #0x20]
0x10027a2a8  mov                          w1, #2
0x10027a2ac  mov                          w2, #8
0x10027a2b0  bl                           #0x10057f190
0x10027a2b4  ldr                          x0, [sp, #0x18]
0x10027a2b8  ldr                          w8, [x0]
0x10027a2bc  cmn                          w8, #1
0x10027a2c0  b.eq                         #0x10027a2e8
0x10027a2c4  cbz                          w8, #0x10027a2dc
