0x100513620  sub                          sp, sp, #0x30
0x100513624  stp                          x20, x19, [sp, #0x10]
0x100513628  stp                          x29, x30, [sp, #0x20]
0x10051362c  add                          x29, sp, #0x20
0x100513630  mov                          x19, x8
0x100513634  mov                          x8, sp
0x100513638  bl                           #0x1005130f4
0x10051363c  ldr                          x8, [sp]
0x100513640  str                          x8, [x19]
0x100513644  ldr                          w9, [x8]
0x100513648  sub                          w9, w9, #1
0x10051364c  cmn                          w9, #3
0x100513650  b.hi                         #0x10051365c
0x100513654  mov                          w9, #1
0x100513658  ldaddal                      w9, w8, [x8]
0x10051365c  adrp                         x0, #0x10067d000
0x100513660  add                          x0, x0, #0x2fe
0x100513664  add                          x8, sp, #8
0x100513668  mov                          w1, #0xe
0x10051366c  bl                           #0x10058294c
0x100513670  add                          x1, sp, #8
0x100513674  mov                          x0, x19
0x100513678  bl                           #0x1005829dc
0x10051367c  ldr                          x0, [sp, #8]
0x100513680  ldr                          w8, [x0]
0x100513684  cmn                          w8, #1
0x100513688  b.eq                         #0x1005136b0
0x10051368c  cbz                          w8, #0x1005136a4
0x100513690  mov                          w8, #-1
0x100513694  ldaddal                      w8, w8, [x0]
0x100513698  cmp                          w8, #1
0x10051369c  b.ne                         #0x1005136b0
0x1005136a0  ldr                          x0, [sp, #8]
0x1005136a4  mov                          w1, #2
0x1005136a8  mov                          w2, #8
0x1005136ac  bl                           #0x10057f190
0x1005136b0  ldr                          x0, [sp]
0x1005136b4  ldr                          w8, [x0]
0x1005136b8  cmn                          w8, #1
0x1005136bc  b.eq                         #0x1005136e4
0x1005136c0  cbz                          w8, #0x1005136d8
0x1005136c4  mov                          w8, #-1
0x1005136c8  ldaddal                      w8, w8, [x0]
0x1005136cc  cmp                          w8, #1
0x1005136d0  b.ne                         #0x1005136e4
0x1005136d4  ldr                          x0, [sp]
0x1005136d8  mov                          w1, #2
0x1005136dc  mov                          w2, #8
0x1005136e0  bl                           #0x10057f190
0x1005136e4  ldp                          x29, x30, [sp, #0x20]
0x1005136e8  ldp                          x20, x19, [sp, #0x10]
0x1005136ec  add                          sp, sp, #0x30
0x1005136f0  ret                          
0x1005136f4  mov                          x20, x0
0x1005136f8  add                          x0, sp, #8
0x1005136fc  bl                           #0x100009fbc
0x100513700  b                            #0x100513708
0x100513704  mov                          x20, x0
0x100513708  mov                          x0, x19
0x10051370c  bl                           #0x100009fbc
0x100513710  mov                          x0, sp
0x100513714  bl                           #0x100009fbc
0x100513718  mov                          x0, x20
0x10051371c  bl                           #0x10057f058
0x100513720  sub                          sp, sp, #0x40
0x100513724  stp                          x20, x19, [sp, #0x20]
0x100513728  stp                          x29, x30, [sp, #0x30]
0x10051372c  add                          x29, sp, #0x30
0x100513730  mov                          x19, x8
0x100513734  adrp                         x0, #0x100625000
0x100513738  add                          x0, x0, #0xb3e
0x10051373c  mov                          w1, #5
0x100513740  bl                           #0x100582964
0x100513744  str                          x0, [sp, #0x10]
0x100513748  add                          x8, sp, #8
0x10051374c  bl                           #0x1005130f4
0x100513750  add                          x8, sp, #0x18
0x100513754  add                          x0, sp, #0x10
0x100513758  add                          x1, sp, #8
0x10051375c  mov                          w2, #0
0x100513760  mov                          w3, #0x20
0x100513764  bl                           #0x100585994
0x100513768  adrp                         x0, #0x100630000
0x10051376c  add                          x0, x0, #0x4c2
0x100513770  mov                          w1, #0x16
0x100513774  bl                           #0x100582964
0x100513778  str                          x0, [sp]
0x10051377c  add                          x0, sp, #0x18
0x100513780  mov                          x1, sp
0x100513784  mov                          x8, x19
0x100513788  mov                          w2, #0
0x10051378c  mov                          w3, #0x20
0x100513790  bl                           #0x100585994
0x100513794  ldr                          x0, [sp]
0x100513798  ldr                          w8, [x0]
0x10051379c  cmn                          w8, #1
0x1005137a0  b.eq                         #0x1005137c8
0x1005137a4  cbz                          w8, #0x1005137bc
0x1005137a8  mov                          w8, #-1
0x1005137ac  ldaddal                      w8, w8, [x0]
0x1005137b0  cmp                          w8, #1
0x1005137b4  b.ne                         #0x1005137c8
0x1005137b8  ldr                          x0, [sp]
0x1005137bc  mov                          w1, #2
0x1005137c0  mov                          w2, #8
0x1005137c4  bl                           #0x10057f190
0x1005137c8  ldr                          x0, [sp, #0x18]
0x1005137cc  ldr                          w8, [x0]
0x1005137d0  cmn                          w8, #1
0x1005137d4  b.eq                         #0x1005137fc
0x1005137d8  cbz                          w8, #0x1005137f0
0x1005137dc  mov                          w8, #-1
0x1005137e0  ldaddal                      w8, w8, [x0]
0x1005137e4  cmp                          w8, #1
0x1005137e8  b.ne                         #0x1005137fc
0x1005137ec  ldr                          x0, [sp, #0x18]
0x1005137f0  mov                          w1, #2
0x1005137f4  mov                          w2, #8
0x1005137f8  bl                           #0x10057f190
0x1005137fc  ldr                          x0, [sp, #8]
0x100513800  ldr                          w8, [x0]
0x100513804  cmn                          w8, #1
0x100513808  b.eq                         #0x100513830
0x10051380c  cbz                          w8, #0x100513824
0x100513810  mov                          w8, #-1
0x100513814  ldaddal                      w8, w8, [x0]
0x100513818  cmp                          w8, #1
0x10051381c  b.ne                         #0x100513830
0x100513820  ldr                          x0, [sp, #8]
0x100513824  mov                          w1, #2
0x100513828  mov                          w2, #8
0x10051382c  bl                           #0x10057f190
0x100513830  ldr                          x0, [sp, #0x10]
0x100513834  ldr                          w8, [x0]
0x100513838  cmn                          w8, #1
0x10051383c  b.eq                         #0x100513864
0x100513840  cbz                          w8, #0x100513858
0x100513844  mov                          w8, #-1
0x100513848  ldaddal                      w8, w8, [x0]
0x10051384c  cmp                          w8, #1
0x100513850  b.ne                         #0x100513864
0x100513854  ldr                          x0, [sp, #0x10]
0x100513858  mov                          w1, #2
0x10051385c  mov                          w2, #8
0x100513860  bl                           #0x10057f190
0x100513864  ldp                          x29, x30, [sp, #0x30]
0x100513868  ldp                          x20, x19, [sp, #0x20]
0x10051386c  add                          sp, sp, #0x40
0x100513870  ret                          
0x100513874  mov                          x19, x0
0x100513878  mov                          x0, sp
0x10051387c  bl                           #0x100009fbc
0x100513880  b                            #0x100513888
0x100513884  mov                          x19, x0
0x100513888  add                          x0, sp, #0x18
0x10051388c  bl                           #0x100009fbc
0x100513890  b                            #0x100513898
0x100513894  mov                          x19, x0
0x100513898  add                          x0, sp, #8
0x10051389c  bl                           #0x100009fbc
0x1005138a0  b                            #0x1005138a8
0x1005138a4  mov                          x19, x0
0x1005138a8  add                          x0, sp, #0x10
0x1005138ac  bl                           #0x100009fbc
0x1005138b0  mov                          x0, x19
0x1005138b4  bl                           #0x10057f058
0x1005138b8  sub                          sp, sp, #0x40
0x1005138bc  stp                          x20, x19, [sp, #0x20]
0x1005138c0  stp                          x29, x30, [sp, #0x30]
0x1005138c4  add                          x29, sp, #0x30
0x1005138c8  mov                          x19, x8
0x1005138cc  adrp                         x0, #0x100625000
0x1005138d0  add                          x0, x0, #0xb3e
0x1005138d4  mov                          w1, #5
0x1005138d8  bl                           #0x100582964
0x1005138dc  str                          x0, [sp, #0x10]
0x1005138e0  add                          x8, sp, #8
0x1005138e4  bl                           #0x1005130f4
0x1005138e8  add                          x8, sp, #0x18
0x1005138ec  add                          x0, sp, #0x10
0x1005138f0  add                          x1, sp, #8
0x1005138f4  mov                          w2, #0
0x1005138f8  mov                          w3, #0x20
0x1005138fc  bl                           #0x100585994
0x100513900  adrp                         x0, #0x100630000
0x100513904  add                          x0, x0, #0x4d9
0x100513908  mov                          w1, #0x1d
0x10051390c  bl                           #0x100582964
0x100513910  str                          x0, [sp]
0x100513914  add                          x0, sp, #0x18
0x100513918  mov                          x1, sp
0x10051391c  mov                          x8, x19
0x100513920  mov                          w2, #0
0x100513924  mov                          w3, #0x20
0x100513928  bl                           #0x100585994
0x10051392c  ldr                          x0, [sp]
0x100513930  ldr                          w8, [x0]
0x100513934  cmn                          w8, #1
0x100513938  b.eq                         #0x100513960
0x10051393c  cbz                          w8, #0x100513954
0x100513940  mov                          w8, #-1
0x100513944  ldaddal                      w8, w8, [x0]
0x100513948  cmp                          w8, #1
0x10051394c  b.ne                         #0x100513960
0x100513950  ldr                          x0, [sp]
0x100513954  mov                          w1, #2
0x100513958  mov                          w2, #8
0x10051395c  bl                           #0x10057f190
0x100513960  ldr                          x0, [sp, #0x18]
0x100513964  ldr                          w8, [x0]
0x100513968  cmn                          w8, #1
0x10051396c  b.eq                         #0x100513994
0x100513970  cbz                          w8, #0x100513988
0x100513974  mov                          w8, #-1
0x100513978  ldaddal                      w8, w8, [x0]
0x10051397c  cmp                          w8, #1
0x100513980  b.ne                         #0x100513994
0x100513984  ldr                          x0, [sp, #0x18]
0x100513988  mov                          w1, #2
0x10051398c  mov                          w2, #8
0x100513990  bl                           #0x10057f190
0x100513994  ldr                          x0, [sp, #8]
0x100513998  ldr                          w8, [x0]
0x10051399c  cmn                          w8, #1
0x1005139a0  b.eq                         #0x1005139c8
0x1005139a4  cbz                          w8, #0x1005139bc
0x1005139a8  mov                          w8, #-1
0x1005139ac  ldaddal                      w8, w8, [x0]
0x1005139b0  cmp                          w8, #1
0x1005139b4  b.ne                         #0x1005139c8
0x1005139b8  ldr                          x0, [sp, #8]
0x1005139bc  mov                          w1, #2
0x1005139c0  mov                          w2, #8
0x1005139c4  bl                           #0x10057f190
0x1005139c8  ldr                          x0, [sp, #0x10]
0x1005139cc  ldr                          w8, [x0]
0x1005139d0  cmn                          w8, #1
0x1005139d4  b.eq                         #0x1005139fc
0x1005139d8  cbz                          w8, #0x1005139f0
0x1005139dc  mov                          w8, #-1
0x1005139e0  ldaddal                      w8, w8, [x0]
0x1005139e4  cmp                          w8, #1
0x1005139e8  b.ne                         #0x1005139fc
0x1005139ec  ldr                          x0, [sp, #0x10]
0x1005139f0  mov                          w1, #2
0x1005139f4  mov                          w2, #8
0x1005139f8  bl                           #0x10057f190
0x1005139fc  ldp                          x29, x30, [sp, #0x30]
0x100513a00  ldp                          x20, x19, [sp, #0x20]
0x100513a04  add                          sp, sp, #0x40
0x100513a08  ret                          
0x100513a0c  mov                          x19, x0
0x100513a10  mov                          x0, sp
0x100513a14  bl                           #0x100009fbc
0x100513a18  b                            #0x100513a20
0x100513a1c  mov                          x19, x0
0x100513a20  add                          x0, sp, #0x18
0x100513a24  bl                           #0x100009fbc
0x100513a28  b                            #0x100513a30
0x100513a2c  mov                          x19, x0
0x100513a30  add                          x0, sp, #8
0x100513a34  bl                           #0x100009fbc
0x100513a38  b                            #0x100513a40
0x100513a3c  mov                          x19, x0
0x100513a40  add                          x0, sp, #0x10
0x100513a44  bl                           #0x100009fbc
0x100513a48  mov                          x0, x19
0x100513a4c  bl                           #0x10057f058
0x100513a50  sub                          sp, sp, #0x30
0x100513a54  stp                          x20, x19, [sp, #0x10]
0x100513a58  stp                          x29, x30, [sp, #0x20]
0x100513a5c  add                          x29, sp, #0x20
