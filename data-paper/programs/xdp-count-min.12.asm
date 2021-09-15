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
  70:	  .14  bcc[.1173]
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
 200:	  .64  alu[gprA_12, --, B, gprB_10], gpr_wrboth
 208:	  .65  alu[gprA_13, --, B, gprB_11], gpr_wrboth
 210:	  .66  alu[gprA_12, gprA_12, AND, gprB_4], gpr_wrboth
 218:	  .67  alu[gprA_13, gprA_13, AND, gprB_5], gpr_wrboth
 220:	  .68  dbl_shf[gprA_12, gprA_13, gprB_12, >>15], gpr_wrboth
 228:	  .69  alu_shf[gprA_13, --, B, gprB_13, >>15], gpr_wrboth
 230:	  .70  alu[gprA_12, gprA_12, XOR, gprB_10], gpr_wrboth
 238:	  .71  alu[gprA_13, gprA_13, XOR, gprB_11], gpr_wrboth
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
 3d8:	 .123  alu[gprA_8, gprA_8, XOR, gprB_12], gpr_wrboth
 3e0:	 .124  alu[gprA_9, gprA_9, XOR, gprB_13], gpr_wrboth
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
 6c0:	 .216  alu[gprA_12, --, B, gprB_8], gpr_wrboth
 6c8:	 .217  alu[gprA_13, --, B, gprB_9], gpr_wrboth
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
 868:	 .269  alu[gprA_12, --, B, gprB_0], gpr_wrboth
 870:	 .270  alu[gprA_13, --, B, gprB_1], gpr_wrboth
 878:	 .271  alu[gprA_12, gprA_12, XOR, gprB_8], gpr_wrboth
 880:	 .272  alu[gprA_13, gprA_13, XOR, gprB_9], gpr_wrboth
 888:	 .273  immed[gprA_6, 0xffff8000], gpr_wrboth
 890:	 .274  immed[gprA_7, 0x0], gpr_wrboth
 898:	 .275  alu[gprA_0, gprA_0, AND, gprB_6], gpr_wrboth
 8a0:	 .276  alu[gprA_1, gprA_1, AND, gprB_7], gpr_wrboth
 8a8:	 .277  dbl_shf[gprA_0, gprA_1, gprB_0, >>15], gpr_wrboth
 8b0:	 .278  alu_shf[gprA_1, --, B, gprB_1, >>15], gpr_wrboth
 8b8:	 .279  alu[gprA_12, gprA_12, XOR, gprB_0], gpr_wrboth
 8c0:	 .280  alu[gprA_13, gprA_13, XOR, gprB_1], gpr_wrboth
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
 9b0:	 .310  alu[gprA_12, gprA_12, XOR, gprB_8], gpr_wrboth
 9b8:	 .311  alu[gprA_13, gprA_13, XOR, gprB_9], gpr_wrboth
 9c0:	 .312  alu[gprA_8, gprA_8, AND, gprB_6], gpr_wrboth
 9c8:	 .313  alu[gprA_9, gprA_9, AND, gprB_7], gpr_wrboth
 9d0:	 .314  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
 9d8:	 .315  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
 9e0:	 .316  alu[gprA_12, gprA_12, XOR, gprB_8], gpr_wrboth
 9e8:	 .317  alu[gprA_13, gprA_13, XOR, gprB_9], gpr_wrboth
 9f0:	 .318  alu[gprA_14, --, B, gprB_12], gpr_wrboth
 9f8:	 .319  alu[gprA_15, --, B, gprB_13], gpr_wrboth
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
 bd0:	 .378  immed[gprA_21, 0xffff1fff, <<16]
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
 c38:	 .391  alu[gprA_16, --, B, gprB_12], gpr_wrboth
 c40:	 .392  alu[gprA_17, --, B, gprB_13], gpr_wrboth
 c48:	 .393  dbl_shf[gprA_16, gprA_17, gprB_16, >>16], gpr_wrboth
 c50:	 .394  alu_shf[gprA_17, --, B, gprB_17, >>16], gpr_wrboth
 c58:	 .395  immed[gprB_21, 0xffff]
 c60:	 .396  alu[gprA_16, gprA_16, AND, gprB_21], gpr_wrboth
 c68:	 .397  immed[gprA_17, 0x0], gpr_wrboth
 c70:	 .398  alu[*l$index0[3], --, B, gprB_16]
 c78:	 .399  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 c80:	 .400  alu[*l$index0[3], --, B, gprB_2]
 c88:	 .401  immed[gprA_3, 0x0], gpr_wrboth
 c90:	 .402  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 c98:	 .403  immed[gprB_21, 0x9f3b]
 ca0:	 .404  immed_w1[gprB_21, 0x45d]
 ca8:	 .405  mul_step[gprA_2, gprB_21], start
 cb0:	 .406  mul_step[gprA_2, gprB_21], 32x32_step1
 cb8:	 .407  mul_step[gprA_2, gprB_21], 32x32_step2
 cc0:	 .408  mul_step[gprA_2, gprB_21], 32x32_step3
 cc8:	 .409  mul_step[gprA_2, gprB_21], 32x32_step4
 cd0:	 .410  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 cd8:	 .411  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 ce0:	 .412  immed[gprA_18, 0xffff, <<16], gpr_wrboth
 ce8:	 .413  immed[gprA_19, 0x0], gpr_wrboth
 cf0:	 .414  alu[gprA_2, gprA_2, AND, gprB_18], gpr_wrboth
 cf8:	 .415  alu[gprA_3, gprA_3, AND, gprB_19], gpr_wrboth
 d00:	 .416  dbl_shf[gprA_2, gprA_3, gprB_2, >>16], gpr_wrboth
 d08:	 .417  alu_shf[gprA_3, --, B, gprB_3, >>16], gpr_wrboth
 d10:	 .418  alu[*l$index0[3], --, B, gprB_2]
 d18:	 .419  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 d20:	 .420  alu[*l$index0[3], --, B, gprB_2]
 d28:	 .421  immed[gprA_3, 0x0], gpr_wrboth
 d30:	 .422  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
 d38:	 .423  immed[gprB_21, 0x9f3b]
 d40:	 .424  immed_w1[gprB_21, 0x45d]
 d48:	 .425  mul_step[gprA_2, gprB_21], start
 d50:	 .426  mul_step[gprA_2, gprB_21], 32x32_step1
 d58:	 .427  mul_step[gprA_2, gprB_21], 32x32_step2
 d60:	 .428  mul_step[gprA_2, gprB_21], 32x32_step3
 d68:	 .429  mul_step[gprA_2, gprB_21], 32x32_step4
 d70:	 .430  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 d78:	 .431  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 d80:	 .432  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 d88:	 .433  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 d90:	 .434  alu[gprA_4, gprA_4, AND, gprB_18], gpr_wrboth
 d98:	 .435  alu[gprA_5, gprA_5, AND, gprB_19], gpr_wrboth
 da0:	 .436  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
 da8:	 .437  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
 db0:	 .438  immed[gprB_21, 0xffff007f, <<16]
 db8:	 .439  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 dc0:	 .440  immed[gprA_3, 0x0], gpr_wrboth
 dc8:	 .441  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
 dd0:	 .442  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
 dd8:	 .443  alu[*l$index0[2], --, B, gprB_4]
 de0:	 .444  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
 de8:	 .445  immed[gprA_5, 0x0], gpr_wrboth
 df0:	 .446  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
 df8:	 .447  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
 e00:	 .448  immed[gprA_2, 0x0], gpr_wrboth
 e08:	 .449  alu[gprA_3, --, B, gprA_2], gpr_wrboth
 e10:	 .450  local_csr_wr[ActLMAddr0, gprB_4]
 e18:	 .451  alu[gprA_1, --, B, gprB_23], gpr_wrboth
 e20:	 .452  nop
 e28:	 .453  immed[gprA_21, 0xffff1fff, <<16]
 e30:	 .454  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
 e38:	 .455  local_csr_wr[ActLMAddr0, gprA_22]
 e40:	 .456  nop
 e48:	 .457  nop
 e50:	 .458  nop
 e58:	 .459  alu[--, gprA_0, OR, gprB_1]
 e60:	 .460  beq[.466]
 e68:	 .461  immed[gprA_2, 0x1], gpr_wrboth
 e70:	 .462  immed[gprA_3, 0x0], gpr_wrboth
 e78:	 .463  immed[gprA_21, 0x890]
 e80:	 .464  ld_field[gprA_21, 1100, gprB_2, <<16]
 e88:	 .465  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
 e90:	 .466  alu[*l$index0, --, B, gprB_14]
 e98:	 .467  alu[*l$index0[1], --, B, gprB_15]
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
 f10:	 .482  immed[gprA_14, 0xffff8000], gpr_wrboth
 f18:	 .483  immed[gprA_15, 0x0], gpr_wrboth
 f20:	 .484  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
 f28:	 .485  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
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
1058:	 .523  immed[gprA_21, 0xffff1fff, <<16]
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
10c0:	 .536  alu[*l$index0[3], --, B, gprB_16]
10c8:	 .537  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
10d0:	 .538  alu[*l$index0[3], --, B, gprB_2]
10d8:	 .539  immed[gprA_3, 0x0], gpr_wrboth
10e0:	 .540  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
10e8:	 .541  immed[gprB_21, 0xb4db]
10f0:	 .542  immed_w1[gprB_21, 0x1ec9]
10f8:	 .543  mul_step[gprA_2, gprB_21], start
1100:	 .544  mul_step[gprA_2, gprB_21], 32x32_step1
1108:	 .545  mul_step[gprA_2, gprB_21], 32x32_step2
1110:	 .546  mul_step[gprA_2, gprB_21], 32x32_step3
1118:	 .547  mul_step[gprA_2, gprB_21], 32x32_step4
1120:	 .548  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1128:	 .549  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1130:	 .550  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
1138:	 .551  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
1140:	 .552  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
1148:	 .553  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
1150:	 .554  alu[*l$index0[3], --, B, gprB_2]
1158:	 .555  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1160:	 .556  alu[*l$index0[3], --, B, gprB_2]
1168:	 .557  immed[gprA_3, 0x0], gpr_wrboth
1170:	 .558  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1178:	 .559  immed[gprB_21, 0xd38d]
1180:	 .560  immed_w1[gprB_21, 0x3224]
1188:	 .561  mul_step[gprA_2, gprB_21], start
1190:	 .562  mul_step[gprA_2, gprB_21], 32x32_step1
1198:	 .563  mul_step[gprA_2, gprB_21], 32x32_step2
11a0:	 .564  mul_step[gprA_2, gprB_21], 32x32_step3
11a8:	 .565  mul_step[gprA_2, gprB_21], 32x32_step4
11b0:	 .566  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
11b8:	 .567  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
11c0:	 .568  immed[gprA_4, 0xfffe, <<16], gpr_wrboth
11c8:	 .569  immed[gprA_5, 0x0], gpr_wrboth
11d0:	 .570  alu[gprA_6, --, B, gprB_2], gpr_wrboth
11d8:	 .571  alu[gprA_7, --, B, gprB_3], gpr_wrboth
11e0:	 .572  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
11e8:	 .573  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
11f0:	 .574  dbl_shf[gprA_6, gprA_7, gprB_6, >>17], gpr_wrboth
11f8:	 .575  alu_shf[gprA_7, --, B, gprB_7, >>17], gpr_wrboth
1200:	 .576  immed[gprB_21, 0xffff007f, <<16]
1208:	 .577  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1210:	 .578  immed[gprA_3, 0x0], gpr_wrboth
1218:	 .579  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
1220:	 .580  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
1228:	 .581  alu[*l$index0[2], --, B, gprB_6]
1230:	 .582  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1238:	 .583  immed[gprA_5, 0x0], gpr_wrboth
1240:	 .584  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1248:	 .585  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1250:	 .586  immed[gprA_2, 0x0], gpr_wrboth
1258:	 .587  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1260:	 .588  local_csr_wr[ActLMAddr0, gprB_4]
1268:	 .589  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1270:	 .590  nop
1278:	 .591  immed[gprA_21, 0xffff1fff, <<16]
1280:	 .592  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1288:	 .593  local_csr_wr[ActLMAddr0, gprA_22]
1290:	 .594  nop
1298:	 .595  nop
12a0:	 .596  nop
12a8:	 .597  alu[--, gprA_0, OR, gprB_1]
12b0:	 .598  beq[.604]
12b8:	 .599  immed[gprA_2, 0x1], gpr_wrboth
12c0:	 .600  immed[gprA_3, 0x0], gpr_wrboth
12c8:	 .601  immed[gprA_21, 0x890]
12d0:	 .602  ld_field[gprA_21, 1100, gprB_2, <<16]
12d8:	 .603  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
12e0:	 .604  alu[gprA_18, --, B, gprB_12], gpr_wrboth
12e8:	 .605  alu[gprA_19, --, B, gprB_13], gpr_wrboth
12f0:	 .606  dbl_shf[gprA_18, gprA_19, gprB_18, >>17], gpr_wrboth
12f8:	 .607  alu_shf[gprA_19, --, B, gprB_19, >>17], gpr_wrboth
1300:	 .608  immed[gprB_21, 0x7fff]
1308:	 .609  alu[gprA_18, gprA_18, AND, gprB_21], gpr_wrboth
1310:	 .610  immed[gprA_19, 0x0], gpr_wrboth
1318:	 .611  alu[*l$index0[3], --, B, gprB_18]
1320:	 .612  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1328:	 .613  alu[*l$index0[3], --, B, gprB_2]
1330:	 .614  immed[gprA_3, 0x0], gpr_wrboth
1338:	 .615  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1340:	 .616  immed[gprB_21, 0xd515]
1348:	 .617  immed_w1[gprB_21, 0x179c]
1350:	 .618  mul_step[gprA_2, gprB_21], start
1358:	 .619  mul_step[gprA_2, gprB_21], 32x32_step1
1360:	 .620  mul_step[gprA_2, gprB_21], 32x32_step2
1368:	 .621  mul_step[gprA_2, gprB_21], 32x32_step3
1370:	 .622  mul_step[gprA_2, gprB_21], 32x32_step4
1378:	 .623  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1380:	 .624  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1388:	 .625  immed[gprA_14, 0xffff8000], gpr_wrboth
1390:	 .626  immed[gprA_15, 0x0], gpr_wrboth
1398:	 .627  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
13a0:	 .628  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
13a8:	 .629  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
13b0:	 .630  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
13b8:	 .631  alu[*l$index0[3], --, B, gprB_2]
13c0:	 .632  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
13c8:	 .633  alu[*l$index0[3], --, B, gprB_2]
13d0:	 .634  immed[gprA_3, 0x0], gpr_wrboth
13d8:	 .635  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
13e0:	 .636  immed[gprB_21, 0x5d47]
13e8:	 .637  immed_w1[gprB_21, 0x4c49]
13f0:	 .638  mul_step[gprA_2, gprB_21], start
13f8:	 .639  mul_step[gprA_2, gprB_21], 32x32_step1
1400:	 .640  mul_step[gprA_2, gprB_21], 32x32_step2
1408:	 .641  mul_step[gprA_2, gprB_21], 32x32_step3
1410:	 .642  mul_step[gprA_2, gprB_21], 32x32_step4
1418:	 .643  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1420:	 .644  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1428:	 .645  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1430:	 .646  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1438:	 .647  alu[gprA_4, gprA_4, AND, gprB_14], gpr_wrboth
1440:	 .648  alu[gprA_5, gprA_5, AND, gprB_15], gpr_wrboth
1448:	 .649  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1450:	 .650  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1458:	 .651  immed[gprB_21, 0xffff007f, <<16]
1460:	 .652  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1468:	 .653  immed[gprA_3, 0x0], gpr_wrboth
1470:	 .654  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1478:	 .655  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
1480:	 .656  alu[*l$index0[2], --, B, gprB_4]
1488:	 .657  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1490:	 .658  immed[gprA_5, 0x0], gpr_wrboth
1498:	 .659  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
14a0:	 .660  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
14a8:	 .661  immed[gprA_2, 0x0], gpr_wrboth
14b0:	 .662  alu[gprA_3, --, B, gprA_2], gpr_wrboth
14b8:	 .663  local_csr_wr[ActLMAddr0, gprB_4]
14c0:	 .664  alu[gprA_1, --, B, gprB_23], gpr_wrboth
14c8:	 .665  nop
14d0:	 .666  immed[gprA_21, 0xffff1fff, <<16]
14d8:	 .667  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
14e0:	 .668  local_csr_wr[ActLMAddr0, gprA_22]
14e8:	 .669  nop
14f0:	 .670  nop
14f8:	 .671  nop
1500:	 .672  alu[--, gprA_0, OR, gprB_1]
1508:	 .673  beq[.679]
1510:	 .674  immed[gprA_2, 0x1], gpr_wrboth
1518:	 .675  immed[gprA_3, 0x0], gpr_wrboth
1520:	 .676  immed[gprA_21, 0x890]
1528:	 .677  ld_field[gprA_21, 1100, gprB_2, <<16]
1530:	 .678  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1538:	 .679  alu[*l$index0[3], --, B, gprB_18]
1540:	 .680  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1548:	 .681  alu[*l$index0[3], --, B, gprB_2]
1550:	 .682  immed[gprA_3, 0x0], gpr_wrboth
1558:	 .683  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1560:	 .684  immed[gprB_21, 0xd2cd]
1568:	 .685  immed_w1[gprB_21, 0x24f4]
1570:	 .686  mul_step[gprA_2, gprB_21], start
1578:	 .687  mul_step[gprA_2, gprB_21], 32x32_step1
1580:	 .688  mul_step[gprA_2, gprB_21], 32x32_step2
1588:	 .689  mul_step[gprA_2, gprB_21], 32x32_step3
1590:	 .690  mul_step[gprA_2, gprB_21], 32x32_step4
1598:	 .691  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
15a0:	 .692  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
15a8:	 .693  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
15b0:	 .694  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
15b8:	 .695  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
15c0:	 .696  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
15c8:	 .697  alu[*l$index0[3], --, B, gprB_2]
15d0:	 .698  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
15d8:	 .699  alu[*l$index0[3], --, B, gprB_2]
15e0:	 .700  immed[gprA_3, 0x0], gpr_wrboth
15e8:	 .701  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
15f0:	 .702  immed[gprB_21, 0xb969]
15f8:	 .703  immed_w1[gprB_21, 0x1ba3]
1600:	 .704  mul_step[gprA_2, gprB_21], start
1608:	 .705  mul_step[gprA_2, gprB_21], 32x32_step1
1610:	 .706  mul_step[gprA_2, gprB_21], 32x32_step2
1618:	 .707  mul_step[gprA_2, gprB_21], 32x32_step3
1620:	 .708  mul_step[gprA_2, gprB_21], 32x32_step4
1628:	 .709  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1630:	 .710  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1638:	 .711  immed[gprA_14, 0xffff, <<16], gpr_wrboth
1640:	 .712  immed[gprA_15, 0x0], gpr_wrboth
1648:	 .713  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1650:	 .714  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1658:	 .715  alu[gprA_4, gprA_4, AND, gprB_14], gpr_wrboth
1660:	 .716  alu[gprA_5, gprA_5, AND, gprB_15], gpr_wrboth
1668:	 .717  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
1670:	 .718  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
1678:	 .719  immed[gprB_21, 0xffff007f, <<16]
1680:	 .720  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1688:	 .721  immed[gprA_3, 0x0], gpr_wrboth
1690:	 .722  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1698:	 .723  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
16a0:	 .724  alu[*l$index0[2], --, B, gprB_4]
16a8:	 .725  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
16b0:	 .726  immed[gprA_5, 0x0], gpr_wrboth
16b8:	 .727  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
16c0:	 .728  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
16c8:	 .729  immed[gprA_2, 0x0], gpr_wrboth
16d0:	 .730  alu[gprA_3, --, B, gprA_2], gpr_wrboth
16d8:	 .731  local_csr_wr[ActLMAddr0, gprB_4]
16e0:	 .732  alu[gprA_1, --, B, gprB_23], gpr_wrboth
16e8:	 .733  nop
16f0:	 .734  immed[gprA_21, 0xffff1fff, <<16]
16f8:	 .735  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1700:	 .736  local_csr_wr[ActLMAddr0, gprA_22]
1708:	 .737  nop
1710:	 .738  nop
1718:	 .739  nop
1720:	 .740  alu[--, gprA_0, OR, gprB_1]
1728:	 .741  beq[.747]
1730:	 .742  immed[gprA_2, 0x1], gpr_wrboth
1738:	 .743  immed[gprA_3, 0x0], gpr_wrboth
1740:	 .744  immed[gprA_21, 0x890]
1748:	 .745  ld_field[gprA_21, 1100, gprB_2, <<16]
1750:	 .746  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1758:	 .747  alu[*l$index0[3], --, B, gprB_18]
1760:	 .748  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1768:	 .749  alu[*l$index0[3], --, B, gprB_2]
1770:	 .750  immed[gprA_3, 0x0], gpr_wrboth
1778:	 .751  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1780:	 .752  immed[gprB_21, 0x3ae5]
1788:	 .753  immed_w1[gprB_21, 0x5abe]
1790:	 .754  mul_step[gprA_2, gprB_21], start
1798:	 .755  mul_step[gprA_2, gprB_21], 32x32_step1
17a0:	 .756  mul_step[gprA_2, gprB_21], 32x32_step2
17a8:	 .757  mul_step[gprA_2, gprB_21], 32x32_step3
17b0:	 .758  mul_step[gprA_2, gprB_21], 32x32_step4
17b8:	 .759  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
17c0:	 .760  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
17c8:	 .761  immed[gprA_4, 0xffffe000], gpr_wrboth
17d0:	 .762  immed[gprA_5, 0x0], gpr_wrboth
17d8:	 .763  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
17e0:	 .764  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
17e8:	 .765  dbl_shf[gprA_2, gprA_3, gprB_2, >>13], gpr_wrboth
17f0:	 .766  alu_shf[gprA_3, --, B, gprB_3, >>13], gpr_wrboth
17f8:	 .767  alu[*l$index0[3], --, B, gprB_2]
1800:	 .768  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1808:	 .769  alu[*l$index0[3], --, B, gprB_2]
1810:	 .770  immed[gprA_3, 0x0], gpr_wrboth
1818:	 .771  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1820:	 .772  immed[gprB_21, 0x9657]
1828:	 .773  immed_w1[gprB_21, 0x6563]
1830:	 .774  mul_step[gprA_2, gprB_21], start
1838:	 .775  mul_step[gprA_2, gprB_21], 32x32_step1
1840:	 .776  mul_step[gprA_2, gprB_21], 32x32_step2
1848:	 .777  mul_step[gprA_2, gprB_21], 32x32_step3
1850:	 .778  mul_step[gprA_2, gprB_21], 32x32_step4
1858:	 .779  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1860:	 .780  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1868:	 .781  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1870:	 .782  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1878:	 .783  alu[gprA_4, gprA_4, AND, gprB_14], gpr_wrboth
1880:	 .784  alu[gprA_5, gprA_5, AND, gprB_15], gpr_wrboth
1888:	 .785  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
1890:	 .786  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
1898:	 .787  immed[gprB_21, 0xffff007f, <<16]
18a0:	 .788  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
18a8:	 .789  immed[gprA_3, 0x0], gpr_wrboth
18b0:	 .790  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
18b8:	 .791  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
18c0:	 .792  alu[*l$index0[2], --, B, gprB_4]
18c8:	 .793  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
18d0:	 .794  immed[gprA_5, 0x0], gpr_wrboth
18d8:	 .795  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
18e0:	 .796  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
18e8:	 .797  immed[gprA_2, 0x0], gpr_wrboth
18f0:	 .798  alu[gprA_3, --, B, gprA_2], gpr_wrboth
18f8:	 .799  local_csr_wr[ActLMAddr0, gprB_4]
1900:	 .800  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1908:	 .801  nop
1910:	 .802  immed[gprA_21, 0xffff1fff, <<16]
1918:	 .803  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1920:	 .804  local_csr_wr[ActLMAddr0, gprA_22]
1928:	 .805  nop
1930:	 .806  nop
1938:	 .807  nop
1940:	 .808  alu[--, gprA_0, OR, gprB_1]
1948:	 .809  beq[.815]
1950:	 .810  immed[gprA_2, 0x1], gpr_wrboth
1958:	 .811  immed[gprA_3, 0x0], gpr_wrboth
1960:	 .812  immed[gprA_21, 0x890]
1968:	 .813  ld_field[gprA_21, 1100, gprB_2, <<16]
1970:	 .814  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1978:	 .815  alu[*l$index0[3], --, B, gprB_18]
1980:	 .816  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1988:	 .817  alu[*l$index0[3], --, B, gprB_2]
1990:	 .818  immed[gprA_3, 0x0], gpr_wrboth
1998:	 .819  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
19a0:	 .820  immed[gprB_21, 0xe54b]
19a8:	 .821  immed_w1[gprB_21, 0x6e79]
19b0:	 .822  mul_step[gprA_2, gprB_21], start
19b8:	 .823  mul_step[gprA_2, gprB_21], 32x32_step1
19c0:	 .824  mul_step[gprA_2, gprB_21], 32x32_step2
19c8:	 .825  mul_step[gprA_2, gprB_21], 32x32_step3
19d0:	 .826  mul_step[gprA_2, gprB_21], 32x32_step4
19d8:	 .827  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
19e0:	 .828  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
19e8:	 .829  immed[gprA_4, 0xffffc000], gpr_wrboth
19f0:	 .830  immed[gprA_5, 0x0], gpr_wrboth
19f8:	 .831  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
1a00:	 .832  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
1a08:	 .833  dbl_shf[gprA_2, gprA_3, gprB_2, >>14], gpr_wrboth
1a10:	 .834  alu_shf[gprA_3, --, B, gprB_3, >>14], gpr_wrboth
1a18:	 .835  alu[*l$index0[3], --, B, gprB_2]
1a20:	 .836  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1a28:	 .837  alu[*l$index0[3], --, B, gprB_2]
1a30:	 .838  immed[gprA_3, 0x0], gpr_wrboth
1a38:	 .839  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1a40:	 .840  immed[gprB_21, 0xb24d]
1a48:	 .841  immed_w1[gprB_21, 0x915]
1a50:	 .842  mul_step[gprA_2, gprB_21], start
1a58:	 .843  mul_step[gprA_2, gprB_21], 32x32_step1
1a60:	 .844  mul_step[gprA_2, gprB_21], 32x32_step2
1a68:	 .845  mul_step[gprA_2, gprB_21], 32x32_step3
1a70:	 .846  mul_step[gprA_2, gprB_21], 32x32_step4
1a78:	 .847  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1a80:	 .848  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1a88:	 .849  immed[gprA_4, 0xffff, <<16], gpr_wrboth
1a90:	 .850  immed[gprA_5, 0x0], gpr_wrboth
1a98:	 .851  alu[gprA_6, --, B, gprB_2], gpr_wrboth
1aa0:	 .852  alu[gprA_7, --, B, gprB_3], gpr_wrboth
1aa8:	 .853  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
1ab0:	 .854  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
1ab8:	 .855  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
1ac0:	 .856  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
1ac8:	 .857  immed[gprB_21, 0xffff007f, <<16]
1ad0:	 .858  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1ad8:	 .859  immed[gprA_3, 0x0], gpr_wrboth
1ae0:	 .860  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
1ae8:	 .861  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
1af0:	 .862  alu[*l$index0[2], --, B, gprB_6]
1af8:	 .863  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1b00:	 .864  immed[gprA_5, 0x0], gpr_wrboth
1b08:	 .865  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1b10:	 .866  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1b18:	 .867  immed[gprA_2, 0x0], gpr_wrboth
1b20:	 .868  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1b28:	 .869  local_csr_wr[ActLMAddr0, gprB_4]
1b30:	 .870  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1b38:	 .871  nop
1b40:	 .872  immed[gprA_21, 0xffff1fff, <<16]
1b48:	 .873  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1b50:	 .874  local_csr_wr[ActLMAddr0, gprA_22]
1b58:	 .875  nop
1b60:	 .876  nop
1b68:	 .877  nop
1b70:	 .878  alu[gprA_14, --, B, *l$index0], gpr_wrboth
1b78:	 .879  alu[gprA_15, --, B, *l$index0[1]], gpr_wrboth
1b80:	 .880  alu[--, gprA_0, OR, gprB_1]
1b88:	 .881  beq[.887]
1b90:	 .882  immed[gprA_2, 0x1], gpr_wrboth
1b98:	 .883  immed[gprA_3, 0x0], gpr_wrboth
1ba0:	 .884  immed[gprA_21, 0x890]
1ba8:	 .885  ld_field[gprA_21, 1100, gprB_2, <<16]
1bb0:	 .886  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1bb8:	 .887  alu[*l$index0[3], --, B, gprB_16]
1bc0:	 .888  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1bc8:	 .889  alu[*l$index0[3], --, B, gprB_2]
1bd0:	 .890  immed[gprA_3, 0x0], gpr_wrboth
1bd8:	 .891  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1be0:	 .892  immed[gprB_21, 0x7153]
1be8:	 .893  immed_w1[gprB_21, 0x236f]
1bf0:	 .894  mul_step[gprA_2, gprB_21], start
1bf8:	 .895  mul_step[gprA_2, gprB_21], 32x32_step1
1c00:	 .896  mul_step[gprA_2, gprB_21], 32x32_step2
1c08:	 .897  mul_step[gprA_2, gprB_21], 32x32_step3
1c10:	 .898  mul_step[gprA_2, gprB_21], 32x32_step4
1c18:	 .899  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1c20:	 .900  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1c28:	 .901  immed[gprA_4, 0xfffff000], gpr_wrboth
1c30:	 .902  immed[gprA_5, 0x0], gpr_wrboth
1c38:	 .903  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
1c40:	 .904  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
1c48:	 .905  dbl_shf[gprA_2, gprA_3, gprB_2, >>12], gpr_wrboth
1c50:	 .906  alu_shf[gprA_3, --, B, gprB_3, >>12], gpr_wrboth
1c58:	 .907  alu[*l$index0[3], --, B, gprB_2]
1c60:	 .908  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1c68:	 .909  alu[*l$index0[3], --, B, gprB_2]
1c70:	 .910  immed[gprA_3, 0x0], gpr_wrboth
1c78:	 .911  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1c80:	 .912  immed[gprB_21, 0x8663]
1c88:	 .913  immed_w1[gprB_21, 0x33cd]
1c90:	 .914  mul_step[gprA_2, gprB_21], start
1c98:	 .915  mul_step[gprA_2, gprB_21], 32x32_step1
1ca0:	 .916  mul_step[gprA_2, gprB_21], 32x32_step2
1ca8:	 .917  mul_step[gprA_2, gprB_21], 32x32_step3
1cb0:	 .918  mul_step[gprA_2, gprB_21], 32x32_step4
1cb8:	 .919  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1cc0:	 .920  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1cc8:	 .921  immed[gprA_16, 0xffff8000], gpr_wrboth
1cd0:	 .922  immed[gprA_17, 0x0], gpr_wrboth
1cd8:	 .923  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1ce0:	 .924  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1ce8:	 .925  alu[gprA_4, gprA_4, AND, gprB_16], gpr_wrboth
1cf0:	 .926  alu[gprA_5, gprA_5, AND, gprB_17], gpr_wrboth
1cf8:	 .927  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1d00:	 .928  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1d08:	 .929  immed[gprB_21, 0xffff007f, <<16]
1d10:	 .930  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1d18:	 .931  immed[gprA_3, 0x0], gpr_wrboth
1d20:	 .932  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1d28:	 .933  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
1d30:	 .934  alu[*l$index0[2], --, B, gprB_4]
1d38:	 .935  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1d40:	 .936  immed[gprA_5, 0x0], gpr_wrboth
1d48:	 .937  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1d50:	 .938  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1d58:	 .939  immed[gprA_2, 0x0], gpr_wrboth
1d60:	 .940  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1d68:	 .941  local_csr_wr[ActLMAddr0, gprB_4]
1d70:	 .942  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1d78:	 .943  nop
1d80:	 .944  immed[gprA_21, 0xffff1fff, <<16]
1d88:	 .945  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1d90:	 .946  local_csr_wr[ActLMAddr0, gprA_22]
1d98:	 .947  nop
1da0:	 .948  nop
1da8:	 .949  nop
1db0:	 .950  alu[--, gprA_0, OR, gprB_1]
1db8:	 .951  beq[.957]
1dc0:	 .952  immed[gprA_2, 0x1], gpr_wrboth
1dc8:	 .953  immed[gprA_3, 0x0], gpr_wrboth
1dd0:	 .954  immed[gprA_21, 0x890]
1dd8:	 .955  ld_field[gprA_21, 1100, gprB_2, <<16]
1de0:	 .956  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1de8:	 .957  immed[gprA_2, 0xfffc, <<16], gpr_wrboth
1df0:	 .958  immed[gprA_3, 0x0], gpr_wrboth
1df8:	 .959  alu[gprA_12, gprA_12, AND, gprB_2], gpr_wrboth
1e00:	 .960  alu[gprA_13, gprA_13, AND, gprB_3], gpr_wrboth
1e08:	 .961  dbl_shf[gprA_12, gprA_13, gprB_12, >>18], gpr_wrboth
1e10:	 .962  alu_shf[gprA_13, --, B, gprB_13, >>18], gpr_wrboth
1e18:	 .963  alu[*l$index0[3], --, B, gprB_12]
1e20:	 .964  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1e28:	 .965  alu[*l$index0[3], --, B, gprB_2]
1e30:	 .966  immed[gprA_3, 0x0], gpr_wrboth
1e38:	 .967  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1e40:	 .968  immed[gprB_21, 0xbb47]
1e48:	 .969  immed_w1[gprB_21, 0x4260]
1e50:	 .970  mul_step[gprA_2, gprB_21], start
1e58:	 .971  mul_step[gprA_2, gprB_21], 32x32_step1
1e60:	 .972  mul_step[gprA_2, gprB_21], 32x32_step2
1e68:	 .973  mul_step[gprA_2, gprB_21], 32x32_step3
1e70:	 .974  mul_step[gprA_2, gprB_21], 32x32_step4
1e78:	 .975  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1e80:	 .976  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1e88:	 .977  immed[gprA_4, 0xffffe000], gpr_wrboth
1e90:	 .978  immed[gprA_5, 0x0], gpr_wrboth
1e98:	 .979  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
1ea0:	 .980  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
1ea8:	 .981  dbl_shf[gprA_2, gprA_3, gprB_2, >>13], gpr_wrboth
1eb0:	 .982  alu_shf[gprA_3, --, B, gprB_3, >>13], gpr_wrboth
1eb8:	 .983  alu[*l$index0[3], --, B, gprB_2]
1ec0:	 .984  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1ec8:	 .985  alu[*l$index0[3], --, B, gprB_2]
1ed0:	 .986  immed[gprA_3, 0x0], gpr_wrboth
1ed8:	 .987  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
1ee0:	 .988  immed[gprB_21, 0xe1ed]
1ee8:	 .989  immed_w1[gprB_21, 0x27e8]
1ef0:	 .990  mul_step[gprA_2, gprB_21], start
1ef8:	 .991  mul_step[gprA_2, gprB_21], 32x32_step1
1f00:	 .992  mul_step[gprA_2, gprB_21], 32x32_step2
1f08:	 .993  mul_step[gprA_2, gprB_21], 32x32_step3
1f10:	 .994  mul_step[gprA_2, gprB_21], 32x32_step4
1f18:	 .995  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1f20:	 .996  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1f28:	 .997  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1f30:	 .998  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1f38:	 .999  alu[gprA_4, gprA_4, AND, gprB_16], gpr_wrboth
1f40:	.1000  alu[gprA_5, gprA_5, AND, gprB_17], gpr_wrboth
1f48:	.1001  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1f50:	.1002  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1f58:	.1003  immed[gprB_21, 0xffff007f, <<16]
1f60:	.1004  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1f68:	.1005  immed[gprA_3, 0x0], gpr_wrboth
1f70:	.1006  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1f78:	.1007  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
1f80:	.1008  alu[*l$index0[2], --, B, gprB_4]
1f88:	.1009  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
1f90:	.1010  immed[gprA_5, 0x0], gpr_wrboth
1f98:	.1011  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1fa0:	.1012  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1fa8:	.1013  immed[gprA_2, 0x0], gpr_wrboth
1fb0:	.1014  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1fb8:	.1015  local_csr_wr[ActLMAddr0, gprB_4]
1fc0:	.1016  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1fc8:	.1017  nop
1fd0:	.1018  immed[gprA_21, 0xffff1fff, <<16]
1fd8:	.1019  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
1fe0:	.1020  local_csr_wr[ActLMAddr0, gprA_22]
1fe8:	.1021  nop
1ff0:	.1022  nop
1ff8:	.1023  nop
2000:	.1024  alu[--, gprA_0, OR, gprB_1]
2008:	.1025  beq[.1031]
2010:	.1026  immed[gprA_2, 0x1], gpr_wrboth
2018:	.1027  immed[gprA_3, 0x0], gpr_wrboth
2020:	.1028  immed[gprA_21, 0x890]
2028:	.1029  ld_field[gprA_21, 1100, gprB_2, <<16]
2030:	.1030  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
2038:	.1031  alu[*l$index0[3], --, B, gprB_18]
2040:	.1032  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2048:	.1033  alu[*l$index0[3], --, B, gprB_2]
2050:	.1034  immed[gprA_3, 0x0], gpr_wrboth
2058:	.1035  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2060:	.1036  immed[gprB_21, 0xde45]
2068:	.1037  immed_w1[gprB_21, 0x3f6c]
2070:	.1038  mul_step[gprA_2, gprB_21], start
2078:	.1039  mul_step[gprA_2, gprB_21], 32x32_step1
2080:	.1040  mul_step[gprA_2, gprB_21], 32x32_step2
2088:	.1041  mul_step[gprA_2, gprB_21], 32x32_step3
2090:	.1042  mul_step[gprA_2, gprB_21], 32x32_step4
2098:	.1043  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
20a0:	.1044  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
20a8:	.1045  immed[gprA_4, 0xfffff000], gpr_wrboth
20b0:	.1046  immed[gprA_5, 0x0], gpr_wrboth
20b8:	.1047  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
20c0:	.1048  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
20c8:	.1049  dbl_shf[gprA_2, gprA_3, gprB_2, >>12], gpr_wrboth
20d0:	.1050  alu_shf[gprA_3, --, B, gprB_3, >>12], gpr_wrboth
20d8:	.1051  alu[*l$index0[3], --, B, gprB_2]
20e0:	.1052  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
20e8:	.1053  alu[*l$index0[3], --, B, gprB_2]
20f0:	.1054  immed[gprA_3, 0x0], gpr_wrboth
20f8:	.1055  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2100:	.1056  immed[gprB_21, 0x8ef]
2108:	.1057  immed_w1[gprB_21, 0x51d6]
2110:	.1058  mul_step[gprA_2, gprB_21], start
2118:	.1059  mul_step[gprA_2, gprB_21], 32x32_step1
2120:	.1060  mul_step[gprA_2, gprB_21], 32x32_step2
2128:	.1061  mul_step[gprA_2, gprB_21], 32x32_step3
2130:	.1062  mul_step[gprA_2, gprB_21], 32x32_step4
2138:	.1063  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2140:	.1064  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2148:	.1065  immed[gprA_4, 0xffff, <<16], gpr_wrboth
2150:	.1066  immed[gprA_5, 0x0], gpr_wrboth
2158:	.1067  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2160:	.1068  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2168:	.1069  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
2170:	.1070  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
2178:	.1071  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
2180:	.1072  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
2188:	.1073  immed[gprB_21, 0xffff007f, <<16]
2190:	.1074  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
2198:	.1075  immed[gprA_3, 0x0], gpr_wrboth
21a0:	.1076  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
21a8:	.1077  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
21b0:	.1078  alu[*l$index0[2], --, B, gprB_6]
21b8:	.1079  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
21c0:	.1080  immed[gprA_5, 0x0], gpr_wrboth
21c8:	.1081  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
21d0:	.1082  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
21d8:	.1083  immed[gprA_2, 0x0], gpr_wrboth
21e0:	.1084  alu[gprA_3, --, B, gprA_2], gpr_wrboth
21e8:	.1085  local_csr_wr[ActLMAddr0, gprB_4]
21f0:	.1086  alu[gprA_1, --, B, gprB_23], gpr_wrboth
21f8:	.1087  nop
2200:	.1088  immed[gprA_21, 0xffff1fff, <<16]
2208:	.1089  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2210:	.1090  local_csr_wr[ActLMAddr0, gprA_22]
2218:	.1091  nop
2220:	.1092  nop
2228:	.1093  nop
2230:	.1094  alu[--, gprA_0, OR, gprB_1]
2238:	.1095  beq[.1101]
2240:	.1096  immed[gprA_2, 0x1], gpr_wrboth
2248:	.1097  immed[gprA_3, 0x0], gpr_wrboth
2250:	.1098  immed[gprA_21, 0x890]
2258:	.1099  ld_field[gprA_21, 1100, gprB_2, <<16]
2260:	.1100  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
2268:	.1101  alu[*l$index0[3], --, B, gprB_14]
2270:	.1102  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2278:	.1103  alu[*l$index0[3], --, B, gprB_2]
2280:	.1104  immed[gprA_3, 0x0], gpr_wrboth
2288:	.1105  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2290:	.1106  immed[gprB_21, 0x224b]
2298:	.1107  immed_w1[gprB_21, 0x5dfa]
22a0:	.1108  mul_step[gprA_2, gprB_21], start
22a8:	.1109  mul_step[gprA_2, gprB_21], 32x32_step1
22b0:	.1110  mul_step[gprA_2, gprB_21], 32x32_step2
22b8:	.1111  mul_step[gprA_2, gprB_21], 32x32_step3
22c0:	.1112  mul_step[gprA_2, gprB_21], 32x32_step4
22c8:	.1113  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
22d0:	.1114  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
22d8:	.1115  immed[gprA_4, 0xffffc000], gpr_wrboth
22e0:	.1116  immed[gprA_5, 0x0], gpr_wrboth
22e8:	.1117  alu[gprA_2, gprA_2, AND, gprB_4], gpr_wrboth
22f0:	.1118  alu[gprA_3, gprA_3, AND, gprB_5], gpr_wrboth
22f8:	.1119  dbl_shf[gprA_2, gprA_3, gprB_2, >>14], gpr_wrboth
2300:	.1120  alu_shf[gprA_3, --, B, gprB_3, >>14], gpr_wrboth
2308:	.1121  alu[*l$index0[3], --, B, gprB_2]
2310:	.1122  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2318:	.1123  alu[*l$index0[3], --, B, gprB_2]
2320:	.1124  immed[gprA_3, 0x0], gpr_wrboth
2328:	.1125  alu[gprA_2, --, B, *l$index0[3]], gpr_wrboth
2330:	.1126  immed[gprB_21, 0x7e4b]
2338:	.1127  immed_w1[gprB_21, 0x4bee]
2340:	.1128  mul_step[gprA_2, gprB_21], start
2348:	.1129  mul_step[gprA_2, gprB_21], 32x32_step1
2350:	.1130  mul_step[gprA_2, gprB_21], 32x32_step2
2358:	.1131  mul_step[gprA_2, gprB_21], 32x32_step3
2360:	.1132  mul_step[gprA_2, gprB_21], 32x32_step4
2368:	.1133  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
2370:	.1134  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
2378:	.1135  immed[gprA_4, 0xfffe, <<16], gpr_wrboth
2380:	.1136  immed[gprA_5, 0x0], gpr_wrboth
2388:	.1137  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2390:	.1138  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2398:	.1139  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
23a0:	.1140  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
23a8:	.1141  dbl_shf[gprA_6, gprA_7, gprB_6, >>17], gpr_wrboth
23b0:	.1142  alu_shf[gprA_7, --, B, gprB_7, >>17], gpr_wrboth
23b8:	.1143  immed[gprB_21, 0xffff007f, <<16]
23c0:	.1144  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
23c8:	.1145  immed[gprA_3, 0x0], gpr_wrboth
23d0:	.1146  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
23d8:	.1147  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
23e0:	.1148  alu[*l$index0[2], --, B, gprB_6]
23e8:	.1149  alu[gprA_4, gprA_22, +, 0x10], gpr_wrboth
23f0:	.1150  immed[gprA_5, 0x0], gpr_wrboth
23f8:	.1151  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
2400:	.1152  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
2408:	.1153  immed[gprA_2, 0x0], gpr_wrboth
2410:	.1154  alu[gprA_3, --, B, gprA_2], gpr_wrboth
2418:	.1155  local_csr_wr[ActLMAddr0, gprB_4]
2420:	.1156  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2428:	.1157  nop
2430:	.1158  immed[gprA_21, 0xffff1fff, <<16]
2438:	.1159  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
2440:	.1160  local_csr_wr[ActLMAddr0, gprA_22]
2448:	.1161  nop
2450:	.1162  nop
2458:	.1163  nop
2460:	.1164  alu[--, gprA_0, OR, gprB_1]
2468:	.1165  beq[.1171]
2470:	.1166  immed[gprA_2, 0x1], gpr_wrboth
2478:	.1167  immed[gprA_3, 0x0], gpr_wrboth
2480:	.1168  immed[gprA_21, 0x890]
2488:	.1169  ld_field[gprA_21, 1100, gprB_2, <<16]
2490:	.1170  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
2498:	.1171  immed[gprA_0, 0x1], gpr_wrboth
24a0:	.1172  immed[gprA_1, 0x0], gpr_wrboth
24a8:	.1173  br[.15000]
24b0:	.1174  br[.15000], defer[2]
24b8:	.1175  alu[gprA_0, --, B, 0x0]
24c0:	.1176  ld_field[gprA_0, 1100, 0x82, <<16]
24c8:	.1177  alu[--, 0x3, -, gprB_0]
24d0:	.1178  bcc[.1174]
24d8:	.1179  immed[gprB_2, 0x2282]
24e0:	.1180  immed_w1[gprB_2, 0x4411]
24e8:	.1181  alu_shf[gprA_1, --, B, gprB_0, <<3]
24f0:	.1182  alu[--, gprA_1, OR, 0x0]
24f8:	.1183  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
2500:	.1184  br[.15000], defer[2]
2508:	.1185  alu[gprA_0, --, B, 0x0]
2510:	.1186  ld_field[gprA_0, 1100, gprB_2, <<16]
2518:	.1187  nop
2520:	.1188  nop
2528:	.1189  nop
2530:	.1190  nop
2538:	.1191  nop
2540:	.1192  nop
2548:	.1193  nop
2550:	.1194  nop
