0x1004620c0  sub                          sp, sp, #0x60
0x1004620c4  stp                          x22, x21, [sp, #0x30]
0x1004620c8  stp                          x20, x19, [sp, #0x40]
0x1004620cc  stp                          x29, x30, [sp, #0x50]
0x1004620d0  add                          x29, sp, #0x50
0x1004620d4  mov                          x20, x2
0x1004620d8  mov                          x21, x1
0x1004620dc  mov                          x19, x8
0x1004620e0  add                          x8, sp, #0x18
0x1004620e4  add                          x1, sp, #0x20
0x1004620e8  bl                           #0x10057fef8
0x1004620ec  cbz                          x21, #0x100462100
0x1004620f0  add                          x0, sp, #0x18
0x1004620f4  bl                           #0x10058402c
0x1004620f8  eor                          w8, w0, #1
0x1004620fc  strb                         w8, [x21]
0x100462100  add                          x0, sp, #0x18
0x100462104  bl                           #0x10058402c
0x100462108  cmp                          x20, #0
0x10046210c  eor                          w8, w0, #1
0x100462110  csinc                        w8, w8, wzr, ne
0x100462114  tbnz                         w8, #0, #0x1004622b0
0x100462118  mov                          x8, sp
0x10046211c  add                          x0, sp, #0x20
0x100462120  bl                           #0x10058450c
0x100462124  ldr                          x8, [sp]
0x100462128  str                          x8, [sp, #8]
0x10046212c  ldr                          w9, [x8]
0x100462130  sub                          w9, w9, #1
0x100462134  cmn                          w9, #3
0x100462138  b.hi                         #0x100462144
0x10046213c  mov                          w9, #1
0x100462140  ldaddal                      w9, w8, [x8]
0x100462144  adrp                         x0, #0x10066a000
0x100462148  add                          x0, x0, #0x4fd
0x10046214c  add                          x8, sp, #0x28
0x100462150  mov                          w1, #0xa
0x100462154  bl                           #0x10058294c
0x100462158  add                          x0, sp, #8
0x10046215c  add                          x1, sp, #0x28
0x100462160  bl                           #0x1005829dc
0x100462164  ldr                          x0, [sp, #0x28]
0x100462168  ldr                          w8, [x0]
0x10046216c  cmn                          w8, #1
0x100462170  b.eq                         #0x100462198
0x100462174  cbz                          w8, #0x10046218c
0x100462178  mov                          w8, #-1
0x10046217c  ldaddal                      w8, w8, [x0]
0x100462180  cmp                          w8, #1
0x100462184  b.ne                         #0x100462198
0x100462188  ldr                          x0, [sp, #0x28]
0x10046218c  mov                          w1, #2
0x100462190  mov                          w2, #8
0x100462194  bl                           #0x10057f190
0x100462198  ldr                          w0, [sp, #0x20]
0x10046219c  add                          x8, sp, #0x28
