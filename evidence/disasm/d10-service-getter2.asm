0x10031a8f0  ldr                          x0, [sp]
0x10031a8f4  mov                          w1, #2
0x10031a8f8  mov                          w2, #8
0x10031a8fc  bl                           #0x10057f190
0x10031a900  tbnz                         w20, #0, #0x10031a9a0
0x10031a904  mov                          x20, sp
0x10031a908  mov                          x8, sp
0x10031a90c  bl                           #0x1003aa6b4
0x10031a910  ldrsb                        w8, [sp, #0x17]
0x10031a914  ldr                          x9, [sp]
0x10031a918  ldr                          w10, [sp, #8]
0x10031a91c  and                          w11, w8, #0xff
0x10031a920  cmp                          w8, #0
0x10031a924  csel                         w1, w10, w11, lt
0x10031a928  csel                         x20, x9, x20, lt
0x10031a92c  cbz                          x20, #0x10031a944
0x10031a930  cmn                          w1, #1
0x10031a934  b.ne                         #0x10031a944
0x10031a938  mov                          x0, x20
0x10031a93c  bl                           #0x1005871f4
0x10031a940  mov                          x1, x0
0x10031a944  add                          x8, sp, #0x18
0x10031a948  mov                          x0, x20
0x10031a94c  bl                           #0x10058294c
0x10031a950  add                          x1, sp, #0x18
0x10031a954  mov                          x0, x19
0x10031a958  bl                           #0x100319f8c
0x10031a95c  mov                          x20, x0
0x10031a960  ldr                          x0, [sp, #0x18]
0x10031a964  ldr                          w8, [x0]
0x10031a968  cmn                          w8, #1
0x10031a96c  b.eq                         #0x10031a994
0x10031a970  cbz                          w8, #0x10031a988
0x10031a974  mov                          w8, #-1
0x10031a978  ldaddal                      w8, w8, [x0]
0x10031a97c  cmp                          w8, #1
0x10031a980  b.ne                         #0x10031a994
0x10031a984  ldr                          x0, [sp, #0x18]
0x10031a988  mov                          w1, #2
0x10031a98c  mov                          w2, #8
0x10031a990  bl                           #0x10057f190
0x10031a994  ldrsb                        w8, [sp, #0x17]
0x10031a998  tbnz                         w8, #0x1f, #0x10031ab88
0x10031a99c  tbz                          w20, #0, #0x10031ab94
0x10031a9a0  mov                          x0, x19
0x10031a9a4  bl                           #0x1003199dc
0x10031a9a8  cbz                          w0, #0x10031aa2c
0x10031a9ac  mov                          x20, x0
0x10031a9b0  adrp                         x0, #0x100628000
0x10031a9b4  add                          x0, x0, #0x8d
0x10031a9b8  mov                          w1, #8
0x10031a9bc  bl                           #0x100582964
0x10031a9c0  str                          x0, [sp]
0x10031a9c4  strb                         wzr, [sp, #0x18]
0x10031a9c8  mov                          x1, sp
0x10031a9cc  add                          x2, sp, #0x18
0x10031a9d0  mov                          x0, x19
0x10031a9d4  bl                           #0x1000134ac
0x10031a9d8  mov                          x21, x0
0x10031a9dc  ldr                          x0, [sp]
0x10031a9e0  ldr                          w8, [x0]
0x10031a9e4  cmn                          w8, #1
0x10031a9e8  b.eq                         #0x10031aa10
0x10031a9ec  cbz                          w8, #0x10031aa04
0x10031a9f0  mov                          w8, #-1
0x10031a9f4  ldaddal                      w8, w8, [x0]
0x10031a9f8  cmp                          w8, #1
0x10031a9fc  b.ne                         #0x10031aa10
0x10031aa00  ldr                          x0, [sp]
0x10031aa04  mov                          w1, #2
0x10031aa08  mov                          w2, #8
0x10031aa0c  bl                           #0x10057f190
0x10031aa10  cmp                          w20, #0x1c
0x10031aa14  csinc                        w8, w21, wzr, ge
0x10031aa18  cmp                          w20, #0x1b
0x10031aa1c  b.eq                         #0x10031aa2c
0x10031aa20  tbz                          w8, #0, #0x10031aa2c
0x10031aa24  mov                          w0, #-0x2afa
0x10031aa28  b                            #0x10031aba0
0x10031aa2c  adrp                         x0, #0x100633000
0x10031aa30  add                          x0, x0, #0x5bc
0x10031aa34  mov                          w1, #7
0x10031aa38  bl                           #0x100582964
0x10031aa3c  str                          x0, [sp]
0x10031aa40  strb                         wzr, [sp, #0x18]
0x10031aa44  mov                          x1, sp
0x10031aa48  add                          x2, sp, #0x18
0x10031aa4c  mov                          x0, x19
0x10031aa50  bl                           #0x1000134ac
0x10031aa54  mov                          x20, x0
0x10031aa58  ldr                          x0, [sp]
0x10031aa5c  ldr                          w8, [x0]
0x10031aa60  cmn                          w8, #1
0x10031aa64  b.eq                         #0x10031aa8c
0x10031aa68  cbz                          w8, #0x10031aa80
0x10031aa6c  mov                          w8, #-1
0x10031aa70  ldaddal                      w8, w8, [x0]
0x10031aa74  cmp                          w8, #1
0x10031aa78  b.ne                         #0x10031aa8c
0x10031aa7c  ldr                          x0, [sp]
0x10031aa80  mov                          w1, #2
0x10031aa84  mov                          w2, #8
0x10031aa88  bl                           #0x10057f190
0x10031aa8c  tbz                          w20, #0, #0x10031aa98
0x10031aa90  mov                          w0, #-0x2b03
0x10031aa94  b                            #0x10031aba0
0x10031aa98  adrp                         x0, #0x100632000
0x10031aa9c  add                          x0, x0, #0x680
0x10031aaa0  mov                          w1, #8
0x10031aaa4  bl                           #0x100582964
0x10031aaa8  str                          x0, [sp]
0x10031aaac  mov                          w8, #5
0x10031aab0  str                          w8, [sp, #0x18]
0x10031aab4  mov                          x1, sp
0x10031aab8  add                          x2, sp, #0x18
0x10031aabc  mov                          x0, x19
0x10031aac0  bl                           #0x10001340c
0x10031aac4  mov                          x20, x0
0x10031aac8  ldr                          x0, [sp]
0x10031aacc  ldr                          w8, [x0]
0x10031aad0  cmn                          w8, #1
0x10031aad4  b.eq                         #0x10031aafc
0x10031aad8  cbz                          w8, #0x10031aaf0
0x10031aadc  mov                          w8, #-1
