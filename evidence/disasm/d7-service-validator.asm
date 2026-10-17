0x100279b54  sub                          sp, sp, #0x80
0x100279b58  stp                          x24, x23, [sp, #0x40]
0x100279b5c  stp                          x22, x21, [sp, #0x50]
0x100279b60  stp                          x20, x19, [sp, #0x60]
0x100279b64  stp                          x29, x30, [sp, #0x70]
0x100279b68  add                          x29, sp, #0x70
0x100279b6c  mov                          x22, x3
0x100279b70  mov                          x20, x2
0x100279b74  mov                          x21, x1
0x100279b78  mov                          x19, x0
0x100279b7c  mov                          x0, x1
0x100279b80  mov                          x1, x2
0x100279b84  bl                           #0x1004626ac
0x100279b88  tbz                          w0, #0, #0x100279c9c
0x100279b8c  add                          x24, sp, #0x18
0x100279b90  add                          x0, sp, #0x18
0x100279b94  bl                           #0x10057f6ac
0x100279b98  adrp                         x8, #0x1006b8000
0x100279b9c  ldr                          x8, [x8, #0x358]
0x100279ba0  stp                          x8, x8, [sp, #0x28]
0x100279ba4  add                          x0, sp, #0x18
0x100279ba8  mov                          x1, x21
0x100279bac  mov                          x2, x20
0x100279bb0  bl                           #0x1003190c8
0x100279bb4  tbz                          w0, #0, #0x100279cc4
0x100279bb8  tbz                          w22, #1, #0x100279c20
0x100279bbc  adrp                         x0, #0x100632000
0x100279bc0  add                          x0, x0, #0x436
0x100279bc4  mov                          w1, #7
0x100279bc8  bl                           #0x100582964
0x100279bcc  str                          x0, [sp]
0x100279bd0  sturb                        wzr, [x29, #-0x31]
0x100279bd4  add                          x0, sp, #0x18
0x100279bd8  mov                          x1, sp
0x100279bdc  sub                          x2, x29, #0x31
0x100279be0  bl                           #0x1000134ac
0x100279be4  mov                          x23, x0
0x100279be8  ldr                          x0, [sp]
0x100279bec  ldr                          w8, [x0]
0x100279bf0  cmn                          w8, #1
0x100279bf4  b.eq                         #0x100279c1c
0x100279bf8  cbz                          w8, #0x100279c10
0x100279bfc  mov                          w8, #-1
0x100279c00  ldaddal                      w8, w8, [x0]
0x100279c04  cmp                          w8, #1
0x100279c08  b.ne                         #0x100279c1c
0x100279c0c  ldr                          x0, [sp]
0x100279c10  mov                          w1, #2
0x100279c14  mov                          w2, #8
0x100279c18  bl                           #0x10057f190
0x100279c1c  cbz                          w23, #0x100279d6c
0x100279c20  tbz                          w22, #2, #0x100279cec
0x100279c24  adrp                         x0, #0x100628000
0x100279c28  add                          x0, x0, #0x8d
0x100279c2c  mov                          w1, #8
0x100279c30  bl                           #0x100582964
0x100279c34  str                          x0, [sp]
0x100279c38  sturb                        wzr, [x29, #-0x31]
0x100279c3c  add                          x0, sp, #0x18
0x100279c40  mov                          x1, sp
0x100279c44  sub                          x2, x29, #0x31
0x100279c48  bl                           #0x1000134ac
0x100279c4c  mov                          x23, x0
0x100279c50  ldr                          x0, [sp]
0x100279c54  ldr                          w8, [x0]
0x100279c58  cmn                          w8, #1
0x100279c5c  b.eq                         #0x100279c84
0x100279c60  cbz                          w8, #0x100279c78
0x100279c64  mov                          w8, #-1
0x100279c68  ldaddal                      w8, w8, [x0]
0x100279c6c  cmp                          w8, #1
0x100279c70  b.ne                         #0x100279c84
0x100279c74  ldr                          x0, [sp]
0x100279c78  mov                          w1, #2
0x100279c7c  mov                          w2, #8
0x100279c80  bl                           #0x10057f190
0x100279c84  cbz                          w23, #0x100279cec
0x100279c88  add                          x0, sp, #0x18
0x100279c8c  bl                           #0x10002d8c8
0x100279c90  tbz                          w0, #0, #0x100279cec
0x100279c94  mov                          w20, #-0x2b44
0x100279c98  b                            #0x100279da0
0x100279c9c  adrp                         x0, #0x100625000
0x100279ca0  add                          x0, x0, #0x5a0
0x100279ca4  adrp                         x1, #0x100625000
0x100279ca8  add                          x1, x1, #0x5a1
0x100279cac  adrp                         x3, #0x10063d000
0x100279cb0  add                          x3, x3, #0x9a4
0x100279cb4  mov                          w2, #0
0x100279cb8  bl                           #0x1005756cc
0x100279cbc  mov                          w20, #-0xdeaa
0x100279cc0  b                            #0x100279e10
0x100279cc4  adrp                         x0, #0x100625000
0x100279cc8  add                          x0, x0, #0x5a0
0x100279ccc  adrp                         x1, #0x100625000
0x100279cd0  add                          x1, x1, #0x5a1
0x100279cd4  adrp                         x3, #0x10063d000
0x100279cd8  add                          x3, x3, #0x9cc
0x100279cdc  mov                          w2, #0
0x100279ce0  bl                           #0x1005756cc
0x100279ce4  mov                          w20, #-0xdeab
0x100279ce8  b                            #0x100279da0
0x100279cec  tbz                          w22, #0, #0x100279d3c
0x100279cf0  mov                          x0, sp
0x100279cf4  mov                          x1, x19
0x100279cf8  mov                          w2, #3
0x100279cfc  bl                           #0x10027a494
0x100279d00  adrp                         x8, #0x1006ef000
0x100279d04  ldr                          x1, [x8, #0x6d0]
0x100279d08  mov                          x0, sp
0x100279d0c  mov                          x2, x21
0x100279d10  bl                           #0x100279e74
0x100279d14  adrp                         x8, #0x1006ef000
0x100279d18  ldr                          x1, [x8, #0x6d8]
0x100279d1c  mov                          x0, sp
0x100279d20  mov                          x2, x20
0x100279d24  bl                           #0x100279e74
0x100279d28  mov                          x0, sp
0x100279d2c  bl                           #0x10027a8b4
0x100279d30  tbz                          w0, #0, #0x100279d74
0x100279d34  mov                          x0, sp
0x100279d38  bl                           #0x10027a6f0
0x100279d3c  add                          x0, x19, #0x18
0x100279d40  add                          x1, sp, #0x18
0x100279d44  bl                           #0x10057f6c4
0x100279d48  add                          x0, x19, #0x28
0x100279d4c  add                          x1, x24, #0x10
0x100279d50  bl                           #0x100582b20
0x100279d54  add                          x0, x19, #0x30
0x100279d58  add                          x1, x24, #0x18
0x100279d5c  bl                           #0x100582b20
0x100279d60  mov                          w20, #0
0x100279d64  strb                         wzr, [x19, #0x38]
0x100279d68  b                            #0x100279da0
0x100279d6c  mov                          w20, #-0xdeac
0x100279d70  b                            #0x100279da0
0x100279d74  adrp                         x0, #0x100625000
0x100279d78  add                          x0, x0, #0x5a0
0x100279d7c  adrp                         x1, #0x100625000
0x100279d80  add                          x1, x1, #0x5a1
0x100279d84  adrp                         x3, #0x10063d000
0x100279d88  add                          x3, x3, #0x9e9
0x100279d8c  mov                          w2, #0
0x100279d90  bl                           #0x1005756cc
0x100279d94  mov                          x0, sp
0x100279d98  bl                           #0x10027a6f0
0x100279d9c  mov                          w20, #-0xdea9
0x100279da0  ldr                          x0, [sp, #0x30]
0x100279da4  ldr                          w8, [x0]
0x100279da8  cmn                          w8, #1
0x100279dac  b.eq                         #0x100279dd4
0x100279db0  cbz                          w8, #0x100279dc8
0x100279db4  mov                          w8, #-1
0x100279db8  ldaddal                      w8, w8, [x0]
0x100279dbc  cmp                          w8, #1
0x100279dc0  b.ne                         #0x100279dd4
0x100279dc4  ldr                          x0, [sp, #0x30]
0x100279dc8  mov                          w1, #2
0x100279dcc  mov                          w2, #8
0x100279dd0  bl                           #0x10057f190
0x100279dd4  ldr                          x0, [sp, #0x28]
0x100279dd8  ldr                          w8, [x0]
0x100279ddc  cmn                          w8, #1
0x100279de0  b.eq                         #0x100279e08
0x100279de4  cbz                          w8, #0x100279dfc
0x100279de8  mov                          w8, #-1
0x100279dec  ldaddal                      w8, w8, [x0]
0x100279df0  cmp                          w8, #1
0x100279df4  b.ne                         #0x100279e08
0x100279df8  ldr                          x0, [sp, #0x28]
0x100279dfc  mov                          w1, #2
0x100279e00  mov                          w2, #8
0x100279e04  bl                           #0x10057f190
0x100279e08  add                          x0, sp, #0x18
0x100279e0c  bl                           #0x10057f6b8
0x100279e10  mov                          x0, x20
0x100279e14  ldp                          x29, x30, [sp, #0x70]
0x100279e18  ldp                          x20, x19, [sp, #0x60]
0x100279e1c  ldp                          x22, x21, [sp, #0x50]
0x100279e20  ldp                          x24, x23, [sp, #0x40]
0x100279e24  add                          sp, sp, #0x80
0x100279e28  ret                          
0x100279e2c  bl                           #0x1000094f4
0x100279e30  b                            #0x100279e60
0x100279e34  b                            #0x100279e38
0x100279e38  mov                          x19, x0
0x100279e3c  mov                          x0, sp
0x100279e40  bl                           #0x100009fbc
0x100279e44  b                            #0x100279e64
0x100279e48  mov                          x19, x0
0x100279e4c  mov                          x0, sp
0x100279e50  bl                           #0x10027a6f0
0x100279e54  b                            #0x100279e64
0x100279e58  bl                           #0x1000094f4
0x100279e5c  bl                           #0x1000094f4
0x100279e60  mov                          x19, x0
0x100279e64  add                          x0, sp, #0x18
0x100279e68  bl                           #0x10002e2e8
0x100279e6c  mov                          x0, x19
0x100279e70  bl                           #0x10057f058
0x100279e74  sub                          sp, sp, #0x40
0x100279e78  stp                          x20, x19, [sp, #0x20]
0x100279e7c  stp                          x29, x30, [sp, #0x30]
0x100279e80  add                          x29, sp, #0x30
0x100279e84  mov                          x20, x1
0x100279e88  mov                          x19, x0
0x100279e8c  add                          x0, sp, #0x10
0x100279e90  mov                          x1, x2
0x100279e94  bl                           #0x100582e68
0x100279e98  cbz                          x20, #0x100279eac
0x100279e9c  mov                          x0, x20
0x100279ea0  bl                           #0x1005871f4
0x100279ea4  mov                          x1, x0
0x100279ea8  b                            #0x100279eb0
0x100279eac  mov                          w1, #-1
0x100279eb0  mov                          x0, x20
0x100279eb4  bl                           #0x100582964
0x100279eb8  str                          x0, [sp, #8]
0x100279ebc  add                          x0, x19, #0x10
0x100279ec0  add                          x1, sp, #8
0x100279ec4  bl                           #0x10015dbd4
0x100279ec8  ldr                          x8, [x0]
0x100279ecc  ldr                          w9, [x0, #8]
0x100279ed0  ldr                          w10, [sp, #0x18]
0x100279ed4  ldr                          x11, [sp, #0x10]
0x100279ed8  str                          x11, [x0]
0x100279edc  str                          w10, [x0, #8]
0x100279ee0  str                          x8, [sp, #0x10]
0x100279ee4  str                          w9, [sp, #0x18]
0x100279ee8  ldr                          x0, [sp, #8]
0x100279eec  ldr                          w8, [x0]
0x100279ef0  cmn                          w8, #1
0x100279ef4  b.eq                         #0x100279f1c
0x100279ef8  cbz                          w8, #0x100279f10
0x100279efc  mov                          w8, #-1
0x100279f00  ldaddal                      w8, w8, [x0]
0x100279f04  cmp                          w8, #1
0x100279f08  b.ne                         #0x100279f1c
0x100279f0c  ldr                          x0, [sp, #8]
0x100279f10  mov                          w1, #2
0x100279f14  mov                          w2, #8
0x100279f18  bl                           #0x10057f190
0x100279f1c  add                          x0, sp, #0x10
0x100279f20  bl                           #0x100582ec8
0x100279f24  ldp                          x29, x30, [sp, #0x30]
0x100279f28  ldp                          x20, x19, [sp, #0x20]
0x100279f2c  add                          sp, sp, #0x40
0x100279f30  ret                          
0x100279f34  mov                          x19, x0
0x100279f38  add                          x0, sp, #8
0x100279f3c  bl                           #0x100009fbc
0x100279f40  b                            #0x100279f48
0x100279f44  mov                          x19, x0
0x100279f48  add                          x0, sp, #0x10
0x100279f4c  bl                           #0x100582ec8
0x100279f50  mov                          x0, x19
0x100279f54  bl                           #0x10057f058
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
