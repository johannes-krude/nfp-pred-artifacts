   0:	  .0  immed[gprB_22, 0x3fff]
   8:	  .1  alu[gprB_22, gprB_22, AND, *l$index1]
  10:	  .2  alu[gprA_4, gprB_22, +, *l$index1[2]], gpr_wrboth
  18:	  .3  immed[gprA_5, 0x0], gpr_wrboth
  20:	  .4  alu[gprA_2, --, B, *l$index1[2]], gpr_wrboth
  28:	  .5  immed[gprA_3, 0x0], gpr_wrboth
  30:	  .6  alu[gprA_6, --, B, gprB_2], gpr_wrboth
  38:	  .7  alu[gprA_7, --, B, gprB_3], gpr_wrboth
  40:	  .8  alu[gprA_6, gprA_6, +, 0xe], gpr_wrboth
  48:	  .9  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
  50:	 .10  alu[--, gprA_4, -, gprB_6]
  58:	 .11  alu[--, gprA_5, -carry, gprB_7]
  60:	 .12  bcc[.121]
  68:	 .13  alu[gprA_6, --, B, gprB_2], gpr_wrboth
  70:	 .14  alu[gprA_7, --, B, gprB_3], gpr_wrboth
  78:	 .15  alu[gprA_6, gprA_6, +, 0x22], gpr_wrboth
  80:	 .16  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
  88:	 .17  alu[--, gprA_4, -, gprB_6]
  90:	 .18  alu[--, gprA_5, -carry, gprB_7]
  98:	 .19  bcc[.121]
  a0:	 .20  mem[read32_swap, $xfer_0, gprA_2, 0xc, 8], ctx_swap[sig1]
  a8:	 .21  ld_field_w_clr[gprA_6, 0001, $xfer_0, >>8], gpr_wrboth
  b0:	 .22  immed[gprA_7, 0x0], gpr_wrboth
  b8:	 .23  dbl_shf[gprA_7, gprA_7, gprB_6, >>24], gpr_wrboth
  c0:	 .24  alu_shf[gprA_6, --, B, gprB_6, <<8], gpr_wrboth
  c8:	 .25  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
  d0:	 .26  immed[gprA_9, 0x0], gpr_wrboth
  d8:	 .27  alu[gprA_6, gprA_6, OR, gprB_8], gpr_wrboth
  e0:	 .28  alu[gprA_7, gprA_7, OR, gprB_9], gpr_wrboth
  e8:	 .29  immed[gprB_21, 0xffff]
  f0:	 .30  alu[gprA_6, gprA_6, AND, gprB_21], gpr_wrboth
  f8:	 .31  immed[gprA_7, 0x0], gpr_wrboth
 100:	 .32  alu[--, gprA_6, XOR, 0x8]
 108:	 .33  bne[.121]
 110:	 .34  alu[--, gprA_7, XOR, 0x0]
 118:	 .35  bne[.121]
 120:	 .36  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 128:	 .37  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 130:	 .38  alu[gprA_6, gprA_6, +, 0x2a], gpr_wrboth
 138:	 .39  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 140:	 .40  alu[--, gprA_4, -, gprB_6]
 148:	 .41  alu[--, gprA_5, -carry, gprB_7]
 150:	 .42  bcc[.121]
 158:	 .43  ld_field_w_clr[gprA_6, 0001, $xfer_2, >>24], gpr_wrboth
 160:	 .44  immed[gprA_7, 0x0], gpr_wrboth
 168:	 .45  alu[--, gprA_6, XOR, 0x11]
 170:	 .46  bne[.121]
 178:	 .47  alu[--, gprA_7, XOR, 0x0]
 180:	 .48  bne[.121]
 188:	 .49  ld_field_w_clr[gprA_6, 0011, $xfer_6], gpr_wrboth
 190:	 .50  immed[gprA_7, 0x0], gpr_wrboth
 198:	 .51  immed[gprB_21, 0x204]
 1a0:	 .52  alu[--, gprA_6, XOR, gprB_21]
 1a8:	 .53  bne[.121]
 1b0:	 .54  alu[--, gprA_7, XOR, 0x0]
 1b8:	 .55  bne[.121]
 1c0:	 .56  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 1c8:	 .57  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 1d0:	 .58  alu[gprA_6, gprA_6, +, 0x36], gpr_wrboth
 1d8:	 .59  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 1e0:	 .60  alu[--, gprA_4, -, gprB_6]
 1e8:	 .61  alu[--, gprA_5, -carry, gprB_7]
 1f0:	 .62  bcc[.121]
 1f8:	 .63  ld_field_w_clr[gprA_6, 0001, $xfer_7, >>24], gpr_wrboth
 200:	 .64  immed[gprA_7, 0x0], gpr_wrboth
 208:	 .65  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 210:	 .66  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 218:	 .67  alu[gprA_8, gprA_8, AND, 0x7f], gpr_wrboth
 220:	 .68  immed[gprA_9, 0x0], gpr_wrboth
 228:	 .69  alu[--, gprA_8, XOR, 0x8]
 230:	 .70  bne[.121]
 238:	 .71  alu[--, gprA_9, XOR, 0x0]
 240:	 .72  bne[.121]
 248:	 .73  alu[gprA_6, gprA_6, AND, 0x80], gpr_wrboth
 250:	 .74  immed[gprA_7, 0x0], gpr_wrboth
 258:	 .75  alu[$xfer_0, --, B, gprA_6]
 260:	 .76  mem[write8_swap, $xfer_0, gprA_2, 0x2b, 1], ctx_swap[sig1]
 268:	 .77  immed[gprA_6, 0x0], gpr_wrboth
 270:	 .78  immed[gprA_7, 0x0], gpr_wrboth
 278:	 .79  immed[gprA_8, 0x8000, <<16], gpr_wrboth
 280:	 .80  immed[gprA_9, 0x0], gpr_wrboth
 288:	 .81  immed[gprA_10, 0xfffffffe], gpr_wrboth
 290:	 .82  immed[gprA_11, 0x0], gpr_wrboth
 298:	 .83  alu[gprA_12, --, B, gprB_2], gpr_wrboth
 2a0:	 .84  alu[gprA_13, --, B, gprB_3], gpr_wrboth
 2a8:	 .85  alu[gprA_12, gprA_12, +, gprB_6], gpr_wrboth
 2b0:	 .86  alu[gprA_13, gprA_13, +carry, gprB_7], gpr_wrboth
 2b8:	 .87  alu[gprA_14, --, B, gprB_12], gpr_wrboth
 2c0:	 .88  alu[gprA_15, --, B, gprB_13], gpr_wrboth
 2c8:	 .89  alu[gprA_14, gprA_14, +, 0x37], gpr_wrboth
 2d0:	 .90  alu[gprA_15, gprA_15, +carry, 0x0], gpr_wrboth
 2d8:	 .91  alu[--, gprA_4, -, gprB_14]
 2e0:	 .92  alu[--, gprA_5, -carry, gprB_15]
 2e8:	 .93  bcc[.121]
 2f0:	 .94  mem[read32_swap, $xfer_0, gprA_12, 0x36, 1], ctx_swap[sig1]
 2f8:	 .95  ld_field_w_clr[gprA_14, 0001, $xfer_0], gpr_wrboth
 300:	 .96  immed[gprA_15, 0x0], gpr_wrboth
 308:	 .97  alu[gprA_16, --, B, gprB_14], gpr_wrboth
 310:	 .98  alu[gprA_17, --, B, gprB_15], gpr_wrboth
 318:	 .99  alu[gprA_16, gprA_16, AND, 0x80], gpr_wrboth
 320:	.100  immed[gprA_17, 0x0], gpr_wrboth
 328:	.101  alu[gprA_14, gprA_14, AND, 0x7f], gpr_wrboth
 330:	.102  immed[gprA_15, 0x0], gpr_wrboth
 338:	.103  alu[gprA_14, gprA_14, XOR, 0x55], gpr_wrboth
 340:	.104  alu[--, 0x7, -, gprA_14]
 348:	.105  alu[--, 0x0, -carry, gprA_15]
 350:	.106  bcc[.124]
 358:	.107  dbl_shf[gprA_15, gprA_15, gprB_14, >>31], gpr_wrboth
 360:	.108  alu_shf[gprA_14, --, B, gprB_14, <<1], gpr_wrboth
 368:	.109  alu[gprA_14, gprA_14, OR, 0x1], gpr_wrboth
 370:	.110  alu[gprA_14, gprA_14, OR, gprB_16], gpr_wrboth
 378:	.111  alu[gprA_15, gprA_15, OR, gprB_17], gpr_wrboth
 380:	.112  alu[gprA_14, gprA_14, XOR, 0x7f], gpr_wrboth
 388:	.113  alu[$xfer_0, --, B, gprA_14]
 390:	.114  mem[write8_swap, $xfer_0, gprA_12, 0x36, 1], ctx_swap[sig1]
 398:	.115  alu[gprA_6, gprA_6, +, 0x1], gpr_wrboth
 3a0:	.116  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 3a8:	.117  alu[--, gprA_6, XOR, 0xa0]
 3b0:	.118  bne[.83]
 3b8:	.119  alu[--, gprA_7, XOR, 0x0]
 3c0:	.120  bne[.83]
 3c8:	.121  immed[gprA_0, 0x2], gpr_wrboth
 3d0:	.122  immed[gprA_1, 0x0], gpr_wrboth
 3d8:	.123  br[.15000]
 3e0:	.124  alu[--, 0x16, -, gprA_14]
 3e8:	.125  alu[--, 0x0, -carry, gprA_15]
 3f0:	.126  bcc[.130]
 3f8:	.127  alu[gprA_14, gprA_14, +, 0x8], gpr_wrboth
 400:	.128  alu[gprA_15, gprA_15, +carry, 0x0], gpr_wrboth
 408:	.129  br[.110]
 410:	.130  alu[--, 0x1e, -, gprA_14]
 418:	.131  alu[--, 0x0, -carry, gprA_15]
 420:	.132  bcc[.154]
 428:	.133  immed[gprA_0, 0x20], gpr_wrboth
 430:	.134  immed[gprA_1, 0x0], gpr_wrboth
 438:	.135  alu[gprA_0, gprA_0, -, gprB_14], gpr_wrboth
 440:	.136  alu[gprA_1, gprA_1, -carry, gprB_15], gpr_wrboth
 448:	.137  alu[gprA_18, --, B, gprB_0], gpr_wrboth
 450:	.138  alu[gprA_19, --, B, gprB_1], gpr_wrboth
 458:	.139  alu[gprA_18, gprA_18, AND, gprB_8], gpr_wrboth
 460:	.140  alu[gprA_19, gprA_19, AND, gprB_9], gpr_wrboth
 468:	.141  dbl_shf[gprA_18, gprA_19, gprB_18, >>31], gpr_wrboth
 470:	.142  alu_shf[gprA_19, --, B, gprB_19, >>31], gpr_wrboth
 478:	.143  alu[gprA_0, gprA_0, +, gprB_18], gpr_wrboth
 480:	.144  alu[gprA_1, gprA_1, +carry, gprB_19], gpr_wrboth
 488:	.145  alu[gprA_0, gprA_0, AND, gprB_10], gpr_wrboth
 490:	.146  alu[gprA_1, gprA_1, AND, gprB_11], gpr_wrboth
 498:	.147  dbl_shf[gprA_0, gprA_1, gprB_0, >>1], gpr_wrboth
 4a0:	.148  alu_shf[gprA_1, --, B, gprB_1, >>1], gpr_wrboth
 4a8:	.149  alu[gprA_14, gprA_14, +, gprB_0], gpr_wrboth
 4b0:	.150  alu[gprA_15, gprA_15, +carry, gprB_1], gpr_wrboth
 4b8:	.151  alu[gprA_14, gprA_14, +, 0x4], gpr_wrboth
 4c0:	.152  alu[gprA_15, gprA_15, +carry, 0x0], gpr_wrboth
 4c8:	.153  br[.110]
 4d0:	.154  alu[--, 0x2c, -, gprA_14]
 4d8:	.155  alu[--, 0x0, -carry, gprA_15]
 4e0:	.156  bcc[.160]
 4e8:	.157  alu[gprA_14, gprA_14, +, 0x4], gpr_wrboth
 4f0:	.158  alu[gprA_15, gprA_15, +carry, 0x0], gpr_wrboth
 4f8:	.159  br[.110]
 500:	.160  alu[--, 0x2e, -, gprA_14]
 508:	.161  alu[--, 0x0, -carry, gprA_15]
 510:	.162  bcc[.166]
 518:	.163  alu[gprA_14, gprA_14, +, 0x3], gpr_wrboth
 520:	.164  alu[gprA_15, gprA_15, +carry, 0x0], gpr_wrboth
 528:	.165  br[.110]
 530:	.166  alu[--, 0x3e, -, gprA_14]
 538:	.167  alu[--, 0x0, -carry, gprA_15]
 540:	.168  bcc[.172]
 548:	.169  alu[gprA_14, gprA_14, +, 0x2], gpr_wrboth
 550:	.170  alu[gprA_15, gprA_15, +carry, 0x0], gpr_wrboth
 558:	.171  br[.110]
 560:	.172  immed[gprA_18, 0x1], gpr_wrboth
 568:	.173  immed[gprA_19, 0x0], gpr_wrboth
 570:	.174  immed[gprA_0, 0x50], gpr_wrboth
 578:	.175  immed[gprA_1, 0x0], gpr_wrboth
 580:	.176  alu[--, gprA_14, -, gprB_0]
 588:	.177  alu[--, gprA_15, -carry, gprB_1]
 590:	.178  bcc[.181]
 598:	.179  immed[gprA_18, 0x0], gpr_wrboth
 5a0:	.180  immed[gprA_19, 0x0], gpr_wrboth
 5a8:	.181  alu[gprA_14, gprA_14, +, gprB_18], gpr_wrboth
 5b0:	.182  alu[gprA_15, gprA_15, +carry, gprB_19], gpr_wrboth
 5b8:	.183  br[.110]
 5c0:	.184  br[.15000], defer[2]
 5c8:	.185  alu[gprA_0, --, B, 0x0]
 5d0:	.186  ld_field[gprA_0, 1100, 0x82, <<16]
 5d8:	.187  alu[--, 0x3, -, gprB_0]
 5e0:	.188  bcc[.184]
 5e8:	.189  immed[gprB_2, 0x2282]
 5f0:	.190  immed_w1[gprB_2, 0x4411]
 5f8:	.191  alu_shf[gprA_1, --, B, gprB_0, <<3]
 600:	.192  alu[--, gprA_1, OR, 0x0]
 608:	.193  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
 610:	.194  br[.15000], defer[2]
 618:	.195  alu[gprA_0, --, B, 0x0]
 620:	.196  ld_field[gprA_0, 1100, gprB_2, <<16]
 628:	.197  nop
 630:	.198  nop
 638:	.199  nop
 640:	.200  nop
 648:	.201  nop
 650:	.202  nop
 658:	.203  nop
 660:	.204  nop
