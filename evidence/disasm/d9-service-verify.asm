0x1004626ac  sub                          sp, sp, #0x70
0x1004626b0  stp                          x24, x23, [sp, #0x30]
0x1004626b4  stp                          x22, x21, [sp, #0x40]
0x1004626b8  stp                          x20, x19, [sp, #0x50]
0x1004626bc  stp                          x29, x30, [sp, #0x60]
0x1004626c0  add                          x29, sp, #0x60
0x1004626c4  mov                          x19, x1
0x1004626c8  mov                          x8, sp
0x1004626cc  bl                           #0x1005828ec
0x1004626d0  ldr                          x23, [sp]
0x1004626d4  ldrsw                        x20, [x23, #4]
0x1004626d8  tbnz                         w20, #0x1f, #0x10046297c
0x1004626dc  ldr                          x24, [x23, #0x10]
0x1004626e0  cmp                          w20, #0x17
0x1004626e4  b.hs                         #0x1004626f8
0x1004626e8  strb                         w20, [sp, #0x2f]
0x1004626ec  add                          x21, sp, #0x18
0x1004626f0  cbnz                         w20, #0x100462720
0x1004626f4  b                            #0x100462730
0x1004626f8  orr                          x8, x20, #7
0x1004626fc  cmp                          x8, #0x17
0x100462700  mov                          w9, #0x19
0x100462704  csinc                        x22, x9, x8, eq
0x100462708  mov                          x0, x22
0x10046270c  bl                           #0x100586420
0x100462710  mov                          x21, x0
0x100462714  orr                          x8, x22, #0x8000000000000000
0x100462718  stp                          x20, x8, [sp, #0x20]
0x10046271c  str                          x0, [sp, #0x18]
0x100462720  add                          x1, x23, x24
0x100462724  mov                          x0, x21
0x100462728  mov                          x2, x20
0x10046272c  bl                           #0x100586ca8
0x100462730  strb                         wzr, [x21, x20]
0x100462734  ldr                          x0, [sp]
0x100462738  ldr                          w8, [x0]
0x10046273c  cmn                          w8, #1
0x100462740  b.eq                         #0x100462768
0x100462744  cbz                          w8, #0x10046275c
0x100462748  mov                          w8, #-1
0x10046274c  ldaddal                      w8, w8, [x0]
0x100462750  cmp                          w8, #1
0x100462754  b.ne                         #0x100462768
0x100462758  ldr                          x0, [sp]
0x10046275c  mov                          w1, #1
