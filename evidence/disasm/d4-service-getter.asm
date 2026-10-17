0x100279b3c  ldrb                         w8, [x0, #0x38]
0x100279b40  tbz                          w8, #0, #0x100279b4c
0x100279b44  mov                          w0, #-0xdeb2
0x100279b48  ret                          
0x100279b4c  add                          x0, x0, #0x18
0x100279b50  b                            #0x10031a878
0x100279b54  sub                          sp, sp, #0x80
0x100279b58  stp                          x24, x23, [sp, #0x40]
0x100279b5c  stp                          x22, x21, [sp, #0x50]
0x100279b60  stp                          x20, x19, [sp, #0x60]
0x100279b64  stp                          x29, x30, [sp, #0x70]
0x100279b68  add                          x29, sp, #0x70
0x100279b6c  mov                          x22, x3
0x100279b70  mov                          x20, x2
0x100279b74  mov                          x21, x1
0x100279b78  mov                          x19, x0
0x100279b7c  mov                          x0, x1
0x100279b80  mov                          x1, x2
0x100279b84  bl                           #0x1004626ac
0x100279b88  tbz                          w0, #0, #0x100279c9c
0x100279b8c  add                          x24, sp, #0x18
0x100279b90  add                          x0, sp, #0x18
0x100279b94  bl                           #0x10057f6ac
0x100279b98  adrp                         x8, #0x1006b8000
0x100279b9c  ldr                          x8, [x8, #0x358]
0x100279ba0  stp                          x8, x8, [sp, #0x28]
0x100279ba4  add                          x0, sp, #0x18
0x100279ba8  mov                          x1, x21
0x100279bac  mov                          x2, x20
0x100279bb0  bl                           #0x1003190c8
0x100279bb4  tbz                          w0, #0, #0x100279cc4
0x100279bb8  tbz                          w22, #1, #0x100279c20
0x100279bbc  adrp                         x0, #0x100632000
0x100279bc0  add                          x0, x0, #0x436
0x100279bc4  mov                          w1, #7
0x100279bc8  bl                           #0x100582964
0x100279bcc  str                          x0, [sp]
