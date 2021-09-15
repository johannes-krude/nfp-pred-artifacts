   0:	   .0  immed[gprB_22, 0x3fff]
   8:	   .1  alu[gprB_22, gprB_22, AND, *l$index1]
  10:	   .2  immed[gprA_0, 0x2], gpr_wrboth
  18:	   .3  immed[gprA_1, 0x0], gpr_wrboth
  20:	   .4  alu[gprA_4, gprB_22, +, *l$index1[2]], gpr_wrboth
  28:	   .5  immed[gprA_5, 0x0], gpr_wrboth
  30:	   .6  alu[gprA_6, --, B, *l$index1[2]], gpr_wrboth
  38:	   .7  immed[gprA_7, 0x0], gpr_wrboth
  40:	   .8  alu[gprA_2, --, B, gprB_6], gpr_wrboth
  48:	   .9  alu[gprA_3, --, B, gprB_7], gpr_wrboth
  50:	  .10  alu[gprA_2, gprA_2, +, 0x2a], gpr_wrboth
  58:	  .11  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
  60:	  .12  alu[--, gprA_4, -, gprB_2]
  68:	  .13  alu[--, gprA_5, -carry, gprB_3]
  70:	  .14  bcc[.1521]
  78:	  .15  mem[read32_swap, $xfer_0, gprA_6, 0xc, 1], ctx_swap[sig1]
  80:	  .16  ld_field_w_clr[gprA_4, 0001, $xfer_0], gpr_wrboth
  88:	  .17  immed[gprA_5, 0x0], gpr_wrboth
  90:	  .18  ld_field_w_clr[gprA_8, 0001, $xfer_0, >>8], gpr_wrboth
  98:	  .19  immed[gprA_9, 0x0], gpr_wrboth
  a0:	  .20  alu[gprA_2, --, B, gprB_8], gpr_wrboth
  a8:	  .21  alu[gprA_3, --, B, gprB_9], gpr_wrboth
  b0:	  .22  dbl_shf[gprA_2, gprA_3, gprB_2, >>7], gpr_wrboth
  b8:	  .23  alu_shf[gprA_3, --, B, gprB_3, >>7], gpr_wrboth
  c0:	  .24  alu[*l$index0[3], --, B, gprB_2]
  c8:	  .25  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
  d0:	  .26  alu[*l$index0[3], --, B, gprB_2]
  d8:	  .27  immed[gprA_11, 0x0], gpr_wrboth
  e0:	  .28  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
  e8:	  .29  immed[gprB_21, 0x3c6d]
  f0:	  .30  immed_w1[gprB_21, 0x2c1b]
  f8:	  .31  mul_step[gprA_10, gprB_21], start
 100:	  .32  mul_step[gprA_10, gprB_21], 32x32_step1
 108:	  .33  mul_step[gprA_10, gprB_21], 32x32_step2
 110:	  .34  mul_step[gprA_10, gprB_21], 32x32_step3
 118:	  .35  mul_step[gprA_10, gprB_21], 32x32_step4
 120:	  .36  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 128:	  .37  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 130:	  .38  immed[gprA_2, 0xfffff000], gpr_wrboth
 138:	  .39  immed[gprA_3, 0x0], gpr_wrboth
 140:	  .40  alu[gprA_10, gprA_10, AND, gprB_2], gpr_wrboth
 148:	  .41  alu[gprA_11, gprA_11, AND, gprB_3], gpr_wrboth
 150:	  .42  dbl_shf[gprA_9, gprA_9, gprB_8, >>24], gpr_wrboth
 158:	  .43  alu_shf[gprA_8, --, B, gprB_8, <<8], gpr_wrboth
 160:	  .44  alu[gprA_8, gprA_8, OR, gprB_4], gpr_wrboth
 168:	  .45  alu[gprA_9, gprA_9, OR, gprB_5], gpr_wrboth
 170:	  .46  dbl_shf[gprA_10, gprA_11, gprB_10, >>12], gpr_wrboth
 178:	  .47  alu_shf[gprA_11, --, B, gprB_11, >>12], gpr_wrboth
 180:	  .48  alu[*l$index0[3], --, B, gprB_10]
 188:	  .49  alu[gprA_4, --, B, *l$index0[3]], gpr_wrboth
 190:	  .50  alu[*l$index0[3], --, B, gprB_4]
 198:	  .51  immed[gprA_11, 0x0], gpr_wrboth
 1a0:	  .52  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
 1a8:	  .53  immed[gprB_21, 0x2d39]
 1b0:	  .54  immed_w1[gprB_21, 0x297a]
 1b8:	  .55  mul_step[gprA_10, gprB_21], start
 1c0:	  .56  mul_step[gprA_10, gprB_21], 32x32_step1
 1c8:	  .57  mul_step[gprA_10, gprB_21], 32x32_step2
 1d0:	  .58  mul_step[gprA_10, gprB_21], 32x32_step3
 1d8:	  .59  mul_step[gprA_10, gprB_21], 32x32_step4
 1e0:	  .60  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 1e8:	  .61  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 1f0:	  .62  immed[gprA_4, 0xffff8000], gpr_wrboth
 1f8:	  .63  immed[gprA_5, 0x0], gpr_wrboth
 200:	  .64  alu[gprA_16, --, B, gprB_10], gpr_wrboth
 208:	  .65  alu[gprA_17, --, B, gprB_11], gpr_wrboth
 210:	  .66  alu[gprA_16, gprA_16, AND, gprB_4], gpr_wrboth
 218:	  .67  alu[gprA_17, gprA_17, AND, gprB_5], gpr_wrboth
 220:	  .68  dbl_shf[gprA_16, gprA_17, gprB_16, >>15], gpr_wrboth
 228:	  .69  alu_shf[gprA_17, --, B, gprB_17, >>15], gpr_wrboth
 230:	  .70  alu[gprA_16, gprA_16, XOR, gprB_10], gpr_wrboth
 238:	  .71  alu[gprA_17, gprA_17, XOR, gprB_11], gpr_wrboth
 240:	  .72  alu[--, gprA_8, XOR, 0x8]
 248:	  .73  bne[.318]
 250:	  .74  alu[--, gprA_9, XOR, 0x0]
 258:	  .75  bne[.318]
 260:	  .76  mem[read32_swap, $xfer_0, gprA_6, 0x1a, 1], ctx_swap[sig1]
 268:	  .77  alu[gprA_8, --, B, $xfer_0], gpr_wrboth
 270:	  .78  immed[gprA_9, 0x0], gpr_wrboth
 278:	  .79  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
 280:	  .80  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
 288:	  .81  alu[*l$index0[3], --, B, gprB_8]
 290:	  .82  alu[gprA_8, --, B, *l$index0[3]], gpr_wrboth
 298:	  .83  alu[*l$index0[3], --, B, gprB_8]
 2a0:	  .84  immed[gprA_9, 0x0], gpr_wrboth
 2a8:	  .85  alu[gprA_8, --, B, *l$index0[3]], gpr_wrboth
 2b0:	  .86  immed[gprB_21, 0x3c6d]
 2b8:	  .87  immed_w1[gprB_21, 0x2c1b]
 2c0:	  .88  mul_step[gprA_8, gprB_21], start
 2c8:	  .89  mul_step[gprA_8, gprB_21], 32x32_step1
 2d0:	  .90  mul_step[gprA_8, gprB_21], 32x32_step2
 2d8:	  .91  mul_step[gprA_8, gprB_21], 32x32_step3
 2e0:	  .92  mul_step[gprA_8, gprB_21], 32x32_step4
 2e8:	  .93  mul_step[gprA_8, --], 32x32_last, gpr_wrboth
 2f0:	  .94  mul_step[gprA_9, --], 32x32_last2, gpr_wrboth
 2f8:	  .95  alu[gprA_8, gprA_8, AND, gprB_2], gpr_wrboth
 300:	  .96  alu[gprA_9, gprA_9, AND, gprB_3], gpr_wrboth
 308:	  .97  dbl_shf[gprA_8, gprA_9, gprB_8, >>12], gpr_wrboth
 310:	  .98  alu_shf[gprA_9, --, B, gprB_9, >>12], gpr_wrboth
 318:	  .99  alu[*l$index0[3], --, B, gprB_8]
 320:	 .100  alu[gprA_8, --, B, *l$index0[3]], gpr_wrboth
 328:	 .101  alu[*l$index0[3], --, B, gprB_8]
 330:	 .102  immed[gprA_11, 0x0], gpr_wrboth
 338:	 .103  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
 340:	 .104  mem[read32_swap, $xfer_0, gprA_6, 0x1e, 1], ctx_swap[sig1]
 348:	 .105  alu[gprA_8, --, B, $xfer_0], gpr_wrboth
 350:	 .106  immed[gprA_9, 0x0], gpr_wrboth
 358:	 .107  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
 360:	 .108  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
 368:	 .109  alu[*l$index0[3], --, B, gprB_8]
 370:	 .110  alu[gprA_8, --, B, *l$index0[3]], gpr_wrboth
 378:	 .111  alu[*l$index0[3], --, B, gprB_8]
 380:	 .112  immed[gprB_21, 0x2d39]
 388:	 .113  immed_w1[gprB_21, 0x297a]
 390:	 .114  mul_step[gprA_10, gprB_21], start
 398:	 .115  mul_step[gprA_10, gprB_21], 32x32_step1
 3a0:	 .116  mul_step[gprA_10, gprB_21], 32x32_step2
 3a8:	 .117  mul_step[gprA_10, gprB_21], 32x32_step3
 3b0:	 .118  mul_step[gprA_10, gprB_21], 32x32_step4
 3b8:	 .119  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 3c0:	 .120  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 3c8:	 .121  alu[gprA_8, --, B, gprB_10], gpr_wrboth
 3d0:	 .122  alu[gprA_9, --, B, gprB_11], gpr_wrboth
 3d8:	 .123  alu[gprA_8, gprA_8, XOR, gprB_16], gpr_wrboth
 3e0:	 .124  alu[gprA_9, gprA_9, XOR, gprB_17], gpr_wrboth
 3e8:	 .125  alu[gprA_10, gprA_10, AND, gprB_4], gpr_wrboth
 3f0:	 .126  alu[gprA_11, gprA_11, AND, gprB_5], gpr_wrboth
 3f8:	 .127  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 400:	 .128  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 408:	 .129  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 410:	 .130  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 418:	 .131  immed[gprA_11, 0x0], gpr_wrboth
 420:	 .132  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
 428:	 .133  immed[gprB_21, 0x3c6d]
 430:	 .134  immed_w1[gprB_21, 0x2c1b]
 438:	 .135  mul_step[gprA_10, gprB_21], start
 440:	 .136  mul_step[gprA_10, gprB_21], 32x32_step1
 448:	 .137  mul_step[gprA_10, gprB_21], 32x32_step2
 450:	 .138  mul_step[gprA_10, gprB_21], 32x32_step3
 458:	 .139  mul_step[gprA_10, gprB_21], 32x32_step4
 460:	 .140  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 468:	 .141  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 470:	 .142  alu[gprA_10, gprA_10, AND, gprB_2], gpr_wrboth
 478:	 .143  alu[gprA_11, gprA_11, AND, gprB_3], gpr_wrboth
 480:	 .144  dbl_shf[gprA_10, gprA_11, gprB_10, >>12], gpr_wrboth
 488:	 .145  alu_shf[gprA_11, --, B, gprB_11, >>12], gpr_wrboth
 490:	 .146  alu[*l$index0[3], --, B, gprB_10]
 498:	 .147  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
 4a0:	 .148  alu[*l$index0[3], --, B, gprB_10]
 4a8:	 .149  immed[gprA_11, 0x0], gpr_wrboth
 4b0:	 .150  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
 4b8:	 .151  immed[gprA_0, 0x0], gpr_wrboth
 4c0:	 .152  immed[gprA_1, 0x0], gpr_wrboth
 4c8:	 .153  alu[*l$index0[3], --, B, gprB_0]
 4d0:	 .154  alu[gprA_0, --, B, *l$index0[3]], gpr_wrboth
 4d8:	 .155  alu[*l$index0[3], --, B, gprB_0]
 4e0:	 .156  immed[gprA_1, 0x0], gpr_wrboth
 4e8:	 .157  alu[gprA_0, --, B, *l$index0[3]], gpr_wrboth
 4f0:	 .158  immed[gprB_21, 0x3c6d]
 4f8:	 .159  immed_w1[gprB_21, 0x2c1b]
 500:	 .160  mul_step[gprA_0, gprB_21], start
 508:	 .161  mul_step[gprA_0, gprB_21], 32x32_step1
 510:	 .162  mul_step[gprA_0, gprB_21], 32x32_step2
 518:	 .163  mul_step[gprA_0, gprB_21], 32x32_step3
 520:	 .164  mul_step[gprA_0, gprB_21], 32x32_step4
 528:	 .165  mul_step[gprA_0, --], 32x32_last, gpr_wrboth
 530:	 .166  mul_step[gprA_1, --], 32x32_last2, gpr_wrboth
 538:	 .167  alu[gprA_0, gprA_0, AND, gprB_2], gpr_wrboth
 540:	 .168  alu[gprA_1, gprA_1, AND, gprB_3], gpr_wrboth
 548:	 .169  dbl_shf[gprA_0, gprA_1, gprB_0, >>12], gpr_wrboth
 550:	 .170  alu_shf[gprA_1, --, B, gprB_1, >>12], gpr_wrboth
 558:	 .171  alu[*l$index0[3], --, B, gprB_0]
 560:	 .172  immed[gprB_21, 0x2d39]
 568:	 .173  immed_w1[gprB_21, 0x297a]
 570:	 .174  mul_step[gprA_10, gprB_21], start
 578:	 .175  mul_step[gprA_10, gprB_21], 32x32_step1
 580:	 .176  mul_step[gprA_10, gprB_21], 32x32_step2
 588:	 .177  mul_step[gprA_10, gprB_21], 32x32_step3
 590:	 .178  mul_step[gprA_10, gprB_21], 32x32_step4
 598:	 .179  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 5a0:	 .180  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 5a8:	 .181  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 5b0:	 .182  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 5b8:	 .183  alu[gprA_10, gprA_10, AND, gprB_4], gpr_wrboth
 5c0:	 .184  alu[gprA_11, gprA_11, AND, gprB_5], gpr_wrboth
 5c8:	 .185  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 5d0:	 .186  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 5d8:	 .187  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 5e0:	 .188  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 5e8:	 .189  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
 5f0:	 .190  alu[*l$index0[3], --, B, gprB_10]
 5f8:	 .191  immed[gprA_11, 0x0], gpr_wrboth
 600:	 .192  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
 608:	 .193  immed[gprB_21, 0x2d39]
 610:	 .194  immed_w1[gprB_21, 0x297a]
 618:	 .195  mul_step[gprA_10, gprB_21], start
 620:	 .196  mul_step[gprA_10, gprB_21], 32x32_step1
 628:	 .197  mul_step[gprA_10, gprB_21], 32x32_step2
 630:	 .198  mul_step[gprA_10, gprB_21], 32x32_step3
 638:	 .199  mul_step[gprA_10, gprB_21], 32x32_step4
 640:	 .200  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 648:	 .201  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 650:	 .202  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 658:	 .203  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 660:	 .204  alu[gprA_10, gprA_10, AND, gprB_4], gpr_wrboth
 668:	 .205  alu[gprA_11, gprA_11, AND, gprB_5], gpr_wrboth
 670:	 .206  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 678:	 .207  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 680:	 .208  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 688:	 .209  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 690:	 .210  mem[read32_swap, $xfer_0, gprA_6, 0x17, 1], ctx_swap[sig1]
 698:	 .211  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
 6a0:	 .212  immed[gprA_11, 0x0], gpr_wrboth
 6a8:	 .213  alu[gprA_21, gprA_10, XOR, 0x6]
 6b0:	 .214  alu[--, gprA_21, OR, gprB_11]
 6b8:	 .215  beq[.222]
 6c0:	 .216  alu[gprA_16, --, B, gprB_8], gpr_wrboth
 6c8:	 .217  alu[gprA_17, --, B, gprB_9], gpr_wrboth
 6d0:	 .218  alu[--, gprA_10, XOR, 0x11]
 6d8:	 .219  bne[.318]
 6e0:	 .220  alu[--, gprA_11, XOR, 0x0]
 6e8:	 .221  bne[.318]
 6f0:	 .222  mem[read32_swap, $xfer_0, gprA_6, 0x22, 1], ctx_swap[sig1]
 6f8:	 .223  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
 700:	 .224  immed[gprA_11, 0x0], gpr_wrboth
 708:	 .225  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 710:	 .226  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 718:	 .227  alu[*l$index0[3], --, B, gprB_10]
 720:	 .228  alu[gprA_10, --, B, *l$index0[3]], gpr_wrboth
 728:	 .229  alu[*l$index0[3], --, B, gprB_10]
 730:	 .230  immed[gprA_1, 0x0], gpr_wrboth
 738:	 .231  alu[gprA_0, --, B, *l$index0[3]], gpr_wrboth
 740:	 .232  immed[gprB_21, 0x3c6d]
 748:	 .233  immed_w1[gprB_21, 0x2c1b]
 750:	 .234  mul_step[gprA_0, gprB_21], start
 758:	 .235  mul_step[gprA_0, gprB_21], 32x32_step1
 760:	 .236  mul_step[gprA_0, gprB_21], 32x32_step2
 768:	 .237  mul_step[gprA_0, gprB_21], 32x32_step3
 770:	 .238  mul_step[gprA_0, gprB_21], 32x32_step4
 778:	 .239  mul_step[gprA_0, --], 32x32_last, gpr_wrboth
 780:	 .240  mul_step[gprA_1, --], 32x32_last2, gpr_wrboth
 788:	 .241  immed[gprA_10, 0xfffff000], gpr_wrboth
 790:	 .242  immed[gprA_11, 0x0], gpr_wrboth
 798:	 .243  alu[gprA_0, gprA_0, AND, gprB_10], gpr_wrboth
 7a0:	 .244  alu[gprA_1, gprA_1, AND, gprB_11], gpr_wrboth
 7a8:	 .245  dbl_shf[gprA_0, gprA_1, gprB_0, >>12], gpr_wrboth
 7b0:	 .246  alu_shf[gprA_1, --, B, gprB_1, >>12], gpr_wrboth
 7b8:	 .247  alu[*l$index0[3], --, B, gprB_0]
 7c0:	 .248  alu[gprA_0, --, B, *l$index0[3]], gpr_wrboth
 7c8:	 .249  alu[*l$index0[3], --, B, gprB_0]
 7d0:	 .250  immed[gprA_1, 0x0], gpr_wrboth
 7d8:	 .251  alu[gprA_0, --, B, *l$index0[3]], gpr_wrboth
 7e0:	 .252  mem[read32_swap, $xfer_0, gprA_6, 0x24, 1], ctx_swap[sig1]
 7e8:	 .253  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
 7f0:	 .254  immed[gprA_7, 0x0], gpr_wrboth
 7f8:	 .255  dbl_shf[gprA_6, gprA_7, gprB_6, >>15], gpr_wrboth
 800:	 .256  alu_shf[gprA_7, --, B, gprB_7, >>15], gpr_wrboth
 808:	 .257  alu[*l$index0[3], --, B, gprB_6]
 810:	 .258  alu[gprA_6, --, B, *l$index0[3]], gpr_wrboth
 818:	 .259  alu[*l$index0[3], --, B, gprB_6]
 820:	 .260  immed[gprB_21, 0x2d39]
 828:	 .261  immed_w1[gprB_21, 0x297a]
 830:	 .262  mul_step[gprA_0, gprB_21], start
 838:	 .263  mul_step[gprA_0, gprB_21], 32x32_step1
 840:	 .264  mul_step[gprA_0, gprB_21], 32x32_step2
 848:	 .265  mul_step[gprA_0, gprB_21], 32x32_step3
 850:	 .266  mul_step[gprA_0, gprB_21], 32x32_step4
 858:	 .267  mul_step[gprA_0, --], 32x32_last, gpr_wrboth
 860:	 .268  mul_step[gprA_1, --], 32x32_last2, gpr_wrboth
 868:	 .269  alu[gprA_16, --, B, gprB_0], gpr_wrboth
 870:	 .270  alu[gprA_17, --, B, gprB_1], gpr_wrboth
 878:	 .271  alu[gprA_16, gprA_16, XOR, gprB_8], gpr_wrboth
 880:	 .272  alu[gprA_17, gprA_17, XOR, gprB_9], gpr_wrboth
 888:	 .273  immed[gprA_6, 0xffff8000], gpr_wrboth
 890:	 .274  immed[gprA_7, 0x0], gpr_wrboth
 898:	 .275  alu[gprA_0, gprA_0, AND, gprB_6], gpr_wrboth
 8a0:	 .276  alu[gprA_1, gprA_1, AND, gprB_7], gpr_wrboth
 8a8:	 .277  dbl_shf[gprA_0, gprA_1, gprB_0, >>15], gpr_wrboth
 8b0:	 .278  alu_shf[gprA_1, --, B, gprB_1, >>15], gpr_wrboth
 8b8:	 .279  alu[gprA_16, gprA_16, XOR, gprB_0], gpr_wrboth
 8c0:	 .280  alu[gprA_17, gprA_17, XOR, gprB_1], gpr_wrboth
 8c8:	 .281  immed[gprA_9, 0x0], gpr_wrboth
 8d0:	 .282  alu[gprA_8, --, B, *l$index0[3]], gpr_wrboth
 8d8:	 .283  immed[gprB_21, 0x3c6d]
 8e0:	 .284  immed_w1[gprB_21, 0x2c1b]
 8e8:	 .285  mul_step[gprA_8, gprB_21], start
 8f0:	 .286  mul_step[gprA_8, gprB_21], 32x32_step1
 8f8:	 .287  mul_step[gprA_8, gprB_21], 32x32_step2
 900:	 .288  mul_step[gprA_8, gprB_21], 32x32_step3
 908:	 .289  mul_step[gprA_8, gprB_21], 32x32_step4
 910:	 .290  mul_step[gprA_8, --], 32x32_last, gpr_wrboth
 918:	 .291  mul_step[gprA_9, --], 32x32_last2, gpr_wrboth
 920:	 .292  alu[gprA_8, gprA_8, AND, gprB_10], gpr_wrboth
 928:	 .293  alu[gprA_9, gprA_9, AND, gprB_11], gpr_wrboth
 930:	 .294  dbl_shf[gprA_8, gprA_9, gprB_8, >>12], gpr_wrboth
 938:	 .295  alu_shf[gprA_9, --, B, gprB_9, >>12], gpr_wrboth
 940:	 .296  alu[*l$index0[3], --, B, gprB_8]
 948:	 .297  alu[gprA_8, --, B, *l$index0[3]], gpr_wrboth
 950:	 .298  alu[*l$index0[3], --, B, gprB_8]
 958:	 .299  immed[gprA_9, 0x0], gpr_wrboth
 960:	 .300  alu[gprA_8, --, B, *l$index0[3]], gpr_wrboth
 968:	 .301  immed[gprB_21, 0x2d39]
 970:	 .302  immed_w1[gprB_21, 0x297a]
 978:	 .303  mul_step[gprA_8, gprB_21], start
 980:	 .304  mul_step[gprA_8, gprB_21], 32x32_step1
 988:	 .305  mul_step[gprA_8, gprB_21], 32x32_step2
 990:	 .306  mul_step[gprA_8, gprB_21], 32x32_step3
 998:	 .307  mul_step[gprA_8, gprB_21], 32x32_step4
 9a0:	 .308  mul_step[gprA_8, --], 32x32_last, gpr_wrboth
 9a8:	 .309  mul_step[gprA_9, --], 32x32_last2, gpr_wrboth
 9b0:	 .310  alu[gprA_16, gprA_16, XOR, gprB_8], gpr_wrboth
 9b8:	 .311  alu[gprA_17, gprA_17, XOR, gprB_9], gpr_wrboth
 9c0:	 .312  alu[gprA_8, gprA_8, AND, gprB_6], gpr_wrboth
 9c8:	 .313  alu[gprA_9, gprA_9, AND, gprB_7], gpr_wrboth
 9d0:	 .314  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
 9d8:	 .315  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
 9e0:	 .316  alu[gprA_16, gprA_16, XOR, gprB_8], gpr_wrboth
 9e8:	 .317  alu[gprA_17, gprA_17, XOR, gprB_9], gpr_wrboth
 9f0:	 .318  alu[gprA_14, --, B, gprB_16], gpr_wrboth
 9f8:	 .319  alu[gprA_15, --, B, gprB_17], gpr_wrboth
 a00:	 .320  dbl_shf[gprA_14, gprA_15, gprB_14, >>15], gpr_wrboth
 a08:	 .321  alu_shf[gprA_15, --, B, gprB_15, >>15], gpr_wrboth
 a10:	 .322  immed[gprB_21, 0xffff0001, <<16]
 a18:	 .323  alu[gprA_14, gprA_14, AND, gprB_21], gpr_wrboth
 a20:	 .324  immed[gprA_15, 0x0], gpr_wrboth
 a28:	 .325  alu[*l$index0[3], --, B, gprB_14]
 a30:	 .326  alu[gprA_6, --, B, *l$index0[3]], gpr_wrboth
 a38:	 .327  alu[*l$index0[3], --, B, gprB_6]
 a40:	 .328  immed[gprA_7, 0x0], gpr_wrboth
 a48:	 .329  alu[gprA_6, --, B, *l$index0[3]], gpr_wrboth
 a50:	 .330  immed[gprB_21, 0x3c6d]
 a58:	 .331  immed_w1[gprB_21, 0x2c1b]
 a60:	 .332  mul_step[gprA_6, gprB_21], start
 a68:	 .333  mul_step[gprA_6, gprB_21], 32x32_step1
 a70:	 .334  mul_step[gprA_6, gprB_21], 32x32_step2
 a78:	 .335  mul_step[gprA_6, gprB_21], 32x32_step3
 a80:	 .336  mul_step[gprA_6, gprB_21], 32x32_step4
 a88:	 .337  mul_step[gprA_6, --], 32x32_last, gpr_wrboth
 a90:	 .338  mul_step[gprA_7, --], 32x32_last2, gpr_wrboth
 a98:	 .339  alu[gprA_6, gprA_6, AND, gprB_2], gpr_wrboth
 aa0:	 .340  alu[gprA_7, gprA_7, AND, gprB_3], gpr_wrboth
 aa8:	 .341  dbl_shf[gprA_6, gprA_7, gprB_6, >>12], gpr_wrboth
 ab0:	 .342  alu_shf[gprA_7, --, B, gprB_7, >>12], gpr_wrboth
 ab8:	 .343  alu[*l$index0[3], --, B, gprB_6]
 ac0:	 .344  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 ac8:	 .345  alu[*l$index0[3], --, B, gprB_2]
 ad0:	 .346  immed[gprA_3, 0x0], gpr_wrboth
 ad8:	 .347  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 ae0:	 .348  immed[gprB_21, 0x2d39]
 ae8:	 .349  immed_w1[gprB_21, 0x297a]
 af0:	 .350  mul_step[gprA_2, gprB_21], start
 af8:	 .351  mul_step[gprA_2, gprB_21], 32x32_step1
 b00:	 .352  mul_step[gprA_2, gprB_21], 32x32_step2
 b08:	 .353  mul_step[gprA_2, gprB_21], 32x32_step3
 b10:	 .354  mul_step[gprA_2, gprB_21], 32x32_step4
 b18:	 .355  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 b20:	 .356  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 b28:	 .357  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 b30:	 .358  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 b38:	 .359  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
 b40:	 .360  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
 b48:	 .361  dbl_shf[gprA_6, gprA_7, gprB_6, >>15], gpr_wrboth
 b50:	 .362  alu_shf[gprA_7, --, B, gprB_7, >>15], gpr_wrboth
 b58:	 .363  immed[gprB_21, 0xffff007f, <<16]
 b60:	 .364  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 b68:	 .365  immed[gprA_3, 0x0], gpr_wrboth
 b70:	 .366  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
 b78:	 .367  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
 b80:	 .368  alu[*l$index0[2], --, B, gprB_6]
 b88:	 .369  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
 b90:	 .370  immed[gprA_5, 0x0], gpr_wrboth
 b98:	 .371  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
 ba0:	 .372  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
 ba8:	 .373  immed[gprA_2, 0x0], gpr_wrboth
 bb0:	 .374  alu[gprA_3, --, B, gprA_2], gpr_wrboth
 bb8:	 .375  local_csr_wr[ActLMAddr0, gprB_4]
 bc0:	 .376  alu[gprA_1, --, B, gprB_23], gpr_wrboth
 bc8:	 .377  nop
 bd0:	 .378  immed[gprA_21, 0xffff3fff, <<16]
 bd8:	 .379  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
 be0:	 .380  local_csr_wr[ActLMAddr0, gprA_22]
 be8:	 .381  nop
 bf0:	 .382  nop
 bf8:	 .383  nop
 c00:	 .384  alu[--, gprA_0, OR, gprB_1]
 c08:	 .385  beq[.391]
 c10:	 .386  immed[gprA_2, 0x1], gpr_wrboth
 c18:	 .387  immed[gprA_3, 0x0], gpr_wrboth
 c20:	 .388  immed[gprA_21, 0x890]
 c28:	 .389  ld_field[gprA_21, 1100, gprB_2, <<16]
 c30:	 .390  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
 c38:	 .391  alu[gprA_2, --, B, gprB_16], gpr_wrboth
 c40:	 .392  alu[gprA_3, --, B, gprB_17], gpr_wrboth
 c48:	 .393  dbl_shf[gprA_2, gprA_3, gprB_2, >>16], gpr_wrboth
 c50:	 .394  alu_shf[gprA_3, --, B, gprB_3, >>16], gpr_wrboth
 c58:	 .395  immed[gprB_21, 0xffff]
 c60:	 .396  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 c68:	 .397  immed[gprA_3, 0x0], gpr_wrboth
 c70:	 .398  alu[*l$index0, --, B, gprB_2]
 c78:	 .399  alu[*l$index0[1], --, B, gprB_3]
 c80:	 .400  alu[*l$index0[3], --, B, gprB_2]
 c88:	 .401  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 c90:	 .402  alu[*l$index0[3], --, B, gprB_2]
 c98:	 .403  immed[gprA_3, 0x0], gpr_wrboth
 ca0:	 .404  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 ca8:	 .405  immed[gprB_21, 0x9f3b]
 cb0:	 .406  immed_w1[gprB_21, 0x45d]
 cb8:	 .407  mul_step[gprA_2, gprB_21], start
 cc0:	 .408  mul_step[gprA_2, gprB_21], 32x32_step1
 cc8:	 .409  mul_step[gprA_2, gprB_21], 32x32_step2
 cd0:	 .410  mul_step[gprA_2, gprB_21], 32x32_step3
 cd8:	 .411  mul_step[gprA_2, gprB_21], 32x32_step4
 ce0:	 .412  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 ce8:	 .413  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 cf0:	 .414  immed[gprA_18, 0xffff, <<16], gpr_wrboth
 cf8:	 .415  immed[gprA_19, 0x0], gpr_wrboth
 d00:	 .416  alu[gprA_2, gprA_2, AND, gprB_18], gpr_wrboth
 d08:	 .417  alu[gprA_3, gprA_3, AND, gprB_19], gpr_wrboth
 d10:	 .418  dbl_shf[gprA_2, gprA_3, gprB_2, >>16], gpr_wrboth
 d18:	 .419  alu_shf[gprA_3, --, B, gprB_3, >>16], gpr_wrboth
 d20:	 .420  alu[*l$index0[3], --, B, gprB_2]
 d28:	 .421  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 d30:	 .422  alu[*l$index0[3], --, B, gprB_2]
 d38:	 .423  immed[gprA_3, 0x0], gpr_wrboth
 d40:	 .424  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 d48:	 .425  immed[gprB_21, 0x9f3b]
 d50:	 .426  immed_w1[gprB_21, 0x45d]
 d58:	 .427  mul_step[gprA_2, gprB_21], start
 d60:	 .428  mul_step[gprA_2, gprB_21], 32x32_step1
 d68:	 .429  mul_step[gprA_2, gprB_21], 32x32_step2
 d70:	 .430  mul_step[gprA_2, gprB_21], 32x32_step3
 d78:	 .431  mul_step[gprA_2, gprB_21], 32x32_step4
 d80:	 .432  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 d88:	 .433  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 d90:	 .434  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 d98:	 .435  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 da0:	 .436  alu[gprA_4, gprA_4, AND, gprB_18], gpr_wrboth
 da8:	 .437  alu[gprA_5, gprA_5, AND, gprB_19], gpr_wrboth
 db0:	 .438  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
 db8:	 .439  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
 dc0:	 .440  immed[gprB_21, 0xffff007f, <<16]
 dc8:	 .441  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 dd0:	 .442  immed[gprA_3, 0x0], gpr_wrboth
 dd8:	 .443  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
 de0:	 .444  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
 de8:	 .445  alu[*l$index0[2], --, B, gprB_4]
 df0:	 .446  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
 df8:	 .447  immed[gprA_5, 0x0], gpr_wrboth
 e00:	 .448  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
 e08:	 .449  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
 e10:	 .450  immed[gprA_2, 0x0], gpr_wrboth
 e18:	 .451  alu[gprA_3, --, B, gprA_2], gpr_wrboth
 e20:	 .452  local_csr_wr[ActLMAddr0, gprB_4]
 e28:	 .453  alu[gprA_1, --, B, gprB_23], gpr_wrboth
 e30:	 .454  nop
 e38:	 .455  immed[gprA_21, 0xffff3fff, <<16]
 e40:	 .456  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
 e48:	 .457  local_csr_wr[ActLMAddr0, gprA_22]
 e50:	 .458  nop
 e58:	 .459  nop
 e60:	 .460  nop
 e68:	 .461  alu[--, gprA_0, OR, gprB_1]
 e70:	 .462  beq[.468]
 e78:	 .463  immed[gprA_2, 0x1], gpr_wrboth
 e80:	 .464  immed[gprA_3, 0x0], gpr_wrboth
 e88:	 .465  immed[gprA_21, 0x890]
 e90:	 .466  ld_field[gprA_21, 1100, gprB_2, <<16]
 e98:	 .467  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
 ea0:	 .468  alu[*l$index0[3], --, B, gprB_14]
 ea8:	 .469  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 eb0:	 .470  alu[*l$index0[3], --, B, gprB_2]
 eb8:	 .471  immed[gprA_3, 0x0], gpr_wrboth
 ec0:	 .472  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 ec8:	 .473  immed[gprB_21, 0xacab]
 ed0:	 .474  immed_w1[gprB_21, 0x4811]
 ed8:	 .475  mul_step[gprA_2, gprB_21], start
 ee0:	 .476  mul_step[gprA_2, gprB_21], 32x32_step1
 ee8:	 .477  mul_step[gprA_2, gprB_21], 32x32_step2
 ef0:	 .478  mul_step[gprA_2, gprB_21], 32x32_step3
 ef8:	 .479  mul_step[gprA_2, gprB_21], 32x32_step4
 f00:	 .480  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 f08:	 .481  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 f10:	 .482  immed[gprA_12, 0xffff8000], gpr_wrboth
 f18:	 .483  immed[gprA_13, 0x0], gpr_wrboth
 f20:	 .484  alu[gprA_2, gprA_2, AND, gprB_12], gpr_wrboth
 f28:	 .485  alu[gprA_3, gprA_3, AND, gprB_13], gpr_wrboth
 f30:	 .486  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
 f38:	 .487  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
 f40:	 .488  alu[*l$index0[3], --, B, gprB_2]
 f48:	 .489  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 f50:	 .490  alu[*l$index0[3], --, B, gprB_2]
 f58:	 .491  immed[gprA_3, 0x0], gpr_wrboth
 f60:	 .492  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 f68:	 .493  immed[gprB_21, 0xacd7]
 f70:	 .494  immed_w1[gprB_21, 0x5591]
 f78:	 .495  mul_step[gprA_2, gprB_21], start
 f80:	 .496  mul_step[gprA_2, gprB_21], 32x32_step1
 f88:	 .497  mul_step[gprA_2, gprB_21], 32x32_step2
 f90:	 .498  mul_step[gprA_2, gprB_21], 32x32_step3
 f98:	 .499  mul_step[gprA_2, gprB_21], 32x32_step4
 fa0:	 .500  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 fa8:	 .501  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 fb0:	 .502  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 fb8:	 .503  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 fc0:	 .504  alu[gprA_4, gprA_4, AND, gprB_18], gpr_wrboth
 fc8:	 .505  alu[gprA_5, gprA_5, AND, gprB_19], gpr_wrboth
 fd0:	 .506  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
 fd8:	 .507  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
 fe0:	 .508  immed[gprB_21, 0xffff007f, <<16]
 fe8:	 .509  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 ff0:	 .510  immed[gprA_3, 0x0], gpr_wrboth
 ff8:	 .511  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1000:	 .512  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
1008:	 .513  alu[*l$index0[2], --, B, gprB_4]
1010:	 .514  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1018:	 .515  immed[gprA_5, 0x0], gpr_wrboth
1020:	 .516  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1028:	 .517  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1030:	 .518  immed[gprA_2, 0x0], gpr_wrboth
1038:	 .519  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1040:	 .520  local_csr_wr[ActLMAddr0, gprB_4]
1048:	 .521  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1050:	 .522  nop
1058:	 .523  immed[gprA_21, 0xffff3fff, <<16]
1060:	 .524  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1068:	 .525  local_csr_wr[ActLMAddr0, gprA_22]
1070:	 .526  nop
1078:	 .527  nop
1080:	 .528  nop
1088:	 .529  alu[--, gprA_0, OR, gprB_1]
1090:	 .530  beq[.536]
1098:	 .531  immed[gprA_2, 0x1], gpr_wrboth
10a0:	 .532  immed[gprA_3, 0x0], gpr_wrboth
10a8:	 .533  immed[gprA_21, 0x890]
10b0:	 .534  ld_field[gprA_21, 1100, gprB_2, <<16]
10b8:	 .535  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
10c0:	 .536  alu[gprA_2, --, B, *l$index0], gpr_wrboth
10c8:	 .537  alu[gprA_3, --, B, *l$index0[1]], gpr_wrboth
10d0:	 .538  alu[*l$index0[3], --, B, gprB_2]
10d8:	 .539  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
10e0:	 .540  alu[*l$index0[3], --, B, gprB_2]
10e8:	 .541  immed[gprA_3, 0x0], gpr_wrboth
10f0:	 .542  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
10f8:	 .543  immed[gprB_21, 0xb4db]
1100:	 .544  immed_w1[gprB_21, 0x1ec9]
1108:	 .545  mul_step[gprA_2, gprB_21], start
1110:	 .546  mul_step[gprA_2, gprB_21], 32x32_step1
1118:	 .547  mul_step[gprA_2, gprB_21], 32x32_step2
1120:	 .548  mul_step[gprA_2, gprB_21], 32x32_step3
1128:	 .549  mul_step[gprA_2, gprB_21], 32x32_step4
1130:	 .550  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1138:	 .551  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1140:	 .552  alu[gprA_2, gprA_2, AND, gprB_12], gpr_wrboth
1148:	 .553  alu[gprA_3, gprA_3, AND, gprB_13], gpr_wrboth
1150:	 .554  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
1158:	 .555  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
1160:	 .556  alu[*l$index0[3], --, B, gprB_2]
1168:	 .557  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1170:	 .558  alu[*l$index0[3], --, B, gprB_2]
1178:	 .559  immed[gprA_3, 0x0], gpr_wrboth
1180:	 .560  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1188:	 .561  immed[gprB_21, 0xd38d]
1190:	 .562  immed_w1[gprB_21, 0x3224]
1198:	 .563  mul_step[gprA_2, gprB_21], start
11a0:	 .564  mul_step[gprA_2, gprB_21], 32x32_step1
11a8:	 .565  mul_step[gprA_2, gprB_21], 32x32_step2
11b0:	 .566  mul_step[gprA_2, gprB_21], 32x32_step3
11b8:	 .567  mul_step[gprA_2, gprB_21], 32x32_step4
11c0:	 .568  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
11c8:	 .569  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
11d0:	 .570  immed[gprA_4, 0xfffe, <<16], gpr_wrboth
11d8:	 .571  immed[gprA_5, 0x0], gpr_wrboth
11e0:	 .572  alu[gprA_6, --, B, gprB_2], gpr_wrboth
11e8:	 .573  alu[gprA_7, --, B, gprB_3], gpr_wrboth
11f0:	 .574  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
11f8:	 .575  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
1200:	 .576  dbl_shf[gprA_6, gprA_7, gprB_6, >>17], gpr_wrboth
1208:	 .577  alu_shf[gprA_7, --, B, gprB_7, >>17], gpr_wrboth
1210:	 .578  immed[gprB_21, 0xffff007f, <<16]
1218:	 .579  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1220:	 .580  immed[gprA_3, 0x0], gpr_wrboth
1228:	 .581  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
1230:	 .582  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
1238:	 .583  alu[*l$index0[2], --, B, gprB_6]
1240:	 .584  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1248:	 .585  immed[gprA_5, 0x0], gpr_wrboth
1250:	 .586  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1258:	 .587  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1260:	 .588  immed[gprA_2, 0x0], gpr_wrboth
1268:	 .589  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1270:	 .590  local_csr_wr[ActLMAddr0, gprB_4]
1278:	 .591  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1280:	 .592  nop
1288:	 .593  immed[gprA_21, 0xffff3fff, <<16]
1290:	 .594  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1298:	 .595  local_csr_wr[ActLMAddr0, gprA_22]
12a0:	 .596  nop
12a8:	 .597  nop
12b0:	 .598  nop
12b8:	 .599  alu[--, gprA_0, OR, gprB_1]
12c0:	 .600  beq[.606]
12c8:	 .601  immed[gprA_2, 0x1], gpr_wrboth
12d0:	 .602  immed[gprA_3, 0x0], gpr_wrboth
12d8:	 .603  immed[gprA_21, 0x890]
12e0:	 .604  ld_field[gprA_21, 1100, gprB_2, <<16]
12e8:	 .605  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
12f0:	 .606  alu[gprA_18, --, B, gprB_16], gpr_wrboth
12f8:	 .607  alu[gprA_19, --, B, gprB_17], gpr_wrboth
1300:	 .608  dbl_shf[gprA_18, gprA_19, gprB_18, >>17], gpr_wrboth
1308:	 .609  alu_shf[gprA_19, --, B, gprB_19, >>17], gpr_wrboth
1310:	 .610  immed[gprB_21, 0x7fff]
1318:	 .611  alu[gprA_18, gprA_18, AND, gprB_21], gpr_wrboth
1320:	 .612  immed[gprA_19, 0x0], gpr_wrboth
1328:	 .613  alu[*l$index0[3], --, B, gprB_18]
1330:	 .614  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1338:	 .615  alu[*l$index0[3], --, B, gprB_2]
1340:	 .616  immed[gprA_3, 0x0], gpr_wrboth
1348:	 .617  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1350:	 .618  immed[gprB_21, 0xd515]
1358:	 .619  immed_w1[gprB_21, 0x179c]
1360:	 .620  mul_step[gprA_2, gprB_21], start
1368:	 .621  mul_step[gprA_2, gprB_21], 32x32_step1
1370:	 .622  mul_step[gprA_2, gprB_21], 32x32_step2
1378:	 .623  mul_step[gprA_2, gprB_21], 32x32_step3
1380:	 .624  mul_step[gprA_2, gprB_21], 32x32_step4
1388:	 .625  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1390:	 .626  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1398:	 .627  immed[gprA_12, 0xffff8000], gpr_wrboth
13a0:	 .628  immed[gprA_13, 0x0], gpr_wrboth
13a8:	 .629  alu[gprA_2, gprA_2, AND, gprB_12], gpr_wrboth
13b0:	 .630  alu[gprA_3, gprA_3, AND, gprB_13], gpr_wrboth
13b8:	 .631  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
13c0:	 .632  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
13c8:	 .633  alu[*l$index0[3], --, B, gprB_2]
13d0:	 .634  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
13d8:	 .635  alu[*l$index0[3], --, B, gprB_2]
13e0:	 .636  immed[gprA_3, 0x0], gpr_wrboth
13e8:	 .637  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
13f0:	 .638  immed[gprB_21, 0x5d47]
13f8:	 .639  immed_w1[gprB_21, 0x4c49]
1400:	 .640  mul_step[gprA_2, gprB_21], start
1408:	 .641  mul_step[gprA_2, gprB_21], 32x32_step1
1410:	 .642  mul_step[gprA_2, gprB_21], 32x32_step2
1418:	 .643  mul_step[gprA_2, gprB_21], 32x32_step3
1420:	 .644  mul_step[gprA_2, gprB_21], 32x32_step4
1428:	 .645  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1430:	 .646  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1438:	 .647  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1440:	 .648  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1448:	 .649  alu[gprA_4, gprA_4, AND, gprB_12], gpr_wrboth
1450:	 .650  alu[gprA_5, gprA_5, AND, gprB_13], gpr_wrboth
1458:	 .651  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1460:	 .652  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1468:	 .653  immed[gprB_21, 0xffff007f, <<16]
1470:	 .654  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1478:	 .655  immed[gprA_3, 0x0], gpr_wrboth
1480:	 .656  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1488:	 .657  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
1490:	 .658  alu[*l$index0[2], --, B, gprB_4]
1498:	 .659  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
14a0:	 .660  immed[gprA_5, 0x0], gpr_wrboth
14a8:	 .661  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
14b0:	 .662  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
14b8:	 .663  immed[gprA_2, 0x0], gpr_wrboth
14c0:	 .664  alu[gprA_3, --, B, gprA_2], gpr_wrboth
14c8:	 .665  local_csr_wr[ActLMAddr0, gprB_4]
14d0:	 .666  alu[gprA_1, --, B, gprB_23], gpr_wrboth
14d8:	 .667  nop
14e0:	 .668  immed[gprA_21, 0xffff3fff, <<16]
14e8:	 .669  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
14f0:	 .670  local_csr_wr[ActLMAddr0, gprA_22]
14f8:	 .671  nop
1500:	 .672  nop
1508:	 .673  nop
1510:	 .674  alu[--, gprA_0, OR, gprB_1]
1518:	 .675  beq[.681]
1520:	 .676  immed[gprA_2, 0x1], gpr_wrboth
1528:	 .677  immed[gprA_3, 0x0], gpr_wrboth
1530:	 .678  immed[gprA_21, 0x890]
1538:	 .679  ld_field[gprA_21, 1100, gprB_2, <<16]
1540:	 .680  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1548:	 .681  alu[*l$index0[3], --, B, gprB_18]
1550:	 .682  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1558:	 .683  alu[*l$index0[3], --, B, gprB_2]
1560:	 .684  immed[gprA_3, 0x0], gpr_wrboth
1568:	 .685  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1570:	 .686  immed[gprB_21, 0xd2cd]
1578:	 .687  immed_w1[gprB_21, 0x24f4]
1580:	 .688  mul_step[gprA_2, gprB_21], start
1588:	 .689  mul_step[gprA_2, gprB_21], 32x32_step1
1590:	 .690  mul_step[gprA_2, gprB_21], 32x32_step2
1598:	 .691  mul_step[gprA_2, gprB_21], 32x32_step3
15a0:	 .692  mul_step[gprA_2, gprB_21], 32x32_step4
15a8:	 .693  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
15b0:	 .694  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
15b8:	 .695  alu[gprA_2, gprA_2, AND, gprB_12], gpr_wrboth
15c0:	 .696  alu[gprA_3, gprA_3, AND, gprB_13], gpr_wrboth
15c8:	 .697  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
15d0:	 .698  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
15d8:	 .699  alu[*l$index0[3], --, B, gprB_2]
15e0:	 .700  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
15e8:	 .701  alu[*l$index0[3], --, B, gprB_2]
15f0:	 .702  immed[gprA_3, 0x0], gpr_wrboth
15f8:	 .703  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1600:	 .704  immed[gprB_21, 0xb969]
1608:	 .705  immed_w1[gprB_21, 0x1ba3]
1610:	 .706  mul_step[gprA_2, gprB_21], start
1618:	 .707  mul_step[gprA_2, gprB_21], 32x32_step1
1620:	 .708  mul_step[gprA_2, gprB_21], 32x32_step2
1628:	 .709  mul_step[gprA_2, gprB_21], 32x32_step3
1630:	 .710  mul_step[gprA_2, gprB_21], 32x32_step4
1638:	 .711  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1640:	 .712  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1648:	 .713  immed[gprA_12, 0xffff, <<16], gpr_wrboth
1650:	 .714  immed[gprA_13, 0x0], gpr_wrboth
1658:	 .715  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1660:	 .716  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1668:	 .717  alu[gprA_4, gprA_4, AND, gprB_12], gpr_wrboth
1670:	 .718  alu[gprA_5, gprA_5, AND, gprB_13], gpr_wrboth
1678:	 .719  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
1680:	 .720  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
1688:	 .721  immed[gprB_21, 0xffff007f, <<16]
1690:	 .722  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1698:	 .723  immed[gprA_3, 0x0], gpr_wrboth
16a0:	 .724  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
16a8:	 .725  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
16b0:	 .726  alu[*l$index0[2], --, B, gprB_4]
16b8:	 .727  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
16c0:	 .728  immed[gprA_5, 0x0], gpr_wrboth
16c8:	 .729  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
16d0:	 .730  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
16d8:	 .731  immed[gprA_2, 0x0], gpr_wrboth
16e0:	 .732  alu[gprA_3, --, B, gprA_2], gpr_wrboth
16e8:	 .733  local_csr_wr[ActLMAddr0, gprB_4]
16f0:	 .734  alu[gprA_1, --, B, gprB_23], gpr_wrboth
16f8:	 .735  nop
1700:	 .736  immed[gprA_21, 0xffff3fff, <<16]
1708:	 .737  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1710:	 .738  local_csr_wr[ActLMAddr0, gprA_22]
1718:	 .739  nop
1720:	 .740  nop
1728:	 .741  nop
1730:	 .742  alu[--, gprA_0, OR, gprB_1]
1738:	 .743  beq[.749]
1740:	 .744  immed[gprA_2, 0x1], gpr_wrboth
1748:	 .745  immed[gprA_3, 0x0], gpr_wrboth
1750:	 .746  immed[gprA_21, 0x890]
1758:	 .747  ld_field[gprA_21, 1100, gprB_2, <<16]
1760:	 .748  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1768:	 .749  alu[*l$index0[3], --, B, gprB_18]
1770:	 .750  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1778:	 .751  alu[*l$index0[3], --, B, gprB_2]
1780:	 .752  immed[gprA_3, 0x0], gpr_wrboth
1788:	 .753  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1790:	 .754  immed[gprB_21, 0x3ae5]
1798:	 .755  immed_w1[gprB_21, 0x5abe]
17a0:	 .756  mul_step[gprA_2, gprB_21], start
17a8:	 .757  mul_step[gprA_2, gprB_21], 32x32_step1
17b0:	 .758  mul_step[gprA_2, gprB_21], 32x32_step2
17b8:	 .759  mul_step[gprA_2, gprB_21], 32x32_step3
17c0:	 .760  mul_step[gprA_2, gprB_21], 32x32_step4
17c8:	 .761  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
17d0:	 .762  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
17d8:	 .763  immed[gprA_4, 0xffffe000], gpr_wrboth
17e0:	 .764  immed[gprA_5, 0x0], gpr_wrboth
17e8:	 .765  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
17f0:	 .766  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
17f8:	 .767  dbl_shf[gprA_2, gprA_3, gprB_2, >>13], gpr_wrboth
1800:	 .768  alu_shf[gprA_3, --, B, gprB_3, >>13], gpr_wrboth
1808:	 .769  alu[*l$index0[3], --, B, gprB_2]
1810:	 .770  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1818:	 .771  alu[*l$index0[3], --, B, gprB_2]
1820:	 .772  immed[gprA_3, 0x0], gpr_wrboth
1828:	 .773  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1830:	 .774  immed[gprB_21, 0x9657]
1838:	 .775  immed_w1[gprB_21, 0x6563]
1840:	 .776  mul_step[gprA_2, gprB_21], start
1848:	 .777  mul_step[gprA_2, gprB_21], 32x32_step1
1850:	 .778  mul_step[gprA_2, gprB_21], 32x32_step2
1858:	 .779  mul_step[gprA_2, gprB_21], 32x32_step3
1860:	 .780  mul_step[gprA_2, gprB_21], 32x32_step4
1868:	 .781  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1870:	 .782  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1878:	 .783  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1880:	 .784  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1888:	 .785  alu[gprA_4, gprA_4, AND, gprB_12], gpr_wrboth
1890:	 .786  alu[gprA_5, gprA_5, AND, gprB_13], gpr_wrboth
1898:	 .787  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
18a0:	 .788  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
18a8:	 .789  immed[gprB_21, 0xffff007f, <<16]
18b0:	 .790  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
18b8:	 .791  immed[gprA_3, 0x0], gpr_wrboth
18c0:	 .792  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
18c8:	 .793  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
18d0:	 .794  alu[*l$index0[2], --, B, gprB_4]
18d8:	 .795  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
18e0:	 .796  immed[gprA_5, 0x0], gpr_wrboth
18e8:	 .797  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
18f0:	 .798  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
18f8:	 .799  immed[gprA_2, 0x0], gpr_wrboth
1900:	 .800  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1908:	 .801  local_csr_wr[ActLMAddr0, gprB_4]
1910:	 .802  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1918:	 .803  nop
1920:	 .804  immed[gprA_21, 0xffff3fff, <<16]
1928:	 .805  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1930:	 .806  local_csr_wr[ActLMAddr0, gprA_22]
1938:	 .807  nop
1940:	 .808  nop
1948:	 .809  nop
1950:	 .810  alu[--, gprA_0, OR, gprB_1]
1958:	 .811  beq[.817]
1960:	 .812  immed[gprA_2, 0x1], gpr_wrboth
1968:	 .813  immed[gprA_3, 0x0], gpr_wrboth
1970:	 .814  immed[gprA_21, 0x890]
1978:	 .815  ld_field[gprA_21, 1100, gprB_2, <<16]
1980:	 .816  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1988:	 .817  alu[*l$index0[3], --, B, gprB_18]
1990:	 .818  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1998:	 .819  alu[*l$index0[3], --, B, gprB_2]
19a0:	 .820  immed[gprA_3, 0x0], gpr_wrboth
19a8:	 .821  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
19b0:	 .822  immed[gprB_21, 0xe54b]
19b8:	 .823  immed_w1[gprB_21, 0x6e79]
19c0:	 .824  mul_step[gprA_2, gprB_21], start
19c8:	 .825  mul_step[gprA_2, gprB_21], 32x32_step1
19d0:	 .826  mul_step[gprA_2, gprB_21], 32x32_step2
19d8:	 .827  mul_step[gprA_2, gprB_21], 32x32_step3
19e0:	 .828  mul_step[gprA_2, gprB_21], 32x32_step4
19e8:	 .829  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
19f0:	 .830  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
19f8:	 .831  immed[gprA_4, 0xffffc000], gpr_wrboth
1a00:	 .832  immed[gprA_5, 0x0], gpr_wrboth
1a08:	 .833  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
1a10:	 .834  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
1a18:	 .835  dbl_shf[gprA_2, gprA_3, gprB_2, >>14], gpr_wrboth
1a20:	 .836  alu_shf[gprA_3, --, B, gprB_3, >>14], gpr_wrboth
1a28:	 .837  alu[*l$index0[3], --, B, gprB_2]
1a30:	 .838  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1a38:	 .839  alu[*l$index0[3], --, B, gprB_2]
1a40:	 .840  immed[gprA_3, 0x0], gpr_wrboth
1a48:	 .841  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1a50:	 .842  immed[gprB_21, 0xb24d]
1a58:	 .843  immed_w1[gprB_21, 0x915]
1a60:	 .844  mul_step[gprA_2, gprB_21], start
1a68:	 .845  mul_step[gprA_2, gprB_21], 32x32_step1
1a70:	 .846  mul_step[gprA_2, gprB_21], 32x32_step2
1a78:	 .847  mul_step[gprA_2, gprB_21], 32x32_step3
1a80:	 .848  mul_step[gprA_2, gprB_21], 32x32_step4
1a88:	 .849  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1a90:	 .850  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1a98:	 .851  immed[gprA_4, 0xffff, <<16], gpr_wrboth
1aa0:	 .852  immed[gprA_5, 0x0], gpr_wrboth
1aa8:	 .853  alu[gprA_6, --, B, gprB_2], gpr_wrboth
1ab0:	 .854  alu[gprA_7, --, B, gprB_3], gpr_wrboth
1ab8:	 .855  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
1ac0:	 .856  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
1ac8:	 .857  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
1ad0:	 .858  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
1ad8:	 .859  immed[gprB_21, 0xffff007f, <<16]
1ae0:	 .860  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1ae8:	 .861  immed[gprA_3, 0x0], gpr_wrboth
1af0:	 .862  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
1af8:	 .863  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
1b00:	 .864  alu[*l$index0[2], --, B, gprB_6]
1b08:	 .865  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1b10:	 .866  immed[gprA_5, 0x0], gpr_wrboth
1b18:	 .867  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1b20:	 .868  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1b28:	 .869  immed[gprA_2, 0x0], gpr_wrboth
1b30:	 .870  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1b38:	 .871  local_csr_wr[ActLMAddr0, gprB_4]
1b40:	 .872  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1b48:	 .873  nop
1b50:	 .874  immed[gprA_21, 0xffff3fff, <<16]
1b58:	 .875  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1b60:	 .876  local_csr_wr[ActLMAddr0, gprA_22]
1b68:	 .877  nop
1b70:	 .878  nop
1b78:	 .879  nop
1b80:	 .880  alu[--, gprA_0, OR, gprB_1]
1b88:	 .881  beq[.887]
1b90:	 .882  immed[gprA_2, 0x1], gpr_wrboth
1b98:	 .883  immed[gprA_3, 0x0], gpr_wrboth
1ba0:	 .884  immed[gprA_21, 0x890]
1ba8:	 .885  ld_field[gprA_21, 1100, gprB_2, <<16]
1bb0:	 .886  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1bb8:	 .887  alu[gprA_2, --, B, *l$index0], gpr_wrboth
1bc0:	 .888  alu[gprA_3, --, B, *l$index0[1]], gpr_wrboth
1bc8:	 .889  alu[*l$index0[3], --, B, gprB_2]
1bd0:	 .890  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1bd8:	 .891  alu[*l$index0[3], --, B, gprB_2]
1be0:	 .892  immed[gprA_3, 0x0], gpr_wrboth
1be8:	 .893  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1bf0:	 .894  immed[gprB_21, 0x7153]
1bf8:	 .895  immed_w1[gprB_21, 0x236f]
1c00:	 .896  mul_step[gprA_2, gprB_21], start
1c08:	 .897  mul_step[gprA_2, gprB_21], 32x32_step1
1c10:	 .898  mul_step[gprA_2, gprB_21], 32x32_step2
1c18:	 .899  mul_step[gprA_2, gprB_21], 32x32_step3
1c20:	 .900  mul_step[gprA_2, gprB_21], 32x32_step4
1c28:	 .901  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1c30:	 .902  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1c38:	 .903  immed[gprA_4, 0xfffff000], gpr_wrboth
1c40:	 .904  immed[gprA_5, 0x0], gpr_wrboth
1c48:	 .905  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
1c50:	 .906  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
1c58:	 .907  dbl_shf[gprA_2, gprA_3, gprB_2, >>12], gpr_wrboth
1c60:	 .908  alu_shf[gprA_3, --, B, gprB_3, >>12], gpr_wrboth
1c68:	 .909  alu[*l$index0[3], --, B, gprB_2]
1c70:	 .910  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1c78:	 .911  alu[*l$index0[3], --, B, gprB_2]
1c80:	 .912  immed[gprA_3, 0x0], gpr_wrboth
1c88:	 .913  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1c90:	 .914  immed[gprB_21, 0x8663]
1c98:	 .915  immed_w1[gprB_21, 0x33cd]
1ca0:	 .916  mul_step[gprA_2, gprB_21], start
1ca8:	 .917  mul_step[gprA_2, gprB_21], 32x32_step1
1cb0:	 .918  mul_step[gprA_2, gprB_21], 32x32_step2
1cb8:	 .919  mul_step[gprA_2, gprB_21], 32x32_step3
1cc0:	 .920  mul_step[gprA_2, gprB_21], 32x32_step4
1cc8:	 .921  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1cd0:	 .922  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1cd8:	 .923  immed[gprA_12, 0xffff8000], gpr_wrboth
1ce0:	 .924  immed[gprA_13, 0x0], gpr_wrboth
1ce8:	 .925  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1cf0:	 .926  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1cf8:	 .927  alu[gprA_4, gprA_4, AND, gprB_12], gpr_wrboth
1d00:	 .928  alu[gprA_5, gprA_5, AND, gprB_13], gpr_wrboth
1d08:	 .929  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1d10:	 .930  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1d18:	 .931  immed[gprB_21, 0xffff007f, <<16]
1d20:	 .932  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1d28:	 .933  immed[gprA_3, 0x0], gpr_wrboth
1d30:	 .934  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1d38:	 .935  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
1d40:	 .936  alu[*l$index0[2], --, B, gprB_4]
1d48:	 .937  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1d50:	 .938  immed[gprA_5, 0x0], gpr_wrboth
1d58:	 .939  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1d60:	 .940  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1d68:	 .941  immed[gprA_2, 0x0], gpr_wrboth
1d70:	 .942  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1d78:	 .943  local_csr_wr[ActLMAddr0, gprB_4]
1d80:	 .944  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1d88:	 .945  nop
1d90:	 .946  immed[gprA_21, 0xffff3fff, <<16]
1d98:	 .947  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1da0:	 .948  local_csr_wr[ActLMAddr0, gprA_22]
1da8:	 .949  nop
1db0:	 .950  nop
1db8:	 .951  nop
1dc0:	 .952  alu[--, gprA_0, OR, gprB_1]
1dc8:	 .953  beq[.959]
1dd0:	 .954  immed[gprA_2, 0x1], gpr_wrboth
1dd8:	 .955  immed[gprA_3, 0x0], gpr_wrboth
1de0:	 .956  immed[gprA_21, 0x890]
1de8:	 .957  ld_field[gprA_21, 1100, gprB_2, <<16]
1df0:	 .958  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1df8:	 .959  immed[gprA_2, 0xfffc, <<16], gpr_wrboth
1e00:	 .960  immed[gprA_3, 0x0], gpr_wrboth
1e08:	 .961  alu[gprA_16, gprA_16, AND, gprB_2], gpr_wrboth
1e10:	 .962  alu[gprA_17, gprA_17, AND, gprB_3], gpr_wrboth
1e18:	 .963  dbl_shf[gprA_16, gprA_17, gprB_16, >>18], gpr_wrboth
1e20:	 .964  alu_shf[gprA_17, --, B, gprB_17, >>18], gpr_wrboth
1e28:	 .965  alu[*l$index0[3], --, B, gprB_16]
1e30:	 .966  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1e38:	 .967  alu[*l$index0[3], --, B, gprB_2]
1e40:	 .968  immed[gprA_3, 0x0], gpr_wrboth
1e48:	 .969  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1e50:	 .970  immed[gprB_21, 0xbb47]
1e58:	 .971  immed_w1[gprB_21, 0x4260]
1e60:	 .972  mul_step[gprA_2, gprB_21], start
1e68:	 .973  mul_step[gprA_2, gprB_21], 32x32_step1
1e70:	 .974  mul_step[gprA_2, gprB_21], 32x32_step2
1e78:	 .975  mul_step[gprA_2, gprB_21], 32x32_step3
1e80:	 .976  mul_step[gprA_2, gprB_21], 32x32_step4
1e88:	 .977  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1e90:	 .978  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1e98:	 .979  immed[gprA_4, 0xffffe000], gpr_wrboth
1ea0:	 .980  immed[gprA_5, 0x0], gpr_wrboth
1ea8:	 .981  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
1eb0:	 .982  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
1eb8:	 .983  dbl_shf[gprA_2, gprA_3, gprB_2, >>13], gpr_wrboth
1ec0:	 .984  alu_shf[gprA_3, --, B, gprB_3, >>13], gpr_wrboth
1ec8:	 .985  alu[*l$index0[3], --, B, gprB_2]
1ed0:	 .986  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1ed8:	 .987  alu[*l$index0[3], --, B, gprB_2]
1ee0:	 .988  immed[gprA_3, 0x0], gpr_wrboth
1ee8:	 .989  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1ef0:	 .990  immed[gprB_21, 0xe1ed]
1ef8:	 .991  immed_w1[gprB_21, 0x27e8]
1f00:	 .992  mul_step[gprA_2, gprB_21], start
1f08:	 .993  mul_step[gprA_2, gprB_21], 32x32_step1
1f10:	 .994  mul_step[gprA_2, gprB_21], 32x32_step2
1f18:	 .995  mul_step[gprA_2, gprB_21], 32x32_step3
1f20:	 .996  mul_step[gprA_2, gprB_21], 32x32_step4
1f28:	 .997  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1f30:	 .998  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1f38:	 .999  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1f40:	.1000  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1f48:	.1001  alu[gprA_4, gprA_4, AND, gprB_12], gpr_wrboth
1f50:	.1002  alu[gprA_5, gprA_5, AND, gprB_13], gpr_wrboth
1f58:	.1003  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1f60:	.1004  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1f68:	.1005  immed[gprB_21, 0xffff007f, <<16]
1f70:	.1006  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1f78:	.1007  immed[gprA_3, 0x0], gpr_wrboth
1f80:	.1008  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1f88:	.1009  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
1f90:	.1010  alu[*l$index0[2], --, B, gprB_4]
1f98:	.1011  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1fa0:	.1012  immed[gprA_5, 0x0], gpr_wrboth
1fa8:	.1013  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1fb0:	.1014  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1fb8:	.1015  immed[gprA_2, 0x0], gpr_wrboth
1fc0:	.1016  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1fc8:	.1017  local_csr_wr[ActLMAddr0, gprB_4]
1fd0:	.1018  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1fd8:	.1019  nop
1fe0:	.1020  immed[gprA_21, 0xffff3fff, <<16]
1fe8:	.1021  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1ff0:	.1022  local_csr_wr[ActLMAddr0, gprA_22]
1ff8:	.1023  nop
2000:	.1024  nop
2008:	.1025  nop
2010:	.1026  alu[--, gprA_0, OR, gprB_1]
2018:	.1027  beq[.1033]
2020:	.1028  immed[gprA_2, 0x1], gpr_wrboth
2028:	.1029  immed[gprA_3, 0x0], gpr_wrboth
2030:	.1030  immed[gprA_21, 0x890]
2038:	.1031  ld_field[gprA_21, 1100, gprB_2, <<16]
2040:	.1032  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
2048:	.1033  alu[*l$index0[3], --, B, gprB_18]
2050:	.1034  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2058:	.1035  alu[*l$index0[3], --, B, gprB_2]
2060:	.1036  immed[gprA_3, 0x0], gpr_wrboth
2068:	.1037  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2070:	.1038  immed[gprB_21, 0xde45]
2078:	.1039  immed_w1[gprB_21, 0x3f6c]
2080:	.1040  mul_step[gprA_2, gprB_21], start
2088:	.1041  mul_step[gprA_2, gprB_21], 32x32_step1
2090:	.1042  mul_step[gprA_2, gprB_21], 32x32_step2
2098:	.1043  mul_step[gprA_2, gprB_21], 32x32_step3
20a0:	.1044  mul_step[gprA_2, gprB_21], 32x32_step4
20a8:	.1045  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
20b0:	.1046  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
20b8:	.1047  immed[gprA_4, 0xfffff000], gpr_wrboth
20c0:	.1048  immed[gprA_5, 0x0], gpr_wrboth
20c8:	.1049  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
20d0:	.1050  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
20d8:	.1051  dbl_shf[gprA_2, gprA_3, gprB_2, >>12], gpr_wrboth
20e0:	.1052  alu_shf[gprA_3, --, B, gprB_3, >>12], gpr_wrboth
20e8:	.1053  alu[*l$index0[3], --, B, gprB_2]
20f0:	.1054  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
20f8:	.1055  alu[*l$index0[3], --, B, gprB_2]
2100:	.1056  immed[gprA_3, 0x0], gpr_wrboth
2108:	.1057  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2110:	.1058  immed[gprB_21, 0x8ef]
2118:	.1059  immed_w1[gprB_21, 0x51d6]
2120:	.1060  mul_step[gprA_2, gprB_21], start
2128:	.1061  mul_step[gprA_2, gprB_21], 32x32_step1
2130:	.1062  mul_step[gprA_2, gprB_21], 32x32_step2
2138:	.1063  mul_step[gprA_2, gprB_21], 32x32_step3
2140:	.1064  mul_step[gprA_2, gprB_21], 32x32_step4
2148:	.1065  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2150:	.1066  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2158:	.1067  immed[gprA_4, 0xffff, <<16], gpr_wrboth
2160:	.1068  immed[gprA_5, 0x0], gpr_wrboth
2168:	.1069  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2170:	.1070  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2178:	.1071  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
2180:	.1072  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
2188:	.1073  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
2190:	.1074  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
2198:	.1075  immed[gprB_21, 0xffff007f, <<16]
21a0:	.1076  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
21a8:	.1077  immed[gprA_3, 0x0], gpr_wrboth
21b0:	.1078  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
21b8:	.1079  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
21c0:	.1080  alu[*l$index0[2], --, B, gprB_6]
21c8:	.1081  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
21d0:	.1082  immed[gprA_5, 0x0], gpr_wrboth
21d8:	.1083  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
21e0:	.1084  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
21e8:	.1085  immed[gprA_2, 0x0], gpr_wrboth
21f0:	.1086  alu[gprA_3, --, B, gprA_2], gpr_wrboth
21f8:	.1087  local_csr_wr[ActLMAddr0, gprB_4]
2200:	.1088  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2208:	.1089  nop
2210:	.1090  immed[gprA_21, 0xffff3fff, <<16]
2218:	.1091  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2220:	.1092  local_csr_wr[ActLMAddr0, gprA_22]
2228:	.1093  nop
2230:	.1094  nop
2238:	.1095  nop
2240:	.1096  alu[--, gprA_0, OR, gprB_1]
2248:	.1097  beq[.1103]
2250:	.1098  immed[gprA_2, 0x1], gpr_wrboth
2258:	.1099  immed[gprA_3, 0x0], gpr_wrboth
2260:	.1100  immed[gprA_21, 0x890]
2268:	.1101  ld_field[gprA_21, 1100, gprB_2, <<16]
2270:	.1102  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
2278:	.1103  alu[*l$index0[3], --, B, gprB_14]
2280:	.1104  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2288:	.1105  alu[*l$index0[3], --, B, gprB_2]
2290:	.1106  immed[gprA_3, 0x0], gpr_wrboth
2298:	.1107  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
22a0:	.1108  immed[gprB_21, 0x224b]
22a8:	.1109  immed_w1[gprB_21, 0x5dfa]
22b0:	.1110  mul_step[gprA_2, gprB_21], start
22b8:	.1111  mul_step[gprA_2, gprB_21], 32x32_step1
22c0:	.1112  mul_step[gprA_2, gprB_21], 32x32_step2
22c8:	.1113  mul_step[gprA_2, gprB_21], 32x32_step3
22d0:	.1114  mul_step[gprA_2, gprB_21], 32x32_step4
22d8:	.1115  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
22e0:	.1116  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
22e8:	.1117  immed[gprA_12, 0xffffc000], gpr_wrboth
22f0:	.1118  immed[gprA_13, 0x0], gpr_wrboth
22f8:	.1119  alu[gprA_2, gprA_2, AND, gprB_12], gpr_wrboth
2300:	.1120  alu[gprA_3, gprA_3, AND, gprB_13], gpr_wrboth
2308:	.1121  dbl_shf[gprA_2, gprA_3, gprB_2, >>14], gpr_wrboth
2310:	.1122  alu_shf[gprA_3, --, B, gprB_3, >>14], gpr_wrboth
2318:	.1123  alu[*l$index0[3], --, B, gprB_2]
2320:	.1124  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2328:	.1125  alu[*l$index0[3], --, B, gprB_2]
2330:	.1126  immed[gprA_3, 0x0], gpr_wrboth
2338:	.1127  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2340:	.1128  immed[gprB_21, 0x7e4b]
2348:	.1129  immed_w1[gprB_21, 0x4bee]
2350:	.1130  mul_step[gprA_2, gprB_21], start
2358:	.1131  mul_step[gprA_2, gprB_21], 32x32_step1
2360:	.1132  mul_step[gprA_2, gprB_21], 32x32_step2
2368:	.1133  mul_step[gprA_2, gprB_21], 32x32_step3
2370:	.1134  mul_step[gprA_2, gprB_21], 32x32_step4
2378:	.1135  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2380:	.1136  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2388:	.1137  immed[gprA_4, 0xfffe, <<16], gpr_wrboth
2390:	.1138  immed[gprA_5, 0x0], gpr_wrboth
2398:	.1139  alu[gprA_6, --, B, gprB_2], gpr_wrboth
23a0:	.1140  alu[gprA_7, --, B, gprB_3], gpr_wrboth
23a8:	.1141  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
23b0:	.1142  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
23b8:	.1143  dbl_shf[gprA_6, gprA_7, gprB_6, >>17], gpr_wrboth
23c0:	.1144  alu_shf[gprA_7, --, B, gprB_7, >>17], gpr_wrboth
23c8:	.1145  immed[gprB_21, 0xffff007f, <<16]
23d0:	.1146  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
23d8:	.1147  immed[gprA_3, 0x0], gpr_wrboth
23e0:	.1148  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
23e8:	.1149  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
23f0:	.1150  alu[*l$index0[2], --, B, gprB_6]
23f8:	.1151  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
2400:	.1152  immed[gprA_5, 0x0], gpr_wrboth
2408:	.1153  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
2410:	.1154  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
2418:	.1155  immed[gprA_2, 0x0], gpr_wrboth
2420:	.1156  alu[gprA_3, --, B, gprA_2], gpr_wrboth
2428:	.1157  local_csr_wr[ActLMAddr0, gprB_4]
2430:	.1158  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2438:	.1159  nop
2440:	.1160  immed[gprA_21, 0xffff3fff, <<16]
2448:	.1161  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2450:	.1162  local_csr_wr[ActLMAddr0, gprA_22]
2458:	.1163  nop
2460:	.1164  nop
2468:	.1165  nop
2470:	.1166  alu[--, gprA_0, OR, gprB_1]
2478:	.1167  beq[.1173]
2480:	.1168  immed[gprA_2, 0x1], gpr_wrboth
2488:	.1169  immed[gprA_3, 0x0], gpr_wrboth
2490:	.1170  immed[gprA_21, 0x890]
2498:	.1171  ld_field[gprA_21, 1100, gprB_2, <<16]
24a0:	.1172  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
24a8:	.1173  alu[*l$index0[3], --, B, gprB_14]
24b0:	.1174  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
24b8:	.1175  alu[*l$index0[3], --, B, gprB_2]
24c0:	.1176  immed[gprA_3, 0x0], gpr_wrboth
24c8:	.1177  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
24d0:	.1178  immed[gprB_21, 0x1d8d]
24d8:	.1179  immed_w1[gprB_21, 0x42f9]
24e0:	.1180  mul_step[gprA_2, gprB_21], start
24e8:	.1181  mul_step[gprA_2, gprB_21], 32x32_step1
24f0:	.1182  mul_step[gprA_2, gprB_21], 32x32_step2
24f8:	.1183  mul_step[gprA_2, gprB_21], 32x32_step3
2500:	.1184  mul_step[gprA_2, gprB_21], 32x32_step4
2508:	.1185  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2510:	.1186  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2518:	.1187  alu[gprA_2, gprA_2, AND, gprB_12], gpr_wrboth
2520:	.1188  alu[gprA_3, gprA_3, AND, gprB_13], gpr_wrboth
2528:	.1189  dbl_shf[gprA_2, gprA_3, gprB_2, >>14], gpr_wrboth
2530:	.1190  alu_shf[gprA_3, --, B, gprB_3, >>14], gpr_wrboth
2538:	.1191  alu[*l$index0[3], --, B, gprB_2]
2540:	.1192  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2548:	.1193  alu[*l$index0[3], --, B, gprB_2]
2550:	.1194  immed[gprA_3, 0x0], gpr_wrboth
2558:	.1195  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2560:	.1196  immed[gprB_21, 0x5a85]
2568:	.1197  immed_w1[gprB_21, 0x6135]
2570:	.1198  mul_step[gprA_2, gprB_21], start
2578:	.1199  mul_step[gprA_2, gprB_21], 32x32_step1
2580:	.1200  mul_step[gprA_2, gprB_21], 32x32_step2
2588:	.1201  mul_step[gprA_2, gprB_21], 32x32_step3
2590:	.1202  mul_step[gprA_2, gprB_21], 32x32_step4
2598:	.1203  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
25a0:	.1204  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
25a8:	.1205  immed[gprA_12, 0xffff8000], gpr_wrboth
25b0:	.1206  immed[gprA_13, 0x0], gpr_wrboth
25b8:	.1207  alu[gprA_4, --, B, gprB_2], gpr_wrboth
25c0:	.1208  alu[gprA_5, --, B, gprB_3], gpr_wrboth
25c8:	.1209  alu[gprA_4, gprA_4, AND, gprB_12], gpr_wrboth
25d0:	.1210  alu[gprA_5, gprA_5, AND, gprB_13], gpr_wrboth
25d8:	.1211  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
25e0:	.1212  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
25e8:	.1213  immed[gprB_21, 0xffff007f, <<16]
25f0:	.1214  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
25f8:	.1215  immed[gprA_3, 0x0], gpr_wrboth
2600:	.1216  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
2608:	.1217  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
2610:	.1218  alu[*l$index0[2], --, B, gprB_4]
2618:	.1219  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
2620:	.1220  immed[gprA_5, 0x0], gpr_wrboth
2628:	.1221  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
2630:	.1222  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
2638:	.1223  immed[gprA_2, 0x0], gpr_wrboth
2640:	.1224  alu[gprA_3, --, B, gprA_2], gpr_wrboth
2648:	.1225  local_csr_wr[ActLMAddr0, gprB_4]
2650:	.1226  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2658:	.1227  nop
2660:	.1228  immed[gprA_21, 0xffff3fff, <<16]
2668:	.1229  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2670:	.1230  local_csr_wr[ActLMAddr0, gprA_22]
2678:	.1231  nop
2680:	.1232  nop
2688:	.1233  nop
2690:	.1234  alu[--, gprA_0, OR, gprB_1]
2698:	.1235  beq[.1241]
26a0:	.1236  immed[gprA_2, 0x1], gpr_wrboth
26a8:	.1237  immed[gprA_3, 0x0], gpr_wrboth
26b0:	.1238  immed[gprA_21, 0x890]
26b8:	.1239  ld_field[gprA_21, 1100, gprB_2, <<16]
26c0:	.1240  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
26c8:	.1241  alu[*l$index0[3], --, B, gprB_14]
26d0:	.1242  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
26d8:	.1243  alu[*l$index0[3], --, B, gprB_2]
26e0:	.1244  immed[gprA_3, 0x0], gpr_wrboth
26e8:	.1245  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
26f0:	.1246  immed[gprB_21, 0x395b]
26f8:	.1247  immed_w1[gprB_21, 0x4df8]
2700:	.1248  mul_step[gprA_2, gprB_21], start
2708:	.1249  mul_step[gprA_2, gprB_21], 32x32_step1
2710:	.1250  mul_step[gprA_2, gprB_21], 32x32_step2
2718:	.1251  mul_step[gprA_2, gprB_21], 32x32_step3
2720:	.1252  mul_step[gprA_2, gprB_21], 32x32_step4
2728:	.1253  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2730:	.1254  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2738:	.1255  alu[gprA_2, gprA_2, AND, gprB_12], gpr_wrboth
2740:	.1256  alu[gprA_3, gprA_3, AND, gprB_13], gpr_wrboth
2748:	.1257  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
2750:	.1258  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
2758:	.1259  alu[*l$index0[3], --, B, gprB_2]
2760:	.1260  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2768:	.1261  alu[*l$index0[3], --, B, gprB_2]
2770:	.1262  immed[gprA_3, 0x0], gpr_wrboth
2778:	.1263  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2780:	.1264  immed[gprB_21, 0x428b]
2788:	.1265  immed_w1[gprB_21, 0x466b]
2790:	.1266  mul_step[gprA_2, gprB_21], start
2798:	.1267  mul_step[gprA_2, gprB_21], 32x32_step1
27a0:	.1268  mul_step[gprA_2, gprB_21], 32x32_step2
27a8:	.1269  mul_step[gprA_2, gprB_21], 32x32_step3
27b0:	.1270  mul_step[gprA_2, gprB_21], 32x32_step4
27b8:	.1271  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
27c0:	.1272  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
27c8:	.1273  immed[gprA_12, 0xffff, <<16], gpr_wrboth
27d0:	.1274  immed[gprA_13, 0x0], gpr_wrboth
27d8:	.1275  alu[gprA_4, --, B, gprB_2], gpr_wrboth
27e0:	.1276  alu[gprA_5, --, B, gprB_3], gpr_wrboth
27e8:	.1277  alu[gprA_4, gprA_4, AND, gprB_12], gpr_wrboth
27f0:	.1278  alu[gprA_5, gprA_5, AND, gprB_13], gpr_wrboth
27f8:	.1279  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
2800:	.1280  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
2808:	.1281  immed[gprB_21, 0xffff007f, <<16]
2810:	.1282  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
2818:	.1283  immed[gprA_3, 0x0], gpr_wrboth
2820:	.1284  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
2828:	.1285  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
2830:	.1286  alu[*l$index0[2], --, B, gprB_4]
2838:	.1287  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
2840:	.1288  immed[gprA_5, 0x0], gpr_wrboth
2848:	.1289  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
2850:	.1290  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
2858:	.1291  immed[gprA_2, 0x0], gpr_wrboth
2860:	.1292  alu[gprA_3, --, B, gprA_2], gpr_wrboth
2868:	.1293  local_csr_wr[ActLMAddr0, gprB_4]
2870:	.1294  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2878:	.1295  nop
2880:	.1296  immed[gprA_21, 0xffff3fff, <<16]
2888:	.1297  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2890:	.1298  local_csr_wr[ActLMAddr0, gprA_22]
2898:	.1299  nop
28a0:	.1300  nop
28a8:	.1301  nop
28b0:	.1302  alu[--, gprA_0, OR, gprB_1]
28b8:	.1303  beq[.1309]
28c0:	.1304  immed[gprA_2, 0x1], gpr_wrboth
28c8:	.1305  immed[gprA_3, 0x0], gpr_wrboth
28d0:	.1306  immed[gprA_21, 0x890]
28d8:	.1307  ld_field[gprA_21, 1100, gprB_2, <<16]
28e0:	.1308  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
28e8:	.1309  alu[gprA_2, --, B, *l$index0], gpr_wrboth
28f0:	.1310  alu[gprA_3, --, B, *l$index0[1]], gpr_wrboth
28f8:	.1311  alu[*l$index0[3], --, B, gprB_2]
2900:	.1312  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2908:	.1313  alu[*l$index0[3], --, B, gprB_2]
2910:	.1314  immed[gprA_3, 0x0], gpr_wrboth
2918:	.1315  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2920:	.1316  immed[gprB_21, 0x94cd]
2928:	.1317  immed_w1[gprB_21, 0xab6]
2930:	.1318  mul_step[gprA_2, gprB_21], start
2938:	.1319  mul_step[gprA_2, gprB_21], 32x32_step1
2940:	.1320  mul_step[gprA_2, gprB_21], 32x32_step2
2948:	.1321  mul_step[gprA_2, gprB_21], 32x32_step3
2950:	.1322  mul_step[gprA_2, gprB_21], 32x32_step4
2958:	.1323  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2960:	.1324  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2968:	.1325  immed[gprA_14, 0xffffc000], gpr_wrboth
2970:	.1326  immed[gprA_15, 0x0], gpr_wrboth
2978:	.1327  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
2980:	.1328  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
2988:	.1329  dbl_shf[gprA_2, gprA_3, gprB_2, >>14], gpr_wrboth
2990:	.1330  alu_shf[gprA_3, --, B, gprB_3, >>14], gpr_wrboth
2998:	.1331  alu[*l$index0[3], --, B, gprB_2]
29a0:	.1332  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
29a8:	.1333  alu[*l$index0[3], --, B, gprB_2]
29b0:	.1334  immed[gprA_3, 0x0], gpr_wrboth
29b8:	.1335  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
29c0:	.1336  immed[gprB_21, 0x9e47]
29c8:	.1337  immed_w1[gprB_21, 0x4c13]
29d0:	.1338  mul_step[gprA_2, gprB_21], start
29d8:	.1339  mul_step[gprA_2, gprB_21], 32x32_step1
29e0:	.1340  mul_step[gprA_2, gprB_21], 32x32_step2
29e8:	.1341  mul_step[gprA_2, gprB_21], 32x32_step3
29f0:	.1342  mul_step[gprA_2, gprB_21], 32x32_step4
29f8:	.1343  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2a00:	.1344  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2a08:	.1345  alu[gprA_4, --, B, gprB_2], gpr_wrboth
2a10:	.1346  alu[gprA_5, --, B, gprB_3], gpr_wrboth
2a18:	.1347  alu[gprA_4, gprA_4, AND, gprB_12], gpr_wrboth
2a20:	.1348  alu[gprA_5, gprA_5, AND, gprB_13], gpr_wrboth
2a28:	.1349  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
2a30:	.1350  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
2a38:	.1351  immed[gprB_21, 0xffff007f, <<16]
2a40:	.1352  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
2a48:	.1353  immed[gprA_3, 0x0], gpr_wrboth
2a50:	.1354  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
2a58:	.1355  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
2a60:	.1356  alu[*l$index0[2], --, B, gprB_4]
2a68:	.1357  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
2a70:	.1358  immed[gprA_5, 0x0], gpr_wrboth
2a78:	.1359  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
2a80:	.1360  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
2a88:	.1361  immed[gprA_2, 0x0], gpr_wrboth
2a90:	.1362  alu[gprA_3, --, B, gprA_2], gpr_wrboth
2a98:	.1363  local_csr_wr[ActLMAddr0, gprB_4]
2aa0:	.1364  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2aa8:	.1365  nop
2ab0:	.1366  immed[gprA_21, 0xffff3fff, <<16]
2ab8:	.1367  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2ac0:	.1368  local_csr_wr[ActLMAddr0, gprA_22]
2ac8:	.1369  nop
2ad0:	.1370  nop
2ad8:	.1371  nop
2ae0:	.1372  alu[--, gprA_0, OR, gprB_1]
2ae8:	.1373  beq[.1379]
2af0:	.1374  immed[gprA_2, 0x1], gpr_wrboth
2af8:	.1375  immed[gprA_3, 0x0], gpr_wrboth
2b00:	.1376  immed[gprA_21, 0x890]
2b08:	.1377  ld_field[gprA_21, 1100, gprB_2, <<16]
2b10:	.1378  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
2b18:	.1379  alu[gprA_2, --, B, *l$index0], gpr_wrboth
2b20:	.1380  alu[gprA_3, --, B, *l$index0[1]], gpr_wrboth
2b28:	.1381  alu[*l$index0[3], --, B, gprB_2]
2b30:	.1382  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2b38:	.1383  alu[*l$index0[3], --, B, gprB_2]
2b40:	.1384  immed[gprA_3, 0x0], gpr_wrboth
2b48:	.1385  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2b50:	.1386  immed[gprB_21, 0x9e55]
2b58:	.1387  immed_w1[gprB_21, 0x4510]
2b60:	.1388  mul_step[gprA_2, gprB_21], start
2b68:	.1389  mul_step[gprA_2, gprB_21], 32x32_step1
2b70:	.1390  mul_step[gprA_2, gprB_21], 32x32_step2
2b78:	.1391  mul_step[gprA_2, gprB_21], 32x32_step3
2b80:	.1392  mul_step[gprA_2, gprB_21], 32x32_step4
2b88:	.1393  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2b90:	.1394  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2b98:	.1395  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
2ba0:	.1396  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
2ba8:	.1397  dbl_shf[gprA_2, gprA_3, gprB_2, >>14], gpr_wrboth
2bb0:	.1398  alu_shf[gprA_3, --, B, gprB_3, >>14], gpr_wrboth
2bb8:	.1399  alu[*l$index0[3], --, B, gprB_2]
2bc0:	.1400  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2bc8:	.1401  alu[*l$index0[3], --, B, gprB_2]
2bd0:	.1402  immed[gprA_3, 0x0], gpr_wrboth
2bd8:	.1403  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2be0:	.1404  immed[gprB_21, 0x759d]
2be8:	.1405  immed_w1[gprB_21, 0x3b94]
2bf0:	.1406  mul_step[gprA_2, gprB_21], start
2bf8:	.1407  mul_step[gprA_2, gprB_21], 32x32_step1
2c00:	.1408  mul_step[gprA_2, gprB_21], 32x32_step2
2c08:	.1409  mul_step[gprA_2, gprB_21], 32x32_step3
2c10:	.1410  mul_step[gprA_2, gprB_21], 32x32_step4
2c18:	.1411  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2c20:	.1412  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2c28:	.1413  immed[gprA_4, 0xffff, <<16], gpr_wrboth
2c30:	.1414  immed[gprA_5, 0x0], gpr_wrboth
2c38:	.1415  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2c40:	.1416  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2c48:	.1417  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
2c50:	.1418  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
2c58:	.1419  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
2c60:	.1420  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
2c68:	.1421  immed[gprB_21, 0xffff007f, <<16]
2c70:	.1422  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
2c78:	.1423  immed[gprA_3, 0x0], gpr_wrboth
2c80:	.1424  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
2c88:	.1425  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
2c90:	.1426  alu[*l$index0[2], --, B, gprB_6]
2c98:	.1427  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
2ca0:	.1428  immed[gprA_5, 0x0], gpr_wrboth
2ca8:	.1429  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
2cb0:	.1430  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
2cb8:	.1431  immed[gprA_2, 0x0], gpr_wrboth
2cc0:	.1432  alu[gprA_3, --, B, gprA_2], gpr_wrboth
2cc8:	.1433  local_csr_wr[ActLMAddr0, gprB_4]
2cd0:	.1434  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2cd8:	.1435  nop
2ce0:	.1436  immed[gprA_21, 0xffff3fff, <<16]
2ce8:	.1437  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2cf0:	.1438  local_csr_wr[ActLMAddr0, gprA_22]
2cf8:	.1439  nop
2d00:	.1440  nop
2d08:	.1441  nop
2d10:	.1442  alu[--, gprA_0, OR, gprB_1]
2d18:	.1443  beq[.1449]
2d20:	.1444  immed[gprA_2, 0x1], gpr_wrboth
2d28:	.1445  immed[gprA_3, 0x0], gpr_wrboth
2d30:	.1446  immed[gprA_21, 0x890]
2d38:	.1447  ld_field[gprA_21, 1100, gprB_2, <<16]
2d40:	.1448  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
2d48:	.1449  alu[gprA_2, --, B, *l$index0], gpr_wrboth
2d50:	.1450  alu[gprA_3, --, B, *l$index0[1]], gpr_wrboth
2d58:	.1451  alu[*l$index0[3], --, B, gprB_2]
2d60:	.1452  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2d68:	.1453  alu[*l$index0[3], --, B, gprB_2]
2d70:	.1454  immed[gprA_3, 0x0], gpr_wrboth
2d78:	.1455  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2d80:	.1456  immed[gprB_21, 0x9705]
2d88:	.1457  immed_w1[gprB_21, 0x6cdb]
2d90:	.1458  mul_step[gprA_2, gprB_21], start
2d98:	.1459  mul_step[gprA_2, gprB_21], 32x32_step1
2da0:	.1460  mul_step[gprA_2, gprB_21], 32x32_step2
2da8:	.1461  mul_step[gprA_2, gprB_21], 32x32_step3
2db0:	.1462  mul_step[gprA_2, gprB_21], 32x32_step4
2db8:	.1463  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2dc0:	.1464  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2dc8:	.1465  immed[gprA_4, 0xffffc000], gpr_wrboth
2dd0:	.1466  immed[gprA_5, 0x0], gpr_wrboth
2dd8:	.1467  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
2de0:	.1468  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
2de8:	.1469  dbl_shf[gprA_2, gprA_3, gprB_2, >>14], gpr_wrboth
2df0:	.1470  alu_shf[gprA_3, --, B, gprB_3, >>14], gpr_wrboth
2df8:	.1471  alu[*l$index0[3], --, B, gprB_2]
2e00:	.1472  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2e08:	.1473  alu[*l$index0[3], --, B, gprB_2]
2e10:	.1474  immed[gprA_3, 0x0], gpr_wrboth
2e18:	.1475  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2e20:	.1476  immed[gprB_21, 0xd2ed]
2e28:	.1477  immed_w1[gprB_21, 0x4d58]
2e30:	.1478  mul_step[gprA_2, gprB_21], start
2e38:	.1479  mul_step[gprA_2, gprB_21], 32x32_step1
2e40:	.1480  mul_step[gprA_2, gprB_21], 32x32_step2
2e48:	.1481  mul_step[gprA_2, gprB_21], 32x32_step3
2e50:	.1482  mul_step[gprA_2, gprB_21], 32x32_step4
2e58:	.1483  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2e60:	.1484  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2e68:	.1485  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2e70:	.1486  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2e78:	.1487  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
2e80:	.1488  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
2e88:	.1489  dbl_shf[gprA_6, gprA_7, gprB_6, >>14], gpr_wrboth
2e90:	.1490  alu_shf[gprA_7, --, B, gprB_7, >>14], gpr_wrboth
2e98:	.1491  immed[gprB_21, 0xffff007f, <<16]
2ea0:	.1492  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
2ea8:	.1493  immed[gprA_3, 0x0], gpr_wrboth
2eb0:	.1494  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
2eb8:	.1495  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
2ec0:	.1496  alu[*l$index0[2], --, B, gprB_6]
2ec8:	.1497  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
2ed0:	.1498  immed[gprA_5, 0x0], gpr_wrboth
2ed8:	.1499  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
2ee0:	.1500  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
2ee8:	.1501  immed[gprA_2, 0x0], gpr_wrboth
2ef0:	.1502  alu[gprA_3, --, B, gprA_2], gpr_wrboth
2ef8:	.1503  local_csr_wr[ActLMAddr0, gprB_4]
2f00:	.1504  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2f08:	.1505  nop
2f10:	.1506  immed[gprA_21, 0xffff3fff, <<16]
2f18:	.1507  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2f20:	.1508  local_csr_wr[ActLMAddr0, gprA_22]
2f28:	.1509  nop
2f30:	.1510  nop
2f38:	.1511  nop
2f40:	.1512  alu[--, gprA_0, OR, gprB_1]
2f48:	.1513  beq[.1519]
2f50:	.1514  immed[gprA_2, 0x1], gpr_wrboth
2f58:	.1515  immed[gprA_3, 0x0], gpr_wrboth
2f60:	.1516  immed[gprA_21, 0x890]
2f68:	.1517  ld_field[gprA_21, 1100, gprB_2, <<16]
2f70:	.1518  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
2f78:	.1519  immed[gprA_0, 0x1], gpr_wrboth
2f80:	.1520  immed[gprA_1, 0x0], gpr_wrboth
2f88:	.1521  br[.15000]
2f90:	.1522  br[.15000], defer[2]
2f98:	.1523  alu[gprA_0, --, B, 0x0]
2fa0:	.1524  ld_field[gprA_0, 1100, 0x82, <<16]
2fa8:	.1525  alu[--, 0x3, -, gprB_0]
2fb0:	.1526  bcc[.1522]
2fb8:	.1527  immed[gprB_2, 0x2282]
2fc0:	.1528  immed_w1[gprB_2, 0x4411]
2fc8:	.1529  alu_shf[gprA_1, --, B, gprB_0, <<3]
2fd0:	.1530  alu[--, gprA_1, OR, 0x0]
2fd8:	.1531  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
2fe0:	.1532  br[.15000], defer[2]
2fe8:	.1533  alu[gprA_0, --, B, 0x0]
2ff0:	.1534  ld_field[gprA_0, 1100, gprB_2, <<16]
2ff8:	.1535  nop
3000:	.1536  nop
3008:	.1537  nop
3010:	.1538  nop
3018:	.1539  nop
3020:	.1540  nop
3028:	.1541  nop
3030:	.1542  nop
