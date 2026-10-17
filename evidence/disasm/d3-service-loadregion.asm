0x10002ab00  bl                           #0x10001f834
0x10002ab04  ldr                          x8, [sp, #8]
0x10002ab08  ldr                          x0, [x8, #8]
0x10002ab0c  add                          x8, sp, #0x18
0x10002ab10  bl                           #0x100584df4
0x10002ab14  ldr                          x20, [sp, #0x10]
0x10002ab18  cbz                          x20, #0x10002ab44
0x10002ab1c  add                          x8, x20, #8
0x10002ab20  mov                          x9, #-1
0x10002ab24  ldaddal                      x9, x8, [x8]
0x10002ab28  cbnz                         x8, #0x10002ab44
0x10002ab2c  ldr                          x8, [x20]
0x10002ab30  ldr                          x8, [x8, #0x10]
0x10002ab34  mov                          x0, x20
0x10002ab38  blr                          x8
0x10002ab3c  mov                          x0, x20
0x10002ab40  bl                           #0x100586330
0x10002ab44  ldr                          x0, [x19, #0x948]
0x10002ab48  bl                           #0x100177e5c
0x10002ab4c  bl                           #0x1003f44c8
0x10002ab50  mov                          x20, x0
0x10002ab54  mov                          w0, #0x10
0x10002ab58  bl                           #0x100586420
0x10002ab5c  mov                          x21, x0
0x10002ab60  bl                           #0x1005818b4
0x10002ab64  mov                          w8, #0x3e8
0x10002ab68  str                          w8, [x21, #8]
0x10002ab6c  mov                          w8, #1
0x10002ab70  strb                         w8, [x21, #0xc]
0x10002ab74  adrp                         x8, #0x1006b9000
0x10002ab78  add                          x8, x8, #0x120
0x10002ab7c  str                          x8, [x21]
0x10002ab80  mov                          x0, x20
0x10002ab84  mov                          x1, x21
0x10002ab88  bl                           #0x100581b24
0x10002ab8c  ldr                          x20, [x19, #0x938]
0x10002ab90  bl                           #0x1003f44c8
0x10002ab94  mov                          x1, x0
0x10002ab98  mov                          x0, x20
0x10002ab9c  bl                           #0x10027b14c
0x10002aba0  add                          x0, x19, #0x940
0x10002aba4  add                          x1, sp, #0x18
0x10002aba8  bl                           #0x100159620
0x10002abac  ldr                          x0, [sp, #0x18]
0x10002abb0  ldr                          w8, [x0]
0x10002abb4  cmn                          w8, #1
0x10002abb8  b.eq                         #0x10002abe0
0x10002abbc  cbz                          w8, #0x10002abd4
0x10002abc0  mov                          w8, #-1
0x10002abc4  ldaddal                      w8, w8, [x0]
0x10002abc8  cmp                          w8, #1
0x10002abcc  b.ne                         #0x10002abe0
0x10002abd0  ldr                          x0, [sp, #0x18]
0x10002abd4  mov                          w1, #2
0x10002abd8  mov                          w2, #8
0x10002abdc  bl                           #0x10057f190
0x10002abe0  ldp                          x29, x30, [sp, #0x40]
0x10002abe4  ldp                          x20, x19, [sp, #0x30]
0x10002abe8  ldp                          x22, x21, [sp, #0x20]
0x10002abec  add                          sp, sp, #0x50
0x10002abf0  ret                          
0x10002abf4  mov                          x19, x0
0x10002abf8  mov                          x0, x21
0x10002abfc  bl                           #0x1005863cc
0x10002ac00  b                            #0x10002ac1c
0x10002ac04  mov                          x19, x0
0x10002ac08  add                          x0, sp, #8
0x10002ac0c  bl                           #0x10003202c
0x10002ac10  mov                          x0, x19
0x10002ac14  bl                           #0x10057f058
0x10002ac18  mov                          x19, x0
0x10002ac1c  add                          x0, sp, #0x18
0x10002ac20  bl                           #0x100009fbc
0x10002ac24  mov                          x0, x19
0x10002ac28  bl                           #0x10057f058
0x10002ac2c  sub                          sp, sp, #0x60
0x10002ac30  stp                          x22, x21, [sp, #0x30]
0x10002ac34  stp                          x20, x19, [sp, #0x40]
0x10002ac38  stp                          x29, x30, [sp, #0x50]
0x10002ac3c  add                          x29, sp, #0x50
0x10002ac40  mov                          x19, x0
0x10002ac44  bl                           #0x1000c0a50
0x10002ac48  add                          x21, x19, #0x158
0x10002ac4c  add                          x22, x19, #0x160
0x10002ac50  mov                          w0, #0x18
0x10002ac54  bl                           #0x100586420
0x10002ac58  mov                          x20, x0
0x10002ac5c  stp                          x21, x22, [x0]
0x10002ac60  str                          wzr, [x0, #0x10]
0x10002ac64  mov                          x0, x21
0x10002ac68  bl                           #0x100582574
0x10002ac6c  mov                          w8, #1
0x10002ac70  str                          w8, [x20, #0x10]
0x10002ac74  str                          x20, [sp, #0x28]
0x10002ac78  mov                          w0, #0x20
0x10002ac7c  bl                           #0x100586420
0x10002ac80  mov                          x8, x0
0x10002ac84  str                          xzr, [x8, #8]!
0x10002ac88  adrp                         x9, #0x1006b9000
0x10002ac8c  add                          x9, x9, #0x3e0
0x10002ac90  str                          x9, [x0]
0x10002ac94  stp                          xzr, x20, [x0, #0x10]
0x10002ac98  ldr                          x20, [x20, #8]
0x10002ac9c  mov                          x9, #-1
0x10002aca0  ldaddal                      x9, x8, [x8]
0x10002aca4  cbnz                         x8, #0x10002acc0
0x10002aca8  ldr                          x8, [x0]
0x10002acac  ldr                          x8, [x8, #0x10]
0x10002acb0  mov                          x21, x0
0x10002acb4  blr                          x8
0x10002acb8  mov                          x0, x21
0x10002acbc  bl                           #0x100586330
0x10002acc0  add                          x0, x20, #0x30
0x10002acc4  bl                           #0x100279f58
0x10002acc8  adrp                         x8, #0x100721000
0x10002accc  add                          x8, x8, #0xd60
0x10002acd0  ldr                          w8, [x8]
0x10002acd4  cmp                          w8, #3
0x10002acd8  b.lt                         #0x10002adb0
0x10002acdc  add                          x8, sp, #0x28
0x10002ace0  mov                          x0, x20
0x10002ace4  bl                           #0x1000bf964
0x10002ace8  add                          x0, sp, #0x28
0x10002acec  mov                          w1, #0xa
0x10002acf0  mov                          w2, #0x20
0x10002acf4  mov                          w3, #1
0x10002acf8  bl                           #0x100582a90
0x10002acfc  ldr                          x8, [x0]
0x10002ad00  str                          x8, [sp, #0x20]
0x10002ad04  ldr                          w9, [x8]
0x10002ad08  sub                          w9, w9, #1
0x10002ad0c  cmn                          w9, #3
0x10002ad10  b.hi                         #0x10002ad1c
0x10002ad14  mov                          w9, #1
0x10002ad18  ldaddal                      w9, w8, [x8]
0x10002ad1c  add                          x8, sp, #0x20
0x10002ad20  adrp                         x0, #0x100625000
0x10002ad24  add                          x0, x0, #0x5a0
