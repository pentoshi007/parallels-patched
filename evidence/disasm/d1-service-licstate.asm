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
0x10002ad28  adrp                         x1, #0x100625000
0x10002ad2c  add                          x1, x1, #0x5a1
0x10002ad30  adrp                         x4, #0x100627000
0x10002ad34  add                          x4, x4, #0x698
0x10002ad38  str                          x8, [sp]
0x10002ad3c  mov                          w2, #3
0x10002ad40  mov                          w3, #3
0x10002ad44  bl                           #0x100009504
0x10002ad48  ldr                          x0, [sp, #0x20]
0x10002ad4c  ldr                          w8, [x0]
0x10002ad50  cmn                          w8, #1
0x10002ad54  b.eq                         #0x10002ad7c
0x10002ad58  cbz                          w8, #0x10002ad70
0x10002ad5c  mov                          w8, #-1
0x10002ad60  ldaddal                      w8, w8, [x0]
0x10002ad64  cmp                          w8, #1
0x10002ad68  b.ne                         #0x10002ad7c
0x10002ad6c  ldr                          x0, [sp, #0x20]
0x10002ad70  mov                          w1, #2
0x10002ad74  mov                          w2, #8
0x10002ad78  bl                           #0x10057f190
0x10002ad7c  ldr                          x0, [sp, #0x28]
0x10002ad80  ldr                          w8, [x0]
0x10002ad84  cmn                          w8, #1
0x10002ad88  b.eq                         #0x10002adb0
0x10002ad8c  cbz                          w8, #0x10002ada4
0x10002ad90  mov                          w8, #-1
0x10002ad94  ldaddal                      w8, w8, [x0]
0x10002ad98  cmp                          w8, #1
0x10002ad9c  b.ne                         #0x10002adb0
0x10002ada0  ldr                          x0, [sp, #0x28]
0x10002ada4  mov                          w1, #2
0x10002ada8  mov                          w2, #8
0x10002adac  bl                           #0x10057f190
0x10002adb0  add                          x0, x20, #0x30
0x10002adb4  bl                           #0x100279b3c
0x10002adb8  mov                          x21, x0
0x10002adbc  add                          x0, x20, #0x30
0x10002adc0  bl                           #0x100279b3c
0x10002adc4  adrp                         x8, #0x100627000
0x10002adc8  add                          x8, x8, #0x6da
0x10002adcc  adrp                         x9, #0x100627000
0x10002add0  add                          x9, x9, #0x6d1
0x10002add4  cmp                          w0, #0
0x10002add8  csel                         x20, x9, x8, eq
0x10002addc  mov                          x0, x21
0x10002ade0  bl                           #0x100573890
0x10002ade4  stp                          x0, x21, [sp, #8]
0x10002ade8  str                          x20, [sp]
0x10002adec  adrp                         x0, #0x100625000
0x10002adf0  add                          x0, x0, #0x5a0
0x10002adf4  adrp                         x1, #0x100625000
0x10002adf8  add                          x1, x1, #0x5a1
0x10002adfc  adrp                         x3, #0x100627000
0x10002ae00  add                          x3, x3, #0x6ac
0x10002ae04  mov                          w2, #0
0x10002ae08  bl                           #0x1005756cc
0x10002ae0c  mov                          x0, x19
0x10002ae10  bl                           #0x1002f7df8
0x10002ae14  mov                          w0, #1
0x10002ae18  ldp                          x29, x30, [sp, #0x50]
0x10002ae1c  ldp                          x20, x19, [sp, #0x40]
0x10002ae20  ldp                          x22, x21, [sp, #0x30]
0x10002ae24  add                          sp, sp, #0x60
0x10002ae28  ret                          
0x10002ae2c  bl                           #0x1000094f4
0x10002ae30  mov                          x19, x0
0x10002ae34  add                          x0, sp, #0x28
0x10002ae38  bl                           #0x100009fbc
0x10002ae3c  mov                          x0, x19
0x10002ae40  bl                           #0x10057f058
0x10002ae44  bl                           #0x1000094f4
0x10002ae48  mov                          x19, x0
0x10002ae4c  add                          x0, sp, #0x28
0x10002ae50  bl                           #0x100034848
0x10002ae54  mov                          x0, x19
0x10002ae58  bl                           #0x10057f058
0x10002ae5c  mov                          x19, x0
0x10002ae60  mov                          x0, x20
0x10002ae64  bl                           #0x1005863cc
0x10002ae68  mov                          x0, x19
0x10002ae6c  bl                           #0x10057f058
0x10002ae70  sub                          sp, sp, #0x90
0x10002ae74  stp                          x24, x23, [sp, #0x50]
0x10002ae78  stp                          x22, x21, [sp, #0x60]
0x10002ae7c  stp                          x20, x19, [sp, #0x70]
0x10002ae80  stp                          x29, x30, [sp, #0x80]
0x10002ae84  add                          x29, sp, #0x80
0x10002ae88  mov                          x19, x0
0x10002ae8c  add                          x8, sp, #0x18
0x10002ae90  bl                           #0x100025a40
0x10002ae94  ldr                          x8, [sp, #0x18]
0x10002ae98  ldr                          x20, [x8, #8]
0x10002ae9c  ldr                          x21, [x19, #0x70]
0x10002aea0  adrp                         x8, #0x1002fc000
0x10002aea4  add                          x8, x8, #0x994
0x10002aea8  stp                          x8, xzr, [sp, #0x40]
0x10002aeac  adrp                         x22, #0x100148000
0x10002aeb0  add                          x22, x22, #0xda0
0x10002aeb4  stp                          x22, xzr, [sp, #0x30]
0x10002aeb8  mov                          w0, #0x20
0x10002aebc  bl                           #0x100586420
0x10002aec0  mov                          x4, x0
0x10002aec4  mov                          w8, #1
0x10002aec8  str                          w8, [x0]
0x10002aecc  adrp                         x8, #0x100034000
0x10002aed0  add                          x8, x8, #0xa88
0x10002aed4  stp                          x8, x22, [x0, #8]
0x10002aed8  str                          xzr, [x0, #0x18]
0x10002aedc  adrp                         x7, #0x1006c2000
0x10002aee0  add                          x7, x7, #0x3e0
0x10002aee4  add                          x8, sp, #0x28
0x10002aee8  add                          x1, sp, #0x40
0x10002aeec  add                          x3, sp, #0x30
0x10002aef0  mov                          x0, x20
0x10002aef4  mov                          x2, x21
0x10002aef8  mov                          w5, #0
0x10002aefc  mov                          x6, #0
0x10002af00  bl                           #0x100582784
0x10002af04  add                          x0, sp, #0x28
0x10002af08  bl                           #0x10057f6f4
0x10002af0c  ldr                          x20, [sp, #0x20]
0x10002af10  cbz                          x20, #0x10002af3c
0x10002af14  add                          x8, x20, #8
0x10002af18  mov                          x9, #-1
0x10002af1c  ldaddal                      x9, x8, [x8]
0x10002af20  cbnz                         x8, #0x10002af3c
0x10002af24  ldr                          x8, [x20]
0x10002af28  ldr                          x8, [x8, #0x10]
0x10002af2c  mov                          x0, x20
0x10002af30  blr                          x8
0x10002af34  mov                          x0, x20
0x10002af38  bl                           #0x100586330
0x10002af3c  ldr                          x20, [x19, #0x70]
0x10002af40  adrp                         x8, #0x1002f7000
0x10002af44  add                          x8, x8, #0xdf8
0x10002af48  stp                          x8, xzr, [sp, #0x40]
0x10002af4c  adrp                         x21, #0x100148000
0x10002af50  add                          x21, x21, #0xa9c
0x10002af54  stp                          x21, xzr, [sp, #0x30]
0x10002af58  mov                          w0, #0x20
0x10002af5c  bl                           #0x100586420
0x10002af60  mov                          x4, x0
0x10002af64  mov                          w22, #1
0x10002af68  str                          w22, [x0]
0x10002af6c  adrp                         x23, #0x100034000
0x10002af70  add                          x23, x23, #0xb00
0x10002af74  stp                          x23, x21, [x0, #8]
0x10002af78  str                          xzr, [x0, #0x18]
0x10002af7c  adrp                         x7, #0x1006c1000
0x10002af80  add                          x7, x7, #0x6c8
0x10002af84  add                          x8, sp, #0x10
0x10002af88  add                          x1, sp, #0x40
0x10002af8c  add                          x3, sp, #0x30
0x10002af90  mov                          x0, x19
0x10002af94  mov                          x2, x20
0x10002af98  mov                          w5, #0
0x10002af9c  mov                          x6, #0
0x10002afa0  bl                           #0x100582784
0x10002afa4  add                          x0, sp, #0x10
0x10002afa8  bl                           #0x10057f6f4
0x10002afac  ldr                          x20, [x19, #0x550]
0x10002afb0  ldr                          x19, [x19, #0x70]
0x10002afb4  adrp                         x8, #0x10030d000
0x10002afb8  add                          x8, x8, #0x3b8
0x10002afbc  stp                          x8, xzr, [sp, #0x40]
0x10002afc0  adrp                         x21, #0x100148000
0x10002afc4  add                          x21, x21, #0xcb8
0x10002afc8  stp                          x21, xzr, [sp, #0x30]
0x10002afcc  mov                          w0, #0x20
0x10002afd0  bl                           #0x100586420
0x10002afd4  mov                          x4, x0
0x10002afd8  str                          w22, [x0]
0x10002afdc  stp                          x23, x21, [x0, #8]
0x10002afe0  str                          xzr, [x0, #0x18]
0x10002afe4  adrp                         x7, #0x1006c8000
0x10002afe8  add                          x7, x7, #0x4e0
0x10002afec  add                          x8, sp, #8
0x10002aff0  add                          x1, sp, #0x40
0x10002aff4  add                          x3, sp, #0x30
0x10002aff8  mov                          x0, x20
0x10002affc  mov                          x2, x19
0x10002b000  mov                          w5, #0
0x10002b004  mov                          x6, #0
0x10002b008  bl                           #0x100582784
0x10002b00c  add                          x0, sp, #8
0x10002b010  bl                           #0x10057f6f4
0x10002b014  ldp                          x29, x30, [sp, #0x80]
0x10002b018  ldp                          x20, x19, [sp, #0x70]
0x10002b01c  ldp                          x22, x21, [sp, #0x60]
0x10002b020  ldp                          x24, x23, [sp, #0x50]
0x10002b024  add                          sp, sp, #0x90
0x10002b028  ret                          
0x10002b02c  mov                          x19, x0
0x10002b030  add                          x0, sp, #0x18
0x10002b034  bl                           #0x10002d5d4
0x10002b038  mov                          x0, x19
0x10002b03c  bl                           #0x10057f058
0x10002b040  stp                          x20, x19, [sp, #-0x20]!
0x10002b044  stp                          x29, x30, [sp, #0x10]
0x10002b048  add                          x29, sp, #0x10
0x10002b04c  ldr                          x19, [x0, #8]
0x10002b050  cbz                          x19, #0x10002b084
0x10002b054  add                          x8, x19, #8
0x10002b058  mov                          x9, #-1
0x10002b05c  ldaddal                      x9, x8, [x8]
0x10002b060  cbnz                         x8, #0x10002b084
0x10002b064  ldr                          x8, [x19]
0x10002b068  ldr                          x8, [x8, #0x10]
0x10002b06c  mov                          x20, x0
0x10002b070  mov                          x0, x19
0x10002b074  blr                          x8
0x10002b078  mov                          x0, x19
0x10002b07c  bl                           #0x100586330
0x10002b080  mov                          x0, x20
0x10002b084  ldp                          x29, x30, [sp, #0x10]
0x10002b088  ldp                          x20, x19, [sp], #0x20
0x10002b08c  ret                          
0x10002b090  sub                          sp, sp, #0xf0
0x10002b094  stp                          x22, x21, [sp, #0xc0]
0x10002b098  stp                          x20, x19, [sp, #0xd0]
0x10002b09c  stp                          x29, x30, [sp, #0xe0]
0x10002b0a0  add                          x29, sp, #0xe0
0x10002b0a4  mov                          x19, x0
0x10002b0a8  bl                           #0x100512404
0x10002b0ac  tbnz                         w0, #0, #0x10002b2c0
0x10002b0b0  sub                          x8, x29, #0x40
0x10002b0b4  add                          x0, x19, #0x398
0x10002b0b8  bl                           #0x10001ef1c
0x10002b0bc  ldur                         x8, [x29, #-0x40]
0x10002b0c0  ldr                          x21, [x8, #8]
0x10002b0c4  mov                          w0, #0x98
0x10002b0c8  bl                           #0x100586420
0x10002b0cc  mov                          x20, x0
0x10002b0d0  mov                          x1, x21
0x10002b0d4  bl                           #0x100580ec4
0x10002b0d8  stur                         x20, [x29, #-0x30]
0x10002b0dc  mov                          w0, #0x20
0x10002b0e0  bl                           #0x100586420
0x10002b0e4  adrp                         x8, #0x1006b8000
0x10002b0e8  add                          x8, x8, #0xbe0
0x10002b0ec  stp                          x8, xzr, [x0]
0x10002b0f0  stp                          xzr, x20, [x0, #0x10]
0x10002b0f4  stur                         x0, [x29, #-0x28]
0x10002b0f8  ldur                         x20, [x29, #-0x38]
0x10002b0fc  cbz                          x20, #0x10002b128
0x10002b100  add                          x8, x20, #8
0x10002b104  mov                          x9, #-1
0x10002b108  ldaddal                      x9, x8, [x8]
0x10002b10c  cbnz                         x8, #0x10002b128
0x10002b110  ldr                          x8, [x20]
0x10002b114  ldr                          x8, [x8, #0x10]
0x10002b118  mov                          x0, x20
0x10002b11c  blr                          x8
0x10002b120  mov                          x0, x20
0x10002b124  bl                           #0x100586330
0x10002b128  ldr                          x21, [x19, #0x608]
0x10002b12c  ldr                          x0, [x19, #0x950]
0x10002b130  sub                          x8, x29, #0x48
0x10002b134  bl                           #0x1001414c8
0x10002b138  ldur                         x19, [x29, #-0x48]
0x10002b13c  stur                         x19, [x29, #-0x40]
0x10002b140  ldr                          w8, [x19, #0x10]
0x10002b144  sub                          w8, w8, #1
0x10002b148  cmn                          w8, #3
0x10002b14c  b.hi                         #0x10002b160
0x10002b150  add                          x8, x19, #0x10
0x10002b154  mov                          w9, #1
0x10002b158  ldaddal                      w9, w8, [x8]
0x10002b15c  ldur                         x19, [x29, #-0x40]
0x10002b160  ldrb                         w8, [x19, #0x28]
0x10002b164  tbnz                         w8, #0, #0x10002b1d4
0x10002b168  ldr                          w8, [x19, #0x10]
0x10002b16c  cmp                          w8, #2
0x10002b170  b.lo                         #0x10002b1d4
0x10002b174  adrp                         x1, #0x100033000
0x10002b178  add                          x1, x1, #0xec0
0x10002b17c  adrp                         x2, #0x100033000
0x10002b180  add                          x2, x2, #0xed4
0x10002b184  mov                          x0, x19
0x10002b188  mov                          w3, #0x10
0x10002b18c  mov                          w4, #8
0x10002b190  bl                           #0x1005832b8
0x10002b194  mov                          x20, x0
0x10002b198  ldr                          w8, [x19, #0x10]
0x10002b19c  cmn                          w8, #1
0x10002b1a0  b.eq                         #0x10002b1d0
0x10002b1a4  cbz                          w8, #0x10002b1c0
0x10002b1a8  add                          x8, x19, #0x10
0x10002b1ac  mov                          w9, #-1
0x10002b1b0  ldaddal                      w9, w8, [x8]
0x10002b1b4  cmp                          w8, #1
0x10002b1b8  b.ne                         #0x10002b1d0
0x10002b1bc  ldur                         x19, [x29, #-0x40]
0x10002b1c0  adrp                         x1, #0x100033000
0x10002b1c4  add                          x1, x1, #0xed4
0x10002b1c8  mov                          x0, x19
0x10002b1cc  bl                           #0x100583294
0x10002b1d0  stur                         x20, [x29, #-0x40]
0x10002b1d4  adrp                         x6, #0x100627000
0x10002b1d8  add                          x6, x6, #0xfba
0x10002b1dc  adrp                         x8, #0x100626000
0x10002b1e0  add                          x8, x8, #0x4c8
0x10002b1e4  movi                         v0.2d, #0000000000000000
0x10002b1e8  stp                          q0, q0, [sp, #0x70]
0x10002b1ec  stp                          q0, q0, [sp, #0x50]
0x10002b1f0  stp                          q0, q0, [sp, #0x30]
0x10002b1f4  adrp                         x1, #0x100627000
0x10002b1f8  add                          x1, x1, #0xfb5
0x10002b1fc  sub                          x9, x29, #0x30
