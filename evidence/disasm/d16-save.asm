0x1001575b0  mov                          x21, x0
0x1001575b4  ldr                          w8, [x21, #0x18]!
0x1001575b8  cmp                          w1, w8
0x1001575bc  b.ne                         #0x1001575cc
0x1001575c0  mov                          w19, #0
0x1001575c4  cbnz                         w1, #0x10015758c
0x1001575c8  b                            #0x100157598
0x1001575cc  ldp                          x29, x30, [sp, #0x20]
0x1001575d0  ldp                          x20, x19, [sp, #0x10]
0x1001575d4  ldp                          x22, x21, [sp], #0x30
0x1001575d8  ret                          
0x1001575dc  sub                          sp, sp, #0x70
0x1001575e0  stp                          x24, x23, [sp, #0x30]
0x1001575e4  stp                          x22, x21, [sp, #0x40]
0x1001575e8  stp                          x20, x19, [sp, #0x50]
0x1001575ec  stp                          x29, x30, [sp, #0x60]
0x1001575f0  add                          x29, sp, #0x60
0x1001575f4  mov                          x20, x1
0x1001575f8  mov                          x19, x0
0x1001575fc  bl                           #0x10014aa34
0x100157600  ldr                          x8, [x19, #0x20]
0x100157604  cbz                          x8, #0x100157614
0x100157608  mov                          x0, x19
0x10015760c  mov                          x1, x20
0x100157610  b                            #0x100157660
0x100157614  tbnz                         w20, #2, #0x100157658
0x100157618  tbz                          w20, #3, #0x100157640
0x10015761c  adrp                         x0, #0x100625000
0x100157620  add                          x0, x0, #0x5a0
0x100157624  adrp                         x1, #0x100625000
0x100157628  add                          x1, x1, #0x5a1
0x10015762c  adrp                         x3, #0x100632000
0x100157630  add                          x3, x3, #0x86c
0x100157634  mov                          w2, #0
0x100157638  bl                           #0x1005756cc
0x10015763c  bl                           #0x10015698c
0x100157640  ubfx                         w1, w20, #3, #1
0x100157644  add                          x8, sp, #0x28
0x100157648  bl                           #0x100157938
0x10015764c  tbnz                         w20, #1, #0x100157678
0x100157650  mov                          w21, #0
0x100157654  b                            #0x100157680
0x100157658  and                          w1, w20, #0xfffffffb
0x10015765c  mov                          x0, x19
0x100157660  ldp                          x29, x30, [sp, #0x60]
0x100157664  ldp                          x20, x19, [sp, #0x50]
0x100157668  ldp                          x22, x21, [sp, #0x40]
0x10015766c  ldp                          x24, x23, [sp, #0x30]
0x100157670  add                          sp, sp, #0x70
0x100157674  b                            #0x1001580a0
0x100157678  bl                           #0x100157a24
0x10015767c  mov                          x21, x0
0x100157680  add                          x0, sp, #0x10
0x100157684  bl                           #0x100156e94
0x100157688  ldrb                         w8, [sp, #0x10]
0x10015768c  cmp                          w8, #1
0x100157690  b.ne                         #0x1001576a0
0x100157694  ldrb                         w8, [sp, #0x11]
0x100157698  cmp                          w8, #1
0x10015769c  b.ne                         #0x100157740
0x1001576a0  bl                           #0x10015698c
0x1001576a4  ldrb                         w8, [sp, #0x10]
0x1001576a8  tbz                          w8, #0, #0x100157790
0x1001576ac  ldrb                         w8, [sp, #0x11]
0x1001576b0  cmp                          w8, #1
0x1001576b4  b.ne                         #0x100157740
0x1001576b8  bl                           #0x100156b38
0x1001576bc  ldr                          x8, [sp, #0x18]
0x1001576c0  str                          x8, [sp]
0x1001576c4  ldr                          w9, [x8]
0x1001576c8  sub                          w9, w9, #1
0x1001576cc  cmn                          w9, #3
0x1001576d0  b.hi                         #0x1001576dc
0x1001576d4  mov                          w9, #1
0x1001576d8  ldaddal                      w9, w8, [x8]
0x1001576dc  mov                          x1, sp
0x1001576e0  bl                           #0x1001500c8
0x1001576e4  mov                          x22, x0
0x1001576e8  ldr                          x0, [sp]
0x1001576ec  ldr                          w8, [x0]
0x1001576f0  cmn                          w8, #1
0x1001576f4  b.eq                         #0x10015771c
0x1001576f8  cbz                          w8, #0x100157710
0x1001576fc  mov                          w8, #-1
0x100157700  ldaddal                      w8, w8, [x0]
0x100157704  cmp                          w8, #1
0x100157708  b.ne                         #0x10015771c
0x10015770c  ldr                          x0, [sp]
0x100157710  mov                          w1, #2
0x100157714  mov                          w2, #8
0x100157718  bl                           #0x10057f190
0x10015771c  tbnz                         w22, #0, #0x100157740
0x100157720  adrp                         x0, #0x100625000
0x100157724  add                          x0, x0, #0x5a0
0x100157728  adrp                         x1, #0x100625000
0x10015772c  add                          x1, x1, #0x5a1
0x100157730  adrp                         x3, #0x100632000
0x100157734  add                          x3, x3, #0x885
0x100157738  mov                          w2, #0
0x10015773c  bl                           #0x1005756cc
0x100157740  add                          x23, sp, #0x10
0x100157744  mov                          x0, sp
0x100157748  add                          x1, x23, #0x10
0x10015774c  bl                           #0x1005831e0
0x100157750  mov                          x1, sp
0x100157754  mov                          x0, x19
0x100157758  mov                          x2, x21
0x10015775c  bl                           #0x10015813c
0x100157760  mov                          x22, x0
0x100157764  mov                          x0, sp
0x100157768  bl                           #0x1005831f8
0x10015776c  cbz                          w22, #0x1001577bc
0x100157770  mov                          x8, sp
0x100157774  bl                           #0x1001581d8
0x100157778  ldr                          x8, [sp]
0x10015777c  cbz                          x8, #0x100157818
0x100157780  mov                          x1, sp
0x100157784  mov                          x0, x19
0x100157788  bl                           #0x1001582b4
0x10015778c  b                            #0x100157834
0x100157790  ldr                          w1, [x19, #0x18]
0x100157794  cbz                          w1, #0x1001577a0
0x100157798  mov                          x0, x19
0x10015779c  bl                           #0x1005827f0
0x1001577a0  str                          wzr, [x19, #0x18]
0x1001577a4  ldr                          w1, [x19, #0x14]
0x1001577a8  cbz                          w1, #0x1001577b4
0x1001577ac  mov                          x0, x19
0x1001577b0  bl                           #0x1005827f0
0x1001577b4  str                          xzr, [x19, #0x10]
0x1001577b8  b                            #0x100157864
0x1001577bc  add                          x1, sp, #0x28
0x1001577c0  mov                          x0, x19
0x1001577c4  mov                          x2, x21
0x1001577c8  bl                           #0x100158418
0x1001577cc  cbz                          w0, #0x1001577f0
0x1001577d0  mov                          x8, sp
0x1001577d4  bl                           #0x1001581d8
0x1001577d8  ldr                          x8, [sp]
0x1001577dc  cbz                          x8, #0x100157828
0x1001577e0  mov                          x1, sp
0x1001577e4  mov                          x0, x19
0x1001577e8  bl                           #0x1001584a0
0x1001577ec  b                            #0x100157834
0x1001577f0  mov                          x0, sp
0x1001577f4  add                          x1, x23, #0x10
0x1001577f8  bl                           #0x1005831e0
0x1001577fc  mov                          x1, sp
0x100157800  add                          x2, sp, #0x28
0x100157804  mov                          x0, x19
0x100157808  bl                           #0x100158604
0x10015780c  mov                          x0, sp
0x100157810  bl                           #0x1005831f8
0x100157814  b                            #0x100157864
0x100157818  mov                          x0, x19
0x10015781c  mov                          x1, x20
0x100157820  bl                           #0x1001580a0
0x100157824  b                            #0x100157834
0x100157828  mov                          x0, x19
0x10015782c  mov                          x1, x20
0x100157830  bl                           #0x1001580a0
0x100157834  ldr                          x19, [sp, #8]
0x100157838  cbz                          x19, #0x100157864
0x10015783c  add                          x8, x19, #8
0x100157840  mov                          x9, #-1
0x100157844  ldaddal                      x9, x8, [x8]
0x100157848  cbnz                         x8, #0x100157864
0x10015784c  ldr                          x8, [x19]
0x100157850  ldr                          x8, [x8, #0x10]
0x100157854  mov                          x0, x19
0x100157858  blr                          x8
0x10015785c  mov                          x0, x19
0x100157860  bl                           #0x100586330
0x100157864  add                          x8, sp, #0x10
0x100157868  add                          x0, x8, #0x10
0x10015786c  bl                           #0x1005831f8
0x100157870  ldr                          x0, [sp, #0x18]
0x100157874  ldr                          w8, [x0]
0x100157878  cmn                          w8, #1
0x10015787c  b.eq                         #0x1001578a4
0x100157880  cbz                          w8, #0x100157898
0x100157884  mov                          w8, #-1
0x100157888  ldaddal                      w8, w8, [x0]
0x10015788c  cmp                          w8, #1
0x100157890  b.ne                         #0x1001578a4
0x100157894  ldr                          x0, [sp, #0x18]
0x100157898  mov                          w1, #2
0x10015789c  mov                          w2, #8
0x1001578a0  bl                           #0x10057f190
0x1001578a4  add                          x0, sp, #0x28
0x1001578a8  bl                           #0x1005831f8
0x1001578ac  ldp                          x29, x30, [sp, #0x60]
0x1001578b0  ldp                          x20, x19, [sp, #0x50]
0x1001578b4  ldp                          x22, x21, [sp, #0x40]
0x1001578b8  ldp                          x24, x23, [sp, #0x30]
0x1001578bc  add                          sp, sp, #0x70
0x1001578c0  ret                          
0x1001578c4  bl                           #0x1000094f4
0x1001578c8  b                            #0x1001578e4
0x1001578cc  b                            #0x100157904
0x1001578d0  b                            #0x10015791c
0x1001578d4  mov                          x19, x0
0x1001578d8  mov                          x0, sp
0x1001578dc  bl                           #0x100009fbc
0x1001578e0  b                            #0x100157920
0x1001578e4  mov                          x19, x0
0x1001578e8  mov                          x0, sp
0x1001578ec  bl                           #0x100038750
0x1001578f0  b                            #0x100157920
0x1001578f4  b                            #0x10015791c
0x1001578f8  mov                          x19, x0
0x1001578fc  b                            #0x100157928
0x100157900  bl                           #0x1000094f4
0x100157904  mov                          x19, x0
0x100157908  mov                          x0, sp
0x10015790c  bl                           #0x1005831f8
0x100157910  b                            #0x100157920
0x100157914  mov                          x19, x0
0x100157918  b                            #0x100157928
0x10015791c  mov                          x19, x0
0x100157920  add                          x0, sp, #0x10
0x100157924  bl                           #0x1001586cc
0x100157928  add                          x0, sp, #0x28
0x10015792c  bl                           #0x1005831f8
0x100157930  mov                          x0, x19
0x100157934  bl                           #0x10057f058
0x100157938  sub                          sp, sp, #0x30
0x10015793c  stp                          x20, x19, [sp, #0x10]
0x100157940  stp                          x29, x30, [sp, #0x20]
0x100157944  add                          x29, sp, #0x20
0x100157948  mov                          x20, x1
0x10015794c  mov                          x19, x8
0x100157950  bl                           #0x100156be4
0x100157954  mov                          x8, x19
0x100157958  bl                           #0x1001502e0
0x10015795c  mov                          x0, x19
0x100157960  bl                           #0x100585f94
0x100157964  orr                          w8, w0, w20
0x100157968  tbz                          w8, #0, #0x1001579f0
0x10015796c  add                          x8, sp, #8
0x100157970  bl                           #0x100583180
0x100157974  ldr                          x8, [x19]
0x100157978  ldr                          x9, [sp, #8]
0x10015797c  str                          x9, [x19]
0x100157980  str                          x8, [sp, #8]
0x100157984  add                          x0, sp, #8
0x100157988  bl                           #0x1005831f8
0x10015798c  cmp                          w20, #0
0x100157990  mov                          x8, #-0x3a81
0x100157994  movk                         x8, #0xfff6, lsl #16
0x100157998  csinv                        x1, x8, xzr, ne
0x10015799c  add                          x8, sp, #8
0x1001579a0  mov                          x0, x19
0x1001579a4  bl                           #0x100585fb8
0x1001579a8  ldr                          x8, [x19]
0x1001579ac  ldr                          x9, [sp, #8]
0x1001579b0  str                          x9, [x19]
0x1001579b4  str                          x8, [sp, #8]
0x1001579b8  add                          x0, sp, #8
0x1001579bc  bl                           #0x1005831f8
0x1001579c0  bl                           #0x100156be4
0x1001579c4  mov                          x1, x19
0x1001579c8  bl                           #0x1001503d4
0x1001579cc  tbnz                         w0, #0, #0x1001579f0
0x1001579d0  adrp                         x0, #0x100625000
0x1001579d4  add                          x0, x0, #0x5a0
0x1001579d8  adrp                         x1, #0x100625000
0x1001579dc  add                          x1, x1, #0x5a1
0x1001579e0  adrp                         x3, #0x100632000
0x1001579e4  add                          x3, x3, #0x84d
0x1001579e8  mov                          w2, #0
0x1001579ec  bl                           #0x1005756cc
0x1001579f0  ldp                          x29, x30, [sp, #0x20]
0x1001579f4  ldp                          x20, x19, [sp, #0x10]
0x1001579f8  add                          sp, sp, #0x30
0x1001579fc  ret                          
0x100157a00  bl                           #0x1000094f4
0x100157a04  b                            #0x100157a10
0x100157a08  b                            #0x100157a10
0x100157a0c  b                            #0x100157a10
0x100157a10  mov                          x20, x0
0x100157a14  mov                          x0, x19
0x100157a18  bl                           #0x1005831f8
0x100157a1c  mov                          x0, x20
0x100157a20  bl                           #0x10057f058
0x100157a24  sub                          sp, sp, #0x90
0x100157a28  stp                          x24, x23, [sp, #0x50]
0x100157a2c  stp                          x22, x21, [sp, #0x60]
0x100157a30  stp                          x20, x19, [sp, #0x70]
0x100157a34  stp                          x29, x30, [sp, #0x80]
0x100157a38  add                          x29, sp, #0x80
0x100157a3c  bl                           #0x100156de8
0x100157a40  sub                          x8, x29, #0x38
0x100157a44  bl                           #0x10014feec
0x100157a48  adrp                         x0, #0x100628000
0x100157a4c  add                          x0, x0, #0xa7b
0x100157a50  mov                          w1, #1
0x100157a54  bl                           #0x100582964
0x100157a58  str                          x0, [sp, #0x10]
0x100157a5c  add                          x8, sp, #0x40
0x100157a60  sub                          x0, x29, #0x38
0x100157a64  add                          x1, sp, #0x10
0x100157a68  mov                          w2, #1
0x100157a6c  mov                          w3, #1
0x100157a70  bl                           #0x100585a0c
0x100157a74  ldr                          x0, [sp, #0x10]
0x100157a78  ldr                          w8, [x0]
0x100157a7c  cmn                          w8, #1
0x100157a80  b.eq                         #0x100157aa8
0x100157a84  cbz                          w8, #0x100157a9c
0x100157a88  mov                          w8, #-1
0x100157a8c  ldaddal                      w8, w8, [x0]
0x100157a90  cmp                          w8, #1
0x100157a94  b.ne                         #0x100157aa8
0x100157a98  ldr                          x0, [sp, #0x10]
0x100157a9c  mov                          w1, #2
0x100157aa0  mov                          w2, #8
0x100157aa4  bl                           #0x10057f190
0x100157aa8  add                          x8, sp, #0x38
0x100157aac  bl                           #0x100583180
0x100157ab0  ldr                          x8, [sp, #0x40]
0x100157ab4  ldp                          w8, w9, [x8, #8]
0x100157ab8  sub                          w8, w9, w8
0x100157abc  cmp                          w8, #3
0x100157ac0  b.gt                         #0x100157b1c
0x100157ac4  add                          x8, sp, #0x10
0x100157ac8  add                          x0, sp, #0x38
0x100157acc  mov                          w1, #0
0x100157ad0  bl                           #0x100585ff4
0x100157ad4  add                          x0, sp, #0x40
0x100157ad8  add                          x1, sp, #0x10
0x100157adc  bl                           #0x100016fac
0x100157ae0  ldr                          x0, [sp, #0x10]
0x100157ae4  ldr                          w8, [x0]
0x100157ae8  cmn                          w8, #1
0x100157aec  b.eq                         #0x100157b14
0x100157af0  cbz                          w8, #0x100157b08
0x100157af4  mov                          w8, #-1
0x100157af8  ldaddal                      w8, w8, [x0]
0x100157afc  cmp                          w8, #1
0x100157b00  b.ne                         #0x100157b14
0x100157b04  ldr                          x0, [sp, #0x10]
0x100157b08  mov                          w1, #2
0x100157b0c  mov                          w2, #8
0x100157b10  bl                           #0x10057f190
0x100157b14  mov                          w19, #1
0x100157b18  b                            #0x100157dbc
0x100157b1c  add                          x0, sp, #0x30
0x100157b20  add                          x1, sp, #0x38
0x100157b24  bl                           #0x1005831e0
0x100157b28  ldr                          x8, [sp, #0x40]
0x100157b2c  str                          x8, [sp, #0x10]
0x100157b30  ldr                          w9, [x8]
0x100157b34  sub                          w10, w9, #1
0x100157b38  cmn                          w10, #3
0x100157b3c  b.hi                         #0x100157b4c
0x100157b40  mov                          w9, #1
0x100157b44  ldaddal                      w9, w8, [x8]
0x100157b48  b                            #0x100157b6c
0x100157b4c  cbnz                         w9, #0x100157b6c
0x100157b50  ldr                          w1, [x8, #4]
0x100157b54  add                          x0, sp, #0x10
0x100157b58  bl                           #0x10058336c
0x100157b5c  ldr                          x8, [sp, #0x10]
0x100157b60  ldpsw                        x9, x10, [x8, #8]
0x100157b64  cmp                          w9, w10
0x100157b68  b.ne                         #0x100157f5c
0x100157b6c  ldr                          x19, [sp, #0x10]
0x100157b70  add                          x8, x19, #0x10
0x100157b74  ldrsw                        x9, [x19, #8]
0x100157b78  add                          x20, x8, x9, lsl #3
0x100157b7c  str                          x20, [sp, #0x18]
0x100157b80  ldrsw                        x10, [x19, #0xc]
0x100157b84  add                          x8, x8, x10, lsl #3
0x100157b88  str                          x8, [sp, #0x20]
0x100157b8c  mov                          w8, #1
0x100157b90  str                          w8, [sp, #0x28]
0x100157b94  cmp                          w9, w10
0x100157b98  b.ne                         #0x100157bb4
0x100157b9c  b                            #0x100157c10
0x100157ba0  ldp                          x8, x9, [sp, #0x18]
0x100157ba4  add                          x20, x8, #8
0x100157ba8  str                          x20, [sp, #0x18]
0x100157bac  cmp                          x20, x9
0x100157bb0  b.eq                         #0x100157c0c
0x100157bb4  add                          x8, sp, #8
0x100157bb8  mov                          x0, x20
0x100157bbc  mov                          w1, #0
0x100157bc0  bl                           #0x10058315c
0x100157bc4  add                          x0, sp, #8
0x100157bc8  add                          x1, sp, #0x30
0x100157bcc  bl                           #0x100586018
0x100157bd0  mov                          x19, x0
0x100157bd4  add                          x0, sp, #8
0x100157bd8  bl                           #0x1005831f8
0x100157bdc  cbz                          w19, #0x100157ba0
0x100157be0  add                          x8, sp, #8
0x100157be4  mov                          x0, x20
0x100157be8  mov                          w1, #0
0x100157bec  bl                           #0x10058315c
0x100157bf0  ldr                          x8, [sp, #0x30]
0x100157bf4  ldr                          x9, [sp, #8]
0x100157bf8  str                          x9, [sp, #0x30]
0x100157bfc  str                          x8, [sp, #8]
0x100157c00  add                          x0, sp, #8
0x100157c04  bl                           #0x1005831f8
0x100157c08  b                            #0x100157ba0
0x100157c0c  ldr                          x19, [sp, #0x10]
0x100157c10  ldr                          w8, [x19]
0x100157c14  cmn                          w8, #1
0x100157c18  b.eq                         #0x100157c48
0x100157c1c  cbz                          w8, #0x100157c34
0x100157c20  mov                          w8, #-1
0x100157c24  ldaddal                      w8, w8, [x19]
0x100157c28  cmp                          w8, #1
0x100157c2c  b.ne                         #0x100157c48
0x100157c30  ldr                          x19, [sp, #0x10]
0x100157c34  ldpsw                        x8, x9, [x19, #8]
0x100157c38  cmp                          w9, w8
0x100157c3c  b.ne                         #0x100157cb4
0x100157c40  mov                          x0, x19
0x100157c44  bl                           #0x10058339c
0x100157c48  add                          x0, sp, #0x30
0x100157c4c  add                          x1, sp, #0x38
0x100157c50  bl                           #0x100586018
0x100157c54  tbz                          w0, #0, #0x100157c8c
0x100157c58  add                          x8, sp, #0x10
0x100157c5c  add                          x0, sp, #0x30
0x100157c60  mov                          w1, #1
0x100157c64  bl                           #0x100585fac
0x100157c68  add                          x0, sp, #0x38
0x100157c6c  add                          x1, sp, #0x10
0x100157c70  bl                           #0x100586018
0x100157c74  mov                          x19, x0
0x100157c78  add                          x0, sp, #0x10
0x100157c7c  bl                           #0x1005831f8
0x100157c80  tbz                          w19, #0, #0x100157d10
0x100157c84  mov                          w19, #0
0x100157c88  b                            #0x100157db4
0x100157c8c  add                          x0, sp, #0x40
0x100157c90  bl                           #0x1000c1e90
0x100157c94  add                          x8, sp, #0x10
0x100157c98  add                          x0, sp, #0x38
0x100157c9c  mov                          w1, #0
0x100157ca0  bl                           #0x100585ff4
0x100157ca4  add                          x0, sp, #0x40
0x100157ca8  add                          x1, sp, #0x10
0x100157cac  bl                           #0x100016fac
0x100157cb0  b                            #0x100157d7c
0x100157cb4  lsl                          x9, x9, #3
0x100157cb8  add                          x10, x9, x19
0x100157cbc  add                          x20, x10, #8
0x100157cc0  lsl                          x8, x8, #3
0x100157cc4  sub                          x21, x8, x9
0x100157cc8  mov                          w22, #-1
0x100157ccc  b                            #0x100157ce8
0x100157cd0  mov                          w1, #2
0x100157cd4  mov                          w2, #8
0x100157cd8  bl                           #0x10057f190
0x100157cdc  sub                          x20, x20, #8
0x100157ce0  adds                         x21, x21, #8
0x100157ce4  b.eq                         #0x100157c40
0x100157ce8  ldr                          x0, [x20]
0x100157cec  ldr                          w8, [x0]
0x100157cf0  cmn                          w8, #1
0x100157cf4  b.eq                         #0x100157cdc
0x100157cf8  cbz                          w8, #0x100157cd0
0x100157cfc  ldaddal                      w22, w8, [x0]
