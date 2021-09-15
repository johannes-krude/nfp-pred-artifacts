   0:	  .0  immed[gprB_22, 0x3fff]
   8:	  .1  alu[gprB_22, gprB_22, AND, *l$index1]
  10:	  .2  immed[gprA_0, 0x2], gpr_wrboth
  18:	  .3  immed[gprA_1, 0x0], gpr_wrboth
  20:	  .4  alu[gprA_4, gprB_22, +, *l$index1[2]], gpr_wrboth
  28:	  .5  immed[gprA_5, 0x0], gpr_wrboth
  30:	  .6  alu[gprA_6, --, B, *l$index1[2]], gpr_wrboth
  38:	  .7  immed[gprA_7, 0x0], gpr_wrboth
  40:	  .8  alu[gprA_2, --, B, gprB_6], gpr_wrboth
  48:	  .9  alu[gprA_3, --, B, gprB_7], gpr_wrboth
  50:	 .10  alu[gprA_2, gprA_2, +, 0x2a], gpr_wrboth
  58:	 .11  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
  60:	 .12  alu[--, gprA_4, -, gprB_2]
  68:	 .13  alu[--, gprA_5, -carry, gprB_3]
  70:	 .14  bcc[.384]
  78:	 .15  mem[read32_swap, $xfer_0, gprA_6, 0xc, 1], ctx_swap[sig1]
  80:	 .16  ld_field_w_clr[gprA_4, 0001, $xfer_0], gpr_wrboth
  88:	 .17  immed[gprA_5, 0x0], gpr_wrboth
  90:	 .18  ld_field_w_clr[gprA_8, 0001, $xfer_0, >>8], gpr_wrboth
  98:	 .19  immed[gprA_9, 0x0], gpr_wrboth
  a0:	 .20  alu[gprA_2, --, B, gprB_8], gpr_wrboth
  a8:	 .21  alu[gprA_3, --, B, gprB_9], gpr_wrboth
  b0:	 .22  dbl_shf[gprA_2, gprA_3, gprB_2, >>7], gpr_wrboth
  b8:	 .23  alu_shf[gprA_3, --, B, gprB_3, >>7], gpr_wrboth
  c0:	 .24  alu[*l$index0[1], --, B, gprB_2]
  c8:	 .25  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
  d0:	 .26  alu[*l$index0[1], --, B, gprB_2]
  d8:	 .27  immed[gprA_11, 0x0], gpr_wrboth
  e0:	 .28  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
  e8:	 .29  immed[gprB_21, 0x3c6d]
  f0:	 .30  immed_w1[gprB_21, 0x2c1b]
  f8:	 .31  mul_step[gprA_10, gprB_21], start
 100:	 .32  mul_step[gprA_10, gprB_21], 32x32_step1
 108:	 .33  mul_step[gprA_10, gprB_21], 32x32_step2
 110:	 .34  mul_step[gprA_10, gprB_21], 32x32_step3
 118:	 .35  mul_step[gprA_10, gprB_21], 32x32_step4
 120:	 .36  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 128:	 .37  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 130:	 .38  immed[gprA_2, 0xfffff000], gpr_wrboth
 138:	 .39  immed[gprA_3, 0x0], gpr_wrboth
 140:	 .40  alu[gprA_10, gprA_10, AND, gprB_2], gpr_wrboth
 148:	 .41  alu[gprA_11, gprA_11, AND, gprB_3], gpr_wrboth
 150:	 .42  dbl_shf[gprA_9, gprA_9, gprB_8, >>24], gpr_wrboth
 158:	 .43  alu_shf[gprA_8, --, B, gprB_8, <<8], gpr_wrboth
 160:	 .44  alu[gprA_8, gprA_8, OR, gprB_4], gpr_wrboth
 168:	 .45  alu[gprA_9, gprA_9, OR, gprB_5], gpr_wrboth
 170:	 .46  dbl_shf[gprA_10, gprA_11, gprB_10, >>12], gpr_wrboth
 178:	 .47  alu_shf[gprA_11, --, B, gprB_11, >>12], gpr_wrboth
 180:	 .48  alu[*l$index0[1], --, B, gprB_10]
 188:	 .49  alu[gprA_4, --, B, *l$index0[1]], gpr_wrboth
 190:	 .50  alu[*l$index0[1], --, B, gprB_4]
 198:	 .51  immed[gprA_1, 0x0], gpr_wrboth
 1a0:	 .52  alu[gprA_0, --, B, *l$index0[1]], gpr_wrboth
 1a8:	 .53  immed[gprB_21, 0x2d39]
 1b0:	 .54  immed_w1[gprB_21, 0x297a]
 1b8:	 .55  mul_step[gprA_0, gprB_21], start
 1c0:	 .56  mul_step[gprA_0, gprB_21], 32x32_step1
 1c8:	 .57  mul_step[gprA_0, gprB_21], 32x32_step2
 1d0:	 .58  mul_step[gprA_0, gprB_21], 32x32_step3
 1d8:	 .59  mul_step[gprA_0, gprB_21], 32x32_step4
 1e0:	 .60  mul_step[gprA_0, --], 32x32_last, gpr_wrboth
 1e8:	 .61  mul_step[gprA_1, --], 32x32_last2, gpr_wrboth
 1f0:	 .62  immed[gprA_4, 0xffff8000], gpr_wrboth
 1f8:	 .63  immed[gprA_5, 0x0], gpr_wrboth
 200:	 .64  alu[gprA_10, --, B, gprB_0], gpr_wrboth
 208:	 .65  alu[gprA_11, --, B, gprB_1], gpr_wrboth
 210:	 .66  alu[gprA_10, gprA_10, AND, gprB_4], gpr_wrboth
 218:	 .67  alu[gprA_11, gprA_11, AND, gprB_5], gpr_wrboth
 220:	 .68  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 228:	 .69  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 230:	 .70  alu[gprA_10, gprA_10, XOR, gprB_0], gpr_wrboth
 238:	 .71  alu[gprA_11, gprA_11, XOR, gprB_1], gpr_wrboth
 240:	 .72  alu[--, gprA_8, XOR, 0x8]
 248:	 .73  bne[.318]
 250:	 .74  alu[--, gprA_9, XOR, 0x0]
 258:	 .75  bne[.318]
 260:	 .76  mem[read32_swap, $xfer_0, gprA_6, 0x1a, 1], ctx_swap[sig1]
 268:	 .77  alu[gprA_8, --, B, $xfer_0], gpr_wrboth
 270:	 .78  immed[gprA_9, 0x0], gpr_wrboth
 278:	 .79  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
 280:	 .80  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
 288:	 .81  alu[*l$index0[1], --, B, gprB_8]
 290:	 .82  alu[gprA_8, --, B, *l$index0[1]], gpr_wrboth
 298:	 .83  alu[*l$index0[1], --, B, gprB_8]
 2a0:	 .84  immed[gprA_9, 0x0], gpr_wrboth
 2a8:	 .85  alu[gprA_8, --, B, *l$index0[1]], gpr_wrboth
 2b0:	 .86  immed[gprB_21, 0x3c6d]
 2b8:	 .87  immed_w1[gprB_21, 0x2c1b]
 2c0:	 .88  mul_step[gprA_8, gprB_21], start
 2c8:	 .89  mul_step[gprA_8, gprB_21], 32x32_step1
 2d0:	 .90  mul_step[gprA_8, gprB_21], 32x32_step2
 2d8:	 .91  mul_step[gprA_8, gprB_21], 32x32_step3
 2e0:	 .92  mul_step[gprA_8, gprB_21], 32x32_step4
 2e8:	 .93  mul_step[gprA_8, --], 32x32_last, gpr_wrboth
 2f0:	 .94  mul_step[gprA_9, --], 32x32_last2, gpr_wrboth
 2f8:	 .95  alu[gprA_8, gprA_8, AND, gprB_2], gpr_wrboth
 300:	 .96  alu[gprA_9, gprA_9, AND, gprB_3], gpr_wrboth
 308:	 .97  dbl_shf[gprA_8, gprA_9, gprB_8, >>12], gpr_wrboth
 310:	 .98  alu_shf[gprA_9, --, B, gprB_9, >>12], gpr_wrboth
 318:	 .99  alu[*l$index0[1], --, B, gprB_8]
 320:	.100  alu[gprA_8, --, B, *l$index0[1]], gpr_wrboth
 328:	.101  alu[*l$index0[1], --, B, gprB_8]
 330:	.102  immed[gprA_1, 0x0], gpr_wrboth
 338:	.103  alu[gprA_0, --, B, *l$index0[1]], gpr_wrboth
 340:	.104  mem[read32_swap, $xfer_0, gprA_6, 0x1e, 1], ctx_swap[sig1]
 348:	.105  alu[gprA_8, --, B, $xfer_0], gpr_wrboth
 350:	.106  immed[gprA_9, 0x0], gpr_wrboth
 358:	.107  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
 360:	.108  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
 368:	.109  alu[*l$index0[1], --, B, gprB_8]
 370:	.110  alu[gprA_8, --, B, *l$index0[1]], gpr_wrboth
 378:	.111  alu[*l$index0[1], --, B, gprB_8]
 380:	.112  immed[gprB_21, 0x2d39]
 388:	.113  immed_w1[gprB_21, 0x297a]
 390:	.114  mul_step[gprA_0, gprB_21], start
 398:	.115  mul_step[gprA_0, gprB_21], 32x32_step1
 3a0:	.116  mul_step[gprA_0, gprB_21], 32x32_step2
 3a8:	.117  mul_step[gprA_0, gprB_21], 32x32_step3
 3b0:	.118  mul_step[gprA_0, gprB_21], 32x32_step4
 3b8:	.119  mul_step[gprA_0, --], 32x32_last, gpr_wrboth
 3c0:	.120  mul_step[gprA_1, --], 32x32_last2, gpr_wrboth
 3c8:	.121  alu[gprA_8, --, B, gprB_0], gpr_wrboth
 3d0:	.122  alu[gprA_9, --, B, gprB_1], gpr_wrboth
 3d8:	.123  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 3e0:	.124  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 3e8:	.125  alu[gprA_0, gprA_0, AND, gprB_4], gpr_wrboth
 3f0:	.126  alu[gprA_1, gprA_1, AND, gprB_5], gpr_wrboth
 3f8:	.127  dbl_shf[gprA_0, gprA_1, gprB_0, >>15], gpr_wrboth
 400:	.128  alu_shf[gprA_1, --, B, gprB_1, >>15], gpr_wrboth
 408:	.129  alu[gprA_8, gprA_8, XOR, gprB_0], gpr_wrboth
 410:	.130  alu[gprA_9, gprA_9, XOR, gprB_1], gpr_wrboth
 418:	.131  immed[gprA_11, 0x0], gpr_wrboth
 420:	.132  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 428:	.133  immed[gprB_21, 0x3c6d]
 430:	.134  immed_w1[gprB_21, 0x2c1b]
 438:	.135  mul_step[gprA_10, gprB_21], start
 440:	.136  mul_step[gprA_10, gprB_21], 32x32_step1
 448:	.137  mul_step[gprA_10, gprB_21], 32x32_step2
 450:	.138  mul_step[gprA_10, gprB_21], 32x32_step3
 458:	.139  mul_step[gprA_10, gprB_21], 32x32_step4
 460:	.140  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 468:	.141  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 470:	.142  alu[gprA_10, gprA_10, AND, gprB_2], gpr_wrboth
 478:	.143  alu[gprA_11, gprA_11, AND, gprB_3], gpr_wrboth
 480:	.144  dbl_shf[gprA_10, gprA_11, gprB_10, >>12], gpr_wrboth
 488:	.145  alu_shf[gprA_11, --, B, gprB_11, >>12], gpr_wrboth
 490:	.146  alu[*l$index0[1], --, B, gprB_10]
 498:	.147  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 4a0:	.148  alu[*l$index0[1], --, B, gprB_10]
 4a8:	.149  immed[gprA_11, 0x0], gpr_wrboth
 4b0:	.150  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 4b8:	.151  immed[gprA_0, 0x0], gpr_wrboth
 4c0:	.152  immed[gprA_1, 0x0], gpr_wrboth
 4c8:	.153  alu[*l$index0[1], --, B, gprB_0]
 4d0:	.154  alu[gprA_0, --, B, *l$index0[1]], gpr_wrboth
 4d8:	.155  alu[*l$index0[1], --, B, gprB_0]
 4e0:	.156  immed[gprA_1, 0x0], gpr_wrboth
 4e8:	.157  alu[gprA_0, --, B, *l$index0[1]], gpr_wrboth
 4f0:	.158  immed[gprB_21, 0x3c6d]
 4f8:	.159  immed_w1[gprB_21, 0x2c1b]
 500:	.160  mul_step[gprA_0, gprB_21], start
 508:	.161  mul_step[gprA_0, gprB_21], 32x32_step1
 510:	.162  mul_step[gprA_0, gprB_21], 32x32_step2
 518:	.163  mul_step[gprA_0, gprB_21], 32x32_step3
 520:	.164  mul_step[gprA_0, gprB_21], 32x32_step4
 528:	.165  mul_step[gprA_0, --], 32x32_last, gpr_wrboth
 530:	.166  mul_step[gprA_1, --], 32x32_last2, gpr_wrboth
 538:	.167  alu[gprA_0, gprA_0, AND, gprB_2], gpr_wrboth
 540:	.168  alu[gprA_1, gprA_1, AND, gprB_3], gpr_wrboth
 548:	.169  dbl_shf[gprA_0, gprA_1, gprB_0, >>12], gpr_wrboth
 550:	.170  alu_shf[gprA_1, --, B, gprB_1, >>12], gpr_wrboth
 558:	.171  alu[*l$index0[1], --, B, gprB_0]
 560:	.172  immed[gprB_21, 0x2d39]
 568:	.173  immed_w1[gprB_21, 0x297a]
 570:	.174  mul_step[gprA_10, gprB_21], start
 578:	.175  mul_step[gprA_10, gprB_21], 32x32_step1
 580:	.176  mul_step[gprA_10, gprB_21], 32x32_step2
 588:	.177  mul_step[gprA_10, gprB_21], 32x32_step3
 590:	.178  mul_step[gprA_10, gprB_21], 32x32_step4
 598:	.179  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 5a0:	.180  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 5a8:	.181  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 5b0:	.182  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 5b8:	.183  alu[gprA_10, gprA_10, AND, gprB_4], gpr_wrboth
 5c0:	.184  alu[gprA_11, gprA_11, AND, gprB_5], gpr_wrboth
 5c8:	.185  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 5d0:	.186  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 5d8:	.187  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 5e0:	.188  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 5e8:	.189  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 5f0:	.190  alu[*l$index0[1], --, B, gprB_10]
 5f8:	.191  immed[gprA_11, 0x0], gpr_wrboth
 600:	.192  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 608:	.193  immed[gprB_21, 0x2d39]
 610:	.194  immed_w1[gprB_21, 0x297a]
 618:	.195  mul_step[gprA_10, gprB_21], start
 620:	.196  mul_step[gprA_10, gprB_21], 32x32_step1
 628:	.197  mul_step[gprA_10, gprB_21], 32x32_step2
 630:	.198  mul_step[gprA_10, gprB_21], 32x32_step3
 638:	.199  mul_step[gprA_10, gprB_21], 32x32_step4
 640:	.200  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 648:	.201  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 650:	.202  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 658:	.203  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 660:	.204  alu[gprA_10, gprA_10, AND, gprB_4], gpr_wrboth
 668:	.205  alu[gprA_11, gprA_11, AND, gprB_5], gpr_wrboth
 670:	.206  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 678:	.207  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 680:	.208  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 688:	.209  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
 690:	.210  mem[read32_swap, $xfer_0, gprA_6, 0x17, 1], ctx_swap[sig1]
 698:	.211  ld_field_w_clr[gprA_0, 0001, $xfer_0], gpr_wrboth
 6a0:	.212  immed[gprA_1, 0x0], gpr_wrboth
 6a8:	.213  alu[gprA_21, gprA_0, XOR, 0x6]
 6b0:	.214  alu[--, gprA_21, OR, gprB_1]
 6b8:	.215  beq[.222]
 6c0:	.216  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 6c8:	.217  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 6d0:	.218  alu[--, gprA_0, XOR, 0x11]
 6d8:	.219  bne[.318]
 6e0:	.220  alu[--, gprA_1, XOR, 0x0]
 6e8:	.221  bne[.318]
 6f0:	.222  mem[read32_swap, $xfer_0, gprA_6, 0x22, 1], ctx_swap[sig1]
 6f8:	.223  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
 700:	.224  immed[gprA_11, 0x0], gpr_wrboth
 708:	.225  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 710:	.226  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 718:	.227  alu[*l$index0[1], --, B, gprB_10]
 720:	.228  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 728:	.229  alu[*l$index0[1], --, B, gprB_10]
 730:	.230  immed[gprA_11, 0x0], gpr_wrboth
 738:	.231  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 740:	.232  immed[gprB_21, 0x3c6d]
 748:	.233  immed_w1[gprB_21, 0x2c1b]
 750:	.234  mul_step[gprA_10, gprB_21], start
 758:	.235  mul_step[gprA_10, gprB_21], 32x32_step1
 760:	.236  mul_step[gprA_10, gprB_21], 32x32_step2
 768:	.237  mul_step[gprA_10, gprB_21], 32x32_step3
 770:	.238  mul_step[gprA_10, gprB_21], 32x32_step4
 778:	.239  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 780:	.240  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 788:	.241  immed[gprA_0, 0xfffff000], gpr_wrboth
 790:	.242  immed[gprA_1, 0x0], gpr_wrboth
 798:	.243  alu[gprA_10, gprA_10, AND, gprB_0], gpr_wrboth
 7a0:	.244  alu[gprA_11, gprA_11, AND, gprB_1], gpr_wrboth
 7a8:	.245  dbl_shf[gprA_10, gprA_11, gprB_10, >>12], gpr_wrboth
 7b0:	.246  alu_shf[gprA_11, --, B, gprB_11, >>12], gpr_wrboth
 7b8:	.247  alu[*l$index0[1], --, B, gprB_10]
 7c0:	.248  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 7c8:	.249  alu[*l$index0[1], --, B, gprB_10]
 7d0:	.250  immed[gprA_13, 0x0], gpr_wrboth
 7d8:	.251  alu[gprA_12, --, B, *l$index0[1]], gpr_wrboth
 7e0:	.252  mem[read32_swap, $xfer_0, gprA_6, 0x24, 1], ctx_swap[sig1]
 7e8:	.253  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
 7f0:	.254  immed[gprA_7, 0x0], gpr_wrboth
 7f8:	.255  dbl_shf[gprA_6, gprA_7, gprB_6, >>15], gpr_wrboth
 800:	.256  alu_shf[gprA_7, --, B, gprB_7, >>15], gpr_wrboth
 808:	.257  alu[*l$index0[1], --, B, gprB_6]
 810:	.258  alu[gprA_6, --, B, *l$index0[1]], gpr_wrboth
 818:	.259  alu[*l$index0[1], --, B, gprB_6]
 820:	.260  immed[gprB_21, 0x2d39]
 828:	.261  immed_w1[gprB_21, 0x297a]
 830:	.262  mul_step[gprA_12, gprB_21], start
 838:	.263  mul_step[gprA_12, gprB_21], 32x32_step1
 840:	.264  mul_step[gprA_12, gprB_21], 32x32_step2
 848:	.265  mul_step[gprA_12, gprB_21], 32x32_step3
 850:	.266  mul_step[gprA_12, gprB_21], 32x32_step4
 858:	.267  mul_step[gprA_12, --], 32x32_last, gpr_wrboth
 860:	.268  mul_step[gprA_13, --], 32x32_last2, gpr_wrboth
 868:	.269  alu[gprA_10, --, B, gprB_12], gpr_wrboth
 870:	.270  alu[gprA_11, --, B, gprB_13], gpr_wrboth
 878:	.271  alu[gprA_10, gprA_10, XOR, gprB_8], gpr_wrboth
 880:	.272  alu[gprA_11, gprA_11, XOR, gprB_9], gpr_wrboth
 888:	.273  immed[gprA_6, 0xffff8000], gpr_wrboth
 890:	.274  immed[gprA_7, 0x0], gpr_wrboth
 898:	.275  alu[gprA_12, gprA_12, AND, gprB_6], gpr_wrboth
 8a0:	.276  alu[gprA_13, gprA_13, AND, gprB_7], gpr_wrboth
 8a8:	.277  dbl_shf[gprA_12, gprA_13, gprB_12, >>15], gpr_wrboth
 8b0:	.278  alu_shf[gprA_13, --, B, gprB_13, >>15], gpr_wrboth
 8b8:	.279  alu[gprA_10, gprA_10, XOR, gprB_12], gpr_wrboth
 8c0:	.280  alu[gprA_11, gprA_11, XOR, gprB_13], gpr_wrboth
 8c8:	.281  immed[gprA_9, 0x0], gpr_wrboth
 8d0:	.282  alu[gprA_8, --, B, *l$index0[1]], gpr_wrboth
 8d8:	.283  immed[gprB_21, 0x3c6d]
 8e0:	.284  immed_w1[gprB_21, 0x2c1b]
 8e8:	.285  mul_step[gprA_8, gprB_21], start
 8f0:	.286  mul_step[gprA_8, gprB_21], 32x32_step1
 8f8:	.287  mul_step[gprA_8, gprB_21], 32x32_step2
 900:	.288  mul_step[gprA_8, gprB_21], 32x32_step3
 908:	.289  mul_step[gprA_8, gprB_21], 32x32_step4
 910:	.290  mul_step[gprA_8, --], 32x32_last, gpr_wrboth
 918:	.291  mul_step[gprA_9, --], 32x32_last2, gpr_wrboth
 920:	.292  alu[gprA_8, gprA_8, AND, gprB_0], gpr_wrboth
 928:	.293  alu[gprA_9, gprA_9, AND, gprB_1], gpr_wrboth
 930:	.294  dbl_shf[gprA_8, gprA_9, gprB_8, >>12], gpr_wrboth
 938:	.295  alu_shf[gprA_9, --, B, gprB_9, >>12], gpr_wrboth
 940:	.296  alu[*l$index0[1], --, B, gprB_8]
 948:	.297  alu[gprA_8, --, B, *l$index0[1]], gpr_wrboth
 950:	.298  alu[*l$index0[1], --, B, gprB_8]
 958:	.299  immed[gprA_9, 0x0], gpr_wrboth
 960:	.300  alu[gprA_8, --, B, *l$index0[1]], gpr_wrboth
 968:	.301  immed[gprB_21, 0x2d39]
 970:	.302  immed_w1[gprB_21, 0x297a]
 978:	.303  mul_step[gprA_8, gprB_21], start
 980:	.304  mul_step[gprA_8, gprB_21], 32x32_step1
 988:	.305  mul_step[gprA_8, gprB_21], 32x32_step2
 990:	.306  mul_step[gprA_8, gprB_21], 32x32_step3
 998:	.307  mul_step[gprA_8, gprB_21], 32x32_step4
 9a0:	.308  mul_step[gprA_8, --], 32x32_last, gpr_wrboth
 9a8:	.309  mul_step[gprA_9, --], 32x32_last2, gpr_wrboth
 9b0:	.310  alu[gprA_10, gprA_10, XOR, gprB_8], gpr_wrboth
 9b8:	.311  alu[gprA_11, gprA_11, XOR, gprB_9], gpr_wrboth
 9c0:	.312  alu[gprA_8, gprA_8, AND, gprB_6], gpr_wrboth
 9c8:	.313  alu[gprA_9, gprA_9, AND, gprB_7], gpr_wrboth
 9d0:	.314  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
 9d8:	.315  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
 9e0:	.316  alu[gprA_10, gprA_10, XOR, gprB_8], gpr_wrboth
 9e8:	.317  alu[gprA_11, gprA_11, XOR, gprB_9], gpr_wrboth
 9f0:	.318  alu[gprA_10, gprA_10, AND, gprB_4], gpr_wrboth
 9f8:	.319  alu[gprA_11, gprA_11, AND, gprB_5], gpr_wrboth
 a00:	.320  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 a08:	.321  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 a10:	.322  alu[*l$index0[1], --, B, gprB_10]
 a18:	.323  alu[gprA_6, --, B, *l$index0[1]], gpr_wrboth
 a20:	.324  alu[*l$index0[1], --, B, gprB_6]
 a28:	.325  immed[gprA_7, 0x0], gpr_wrboth
 a30:	.326  alu[gprA_6, --, B, *l$index0[1]], gpr_wrboth
 a38:	.327  immed[gprB_21, 0x3c6d]
 a40:	.328  immed_w1[gprB_21, 0x2c1b]
 a48:	.329  mul_step[gprA_6, gprB_21], start
 a50:	.330  mul_step[gprA_6, gprB_21], 32x32_step1
 a58:	.331  mul_step[gprA_6, gprB_21], 32x32_step2
 a60:	.332  mul_step[gprA_6, gprB_21], 32x32_step3
 a68:	.333  mul_step[gprA_6, gprB_21], 32x32_step4
 a70:	.334  mul_step[gprA_6, --], 32x32_last, gpr_wrboth
 a78:	.335  mul_step[gprA_7, --], 32x32_last2, gpr_wrboth
 a80:	.336  alu[gprA_6, gprA_6, AND, gprB_2], gpr_wrboth
 a88:	.337  alu[gprA_7, gprA_7, AND, gprB_3], gpr_wrboth
 a90:	.338  dbl_shf[gprA_6, gprA_7, gprB_6, >>12], gpr_wrboth
 a98:	.339  alu_shf[gprA_7, --, B, gprB_7, >>12], gpr_wrboth
 aa0:	.340  alu[*l$index0[1], --, B, gprB_6]
 aa8:	.341  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 ab0:	.342  alu[*l$index0[1], --, B, gprB_2]
 ab8:	.343  immed[gprA_3, 0x0], gpr_wrboth
 ac0:	.344  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 ac8:	.345  immed[gprB_21, 0x2d39]
 ad0:	.346  immed_w1[gprB_21, 0x297a]
 ad8:	.347  mul_step[gprA_2, gprB_21], start
 ae0:	.348  mul_step[gprA_2, gprB_21], 32x32_step1
 ae8:	.349  mul_step[gprA_2, gprB_21], 32x32_step2
 af0:	.350  mul_step[gprA_2, gprB_21], 32x32_step3
 af8:	.351  mul_step[gprA_2, gprB_21], 32x32_step4
 b00:	.352  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 b08:	.353  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 b10:	.354  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 b18:	.355  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 b20:	.356  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
 b28:	.357  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
 b30:	.358  dbl_shf[gprA_6, gprA_7, gprB_6, >>15], gpr_wrboth
 b38:	.359  alu_shf[gprA_7, --, B, gprB_7, >>15], gpr_wrboth
 b40:	.360  immed[gprB_21, 0xffff007f, <<16]
 b48:	.361  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 b50:	.362  immed[gprA_3, 0x0], gpr_wrboth
 b58:	.363  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
 b60:	.364  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
 b68:	.365  alu[*l$index0, --, B, gprB_6]
 b70:	.366  alu[gprA_4, gprA_22, +, 0x8], gpr_wrboth
 b78:	.367  immed[gprA_5, 0x0], gpr_wrboth
 b80:	.368  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
 b88:	.369  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
 b90:	.370  immed[gprA_2, 0x0], gpr_wrboth
 b98:	.371  alu[gprA_3, --, B, gprA_2], gpr_wrboth
 ba0:	.372  alu[gprA_1, --, B, gprB_23], gpr_wrboth
 ba8:	.373  immed[gprA_21, 0xffff01ff, <<16]
 bb0:	.374  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
 bb8:	.375  alu[--, gprA_0, OR, gprB_1]
 bc0:	.376  beq[.382]
 bc8:	.377  immed[gprA_2, 0x1], gpr_wrboth
 bd0:	.378  immed[gprA_3, 0x0], gpr_wrboth
 bd8:	.379  immed[gprA_21, 0x890]
 be0:	.380  ld_field[gprA_21, 1100, gprB_2, <<16]
 be8:	.381  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
 bf0:	.382  immed[gprA_0, 0x1], gpr_wrboth
 bf8:	.383  immed[gprA_1, 0x0], gpr_wrboth
 c00:	.384  br[.15000]
 c08:	.385  br[.15000], defer[2]
 c10:	.386  alu[gprA_0, --, B, 0x0]
 c18:	.387  ld_field[gprA_0, 1100, 0x82, <<16]
 c20:	.388  alu[--, 0x3, -, gprB_0]
 c28:	.389  bcc[.385]
 c30:	.390  immed[gprB_2, 0x2282]
 c38:	.391  immed_w1[gprB_2, 0x4411]
 c40:	.392  alu_shf[gprA_1, --, B, gprB_0, <<3]
 c48:	.393  alu[--, gprA_1, OR, 0x0]
 c50:	.394  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
 c58:	.395  br[.15000], defer[2]
 c60:	.396  alu[gprA_0, --, B, 0x0]
 c68:	.397  ld_field[gprA_0, 1100, gprB_2, <<16]
 c70:	.398  nop
 c78:	.399  nop
 c80:	.400  nop
 c88:	.401  nop
 c90:	.402  nop
 c98:	.403  nop
 ca0:	.404  nop
 ca8:	.405  nop
