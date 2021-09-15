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
  70:	 .14  bcc[.709]
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
 198:	 .51  immed[gprA_11, 0x0], gpr_wrboth
 1a0:	 .52  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 1a8:	 .53  immed[gprB_21, 0x2d39]
 1b0:	 .54  immed_w1[gprB_21, 0x297a]
 1b8:	 .55  mul_step[gprA_10, gprB_21], start
 1c0:	 .56  mul_step[gprA_10, gprB_21], 32x32_step1
 1c8:	 .57  mul_step[gprA_10, gprB_21], 32x32_step2
 1d0:	 .58  mul_step[gprA_10, gprB_21], 32x32_step3
 1d8:	 .59  mul_step[gprA_10, gprB_21], 32x32_step4
 1e0:	 .60  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 1e8:	 .61  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 1f0:	 .62  immed[gprA_4, 0xffff8000], gpr_wrboth
 1f8:	 .63  immed[gprA_5, 0x0], gpr_wrboth
 200:	 .64  alu[gprA_12, --, B, gprB_10], gpr_wrboth
 208:	 .65  alu[gprA_13, --, B, gprB_11], gpr_wrboth
 210:	 .66  alu[gprA_12, gprA_12, AND, gprB_4], gpr_wrboth
 218:	 .67  alu[gprA_13, gprA_13, AND, gprB_5], gpr_wrboth
 220:	 .68  dbl_shf[gprA_12, gprA_13, gprB_12, >>15], gpr_wrboth
 228:	 .69  alu_shf[gprA_13, --, B, gprB_13, >>15], gpr_wrboth
 230:	 .70  alu[gprA_12, gprA_12, XOR, gprB_10], gpr_wrboth
 238:	 .71  alu[gprA_13, gprA_13, XOR, gprB_11], gpr_wrboth
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
 330:	.102  immed[gprA_11, 0x0], gpr_wrboth
 338:	.103  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
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
 390:	.114  mul_step[gprA_10, gprB_21], start
 398:	.115  mul_step[gprA_10, gprB_21], 32x32_step1
 3a0:	.116  mul_step[gprA_10, gprB_21], 32x32_step2
 3a8:	.117  mul_step[gprA_10, gprB_21], 32x32_step3
 3b0:	.118  mul_step[gprA_10, gprB_21], 32x32_step4
 3b8:	.119  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
 3c0:	.120  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
 3c8:	.121  alu[gprA_8, --, B, gprB_10], gpr_wrboth
 3d0:	.122  alu[gprA_9, --, B, gprB_11], gpr_wrboth
 3d8:	.123  alu[gprA_8, gprA_8, XOR, gprB_12], gpr_wrboth
 3e0:	.124  alu[gprA_9, gprA_9, XOR, gprB_13], gpr_wrboth
 3e8:	.125  alu[gprA_10, gprA_10, AND, gprB_4], gpr_wrboth
 3f0:	.126  alu[gprA_11, gprA_11, AND, gprB_5], gpr_wrboth
 3f8:	.127  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 400:	.128  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 408:	.129  alu[gprA_8, gprA_8, XOR, gprB_10], gpr_wrboth
 410:	.130  alu[gprA_9, gprA_9, XOR, gprB_11], gpr_wrboth
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
 698:	.211  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
 6a0:	.212  immed[gprA_11, 0x0], gpr_wrboth
 6a8:	.213  alu[gprA_21, gprA_10, XOR, 0x6]
 6b0:	.214  alu[--, gprA_21, OR, gprB_11]
 6b8:	.215  beq[.222]
 6c0:	.216  alu[gprA_12, --, B, gprB_8], gpr_wrboth
 6c8:	.217  alu[gprA_13, --, B, gprB_9], gpr_wrboth
 6d0:	.218  alu[--, gprA_10, XOR, 0x11]
 6d8:	.219  bne[.318]
 6e0:	.220  alu[--, gprA_11, XOR, 0x0]
 6e8:	.221  bne[.318]
 6f0:	.222  mem[read32_swap, $xfer_0, gprA_6, 0x22, 1], ctx_swap[sig1]
 6f8:	.223  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
 700:	.224  immed[gprA_11, 0x0], gpr_wrboth
 708:	.225  dbl_shf[gprA_10, gprA_11, gprB_10, >>15], gpr_wrboth
 710:	.226  alu_shf[gprA_11, --, B, gprB_11, >>15], gpr_wrboth
 718:	.227  alu[*l$index0[1], --, B, gprB_10]
 720:	.228  alu[gprA_10, --, B, *l$index0[1]], gpr_wrboth
 728:	.229  alu[*l$index0[1], --, B, gprB_10]
 730:	.230  immed[gprA_1, 0x0], gpr_wrboth
 738:	.231  alu[gprA_0, --, B, *l$index0[1]], gpr_wrboth
 740:	.232  immed[gprB_21, 0x3c6d]
 748:	.233  immed_w1[gprB_21, 0x2c1b]
 750:	.234  mul_step[gprA_0, gprB_21], start
 758:	.235  mul_step[gprA_0, gprB_21], 32x32_step1
 760:	.236  mul_step[gprA_0, gprB_21], 32x32_step2
 768:	.237  mul_step[gprA_0, gprB_21], 32x32_step3
 770:	.238  mul_step[gprA_0, gprB_21], 32x32_step4
 778:	.239  mul_step[gprA_0, --], 32x32_last, gpr_wrboth
 780:	.240  mul_step[gprA_1, --], 32x32_last2, gpr_wrboth
 788:	.241  immed[gprA_10, 0xfffff000], gpr_wrboth
 790:	.242  immed[gprA_11, 0x0], gpr_wrboth
 798:	.243  alu[gprA_0, gprA_0, AND, gprB_10], gpr_wrboth
 7a0:	.244  alu[gprA_1, gprA_1, AND, gprB_11], gpr_wrboth
 7a8:	.245  dbl_shf[gprA_0, gprA_1, gprB_0, >>12], gpr_wrboth
 7b0:	.246  alu_shf[gprA_1, --, B, gprB_1, >>12], gpr_wrboth
 7b8:	.247  alu[*l$index0[1], --, B, gprB_0]
 7c0:	.248  alu[gprA_0, --, B, *l$index0[1]], gpr_wrboth
 7c8:	.249  alu[*l$index0[1], --, B, gprB_0]
 7d0:	.250  immed[gprA_1, 0x0], gpr_wrboth
 7d8:	.251  alu[gprA_0, --, B, *l$index0[1]], gpr_wrboth
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
 830:	.262  mul_step[gprA_0, gprB_21], start
 838:	.263  mul_step[gprA_0, gprB_21], 32x32_step1
 840:	.264  mul_step[gprA_0, gprB_21], 32x32_step2
 848:	.265  mul_step[gprA_0, gprB_21], 32x32_step3
 850:	.266  mul_step[gprA_0, gprB_21], 32x32_step4
 858:	.267  mul_step[gprA_0, --], 32x32_last, gpr_wrboth
 860:	.268  mul_step[gprA_1, --], 32x32_last2, gpr_wrboth
 868:	.269  alu[gprA_12, --, B, gprB_0], gpr_wrboth
 870:	.270  alu[gprA_13, --, B, gprB_1], gpr_wrboth
 878:	.271  alu[gprA_12, gprA_12, XOR, gprB_8], gpr_wrboth
 880:	.272  alu[gprA_13, gprA_13, XOR, gprB_9], gpr_wrboth
 888:	.273  immed[gprA_6, 0xffff8000], gpr_wrboth
 890:	.274  immed[gprA_7, 0x0], gpr_wrboth
 898:	.275  alu[gprA_0, gprA_0, AND, gprB_6], gpr_wrboth
 8a0:	.276  alu[gprA_1, gprA_1, AND, gprB_7], gpr_wrboth
 8a8:	.277  dbl_shf[gprA_0, gprA_1, gprB_0, >>15], gpr_wrboth
 8b0:	.278  alu_shf[gprA_1, --, B, gprB_1, >>15], gpr_wrboth
 8b8:	.279  alu[gprA_12, gprA_12, XOR, gprB_0], gpr_wrboth
 8c0:	.280  alu[gprA_13, gprA_13, XOR, gprB_1], gpr_wrboth
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
 920:	.292  alu[gprA_8, gprA_8, AND, gprB_10], gpr_wrboth
 928:	.293  alu[gprA_9, gprA_9, AND, gprB_11], gpr_wrboth
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
 9b0:	.310  alu[gprA_12, gprA_12, XOR, gprB_8], gpr_wrboth
 9b8:	.311  alu[gprA_13, gprA_13, XOR, gprB_9], gpr_wrboth
 9c0:	.312  alu[gprA_8, gprA_8, AND, gprB_6], gpr_wrboth
 9c8:	.313  alu[gprA_9, gprA_9, AND, gprB_7], gpr_wrboth
 9d0:	.314  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
 9d8:	.315  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
 9e0:	.316  alu[gprA_12, gprA_12, XOR, gprB_8], gpr_wrboth
 9e8:	.317  alu[gprA_13, gprA_13, XOR, gprB_9], gpr_wrboth
 9f0:	.318  alu[gprA_14, --, B, gprB_12], gpr_wrboth
 9f8:	.319  alu[gprA_15, --, B, gprB_13], gpr_wrboth
 a00:	.320  dbl_shf[gprA_14, gprA_15, gprB_14, >>15], gpr_wrboth
 a08:	.321  alu_shf[gprA_15, --, B, gprB_15, >>15], gpr_wrboth
 a10:	.322  immed[gprB_21, 0xffff0001, <<16]
 a18:	.323  alu[gprA_14, gprA_14, AND, gprB_21], gpr_wrboth
 a20:	.324  immed[gprA_15, 0x0], gpr_wrboth
 a28:	.325  alu[*l$index0[1], --, B, gprB_14]
 a30:	.326  alu[gprA_6, --, B, *l$index0[1]], gpr_wrboth
 a38:	.327  alu[*l$index0[1], --, B, gprB_6]
 a40:	.328  immed[gprA_7, 0x0], gpr_wrboth
 a48:	.329  alu[gprA_6, --, B, *l$index0[1]], gpr_wrboth
 a50:	.330  immed[gprB_21, 0x3c6d]
 a58:	.331  immed_w1[gprB_21, 0x2c1b]
 a60:	.332  mul_step[gprA_6, gprB_21], start
 a68:	.333  mul_step[gprA_6, gprB_21], 32x32_step1
 a70:	.334  mul_step[gprA_6, gprB_21], 32x32_step2
 a78:	.335  mul_step[gprA_6, gprB_21], 32x32_step3
 a80:	.336  mul_step[gprA_6, gprB_21], 32x32_step4
 a88:	.337  mul_step[gprA_6, --], 32x32_last, gpr_wrboth
 a90:	.338  mul_step[gprA_7, --], 32x32_last2, gpr_wrboth
 a98:	.339  alu[gprA_6, gprA_6, AND, gprB_2], gpr_wrboth
 aa0:	.340  alu[gprA_7, gprA_7, AND, gprB_3], gpr_wrboth
 aa8:	.341  dbl_shf[gprA_6, gprA_7, gprB_6, >>12], gpr_wrboth
 ab0:	.342  alu_shf[gprA_7, --, B, gprB_7, >>12], gpr_wrboth
 ab8:	.343  alu[*l$index0[1], --, B, gprB_6]
 ac0:	.344  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 ac8:	.345  alu[*l$index0[1], --, B, gprB_2]
 ad0:	.346  immed[gprA_3, 0x0], gpr_wrboth
 ad8:	.347  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 ae0:	.348  immed[gprB_21, 0x2d39]
 ae8:	.349  immed_w1[gprB_21, 0x297a]
 af0:	.350  mul_step[gprA_2, gprB_21], start
 af8:	.351  mul_step[gprA_2, gprB_21], 32x32_step1
 b00:	.352  mul_step[gprA_2, gprB_21], 32x32_step2
 b08:	.353  mul_step[gprA_2, gprB_21], 32x32_step3
 b10:	.354  mul_step[gprA_2, gprB_21], 32x32_step4
 b18:	.355  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 b20:	.356  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 b28:	.357  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 b30:	.358  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 b38:	.359  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
 b40:	.360  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
 b48:	.361  dbl_shf[gprA_6, gprA_7, gprB_6, >>15], gpr_wrboth
 b50:	.362  alu_shf[gprA_7, --, B, gprB_7, >>15], gpr_wrboth
 b58:	.363  immed[gprB_21, 0xffff007f, <<16]
 b60:	.364  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 b68:	.365  immed[gprA_3, 0x0], gpr_wrboth
 b70:	.366  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
 b78:	.367  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
 b80:	.368  alu[*l$index0, --, B, gprB_6]
 b88:	.369  alu[gprA_4, gprA_22, +, 0x8], gpr_wrboth
 b90:	.370  immed[gprA_5, 0x0], gpr_wrboth
 b98:	.371  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
 ba0:	.372  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
 ba8:	.373  immed[gprA_2, 0x0], gpr_wrboth
 bb0:	.374  alu[gprA_3, --, B, gprA_2], gpr_wrboth
 bb8:	.375  alu[gprA_1, --, B, gprB_23], gpr_wrboth
 bc0:	.376  immed[gprA_21, 0xffff0fff, <<16]
 bc8:	.377  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
 bd0:	.378  alu[--, gprA_0, OR, gprB_1]
 bd8:	.379  beq[.385]
 be0:	.380  immed[gprA_2, 0x1], gpr_wrboth
 be8:	.381  immed[gprA_3, 0x0], gpr_wrboth
 bf0:	.382  immed[gprA_21, 0x890]
 bf8:	.383  ld_field[gprA_21, 1100, gprB_2, <<16]
 c00:	.384  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
 c08:	.385  alu[gprA_16, --, B, gprB_12], gpr_wrboth
 c10:	.386  alu[gprA_17, --, B, gprB_13], gpr_wrboth
 c18:	.387  dbl_shf[gprA_16, gprA_17, gprB_16, >>16], gpr_wrboth
 c20:	.388  alu_shf[gprA_17, --, B, gprB_17, >>16], gpr_wrboth
 c28:	.389  immed[gprB_21, 0xffff]
 c30:	.390  alu[gprA_16, gprA_16, AND, gprB_21], gpr_wrboth
 c38:	.391  immed[gprA_17, 0x0], gpr_wrboth
 c40:	.392  alu[*l$index0[1], --, B, gprB_16]
 c48:	.393  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 c50:	.394  alu[*l$index0[1], --, B, gprB_2]
 c58:	.395  immed[gprA_3, 0x0], gpr_wrboth
 c60:	.396  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 c68:	.397  immed[gprB_21, 0x9f3b]
 c70:	.398  immed_w1[gprB_21, 0x45d]
 c78:	.399  mul_step[gprA_2, gprB_21], start
 c80:	.400  mul_step[gprA_2, gprB_21], 32x32_step1
 c88:	.401  mul_step[gprA_2, gprB_21], 32x32_step2
 c90:	.402  mul_step[gprA_2, gprB_21], 32x32_step3
 c98:	.403  mul_step[gprA_2, gprB_21], 32x32_step4
 ca0:	.404  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 ca8:	.405  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 cb0:	.406  immed[gprA_18, 0xffff, <<16], gpr_wrboth
 cb8:	.407  immed[gprA_19, 0x0], gpr_wrboth
 cc0:	.408  alu[gprA_2, gprA_2, AND, gprB_18], gpr_wrboth
 cc8:	.409  alu[gprA_3, gprA_3, AND, gprB_19], gpr_wrboth
 cd0:	.410  dbl_shf[gprA_2, gprA_3, gprB_2, >>16], gpr_wrboth
 cd8:	.411  alu_shf[gprA_3, --, B, gprB_3, >>16], gpr_wrboth
 ce0:	.412  alu[*l$index0[1], --, B, gprB_2]
 ce8:	.413  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 cf0:	.414  alu[*l$index0[1], --, B, gprB_2]
 cf8:	.415  immed[gprA_3, 0x0], gpr_wrboth
 d00:	.416  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 d08:	.417  immed[gprB_21, 0x9f3b]
 d10:	.418  immed_w1[gprB_21, 0x45d]
 d18:	.419  mul_step[gprA_2, gprB_21], start
 d20:	.420  mul_step[gprA_2, gprB_21], 32x32_step1
 d28:	.421  mul_step[gprA_2, gprB_21], 32x32_step2
 d30:	.422  mul_step[gprA_2, gprB_21], 32x32_step3
 d38:	.423  mul_step[gprA_2, gprB_21], 32x32_step4
 d40:	.424  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 d48:	.425  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 d50:	.426  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 d58:	.427  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 d60:	.428  alu[gprA_4, gprA_4, AND, gprB_18], gpr_wrboth
 d68:	.429  alu[gprA_5, gprA_5, AND, gprB_19], gpr_wrboth
 d70:	.430  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
 d78:	.431  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
 d80:	.432  immed[gprB_21, 0xffff007f, <<16]
 d88:	.433  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 d90:	.434  immed[gprA_3, 0x0], gpr_wrboth
 d98:	.435  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
 da0:	.436  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
 da8:	.437  alu[*l$index0, --, B, gprB_4]
 db0:	.438  alu[gprA_4, gprA_22, +, 0x8], gpr_wrboth
 db8:	.439  immed[gprA_5, 0x0], gpr_wrboth
 dc0:	.440  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
 dc8:	.441  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
 dd0:	.442  immed[gprA_2, 0x0], gpr_wrboth
 dd8:	.443  alu[gprA_3, --, B, gprA_2], gpr_wrboth
 de0:	.444  alu[gprA_1, --, B, gprB_23], gpr_wrboth
 de8:	.445  immed[gprA_21, 0xffff0fff, <<16]
 df0:	.446  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
 df8:	.447  alu[--, gprA_0, OR, gprB_1]
 e00:	.448  beq[.454]
 e08:	.449  immed[gprA_2, 0x1], gpr_wrboth
 e10:	.450  immed[gprA_3, 0x0], gpr_wrboth
 e18:	.451  immed[gprA_21, 0x890]
 e20:	.452  ld_field[gprA_21, 1100, gprB_2, <<16]
 e28:	.453  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
 e30:	.454  alu[*l$index0[1], --, B, gprB_14]
 e38:	.455  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 e40:	.456  alu[*l$index0[1], --, B, gprB_2]
 e48:	.457  immed[gprA_3, 0x0], gpr_wrboth
 e50:	.458  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 e58:	.459  immed[gprB_21, 0xacab]
 e60:	.460  immed_w1[gprB_21, 0x4811]
 e68:	.461  mul_step[gprA_2, gprB_21], start
 e70:	.462  mul_step[gprA_2, gprB_21], 32x32_step1
 e78:	.463  mul_step[gprA_2, gprB_21], 32x32_step2
 e80:	.464  mul_step[gprA_2, gprB_21], 32x32_step3
 e88:	.465  mul_step[gprA_2, gprB_21], 32x32_step4
 e90:	.466  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 e98:	.467  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 ea0:	.468  immed[gprA_14, 0xffff8000], gpr_wrboth
 ea8:	.469  immed[gprA_15, 0x0], gpr_wrboth
 eb0:	.470  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
 eb8:	.471  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
 ec0:	.472  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
 ec8:	.473  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
 ed0:	.474  alu[*l$index0[1], --, B, gprB_2]
 ed8:	.475  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 ee0:	.476  alu[*l$index0[1], --, B, gprB_2]
 ee8:	.477  immed[gprA_3, 0x0], gpr_wrboth
 ef0:	.478  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
 ef8:	.479  immed[gprB_21, 0xacd7]
 f00:	.480  immed_w1[gprB_21, 0x5591]
 f08:	.481  mul_step[gprA_2, gprB_21], start
 f10:	.482  mul_step[gprA_2, gprB_21], 32x32_step1
 f18:	.483  mul_step[gprA_2, gprB_21], 32x32_step2
 f20:	.484  mul_step[gprA_2, gprB_21], 32x32_step3
 f28:	.485  mul_step[gprA_2, gprB_21], 32x32_step4
 f30:	.486  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
 f38:	.487  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
 f40:	.488  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 f48:	.489  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 f50:	.490  alu[gprA_4, gprA_4, AND, gprB_18], gpr_wrboth
 f58:	.491  alu[gprA_5, gprA_5, AND, gprB_19], gpr_wrboth
 f60:	.492  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
 f68:	.493  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
 f70:	.494  immed[gprB_21, 0xffff007f, <<16]
 f78:	.495  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 f80:	.496  immed[gprA_3, 0x0], gpr_wrboth
 f88:	.497  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
 f90:	.498  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
 f98:	.499  alu[*l$index0, --, B, gprB_4]
 fa0:	.500  alu[gprA_4, gprA_22, +, 0x8], gpr_wrboth
 fa8:	.501  immed[gprA_5, 0x0], gpr_wrboth
 fb0:	.502  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
 fb8:	.503  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
 fc0:	.504  immed[gprA_2, 0x0], gpr_wrboth
 fc8:	.505  alu[gprA_3, --, B, gprA_2], gpr_wrboth
 fd0:	.506  alu[gprA_1, --, B, gprB_23], gpr_wrboth
 fd8:	.507  immed[gprA_21, 0xffff0fff, <<16]
 fe0:	.508  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
 fe8:	.509  alu[--, gprA_0, OR, gprB_1]
 ff0:	.510  beq[.516]
 ff8:	.511  immed[gprA_2, 0x1], gpr_wrboth
1000:	.512  immed[gprA_3, 0x0], gpr_wrboth
1008:	.513  immed[gprA_21, 0x890]
1010:	.514  ld_field[gprA_21, 1100, gprB_2, <<16]
1018:	.515  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1020:	.516  alu[*l$index0[1], --, B, gprB_16]
1028:	.517  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
1030:	.518  alu[*l$index0[1], --, B, gprB_2]
1038:	.519  immed[gprA_3, 0x0], gpr_wrboth
1040:	.520  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
1048:	.521  immed[gprB_21, 0xb4db]
1050:	.522  immed_w1[gprB_21, 0x1ec9]
1058:	.523  mul_step[gprA_2, gprB_21], start
1060:	.524  mul_step[gprA_2, gprB_21], 32x32_step1
1068:	.525  mul_step[gprA_2, gprB_21], 32x32_step2
1070:	.526  mul_step[gprA_2, gprB_21], 32x32_step3
1078:	.527  mul_step[gprA_2, gprB_21], 32x32_step4
1080:	.528  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1088:	.529  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1090:	.530  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
1098:	.531  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
10a0:	.532  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
10a8:	.533  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
10b0:	.534  alu[*l$index0[1], --, B, gprB_2]
10b8:	.535  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
10c0:	.536  alu[*l$index0[1], --, B, gprB_2]
10c8:	.537  immed[gprA_3, 0x0], gpr_wrboth
10d0:	.538  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
10d8:	.539  immed[gprB_21, 0xd38d]
10e0:	.540  immed_w1[gprB_21, 0x3224]
10e8:	.541  mul_step[gprA_2, gprB_21], start
10f0:	.542  mul_step[gprA_2, gprB_21], 32x32_step1
10f8:	.543  mul_step[gprA_2, gprB_21], 32x32_step2
1100:	.544  mul_step[gprA_2, gprB_21], 32x32_step3
1108:	.545  mul_step[gprA_2, gprB_21], 32x32_step4
1110:	.546  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1118:	.547  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1120:	.548  immed[gprA_4, 0xfffe, <<16], gpr_wrboth
1128:	.549  immed[gprA_5, 0x0], gpr_wrboth
1130:	.550  alu[gprA_6, --, B, gprB_2], gpr_wrboth
1138:	.551  alu[gprA_7, --, B, gprB_3], gpr_wrboth
1140:	.552  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
1148:	.553  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
1150:	.554  dbl_shf[gprA_6, gprA_7, gprB_6, >>17], gpr_wrboth
1158:	.555  alu_shf[gprA_7, --, B, gprB_7, >>17], gpr_wrboth
1160:	.556  immed[gprB_21, 0xffff007f, <<16]
1168:	.557  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1170:	.558  immed[gprA_3, 0x0], gpr_wrboth
1178:	.559  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
1180:	.560  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
1188:	.561  alu[*l$index0, --, B, gprB_6]
1190:	.562  alu[gprA_4, gprA_22, +, 0x8], gpr_wrboth
1198:	.563  immed[gprA_5, 0x0], gpr_wrboth
11a0:	.564  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
11a8:	.565  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
11b0:	.566  immed[gprA_2, 0x0], gpr_wrboth
11b8:	.567  alu[gprA_3, --, B, gprA_2], gpr_wrboth
11c0:	.568  alu[gprA_1, --, B, gprB_23], gpr_wrboth
11c8:	.569  immed[gprA_21, 0xffff0fff, <<16]
11d0:	.570  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
11d8:	.571  alu[--, gprA_0, OR, gprB_1]
11e0:	.572  beq[.578]
11e8:	.573  immed[gprA_2, 0x1], gpr_wrboth
11f0:	.574  immed[gprA_3, 0x0], gpr_wrboth
11f8:	.575  immed[gprA_21, 0x890]
1200:	.576  ld_field[gprA_21, 1100, gprB_2, <<16]
1208:	.577  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1210:	.578  dbl_shf[gprA_12, gprA_13, gprB_12, >>17], gpr_wrboth
1218:	.579  alu_shf[gprA_13, --, B, gprB_13, >>17], gpr_wrboth
1220:	.580  immed[gprB_21, 0x7fff]
1228:	.581  alu[gprA_12, gprA_12, AND, gprB_21], gpr_wrboth
1230:	.582  immed[gprA_13, 0x0], gpr_wrboth
1238:	.583  alu[*l$index0[1], --, B, gprB_12]
1240:	.584  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
1248:	.585  alu[*l$index0[1], --, B, gprB_2]
1250:	.586  immed[gprA_3, 0x0], gpr_wrboth
1258:	.587  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
1260:	.588  immed[gprB_21, 0xd515]
1268:	.589  immed_w1[gprB_21, 0x179c]
1270:	.590  mul_step[gprA_2, gprB_21], start
1278:	.591  mul_step[gprA_2, gprB_21], 32x32_step1
1280:	.592  mul_step[gprA_2, gprB_21], 32x32_step2
1288:	.593  mul_step[gprA_2, gprB_21], 32x32_step3
1290:	.594  mul_step[gprA_2, gprB_21], 32x32_step4
1298:	.595  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
12a0:	.596  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
12a8:	.597  immed[gprA_14, 0xffff8000], gpr_wrboth
12b0:	.598  immed[gprA_15, 0x0], gpr_wrboth
12b8:	.599  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
12c0:	.600  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
12c8:	.601  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
12d0:	.602  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
12d8:	.603  alu[*l$index0[1], --, B, gprB_2]
12e0:	.604  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
12e8:	.605  alu[*l$index0[1], --, B, gprB_2]
12f0:	.606  immed[gprA_3, 0x0], gpr_wrboth
12f8:	.607  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
1300:	.608  immed[gprB_21, 0x5d47]
1308:	.609  immed_w1[gprB_21, 0x4c49]
1310:	.610  mul_step[gprA_2, gprB_21], start
1318:	.611  mul_step[gprA_2, gprB_21], 32x32_step1
1320:	.612  mul_step[gprA_2, gprB_21], 32x32_step2
1328:	.613  mul_step[gprA_2, gprB_21], 32x32_step3
1330:	.614  mul_step[gprA_2, gprB_21], 32x32_step4
1338:	.615  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1340:	.616  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1348:	.617  alu[gprA_4, --, B, gprB_2], gpr_wrboth
1350:	.618  alu[gprA_5, --, B, gprB_3], gpr_wrboth
1358:	.619  alu[gprA_4, gprA_4, AND, gprB_14], gpr_wrboth
1360:	.620  alu[gprA_5, gprA_5, AND, gprB_15], gpr_wrboth
1368:	.621  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1370:	.622  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1378:	.623  immed[gprB_21, 0xffff007f, <<16]
1380:	.624  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1388:	.625  immed[gprA_3, 0x0], gpr_wrboth
1390:	.626  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
1398:	.627  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
13a0:	.628  alu[*l$index0, --, B, gprB_4]
13a8:	.629  alu[gprA_4, gprA_22, +, 0x8], gpr_wrboth
13b0:	.630  immed[gprA_5, 0x0], gpr_wrboth
13b8:	.631  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
13c0:	.632  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
13c8:	.633  immed[gprA_2, 0x0], gpr_wrboth
13d0:	.634  alu[gprA_3, --, B, gprA_2], gpr_wrboth
13d8:	.635  alu[gprA_1, --, B, gprB_23], gpr_wrboth
13e0:	.636  immed[gprA_21, 0xffff0fff, <<16]
13e8:	.637  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
13f0:	.638  alu[--, gprA_0, OR, gprB_1]
13f8:	.639  beq[.645]
1400:	.640  immed[gprA_2, 0x1], gpr_wrboth
1408:	.641  immed[gprA_3, 0x0], gpr_wrboth
1410:	.642  immed[gprA_21, 0x890]
1418:	.643  ld_field[gprA_21, 1100, gprB_2, <<16]
1420:	.644  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1428:	.645  alu[*l$index0[1], --, B, gprB_12]
1430:	.646  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
1438:	.647  alu[*l$index0[1], --, B, gprB_2]
1440:	.648  immed[gprA_3, 0x0], gpr_wrboth
1448:	.649  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
1450:	.650  immed[gprB_21, 0xd2cd]
1458:	.651  immed_w1[gprB_21, 0x24f4]
1460:	.652  mul_step[gprA_2, gprB_21], start
1468:	.653  mul_step[gprA_2, gprB_21], 32x32_step1
1470:	.654  mul_step[gprA_2, gprB_21], 32x32_step2
1478:	.655  mul_step[gprA_2, gprB_21], 32x32_step3
1480:	.656  mul_step[gprA_2, gprB_21], 32x32_step4
1488:	.657  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1490:	.658  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1498:	.659  alu[gprA_2, gprA_2, AND, gprB_14], gpr_wrboth
14a0:	.660  alu[gprA_3, gprA_3, AND, gprB_15], gpr_wrboth
14a8:	.661  dbl_shf[gprA_2, gprA_3, gprB_2, >>15], gpr_wrboth
14b0:	.662  alu_shf[gprA_3, --, B, gprB_3, >>15], gpr_wrboth
14b8:	.663  alu[*l$index0[1], --, B, gprB_2]
14c0:	.664  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
14c8:	.665  alu[*l$index0[1], --, B, gprB_2]
14d0:	.666  immed[gprA_3, 0x0], gpr_wrboth
14d8:	.667  alu[gprA_2, --, B, *l$index0[1]], gpr_wrboth
14e0:	.668  immed[gprB_21, 0xb969]
14e8:	.669  immed_w1[gprB_21, 0x1ba3]
14f0:	.670  mul_step[gprA_2, gprB_21], start
14f8:	.671  mul_step[gprA_2, gprB_21], 32x32_step1
1500:	.672  mul_step[gprA_2, gprB_21], 32x32_step2
1508:	.673  mul_step[gprA_2, gprB_21], 32x32_step3
1510:	.674  mul_step[gprA_2, gprB_21], 32x32_step4
1518:	.675  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
1520:	.676  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
1528:	.677  immed[gprA_4, 0xffff, <<16], gpr_wrboth
1530:	.678  immed[gprA_5, 0x0], gpr_wrboth
1538:	.679  alu[gprA_6, --, B, gprB_2], gpr_wrboth
1540:	.680  alu[gprA_7, --, B, gprB_3], gpr_wrboth
1548:	.681  alu[gprA_6, gprA_6, AND, gprB_4], gpr_wrboth
1550:	.682  alu[gprA_7, gprA_7, AND, gprB_5], gpr_wrboth
1558:	.683  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
1560:	.684  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
1568:	.685  immed[gprB_21, 0xffff007f, <<16]
1570:	.686  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
1578:	.687  immed[gprA_3, 0x0], gpr_wrboth
1580:	.688  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
1588:	.689  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
1590:	.690  alu[*l$index0, --, B, gprB_6]
1598:	.691  alu[gprA_4, gprA_22, +, 0x8], gpr_wrboth
15a0:	.692  immed[gprA_5, 0x0], gpr_wrboth
15a8:	.693  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
15b0:	.694  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
15b8:	.695  immed[gprA_2, 0x0], gpr_wrboth
15c0:	.696  alu[gprA_3, --, B, gprA_2], gpr_wrboth
15c8:	.697  alu[gprA_1, --, B, gprB_23], gpr_wrboth
15d0:	.698  immed[gprA_21, 0xffff0fff, <<16]
15d8:	.699  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<2], gpr_wrboth
15e0:	.700  alu[--, gprA_0, OR, gprB_1]
15e8:	.701  beq[.707]
15f0:	.702  immed[gprA_2, 0x1], gpr_wrboth
15f8:	.703  immed[gprA_3, 0x0], gpr_wrboth
1600:	.704  immed[gprA_21, 0x890]
1608:	.705  ld_field[gprA_21, 1100, gprB_2, <<16]
1610:	.706  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
1618:	.707  immed[gprA_0, 0x1], gpr_wrboth
1620:	.708  immed[gprA_1, 0x0], gpr_wrboth
1628:	.709  br[.15000]
1630:	.710  br[.15000], defer[2]
1638:	.711  alu[gprA_0, --, B, 0x0]
1640:	.712  ld_field[gprA_0, 1100, 0x82, <<16]
1648:	.713  alu[--, 0x3, -, gprB_0]
1650:	.714  bcc[.710]
1658:	.715  immed[gprB_2, 0x2282]
1660:	.716  immed_w1[gprB_2, 0x4411]
1668:	.717  alu_shf[gprA_1, --, B, gprB_0, <<3]
1670:	.718  alu[--, gprA_1, OR, 0x0]
1678:	.719  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
1680:	.720  br[.15000], defer[2]
1688:	.721  alu[gprA_0, --, B, 0x0]
1690:	.722  ld_field[gprA_0, 1100, gprB_2, <<16]
1698:	.723  nop
16a0:	.724  nop
16a8:	.725  nop
16b0:	.726  nop
16b8:	.727  nop
16c0:	.728  nop
16c8:	.729  nop
16d0:	.730  nop
