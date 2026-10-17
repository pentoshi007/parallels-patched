0x1000bf980  stp                          x29, x30, [sp, #0xd0]
0x1000bf984  add                          x29, sp, #0xd0
0x1000bf988  mov                          x19, x1
0x1000bf98c  mov                          x20, x0
0x1000bf990  add                          x0, x0, #0x30
0x1000bf994  bl                           #0x100279b3c
0x1000bf998  cmp                          w0, #0
0x1000bf99c  cset                         w1, eq
0x1000bf9a0  mov                          x0, x19
0x1000bf9a4  mov                          w2, #0x64
0x1000bf9a8  bl                           #0x10009ca0c
0x1000bf9ac  add                          x0, x20, #0x30
0x1000bf9b0  bl                           #0x100279b3c
0x1000bf9b4  mov                          x1, x0
0x1000bf9b8  mov                          x0, x19
0x1000bf9bc  mov                          w2, #0x65
0x1000bf9c0  bl                           #0x10006050c
0x1000bf9c4  bl                           #0x1001594e8
0x1000bf9c8  sub                          x8, x29, #0x30
0x1000bf9cc  eor                          w0, w0, #1
0x1000bf9d0  mov                          w1, #0xa
0x1000bf9d4  bl                           #0x100582a0c
0x1000bf9d8  sub                          x1, x29, #0x30
0x1000bf9dc  mov                          x0, x19
0x1000bf9e0  mov                          w2, #0x6e
0x1000bf9e4  bl                           #0x10000d9f0
0x1000bf9e8  ldur                         x0, [x29, #-0x30]
0x1000bf9ec  ldr                          w8, [x0]
0x1000bf9f0  cmn                          w8, #1
0x1000bf9f4  b.eq                         #0x1000bfa1c
0x1000bf9f8  cbz                          w8, #0x1000bfa10
0x1000bf9fc  mov                          w8, #-1
0x1000bfa00  ldaddal                      w8, w8, [x0]
0x1000bfa04  cmp                          w8, #1
0x1000bfa08  b.ne                         #0x1000bfa1c
0x1000bfa0c  ldur                         x0, [x29, #-0x30]
