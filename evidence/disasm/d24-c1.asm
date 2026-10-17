0x100057fa0  ldur                         x19, [x29, #-0xc8]
0x100057fa4  cbnz                         x19, #0x10005882c
0x100057fa8  b                            #0x1000589a4
0x100057fac  ldr                          x0, [x26]
0x100057fb0  add                          x8, sp, #0xc0
0x100057fb4  bl                           #0x100025788
0x100057fb8  ldr                          x8, [sp, #0xc0]
0x100057fbc  ldr                          x8, [x8, #8]
0x100057fc0  add                          x0, x8, #0x30
0x100057fc4  bl                           #0x100279b3c
0x100057fc8  cbz                          w0, #0x100058320
0x100057fcc  ldr                          x8, [sp, #0xc0]
0x100057fd0  ldr                          x8, [x8, #8]
0x100057fd4  add                          x0, x8, #0x30
0x100057fd8  bl                           #0x100279b3c
0x100057fdc  mov                          x22, x0
0x100057fe0  ldr                          x8, [x21]
0x100057fe4  ldr                          x8, [x8, #8]
0x100057fe8  stur                         x8, [x29, #-0xd8]
0x100057fec  ldr                          w9, [x8]
0x100057ff0  sub                          w9, w9, #1
0x100057ff4  cmn                          w9, #3
0x100057ff8  b.hi                         #0x100058004
0x100057ffc  mov                          w9, #1
