0x100037d40  stp                          x20, x19, [sp, #0x10]
0x100037d44  stp                          x29, x30, [sp, #0x20]
0x100037d48  add                          x29, sp, #0x20
0x100037d4c  adrp                         x8, #0x100722000
0x100037d50  add                          x8, x8, #0x5c8
0x100037d54  ldr                          x0, [x8]
0x100037d58  bl                           #0x1000248c4
0x100037d5c  mov                          x8, sp
0x100037d60  bl                           #0x10001f620
0x100037d64  ldr                          x8, [sp]
0x100037d68  ldr                          x0, [x8, #8]
0x100037d6c  bl                           #0x100585028
0x100037d70  bl                           #0x100585358
0x100037d74  ldr                          x19, [sp, #8]
0x100037d78  cbz                          x19, #0x100037d8c
0x100037d7c  add                          x8, x19, #8
0x100037d80  mov                          x9, #-1
0x100037d84  ldaddal                      x9, x8, [x8]
0x100037d88  cbz                          x8, #0x100037da4
0x100037d8c  tbnz                         w0, #0, #0x100037d94
0x100037d90  bl                           #0x10020c3fc
0x100037d94  ldp                          x29, x30, [sp, #0x20]
0x100037d98  ldp                          x20, x19, [sp, #0x10]
0x100037d9c  add                          sp, sp, #0x30
0x100037da0  ret                          
0x100037da4  ldr                          x8, [x19]
0x100037da8  ldr                          x8, [x8, #0x10]
0x100037dac  mov                          x20, x0
0x100037db0  mov                          x0, x19
0x100037db4  blr                          x8
0x100037db8  mov                          x0, x19
0x100037dbc  bl                           #0x100586330
0x100037dc0  mov                          x0, x20
0x100037dc4  tbz                          w0, #0, #0x100037d90
0x100037dc8  b                            #0x100037d94
0x100037dcc  mov                          x19, x0
0x100037dd0  mov                          x0, sp
0x100037dd4  bl                           #0x10001cb58
0x100037dd8  mov                          x0, x19
0x100037ddc  bl                           #0x10057f058
0x100037de0  sub                          sp, sp, #0x1d0
0x100037de4  stp                          x26, x25, [sp, #0x180]
0x100037de8  stp                          x24, x23, [sp, #0x190]
0x100037dec  stp                          x22, x21, [sp, #0x1a0]
0x100037df0  stp                          x20, x19, [sp, #0x1b0]
0x100037df4  stp                          x29, x30, [sp, #0x1c0]
0x100037df8  add                          x29, sp, #0x1c0
0x100037dfc  mov                          x19, x2
0x100037e00  mov                          x20, x1
0x100037e04  ldr                          x8, [x2]
0x100037e08  ldr                          w1, [x8, #0x50]
0x100037e0c  add                          x23, sp, #0xd8
0x100037e10  add                          x0, sp, #0xd8
0x100037e14  mov                          w2, #0
0x100037e18  bl                           #0x10046c1cc
0x100037e1c  adrp                         x8, #0x1006b9000
0x100037e20  add                          x8, x8, #0x608
0x100037e24  add                          x9, x8, #0xb0
0x100037e28  str                          x8, [sp, #0xd8]
0x100037e2c  str                          x9, [sp, #0x168]
0x100037e30  add                          x0, sp, #0xd8
0x100037e34  mov                          x1, x19
0x100037e38  bl                           #0x10003eb30
0x100037e3c  add                          x0, sp, #0xd8
0x100037e40  bl                           #0x10046d1cc
0x100037e44  tbz                          w0, #0, #0x100037f20
0x100037e48  add                          x0, sp, #0xd8
0x100037e4c  bl                           #0x10046c374
0x100037e50  mov                          x21, x0
0x100037e54  add                          x8, sp, #0xc0
0x100037e58  add                          x0, sp, #0xd8
0x100037e5c  bl                           #0x10046d224
0x100037e60  str                          x21, [sp]
0x100037e64  adrp                         x0, #0x100625000
0x100037e68  add                          x0, x0, #0x5a0
0x100037e6c  adrp                         x1, #0x100625000
0x100037e70  add                          x1, x1, #0x5a1
0x100037e74  adrp                         x3, #0x100628000
0x100037e78  add                          x3, x3, #0x115
0x100037e7c  mov                          w2, #0
0x100037e80  bl                           #0x1005756cc
0x100037e84  bl                           #0x10039956c
0x100037e88  cmp                          w0, #2
0x100037e8c  b.ne                         #0x100037f68
0x100037e90  add                          x8, sp, #0x78
0x100037e94  bl                           #0x100399470
0x100037e98  ldr                          x0, [sp, #0x78]
0x100037e9c  ldr                          w22, [x0, #4]
0x100037ea0  ldr                          w8, [x0]
0x100037ea4  cmn                          w8, #1
0x100037ea8  b.eq                         #0x100037ed0
0x100037eac  cbz                          w8, #0x100037ec4
0x100037eb0  mov                          w8, #-1
0x100037eb4  ldaddal                      w8, w8, [x0]
0x100037eb8  cmp                          w8, #1
0x100037ebc  b.ne                         #0x100037ed0
0x100037ec0  ldr                          x0, [sp, #0x78]
0x100037ec4  mov                          w1, #2
0x100037ec8  mov                          w2, #8
0x100037ecc  bl                           #0x10057f190
0x100037ed0  tst                          w21, #0x800
0x100037ed4  cset                         w24, eq
0x100037ed8  tbnz                         w21, #0xb, #0x100037fc8
0x100037edc  cbz                          w22, #0x100037fc8
0x100037ee0  adrp                         x0, #0x100625000
0x100037ee4  add                          x0, x0, #0x5a0
0x100037ee8  adrp                         x1, #0x100625000
0x100037eec  add                          x1, x1, #0x5a1
0x100037ef0  adrp                         x3, #0x100628000
0x100037ef4  add                          x3, x3, #0x140
0x100037ef8  mov                          w2, #0
0x100037efc  bl                           #0x1005756cc
0x100037f00  ldr                          x0, [x20]
0x100037f04  add                          x8, sp, #0xb0
0x100037f08  mov                          x1, x19
0x100037f0c  mov                          w2, #-0x2b4b
0x100037f10  bl                           #0x1000156d0
0x100037f14  ldr                          x19, [sp, #0xb8]
0x100037f18  cbnz                         x19, #0x100038308
0x100037f1c  b                            #0x100038330
0x100037f20  ldr                          x0, [x20]
0x100037f24  add                          x8, sp, #0xc8
0x100037f28  mov                          x1, x19
0x100037f2c  mov                          w2, #-9
0x100037f30  bl                           #0x1000156d0
0x100037f34  ldr                          x19, [sp, #0xd0]
0x100037f38  cbz                          x19, #0x100038364
0x100037f3c  add                          x8, x19, #8
0x100037f40  mov                          x9, #-1
0x100037f44  ldaddal                      x9, x8, [x8]
0x100037f48  cbnz                         x8, #0x100038364
0x100037f4c  ldr                          x8, [x19]
0x100037f50  ldr                          x8, [x8, #0x10]
0x100037f54  mov                          x0, x19
0x100037f58  blr                          x8
0x100037f5c  mov                          x0, x19
0x100037f60  bl                           #0x100586330
0x100037f64  b                            #0x100038364
0x100037f68  tbnz                         w21, #0xb, #0x100037fc4
0x100037f6c  mov                          w24, #1
0x100037f70  cmp                          w0, #1
0x100037f74  b.ne                         #0x100037fc8
0x100037f78  and                          w8, w21, #0x1fff8000
0x100037f7c  and                          w8, w8, #0xf000ffff
0x100037f80  cbnz                         w8, #0x100037fc8
0x100037f84  adrp                         x0, #0x100625000
0x100037f88  add                          x0, x0, #0x5a0
0x100037f8c  adrp                         x1, #0x100625000
0x100037f90  add                          x1, x1, #0x5a1
0x100037f94  adrp                         x3, #0x100628000
0x100037f98  add                          x3, x3, #0x181
0x100037f9c  mov                          w2, #0
0x100037fa0  bl                           #0x1005756cc
0x100037fa4  ldr                          x0, [x20]
0x100037fa8  add                          x8, sp, #0xa0
0x100037fac  mov                          x1, x19
0x100037fb0  mov                          w2, #-0x2b4c
0x100037fb4  bl                           #0x1000156d0
0x100037fb8  ldr                          x19, [sp, #0xa8]
0x100037fbc  cbnz                         x19, #0x100038308
0x100037fc0  b                            #0x100038330
0x100037fc4  mov                          w24, #0
0x100037fc8  tbnz                         w21, #0x16, #0x1000380a0
0x100037fcc  tbz                          w21, #0x1a, #0x10003821c
0x100037fd0  adrp                         x8, #0x100722000
0x100037fd4  add                          x8, x8, #0x5c8
0x100037fd8  ldr                          x0, [x8]
0x100037fdc  add                          x8, sp, #0x78
0x100037fe0  bl                           #0x100025788
0x100037fe4  ldr                          x8, [sp, #0x78]
0x100037fe8  ldr                          x0, [x8, #8]
0x100037fec  add                          x8, sp, #0x58
0x100037ff0  bl                           #0x1000c2c24
0x100037ff4  ldr                          x0, [sp, #0xc0]
0x100037ff8  ldr                          x8, [sp, #0x58]
0x100037ffc  str                          x8, [sp, #0xc0]
0x100038000  str                          x0, [sp, #0x58]
0x100038004  ldr                          w8, [x0]
0x100038008  cmn                          w8, #1
0x10003800c  b.eq                         #0x100038034
0x100038010  cbz                          w8, #0x100038028
0x100038014  mov                          w8, #-1
0x100038018  ldaddal                      w8, w8, [x0]
0x10003801c  cmp                          w8, #1
0x100038020  b.ne                         #0x100038034
0x100038024  ldr                          x0, [sp, #0x58]
0x100038028  mov                          w1, #2
0x10003802c  mov                          w2, #8
0x100038030  bl                           #0x10057f190
0x100038034  ldr                          x8, [sp, #0xc0]
0x100038038  ldr                          w25, [x8, #4]
0x10003803c  cbz                          w25, #0x1000381a4
0x100038040  ldr                          x8, [sp, #0x78]
0x100038044  ldr                          x22, [x8, #8]
0x100038048  adrp                         x0, #0x100625000
0x10003804c  add                          x0, x0, #0x5a0
0x100038050  mov                          w1, #0
0x100038054  bl                           #0x100582964
0x100038058  str                          x0, [sp, #0x58]
0x10003805c  add                          x1, sp, #0x58
0x100038060  mov                          x0, x22
0x100038064  bl                           #0x1000c2c48
0x100038068  ldr                          x0, [sp, #0x58]
0x10003806c  ldr                          w8, [x0]
0x100038070  cmn                          w8, #1
0x100038074  b.eq                         #0x1000381e8
0x100038078  cbz                          w8, #0x100038090
0x10003807c  mov                          w8, #-1
0x100038080  ldaddal                      w8, w8, [x0]
0x100038084  cmp                          w8, #1
0x100038088  b.ne                         #0x1000381e8
0x10003808c  ldr                          x0, [sp, #0x58]
0x100038090  mov                          w1, #2
0x100038094  mov                          w2, #8
0x100038098  bl                           #0x10057f190
0x10003809c  b                            #0x1000381e8
0x1000380a0  strb                         wzr, [sp, #0x58]
0x1000380a4  add                          x0, sp, #0xc0
0x1000380a8  add                          x1, sp, #0x58
0x1000380ac  mov                          w2, #0xa
0x1000380b0  bl                           #0x100585a18
0x1000380b4  ldrb                         w8, [sp, #0x58]
0x1000380b8  tbz                          w8, #0, #0x100038104
0x1000380bc  mov                          x21, x0
0x1000380c0  adrp                         x8, #0x100722000
0x1000380c4  add                          x8, x8, #0x5c8
0x1000380c8  ldr                          x0, [x8]
0x1000380cc  bl                           #0x100025690
0x1000380d0  mov                          x22, x0
0x1000380d4  add                          x8, sp, #0x78
0x1000380d8  mov                          x0, x20
0x1000380dc  mov                          x1, x19
