0x10031a878  sub                          sp, sp, #0x50
0x10031a87c  stp                          x22, x21, [sp, #0x20]
0x10031a880  stp                          x20, x19, [sp, #0x30]
0x10031a884  stp                          x29, x30, [sp, #0x40]
0x10031a888  add                          x29, sp, #0x40
0x10031a88c  mov                          x19, x0
0x10031a890  bl                           #0x100583bd0
0x10031a894  tbz                          w0, #0, #0x10031a8a0
0x10031a898  mov                          w0, #-0x2af8
0x10031a89c  b                            #0x10031aba0
0x10031a8a0  adrp                         x0, #0x100632000
0x10031a8a4  add                          x0, x0, #0x436
0x10031a8a8  mov                          w1, #7
0x10031a8ac  bl                           #0x100582964
0x10031a8b0  str                          x0, [sp]
0x10031a8b4  strb                         wzr, [sp, #0x18]
0x10031a8b8  mov                          x1, sp
0x10031a8bc  add                          x2, sp, #0x18
0x10031a8c0  mov                          x0, x19
0x10031a8c4  bl                           #0x1000134ac
0x10031a8c8  mov                          x20, x0
0x10031a8cc  ldr                          x0, [sp]
0x10031a8d0  ldr                          w8, [x0]
0x10031a8d4  cmn                          w8, #1
0x10031a8d8  b.eq                         #0x10031a900
0x10031a8dc  cbz                          w8, #0x10031a8f4
0x10031a8e0  mov                          w8, #-1
0x10031a8e4  ldaddal                      w8, w8, [x0]
0x10031a8e8  cmp                          w8, #1
0x10031a8ec  b.ne                         #0x10031a900
