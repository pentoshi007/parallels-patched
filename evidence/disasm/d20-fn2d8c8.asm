0x10002d8c8  sub                          sp, sp, #0x30
0x10002d8cc  stp                          x20, x19, [sp, #0x10]
0x10002d8d0  stp                          x29, x30, [sp, #0x20]
0x10002d8d4  add                          x29, sp, #0x20
0x10002d8d8  mov                          x19, x0
0x10002d8dc  add                          x8, sp, #8
0x10002d8e0  bl                           #0x100033a24
0x10002d8e4  add                          x0, sp, #8
0x10002d8e8  bl                           #0x100585f94
0x10002d8ec  tbz                          w0, #0, #0x10002d900
0x10002d8f0  mov                          x8, sp
0x10002d8f4  mov                          x0, x19
0x10002d8f8  bl                           #0x100033bc8
0x10002d8fc  b                            #0x10002d90c
0x10002d900  mov                          x0, sp
0x10002d904  add                          x1, sp, #8
0x10002d908  bl                           #0x1005831e0
0x10002d90c  add                          x0, sp, #8
0x10002d910  bl                           #0x1005831f8
0x10002d914  mov                          x0, sp
0x10002d918  bl                           #0x100585f94
0x10002d91c  tbz                          w0, #0, #0x10002d928
0x10002d920  mov                          w19, #0
0x10002d924  b                            #0x10002d948
0x10002d928  add                          x8, sp, #8
0x10002d92c  bl                           #0x100583180
0x10002d930  mov                          x0, sp
0x10002d934  add                          x1, sp, #8
0x10002d938  bl                           #0x100586018
0x10002d93c  mov                          x19, x0
0x10002d940  add                          x0, sp, #8
0x10002d944  bl                           #0x1005831f8
0x10002d948  mov                          x0, sp
0x10002d94c  bl                           #0x1005831f8
0x10002d950  mov                          x0, x19
0x10002d954  ldp                          x29, x30, [sp, #0x20]
0x10002d958  ldp                          x20, x19, [sp, #0x10]
0x10002d95c  add                          sp, sp, #0x30
0x10002d960  ret                          
0x10002d964  mov                          x19, x0
0x10002d968  add                          x0, sp, #8
0x10002d96c  bl                           #0x1005831f8
0x10002d970  mov                          x0, sp
0x10002d974  b                            #0x10002d990
0x10002d978  b                            #0x10002d97c
0x10002d97c  mov                          x19, x0
0x10002d980  mov                          x0, sp
0x10002d984  b                            #0x10002d990
0x10002d988  mov                          x19, x0
0x10002d98c  add                          x0, sp, #8
0x10002d990  bl                           #0x1005831f8
0x10002d994  mov                          x0, x19
0x10002d998  bl                           #0x10057f058
0x10002d99c  stp                          x20, x19, [sp, #-0x20]!
