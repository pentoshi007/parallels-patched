0x1000134ac  sub                          sp, sp, #0x50
0x1000134b0  stp                          x20, x19, [sp, #0x30]
0x1000134b4  stp                          x29, x30, [sp, #0x40]
0x1000134b8  add                          x29, sp, #0x40
0x1000134bc  mov                          x19, x2
0x1000134c0  add                          x8, sp, #0x18
0x1000134c4  bl                           #0x100583bc4
0x1000134c8  mov                          x0, sp
0x1000134cc  mov                          w1, #0x80
0x1000134d0  bl                           #0x10057f310
0x1000134d4  add                          x0, sp, #0x18
0x1000134d8  mov                          x1, sp
0x1000134dc  bl                           #0x1005837e0
0x1000134e0  mov                          x20, x0
0x1000134e4  mov                          x0, sp
0x1000134e8  bl                           #0x10057f370
0x1000134ec  cbz                          w20, #0x1000134f8
0x1000134f0  ldrb                         w19, [x19]
0x1000134f4  b                            #0x100013508
0x1000134f8  add                          x0, sp, #0x18
0x1000134fc  mov                          x1, x19
0x100013500  bl                           #0x10031ac04
0x100013504  mov                          x19, x0
0x100013508  add                          x0, sp, #0x18
0x10001350c  bl                           #0x10057f370
0x100013510  and                          w0, w19, #1
0x100013514  ldp                          x29, x30, [sp, #0x40]
0x100013518  ldp                          x20, x19, [sp, #0x30]
0x10001351c  add                          sp, sp, #0x50
0x100013520  ret                          
0x100013524  b                            #0x100013538
0x100013528  mov                          x19, x0
0x10001352c  mov                          x0, sp
0x100013530  bl                           #0x10057f370
0x100013534  b                            #0x10001353c
0x100013538  mov                          x19, x0
0x10001353c  add                          x0, sp, #0x18
0x100013540  bl                           #0x10057f370
0x100013544  mov                          x0, x19
0x100013548  bl                           #0x10057f058
0x10001354c  stp                          x22, x21, [sp, #-0x30]!
0x100013550  stp                          x20, x19, [sp, #0x10]
0x100013554  stp                          x29, x30, [sp, #0x20]
0x100013558  add                          x29, sp, #0x20
0x10001355c  mov                          x19, x0
