0x100279f58  sub                          sp, sp, #0x50
0x100279f5c  stp                          x20, x19, [sp, #0x30]
0x100279f60  stp                          x29, x30, [sp, #0x40]
0x100279f64  add                          x29, sp, #0x40
0x100279f68  mov                          x19, x0
0x100279f6c  add                          x0, sp, #0x18
0x100279f70  mov                          x1, x19
0x100279f74  mov                          w2, #1
0x100279f78  bl                           #0x10027a494
0x100279f7c  adrp                         x8, #0x1006ef000
0x100279f80  ldr                          x1, [x8, #0x6d0]
0x100279f84  add                          x8, sp, #0x10
0x100279f88  add                          x0, sp, #0x18
0x100279f8c  bl                           #0x10027a0b8
0x100279f90  adrp                         x8, #0x1006ef000
0x100279f94  ldr                          x1, [x8, #0x6d8]
0x100279f98  add                          x8, sp, #8
0x100279f9c  add                          x0, sp, #0x18
0x100279fa0  bl                           #0x10027a0b8
0x100279fa4  ldr                          x8, [sp, #0x10]
0x100279fa8  ldr                          w8, [x8, #4]
0x100279fac  cbz                          w8, #0x100279fd8
0x100279fb0  ldr                          x8, [sp, #8]
0x100279fb4  ldr                          w8, [x8, #4]
0x100279fb8  cbz                          w8, #0x100279fd8
0x100279fbc  add                          x1, sp, #0x10
0x100279fc0  add                          x2, sp, #8
0x100279fc4  mov                          x0, x19
0x100279fc8  mov                          w3, #0
0x100279fcc  bl                           #0x100279b54
0x100279fd0  mov                          x19, x0
0x100279fd4  b                            #0x100279ffc
0x100279fd8  adrp                         x0, #0x100625000
0x100279fdc  add                          x0, x0, #0x5a0
0x100279fe0  adrp                         x1, #0x100625000
0x100279fe4  add                          x1, x1, #0x5a1
0x100279fe8  adrp                         x3, #0x10063d000
0x100279fec  add                          x3, x3, #0xa05
0x100279ff0  mov                          w2, #0
0x100279ff4  bl                           #0x1005756cc
0x100279ff8  mov                          w19, #-0xdea8
0x100279ffc  ldr                          x0, [sp, #8]
0x10027a000  ldr                          w8, [x0]
0x10027a004  cmn                          w8, #1
0x10027a008  b.eq                         #0x10027a030
0x10027a00c  cbz                          w8, #0x10027a024
0x10027a010  mov                          w8, #-1
0x10027a014  ldaddal                      w8, w8, [x0]
0x10027a018  cmp                          w8, #1
0x10027a01c  b.ne                         #0x10027a030
0x10027a020  ldr                          x0, [sp, #8]
0x10027a024  mov                          w1, #2
0x10027a028  mov                          w2, #8
0x10027a02c  bl                           #0x10057f190
0x10027a030  ldr                          x0, [sp, #0x10]
0x10027a034  ldr                          w8, [x0]
0x10027a038  cmn                          w8, #1
0x10027a03c  b.eq                         #0x10027a064
0x10027a040  cbz                          w8, #0x10027a058
0x10027a044  mov                          w8, #-1
0x10027a048  ldaddal                      w8, w8, [x0]
0x10027a04c  cmp                          w8, #1
0x10027a050  b.ne                         #0x10027a064
0x10027a054  ldr                          x0, [sp, #0x10]
0x10027a058  mov                          w1, #2
0x10027a05c  mov                          w2, #8
0x10027a060  bl                           #0x10057f190
0x10027a064  add                          x0, sp, #0x18
0x10027a068  bl                           #0x10027a6f0
0x10027a06c  mov                          x0, x19
0x10027a070  ldp                          x29, x30, [sp, #0x40]
0x10027a074  ldp                          x20, x19, [sp, #0x30]
0x10027a078  add                          sp, sp, #0x50
0x10027a07c  ret                          
0x10027a080  mov                          x19, x0
0x10027a084  add                          x0, sp, #8
0x10027a088  bl                           #0x100009fbc
0x10027a08c  b                            #0x10027a098
0x10027a090  bl                           #0x1000094f4
0x10027a094  mov                          x19, x0
0x10027a098  add                          x0, sp, #0x10
0x10027a09c  bl                           #0x100009fbc
0x10027a0a0  b                            #0x10027a0a8
0x10027a0a4  mov                          x19, x0
0x10027a0a8  add                          x0, sp, #0x18
0x10027a0ac  bl                           #0x10027a6f0
0x10027a0b0  mov                          x0, x19
0x10027a0b4  bl                           #0x10057f058
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
0x10027a2c8  mov                          w8, #-1
0x10027a2cc  ldaddal                      w8, w8, [x0]
0x10027a2d0  cmp                          w8, #1
0x10027a2d4  b.ne                         #0x10027a2e8
0x10027a2d8  ldr                          x0, [sp, #0x18]
0x10027a2dc  mov                          w1, #2
0x10027a2e0  mov                          w2, #8
0x10027a2e4  bl                           #0x10057f190
0x10027a2e8  add                          x0, sp, #8
0x10027a2ec  bl                           #0x10057f6b8
0x10027a2f0  mov                          w20, #0
0x10027a2f4  strb                         wzr, [x19, #0x38]
0x10027a2f8  b                            #0x10027a320
0x10027a2fc  adrp                         x0, #0x100625000
0x10027a300  add                          x0, x0, #0x5a0
0x10027a304  adrp                         x1, #0x100625000
0x10027a308  add                          x1, x1, #0x5a1
0x10027a30c  adrp                         x3, #0x10063d000
0x10027a310  add                          x3, x3, #0xa1e
0x10027a314  mov                          w2, #0
0x10027a318  bl                           #0x1005756cc
0x10027a31c  mov                          w20, #-0xdea9
0x10027a320  add                          x0, sp, #0x28
0x10027a324  bl                           #0x10027a6f0
0x10027a328  mov                          x0, x20
0x10027a32c  ldp                          x29, x30, [sp, #0x50]
0x10027a330  ldp                          x20, x19, [sp, #0x40]
0x10027a334  add                          sp, sp, #0x60
0x10027a338  ret                          
0x10027a33c  bl                           #0x1000094f4
0x10027a340  b                            #0x10027a344
0x10027a344  mov                          x19, x0
0x10027a348  add                          x0, sp, #0x28
0x10027a34c  bl                           #0x10027a6f0
0x10027a350  mov                          x0, x19
0x10027a354  bl                           #0x10057f058
0x10027a358  sub                          sp, sp, #0x30
0x10027a35c  stp                          x20, x19, [sp, #0x10]
0x10027a360  stp                          x29, x30, [sp, #0x20]
0x10027a364  add                          x29, sp, #0x20
0x10027a368  mov                          x20, x1
0x10027a36c  mov                          x19, x0
0x10027a370  cbz                          x1, #0x10027a384
0x10027a374  mov                          x0, x20
0x10027a378  bl                           #0x1005871f4
0x10027a37c  mov                          x1, x0
0x10027a380  b                            #0x10027a388
0x10027a384  mov                          w1, #-1
0x10027a388  mov                          x0, x20
0x10027a38c  bl                           #0x100582964
0x10027a390  str                          x0, [sp, #8]
0x10027a394  add                          x0, x19, #0x10
0x10027a398  add                          x1, sp, #8
0x10027a39c  bl                           #0x10027a7a8
0x10027a3a0  ldr                          x0, [sp, #8]
0x10027a3a4  ldr                          w8, [x0]
0x10027a3a8  cmn                          w8, #1
0x10027a3ac  b.eq                         #0x10027a3d4
0x10027a3b0  cbz                          w8, #0x10027a3c8
0x10027a3b4  mov                          w8, #-1
0x10027a3b8  ldaddal                      w8, w8, [x0]
0x10027a3bc  cmp                          w8, #1
0x10027a3c0  b.ne                         #0x10027a3d4
0x10027a3c4  ldr                          x0, [sp, #8]
0x10027a3c8  mov                          w1, #2
0x10027a3cc  mov                          w2, #8
0x10027a3d0  bl                           #0x10057f190
0x10027a3d4  ldp                          x29, x30, [sp, #0x20]
0x10027a3d8  ldp                          x20, x19, [sp, #0x10]
0x10027a3dc  add                          sp, sp, #0x30
0x10027a3e0  ret                          
0x10027a3e4  mov                          x19, x0
0x10027a3e8  add                          x0, sp, #8
0x10027a3ec  bl                           #0x100009fbc
0x10027a3f0  mov                          x0, x19
0x10027a3f4  bl                           #0x10057f058
0x10027a3f8  sub                          sp, sp, #0x40
0x10027a3fc  stp                          x20, x19, [sp, #0x20]
0x10027a400  stp                          x29, x30, [sp, #0x30]
0x10027a404  add                          x29, sp, #0x30
0x10027a408  mov                          x1, x0
0x10027a40c  add                          x0, sp, #8
0x10027a410  mov                          w2, #3
0x10027a414  bl                           #0x10027a494
0x10027a418  adrp                         x8, #0x1006ef000
0x10027a41c  ldr                          x1, [x8, #0x6e0]
0x10027a420  add                          x0, sp, #8
0x10027a424  bl                           #0x10027a358
0x10027a428  add                          x0, sp, #8
0x10027a42c  bl                           #0x10027a8b4
0x10027a430  tbz                          w0, #0, #0x10027a43c
0x10027a434  mov                          w19, #0
0x10027a438  b                            #0x10027a460
0x10027a43c  adrp                         x0, #0x100625000
0x10027a440  add                          x0, x0, #0x5a0
0x10027a444  adrp                         x1, #0x100625000
