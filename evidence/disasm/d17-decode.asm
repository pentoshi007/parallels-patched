0x10046232c  sub                          sp, sp, #0x40
0x100462330  stp                          x22, x21, [sp, #0x10]
0x100462334  stp                          x20, x19, [sp, #0x20]
0x100462338  stp                          x29, x30, [sp, #0x30]
0x10046233c  add                          x29, sp, #0x30
0x100462340  mov                          x19, x2
0x100462344  mov                          x20, x1
0x100462348  mov                          x21, x8
0x10046234c  add                          x8, sp, #8
0x100462350  bl                           #0x1005828ec
0x100462354  add                          x0, sp, #8
0x100462358  mov                          x8, x21
0x10046235c  mov                          x1, x20
0x100462360  mov                          x2, x19
0x100462364  bl                           #0x1004620c0
0x100462368  ldr                          x0, [sp, #8]
0x10046236c  ldr                          w8, [x0]
0x100462370  cmn                          w8, #1
0x100462374  b.eq                         #0x10046239c
0x100462378  cbz                          w8, #0x100462390
0x10046237c  mov                          w8, #-1
0x100462380  ldaddal                      w8, w8, [x0]
0x100462384  cmp                          w8, #1
0x100462388  b.ne                         #0x10046239c
0x10046238c  ldr                          x0, [sp, #8]
0x100462390  mov                          w1, #1
0x100462394  mov                          w2, #8
0x100462398  bl                           #0x10057f190
0x10046239c  ldp                          x29, x30, [sp, #0x30]
0x1004623a0  ldp                          x20, x19, [sp, #0x20]
0x1004623a4  ldp                          x22, x21, [sp, #0x10]
0x1004623a8  add                          sp, sp, #0x40
0x1004623ac  ret                          
0x1004623b0  mov                          x19, x0
0x1004623b4  add                          x0, sp, #8
0x1004623b8  bl                           #0x100009864
0x1004623bc  mov                          x0, x19
0x1004623c0  bl                           #0x10057f058
0x1004623c4  stp                          x20, x19, [sp, #-0x20]!
0x1004623c8  stp                          x29, x30, [sp, #0x10]
0x1004623cc  add                          x29, sp, #0x10
0x1004623d0  mov                          x19, x1
0x1004623d4  mov                          x20, x0
0x1004623d8  bl                           #0x100583774
0x1004623dc  cmp                          w0, #1
0x1004623e0  cset                         w8, eq
0x1004623e4  strb                         w8, [x19]
0x1004623e8  mov                          x0, x20
0x1004623ec  mov                          w1, #0
0x1004623f0  ldp                          x29, x30, [sp, #0x10]
0x1004623f4  ldp                          x20, x19, [sp], #0x20
0x1004623f8  b                            #0x10058378c
0x1004623fc  stp                          x20, x19, [sp, #-0x20]!
0x100462400  stp                          x29, x30, [sp, #0x10]
0x100462404  add                          x29, sp, #0x10
0x100462408  mov                          x19, x1
0x10046240c  mov                          x20, x0
0x100462410  bl                           #0x100583774
0x100462414  cmp                          w0, #2
0x100462418  cset                         w8, eq
0x10046241c  strb                         w8, [x19]
0x100462420  b.ne                         #0x10046244c
0x100462424  movi                         d0, #0000000000000000
0x100462428  mov                          x0, x20
0x10046242c  bl                           #0x1005837a4
0x100462430  fcvtzu                       w8, d0
0x100462434  ucvtf                        d1, w8
0x100462438  fcmp                         d0, d1
0x10046243c  cset                         w9, eq
0x100462440  strb                         w9, [x19]
0x100462444  csel                         w0, w8, wzr, eq
0x100462448  b                            #0x100462450
0x10046244c  mov                          w0, #0
0x100462450  ldp                          x29, x30, [sp, #0x10]
0x100462454  ldp                          x20, x19, [sp], #0x20
0x100462458  ret                          
0x10046245c  stp                          x28, x27, [sp, #-0x30]!
0x100462460  stp                          x20, x19, [sp, #0x10]
0x100462464  stp                          x29, x30, [sp, #0x20]
0x100462468  add                          x29, sp, #0x20
0x10046246c  sub                          sp, sp, #0x270
