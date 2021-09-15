   0:	  .0  immed[gprB_22, 0x3fff]
   8:	  .1  alu[gprB_22, gprB_22, AND, *l$index1]
  10:	  .2  alu[gprA_6, gprB_22, +, *l$index1[2]], gpr_wrboth
  18:	  .3  immed[gprA_7, 0x0], gpr_wrboth
  20:	  .4  alu[gprA_2, --, B, *l$index1[2]], gpr_wrboth
  28:	  .5  immed[gprA_3, 0x0], gpr_wrboth
  30:	  .6  alu[gprA_4, --, B, gprB_2], gpr_wrboth
  38:	  .7  alu[gprA_5, --, B, gprB_3], gpr_wrboth
  40:	  .8  alu[gprA_4, gprA_4, +, 0xe], gpr_wrboth
  48:	  .9  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
  50:	 .10  immed[gprA_0, 0x2], gpr_wrboth
  58:	 .11  immed[gprA_1, 0x0], gpr_wrboth
  60:	 .12  alu[--, gprA_6, -, gprB_4]
  68:	 .13  alu[--, gprA_7, -carry, gprB_5]
  70:	 .14  bcc[.577]
  78:	 .15  alu[gprA_4, --, B, gprB_2], gpr_wrboth
  80:	 .16  alu[gprA_5, --, B, gprB_3], gpr_wrboth
  88:	 .17  alu[gprA_4, gprA_4, +, 0x22], gpr_wrboth
  90:	 .18  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
  98:	 .19  immed[gprA_0, 0x2], gpr_wrboth
  a0:	 .20  immed[gprA_1, 0x0], gpr_wrboth
  a8:	 .21  alu[--, gprA_6, -, gprB_4]
  b0:	 .22  alu[--, gprA_7, -carry, gprB_5]
  b8:	 .23  bcc[.577]
  c0:	 .24  mem[read32_swap, $xfer_0, gprA_2, 0xc, 7], ctx_swap[sig1]
  c8:	 .25  ld_field_w_clr[gprA_4, 0001, $xfer_0, >>8], gpr_wrboth
  d0:	 .26  immed[gprA_5, 0x0], gpr_wrboth
  d8:	 .27  dbl_shf[gprA_5, gprA_5, gprB_4, >>24], gpr_wrboth
  e0:	 .28  alu_shf[gprA_4, --, B, gprB_4, <<8], gpr_wrboth
  e8:	 .29  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
  f0:	 .30  immed[gprA_9, 0x0], gpr_wrboth
  f8:	 .31  alu[gprA_4, gprA_4, OR, gprB_8], gpr_wrboth
 100:	 .32  alu[gprA_5, gprA_5, OR, gprB_9], gpr_wrboth
 108:	 .33  immed[gprB_21, 0xffff]
 110:	 .34  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 118:	 .35  immed[gprA_5, 0x0], gpr_wrboth
 120:	 .36  immed[gprA_0, 0x2], gpr_wrboth
 128:	 .37  immed[gprA_1, 0x0], gpr_wrboth
 130:	 .38  alu[--, gprA_4, XOR, 0x8]
 138:	 .39  bne[.577]
 140:	 .40  alu[--, gprA_5, XOR, 0x0]
 148:	 .41  bne[.577]
 150:	 .42  ld_field_w_clr[gprA_4, 0001, $xfer_2, >>24], gpr_wrboth
 158:	 .43  immed[gprA_5, 0x0], gpr_wrboth
 160:	 .44  immed[gprA_0, 0x2], gpr_wrboth
 168:	 .45  immed[gprA_1, 0x0], gpr_wrboth
 170:	 .46  alu[--, gprA_4, XOR, 0x11]
 178:	 .47  bne[.577]
 180:	 .48  alu[--, gprA_5, XOR, 0x0]
 188:	 .49  bne[.577]
 190:	 .50  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 198:	 .51  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 1a0:	 .52  alu[gprA_4, gprA_4, +, 0x2a], gpr_wrboth
 1a8:	 .53  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
 1b0:	 .54  immed[gprA_0, 0x2], gpr_wrboth
 1b8:	 .55  immed[gprA_1, 0x0], gpr_wrboth
 1c0:	 .56  alu[--, gprA_6, -, gprB_4]
 1c8:	 .57  alu[--, gprA_7, -carry, gprB_5]
 1d0:	 .58  bcc[.577]
 1d8:	 .59  ld_field_w_clr[gprA_8, 0011, $xfer_6], gpr_wrboth
 1e0:	 .60  immed[gprA_9, 0x0], gpr_wrboth
 1e8:	 .61  immed[gprB_21, 0xbb01]
 1f0:	 .62  alu[gprA_21, gprA_8, XOR, gprB_21]
 1f8:	 .63  alu[--, gprA_21, OR, gprB_9]
 200:	 .64  beq[.72]
 208:	 .65  immed[gprA_0, 0x2], gpr_wrboth
 210:	 .66  immed[gprA_1, 0x0], gpr_wrboth
 218:	 .67  immed[gprB_21, 0x5000]
 220:	 .68  alu[--, gprA_8, XOR, gprB_21]
 228:	 .69  bne[.577]
 230:	 .70  alu[--, gprA_9, XOR, 0x0]
 238:	 .71  bne[.577]
 240:	 .72  immed[gprA_0, 0x1], gpr_wrboth
 248:	 .73  immed[gprA_1, 0x0], gpr_wrboth
 250:	 .74  alu[gprA_8, --, B, gprB_2], gpr_wrboth
 258:	 .75  alu[gprA_9, --, B, gprB_3], gpr_wrboth
 260:	 .76  alu[gprA_8, gprA_8, +, 0x2b], gpr_wrboth
 268:	 .77  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 270:	 .78  alu[--, gprA_6, -, gprB_8]
 278:	 .79  alu[--, gprA_7, -carry, gprB_9]
 280:	 .80  bcc[.577]
 288:	 .81  mem[read32_swap, $xfer_0, gprA_4, 0x0, 1], ctx_swap[sig1]
 290:	 .82  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
 298:	 .83  immed[gprA_11, 0x0], gpr_wrboth
 2a0:	 .84  alu[gprA_8, --, B, gprB_10], gpr_wrboth
 2a8:	 .85  alu[gprA_9, --, B, gprB_11], gpr_wrboth
 2b0:	 .86  alu[gprA_8, gprA_8, AND, 0x40], gpr_wrboth
 2b8:	 .87  immed[gprA_9, 0x0], gpr_wrboth
 2c0:	 .88  alu[--, gprA_8, OR, gprB_9]
 2c8:	 .89  beq[.577]
 2d0:	 .90  alu_shf[gprA_11, --, B, gprB_10, <<24], gpr_wrboth
 2d8:	 .91  immed[gprA_10, 0x0], gpr_wrboth
 2e0:	 .92  alu[--, gprA_11, OR, 0x0]
 2e8:	 .93  asr[gprA_10, gprB_11, >>24], gpr_wrboth
 2f0:	 .94  asr[gprA_11, gprB_11, >>31], gpr_wrboth
 2f8:	 .95  immed[gprA_8, 0x7fff], gpr_wrboth
 300:	 .96  immed[gprA_9, 0x0], gpr_wrboth
 308:	 .97  immed[gprA_12, 0x1], gpr_wrboth
 310:	 .98  immed[gprA_13, 0x0], gpr_wrboth
 318:	 .99  immed[gprB_21, 0xffffffff]
 320:	.100  alu[--, gprB_21, -, gprA_10]
 328:	.101  immed[gprB_21, 0xffffffff]
 330:	.102  alu[--, gprB_21, -carry, gprA_11]
 338:	.103  blt[.139]
 340:	.104  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 348:	.105  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 350:	.106  alu[gprA_10, gprA_10, +, 0x30], gpr_wrboth
 358:	.107  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 360:	.108  immed[gprA_0, 0x1], gpr_wrboth
 368:	.109  immed[gprA_1, 0x0], gpr_wrboth
 370:	.110  alu[--, gprA_6, -, gprB_10]
 378:	.111  alu[--, gprA_7, -carry, gprB_11]
 380:	.112  bcc[.577]
 388:	.113  mem[read32_swap, $xfer_0, gprA_2, 0x2f, 1], ctx_swap[sig1]
 390:	.114  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 398:	.115  immed[gprA_9, 0x0], gpr_wrboth
 3a0:	.116  alu_shf[gprA_9, --, B, gprB_8, <<24], gpr_wrboth
 3a8:	.117  immed[gprA_8, 0x0], gpr_wrboth
 3b0:	.118  alu[--, gprA_9, OR, 0x0]
 3b8:	.119  asr[gprA_8, gprB_9, >>24], gpr_wrboth
 3c0:	.120  asr[gprA_9, gprB_9, >>31], gpr_wrboth
 3c8:	.121  immed[gprA_0, 0x2], gpr_wrboth
 3d0:	.122  immed[gprA_1, 0x0], gpr_wrboth
 3d8:	.123  alu[--, gprA_8, OR, gprB_9]
 3e0:	.124  beq[.577]
 3e8:	.125  alu[gprA_0, --, B, gprB_8], gpr_wrboth
 3f0:	.126  alu[gprA_1, --, B, gprB_9], gpr_wrboth
 3f8:	.127  immed[gprB_21, 0xffff]
 400:	.128  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
 408:	.129  immed[gprA_1, 0x0], gpr_wrboth
 410:	.130  alu[gprA_10, gprA_10, +, gprB_0], gpr_wrboth
 418:	.131  alu[gprA_11, gprA_11, +carry, gprB_1], gpr_wrboth
 420:	.132  immed[gprA_12, 0x6], gpr_wrboth
 428:	.133  immed[gprA_13, 0x0], gpr_wrboth
 430:	.134  immed[gprA_0, 0x1], gpr_wrboth
 438:	.135  immed[gprA_1, 0x0], gpr_wrboth
 440:	.136  alu[--, gprA_6, -, gprB_10]
 448:	.137  alu[--, gprA_7, -carry, gprB_11]
 450:	.138  bcc[.577]
 458:	.139  alu[gprA_4, gprA_4, +, gprB_12], gpr_wrboth
 460:	.140  alu[gprA_5, gprA_5, +carry, gprB_13], gpr_wrboth
 468:	.141  alu[gprA_10, --, B, gprB_4], gpr_wrboth
 470:	.142  alu[gprA_11, --, B, gprB_5], gpr_wrboth
 478:	.143  alu[gprA_10, gprA_10, +, 0x1], gpr_wrboth
 480:	.144  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 488:	.145  immed[gprA_0, 0x1], gpr_wrboth
 490:	.146  immed[gprA_1, 0x0], gpr_wrboth
 498:	.147  alu[--, gprA_6, -, gprB_10]
 4a0:	.148  alu[--, gprA_7, -carry, gprB_11]
 4a8:	.149  bcc[.577]
 4b0:	.150  mem[read32_swap, $xfer_0, gprA_4, 0x0, 1], ctx_swap[sig1]
 4b8:	.151  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
 4c0:	.152  immed[gprA_11, 0x0], gpr_wrboth
 4c8:	.153  alu[gprA_10, gprA_10, AND, 0x3f], gpr_wrboth
 4d0:	.154  immed[gprA_11, 0x0], gpr_wrboth
 4d8:	.155  immed[gprB_21, 0x7fff]
 4e0:	.156  alu[gprA_21, gprA_8, XOR, gprB_21]
 4e8:	.157  alu[--, gprA_21, OR, gprB_9]
 4f0:	.158  beq[.178]
 4f8:	.159  immed[gprA_12, 0x8], gpr_wrboth
 500:	.160  immed[gprA_13, 0x0], gpr_wrboth
 508:	.161  immed[gprA_0, 0x2], gpr_wrboth
 510:	.162  immed[gprA_1, 0x0], gpr_wrboth
 518:	.163  alu[--, gprA_10, -, gprB_12]
 520:	.164  alu[--, gprA_11, -carry, gprB_13]
 528:	.165  bcc[.577]
 530:	.166  immed[gprB_21, 0xffff]
 538:	.167  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 540:	.168  immed[gprA_9, 0x0], gpr_wrboth
 548:	.169  alu[gprA_8, gprA_8, -, 0x1], gpr_wrboth
 550:	.170  alu[gprA_9, gprA_9, -carry, 0x0], gpr_wrboth
 558:	.171  immed[gprA_0, 0x2], gpr_wrboth
 560:	.172  immed[gprA_1, 0x0], gpr_wrboth
 568:	.173  alu[--, gprA_8, XOR, gprB_10]
 570:	.174  bne[.577]
 578:	.175  alu[--, gprA_9, XOR, gprB_11]
 580:	.176  bne[.577]
 588:	.177  br[.185]
 590:	.178  immed[gprA_8, 0x8], gpr_wrboth
 598:	.179  immed[gprA_9, 0x0], gpr_wrboth
 5a0:	.180  immed[gprA_0, 0x2], gpr_wrboth
 5a8:	.181  immed[gprA_1, 0x0], gpr_wrboth
 5b0:	.182  alu[--, gprA_10, -, gprB_8]
 5b8:	.183  alu[--, gprA_11, -carry, gprB_9]
 5c0:	.184  bcc[.577]
 5c8:	.185  alu[gprA_8, --, B, gprB_4], gpr_wrboth
 5d0:	.186  alu[gprA_9, --, B, gprB_5], gpr_wrboth
 5d8:	.187  alu[gprA_8, gprA_8, +, 0x9], gpr_wrboth
 5e0:	.188  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 5e8:	.189  immed[gprA_0, 0x1], gpr_wrboth
 5f0:	.190  immed[gprA_1, 0x0], gpr_wrboth
 5f8:	.191  alu[--, gprA_6, -, gprB_8]
 600:	.192  alu[--, gprA_7, -carry, gprB_9]
 608:	.193  bcc[.577]
 610:	.194  mem[read32_swap, $xfer_0, gprA_4, 0x1, 1], ctx_swap[sig1]
 618:	.195  ld_field_w_clr[gprA_8, 0001, $xfer_0, >>24], gpr_wrboth
 620:	.196  immed[gprA_9, 0x0], gpr_wrboth
 628:	.197  alu_shf[gprA_9, --, B, gprB_8, <<24], gpr_wrboth
 630:	.198  immed[gprA_8, 0x0], gpr_wrboth
 638:	.199  alu[--, gprA_9, OR, 0x0]
 640:	.200  asr[gprA_8, gprB_9, >>24], gpr_wrboth
 648:	.201  asr[gprA_9, gprB_9, >>31], gpr_wrboth
 650:	.202  alu[gprA_6, --, B, gprB_8], gpr_wrboth
 658:	.203  alu[gprA_7, --, B, gprB_9], gpr_wrboth
 660:	.204  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 668:	.205  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 670:	.206  dbl_shf[gprA_7, gprA_7, gprB_6, >>21], gpr_wrboth
 678:	.207  alu_shf[gprA_6, --, B, gprB_6, <<11], gpr_wrboth
 680:	.208  immed[gprB_21, 0x2000]
 688:	.209  alu[gprA_6, gprA_6, AND, gprB_21], gpr_wrboth
 690:	.210  immed[gprA_7, 0x0], gpr_wrboth
 698:	.211  ld_field_w_clr[gprA_16, 0001, $xfer_0, >>8], gpr_wrboth
 6a0:	.212  immed[gprA_17, 0x0], gpr_wrboth
 6a8:	.213  alu_shf[gprA_17, --, B, gprB_16, <<24], gpr_wrboth
 6b0:	.214  immed[gprA_16, 0x0], gpr_wrboth
 6b8:	.215  alu[--, gprA_17, OR, 0x0]
 6c0:	.216  asr[gprA_16, gprB_17, >>24], gpr_wrboth
 6c8:	.217  asr[gprA_17, gprB_17, >>31], gpr_wrboth
 6d0:	.218  alu[gprA_8, --, B, gprB_16], gpr_wrboth
 6d8:	.219  alu[gprA_9, --, B, gprB_17], gpr_wrboth
 6e0:	.220  dbl_shf[gprA_9, gprA_9, gprB_8, >>29], gpr_wrboth
 6e8:	.221  alu_shf[gprA_8, --, B, gprB_8, <<3], gpr_wrboth
 6f0:	.222  alu[gprA_8, gprA_8, AND, 0x20], gpr_wrboth
 6f8:	.223  immed[gprA_9, 0x0], gpr_wrboth
 700:	.224  alu[gprA_8, gprA_8, OR, gprB_6], gpr_wrboth
 708:	.225  alu[gprA_9, gprA_9, OR, gprB_7], gpr_wrboth
 710:	.226  alu[*l$index0[4], --, B, gprB_8]
 718:	.227  alu[*l$index0[5], --, B, gprB_9]
 720:	.228  ld_field_w_clr[gprA_0, 0001, $xfer_0, >>16], gpr_wrboth
 728:	.229  immed[gprA_1, 0x0], gpr_wrboth
 730:	.230  alu_shf[gprA_1, --, B, gprB_0, <<24], gpr_wrboth
 738:	.231  immed[gprA_0, 0x0], gpr_wrboth
 740:	.232  alu[--, gprA_1, OR, 0x0]
 748:	.233  asr[gprA_0, gprB_1, >>24], gpr_wrboth
 750:	.234  asr[gprA_1, gprB_1, >>31], gpr_wrboth
 758:	.235  alu[gprA_6, --, B, gprB_0], gpr_wrboth
 760:	.236  alu[gprA_7, --, B, gprB_1], gpr_wrboth
 768:	.237  dbl_shf[gprA_7, gprA_7, gprB_6, >>25], gpr_wrboth
 770:	.238  alu_shf[gprA_6, --, B, gprB_6, <<7], gpr_wrboth
 778:	.239  immed[gprB_21, 0x200]
 780:	.240  alu[gprA_6, gprA_6, AND, gprB_21], gpr_wrboth
 788:	.241  immed[gprA_7, 0x0], gpr_wrboth
 790:	.242  ld_field_w_clr[gprA_14, 0001, $xfer_0], gpr_wrboth
 798:	.243  immed[gprA_15, 0x0], gpr_wrboth
 7a0:	.244  alu_shf[gprA_15, --, B, gprB_14, <<24], gpr_wrboth
 7a8:	.245  immed[gprA_14, 0x0], gpr_wrboth
 7b0:	.246  alu[--, gprA_15, OR, 0x0]
 7b8:	.247  asr[gprA_14, gprB_15, >>24], gpr_wrboth
 7c0:	.248  asr[gprA_15, gprB_15, >>31], gpr_wrboth
 7c8:	.249  alu[gprA_8, --, B, gprB_14], gpr_wrboth
 7d0:	.250  alu[gprA_9, --, B, gprB_15], gpr_wrboth
 7d8:	.251  alu[gprA_8, gprA_8, AND, 0x1], gpr_wrboth
 7e0:	.252  immed[gprA_9, 0x0], gpr_wrboth
 7e8:	.253  alu[gprA_8, gprA_8, OR, gprB_6], gpr_wrboth
 7f0:	.254  alu[gprA_9, gprA_9, OR, gprB_7], gpr_wrboth
 7f8:	.255  alu[*l$index0[2], --, B, gprB_8]
 800:	.256  alu[*l$index0[3], --, B, gprB_9]
 808:	.257  alu[gprA_6, --, B, gprB_10], gpr_wrboth
 810:	.258  alu[gprA_7, --, B, gprB_11], gpr_wrboth
 818:	.259  alu[*l$index0, --, B, gprB_10]
 820:	.260  alu[*l$index0[1], --, B, gprB_11]
 828:	.261  dbl_shf[gprA_7, gprA_7, gprB_6, >>20], gpr_wrboth
 830:	.262  alu_shf[gprA_6, --, B, gprB_6, <<12], gpr_wrboth
 838:	.263  immed[gprB_21, 0x1000]
 840:	.264  alu[gprA_6, gprA_6, AND, gprB_21], gpr_wrboth
 848:	.265  immed[gprA_7, 0x0], gpr_wrboth
 850:	.266  alu[gprA_18, --, B, gprB_16], gpr_wrboth
 858:	.267  alu[gprA_19, --, B, gprB_17], gpr_wrboth
 860:	.268  dbl_shf[gprA_19, gprA_19, gprB_18, >>28], gpr_wrboth
 868:	.269  alu_shf[gprA_18, --, B, gprB_18, <<4], gpr_wrboth
 870:	.270  alu[gprA_18, gprA_18, AND, 0x10], gpr_wrboth
 878:	.271  immed[gprA_19, 0x0], gpr_wrboth
 880:	.272  alu[gprA_18, gprA_18, OR, gprB_6], gpr_wrboth
 888:	.273  alu[gprA_19, gprA_19, OR, gprB_7], gpr_wrboth
 890:	.274  alu[gprA_8, --, B, gprB_0], gpr_wrboth
 898:	.275  alu[gprA_9, --, B, gprB_1], gpr_wrboth
 8a0:	.276  dbl_shf[gprA_9, gprA_9, gprB_8, >>24], gpr_wrboth
 8a8:	.277  alu_shf[gprA_8, --, B, gprB_8, <<8], gpr_wrboth
 8b0:	.278  immed[gprB_21, 0x100]
 8b8:	.279  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 8c0:	.280  immed[gprA_9, 0x0], gpr_wrboth
 8c8:	.281  alu[gprA_15, --, B, gprB_14], gpr_wrboth
 8d0:	.282  immed[gprA_14, 0x0], gpr_wrboth
 8d8:	.283  alu[gprA_14, --, B, gprB_15], gpr_wrboth
 8e0:	.284  immed[gprA_15, 0x0], gpr_wrboth
 8e8:	.285  alu[gprA_6, --, B, gprB_14], gpr_wrboth
 8f0:	.286  alu[gprA_7, --, B, gprB_15], gpr_wrboth
 8f8:	.287  dbl_shf[gprA_6, gprA_7, gprB_6, >>1], gpr_wrboth
 900:	.288  alu_shf[gprA_7, --, B, gprB_7, >>1], gpr_wrboth
 908:	.289  alu[gprA_6, gprA_6, AND, 0x2], gpr_wrboth
 910:	.290  immed[gprA_7, 0x0], gpr_wrboth
 918:	.291  alu[gprA_6, gprA_6, OR, gprB_8], gpr_wrboth
 920:	.292  alu[gprA_7, gprA_7, OR, gprB_9], gpr_wrboth
 928:	.293  alu[gprA_8, --, B, gprB_10], gpr_wrboth
 930:	.294  alu[gprA_9, --, B, gprB_11], gpr_wrboth
 938:	.295  dbl_shf[gprA_9, gprA_9, gprB_8, >>22], gpr_wrboth
 940:	.296  alu_shf[gprA_8, --, B, gprB_8, <<10], gpr_wrboth
 948:	.297  immed[gprB_21, 0x4000]
 950:	.298  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 958:	.299  immed[gprA_9, 0x0], gpr_wrboth
 960:	.300  alu[gprA_10, --, B, gprB_16], gpr_wrboth
 968:	.301  alu[gprA_11, --, B, gprB_17], gpr_wrboth
 970:	.302  dbl_shf[gprA_11, gprA_11, gprB_10, >>30], gpr_wrboth
 978:	.303  alu_shf[gprA_10, --, B, gprB_10, <<2], gpr_wrboth
 980:	.304  alu[gprA_10, gprA_10, AND, 0x40], gpr_wrboth
 988:	.305  immed[gprA_11, 0x0], gpr_wrboth
 990:	.306  alu[gprA_10, gprA_10, OR, gprB_8], gpr_wrboth
 998:	.307  alu[gprA_11, gprA_11, OR, gprB_9], gpr_wrboth
 9a0:	.308  alu[gprA_12, --, B, gprB_0], gpr_wrboth
 9a8:	.309  alu[gprA_13, --, B, gprB_1], gpr_wrboth
 9b0:	.310  dbl_shf[gprA_13, gprA_13, gprB_12, >>26], gpr_wrboth
 9b8:	.311  alu_shf[gprA_12, --, B, gprB_12, <<6], gpr_wrboth
 9c0:	.312  immed[gprB_21, 0x400]
 9c8:	.313  alu[gprA_12, gprA_12, AND, gprB_21], gpr_wrboth
 9d0:	.314  immed[gprA_13, 0x0], gpr_wrboth
 9d8:	.315  alu[gprA_8, --, B, gprB_14], gpr_wrboth
 9e0:	.316  alu[gprA_9, --, B, gprB_15], gpr_wrboth
 9e8:	.317  dbl_shf[gprA_8, gprA_9, gprB_8, >>2], gpr_wrboth
 9f0:	.318  alu_shf[gprA_9, --, B, gprB_9, >>2], gpr_wrboth
 9f8:	.319  alu[gprA_8, gprA_8, AND, 0x4], gpr_wrboth
 a00:	.320  immed[gprA_9, 0x0], gpr_wrboth
 a08:	.321  alu[gprA_8, gprA_8, OR, gprB_12], gpr_wrboth
 a10:	.322  alu[gprA_9, gprA_9, OR, gprB_13], gpr_wrboth
 a18:	.323  alu[gprA_8, gprA_8, OR, gprB_10], gpr_wrboth
 a20:	.324  alu[gprA_9, gprA_9, OR, gprB_11], gpr_wrboth
 a28:	.325  alu[gprA_6, gprA_6, OR, gprB_18], gpr_wrboth
 a30:	.326  alu[gprA_7, gprA_7, OR, gprB_19], gpr_wrboth
 a38:	.327  alu[gprA_10, --, B, *l$index0[2]], gpr_wrboth
 a40:	.328  alu[gprA_11, --, B, *l$index0[3]], gpr_wrboth
 a48:	.329  alu[gprA_12, --, B, *l$index0[4]], gpr_wrboth
 a50:	.330  alu[gprA_13, --, B, *l$index0[5]], gpr_wrboth
 a58:	.331  alu[gprA_10, gprA_10, OR, gprB_12], gpr_wrboth
 a60:	.332  alu[gprA_11, gprA_11, OR, gprB_13], gpr_wrboth
 a68:	.333  alu[gprA_12, --, B, *l$index0], gpr_wrboth
 a70:	.334  alu[gprA_13, --, B, *l$index0[1]], gpr_wrboth
 a78:	.335  dbl_shf[gprA_13, gprA_13, gprB_12, >>23], gpr_wrboth
 a80:	.336  alu_shf[gprA_12, --, B, gprB_12, <<9], gpr_wrboth
 a88:	.337  immed[gprB_21, 0x8000]
 a90:	.338  alu[gprA_12, gprA_12, AND, gprB_21], gpr_wrboth
 a98:	.339  immed[gprA_13, 0x0], gpr_wrboth
 aa0:	.340  dbl_shf[gprA_17, gprA_17, gprB_16, >>31], gpr_wrboth
 aa8:	.341  alu_shf[gprA_16, --, B, gprB_16, <<1], gpr_wrboth
 ab0:	.342  alu[gprA_16, gprA_16, AND, 0x80], gpr_wrboth
 ab8:	.343  immed[gprA_17, 0x0], gpr_wrboth
 ac0:	.344  alu[gprA_16, gprA_16, OR, gprB_12], gpr_wrboth
 ac8:	.345  alu[gprA_17, gprA_17, OR, gprB_13], gpr_wrboth
 ad0:	.346  dbl_shf[gprA_1, gprA_1, gprB_0, >>27], gpr_wrboth
 ad8:	.347  alu_shf[gprA_0, --, B, gprB_0, <<5], gpr_wrboth
 ae0:	.348  immed[gprB_21, 0x800]
 ae8:	.349  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
 af0:	.350  immed[gprA_1, 0x0], gpr_wrboth
 af8:	.351  dbl_shf[gprA_14, gprA_15, gprB_14, >>3], gpr_wrboth
 b00:	.352  alu_shf[gprA_15, --, B, gprB_15, >>3], gpr_wrboth
 b08:	.353  alu[gprA_14, gprA_14, AND, 0x8], gpr_wrboth
 b10:	.354  immed[gprA_15, 0x0], gpr_wrboth
 b18:	.355  alu[gprA_14, gprA_14, OR, gprB_0], gpr_wrboth
 b20:	.356  alu[gprA_15, gprA_15, OR, gprB_1], gpr_wrboth
 b28:	.357  alu[gprA_14, gprA_14, OR, gprB_16], gpr_wrboth
 b30:	.358  alu[gprA_15, gprA_15, OR, gprB_17], gpr_wrboth
 b38:	.359  alu[gprA_10, gprA_10, OR, gprB_14], gpr_wrboth
 b40:	.360  alu[gprA_11, gprA_11, OR, gprB_15], gpr_wrboth
 b48:	.361  alu[gprA_16, --, B, gprB_10], gpr_wrboth
 b50:	.362  alu[gprA_17, --, B, gprB_11], gpr_wrboth
 b58:	.363  alu[gprA_6, gprA_6, OR, gprB_8], gpr_wrboth
 b60:	.364  alu[gprA_7, gprA_7, OR, gprB_9], gpr_wrboth
 b68:	.365  mem[read32_swap, $xfer_0, gprA_4, 0x5, 1], ctx_swap[sig1]
 b70:	.366  ld_field_w_clr[gprA_10, 0001, $xfer_0, >>8], gpr_wrboth
 b78:	.367  immed[gprA_11, 0x0], gpr_wrboth
 b80:	.368  alu_shf[gprA_11, --, B, gprB_10, <<24], gpr_wrboth
 b88:	.369  immed[gprA_10, 0x0], gpr_wrboth
 b90:	.370  alu[--, gprA_11, OR, 0x0]
 b98:	.371  asr[gprA_10, gprB_11, >>24], gpr_wrboth
 ba0:	.372  asr[gprA_11, gprB_11, >>31], gpr_wrboth
 ba8:	.373  alu[gprA_8, --, B, gprB_10], gpr_wrboth
 bb0:	.374  alu[gprA_9, --, B, gprB_11], gpr_wrboth
 bb8:	.375  dbl_shf[gprA_9, gprA_9, gprB_8, >>15], gpr_wrboth
 bc0:	.376  alu_shf[gprA_8, --, B, gprB_8, <<17], gpr_wrboth
 bc8:	.377  immed[gprB_21, 0x8000, <<8]
 bd0:	.378  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 bd8:	.379  immed[gprA_9, 0x0], gpr_wrboth
 be0:	.380  ld_field_w_clr[gprA_0, 0001, $xfer_0], gpr_wrboth
 be8:	.381  immed[gprA_1, 0x0], gpr_wrboth
 bf0:	.382  alu_shf[gprA_1, --, B, gprB_0, <<24], gpr_wrboth
 bf8:	.383  immed[gprA_0, 0x0], gpr_wrboth
 c00:	.384  alu[--, gprA_1, OR, 0x0]
 c08:	.385  asr[gprA_0, gprB_1, >>24], gpr_wrboth
 c10:	.386  asr[gprA_1, gprB_1, >>31], gpr_wrboth
 c18:	.387  alu[gprA_12, --, B, gprB_0], gpr_wrboth
 c20:	.388  alu[gprA_13, --, B, gprB_1], gpr_wrboth
 c28:	.389  dbl_shf[gprA_13, gprA_13, gprB_12, >>19], gpr_wrboth
 c30:	.390  alu_shf[gprA_12, --, B, gprB_12, <<13], gpr_wrboth
 c38:	.391  immed[gprB_21, 0x800, <<8]
 c40:	.392  alu[gprA_12, gprA_12, AND, gprB_21], gpr_wrboth
 c48:	.393  immed[gprA_13, 0x0], gpr_wrboth
 c50:	.394  alu[gprA_12, gprA_12, OR, gprB_8], gpr_wrboth
 c58:	.395  alu[gprA_13, gprA_13, OR, gprB_9], gpr_wrboth
 c60:	.396  alu[gprA_14, --, B, gprB_10], gpr_wrboth
 c68:	.397  alu[gprA_15, --, B, gprB_11], gpr_wrboth
 c70:	.398  dbl_shf[gprA_15, gprA_15, gprB_14, >>13], gpr_wrboth
 c78:	.399  alu_shf[gprA_14, --, B, gprB_14, <<19], gpr_wrboth
 c80:	.400  immed[gprB_21, 0x2000, <<8]
 c88:	.401  alu[gprA_14, gprA_14, AND, gprB_21], gpr_wrboth
 c90:	.402  immed[gprA_15, 0x0], gpr_wrboth
 c98:	.403  alu[gprA_8, --, B, gprB_0], gpr_wrboth
 ca0:	.404  alu[gprA_9, --, B, gprB_1], gpr_wrboth
 ca8:	.405  dbl_shf[gprA_9, gprA_9, gprB_8, >>17], gpr_wrboth
 cb0:	.406  alu_shf[gprA_8, --, B, gprB_8, <<15], gpr_wrboth
 cb8:	.407  immed[gprB_21, 0x200, <<8]
 cc0:	.408  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 cc8:	.409  immed[gprA_9, 0x0], gpr_wrboth
 cd0:	.410  alu[gprA_8, gprA_8, OR, gprB_14], gpr_wrboth
 cd8:	.411  alu[gprA_9, gprA_9, OR, gprB_15], gpr_wrboth
 ce0:	.412  alu[gprA_6, gprA_6, OR, gprB_16], gpr_wrboth
 ce8:	.413  alu[gprA_7, gprA_7, OR, gprB_17], gpr_wrboth
 cf0:	.414  alu[gprA_8, gprA_8, OR, gprB_12], gpr_wrboth
 cf8:	.415  alu[gprA_9, gprA_9, OR, gprB_13], gpr_wrboth
 d00:	.416  alu[gprA_12, --, B, gprB_10], gpr_wrboth
 d08:	.417  alu[gprA_13, --, B, gprB_11], gpr_wrboth
 d10:	.418  dbl_shf[gprA_13, gprA_13, gprB_12, >>14], gpr_wrboth
 d18:	.419  alu_shf[gprA_12, --, B, gprB_12, <<18], gpr_wrboth
 d20:	.420  immed[gprB_21, 0x4000, <<8]
 d28:	.421  alu[gprA_12, gprA_12, AND, gprB_21], gpr_wrboth
 d30:	.422  immed[gprA_13, 0x0], gpr_wrboth
 d38:	.423  alu[gprA_14, --, B, gprB_0], gpr_wrboth
 d40:	.424  alu[gprA_15, --, B, gprB_1], gpr_wrboth
 d48:	.425  dbl_shf[gprA_15, gprA_15, gprB_14, >>18], gpr_wrboth
 d50:	.426  alu_shf[gprA_14, --, B, gprB_14, <<14], gpr_wrboth
 d58:	.427  immed[gprB_21, 0x400, <<8]
 d60:	.428  alu[gprA_14, gprA_14, AND, gprB_21], gpr_wrboth
 d68:	.429  immed[gprA_15, 0x0], gpr_wrboth
 d70:	.430  alu[gprA_14, gprA_14, OR, gprB_12], gpr_wrboth
 d78:	.431  alu[gprA_15, gprA_15, OR, gprB_13], gpr_wrboth
 d80:	.432  dbl_shf[gprA_11, gprA_11, gprB_10, >>12], gpr_wrboth
 d88:	.433  alu_shf[gprA_10, --, B, gprB_10, <<20], gpr_wrboth
 d90:	.434  immed[gprB_21, 0x1000, <<8]
 d98:	.435  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 da0:	.436  immed[gprA_11, 0x0], gpr_wrboth
 da8:	.437  dbl_shf[gprA_1, gprA_1, gprB_0, >>16], gpr_wrboth
 db0:	.438  alu_shf[gprA_0, --, B, gprB_0, <<16], gpr_wrboth
 db8:	.439  immed[gprB_21, 0x100, <<8]
 dc0:	.440  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
 dc8:	.441  immed[gprA_1, 0x0], gpr_wrboth
 dd0:	.442  alu[gprA_0, gprA_0, OR, gprB_10], gpr_wrboth
 dd8:	.443  alu[gprA_1, gprA_1, OR, gprB_11], gpr_wrboth
 de0:	.444  alu[gprA_0, gprA_0, OR, gprB_14], gpr_wrboth
 de8:	.445  alu[gprA_1, gprA_1, OR, gprB_15], gpr_wrboth
 df0:	.446  alu[gprA_0, gprA_0, OR, gprB_8], gpr_wrboth
 df8:	.447  alu[gprA_1, gprA_1, OR, gprB_9], gpr_wrboth
 e00:	.448  alu[gprA_6, gprA_6, OR, gprB_0], gpr_wrboth
 e08:	.449  alu[gprA_7, gprA_7, OR, gprB_1], gpr_wrboth
 e10:	.450  ld_field_w_clr[gprA_8, 0001, $xfer_0, >>16], gpr_wrboth
 e18:	.451  immed[gprA_9, 0x0], gpr_wrboth
 e20:	.452  alu_shf[gprA_9, --, B, gprB_8, <<24], gpr_wrboth
 e28:	.453  immed[gprA_8, 0x0], gpr_wrboth
 e30:	.454  alu[--, gprA_9, OR, 0x0]
 e38:	.455  asr[gprA_8, gprB_9, >>24], gpr_wrboth
 e40:	.456  asr[gprA_9, gprB_9, >>31], gpr_wrboth
 e48:	.457  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 e50:	.458  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 e58:	.459  dbl_shf[gprA_11, gprA_11, gprB_10, >>8], gpr_wrboth
 e60:	.460  alu_shf[gprA_10, --, B, gprB_10, <<24], gpr_wrboth
 e68:	.461  immed[gprB_21, 0x100, <<16]
 e70:	.462  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 e78:	.463  immed[gprA_11, 0x0], gpr_wrboth
 e80:	.464  alu[gprA_6, gprA_6, OR, gprB_10], gpr_wrboth
 e88:	.465  alu[gprA_7, gprA_7, OR, gprB_11], gpr_wrboth
 e90:	.466  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 e98:	.467  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 ea0:	.468  dbl_shf[gprA_11, gprA_11, gprB_10, >>9], gpr_wrboth
 ea8:	.469  alu_shf[gprA_10, --, B, gprB_10, <<23], gpr_wrboth
 eb0:	.470  immed[gprB_21, 0x200, <<16]
 eb8:	.471  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 ec0:	.472  immed[gprA_11, 0x0], gpr_wrboth
 ec8:	.473  alu[gprA_6, gprA_6, OR, gprB_10], gpr_wrboth
 ed0:	.474  alu[gprA_7, gprA_7, OR, gprB_11], gpr_wrboth
 ed8:	.475  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 ee0:	.476  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 ee8:	.477  dbl_shf[gprA_11, gprA_11, gprB_10, >>10], gpr_wrboth
 ef0:	.478  alu_shf[gprA_10, --, B, gprB_10, <<22], gpr_wrboth
 ef8:	.479  immed[gprB_21, 0x400, <<16]
 f00:	.480  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 f08:	.481  immed[gprA_11, 0x0], gpr_wrboth
 f10:	.482  alu[gprA_6, gprA_6, OR, gprB_10], gpr_wrboth
 f18:	.483  alu[gprA_7, gprA_7, OR, gprB_11], gpr_wrboth
 f20:	.484  dbl_shf[gprA_9, gprA_9, gprB_8, >>11], gpr_wrboth
 f28:	.485  alu_shf[gprA_8, --, B, gprB_8, <<21], gpr_wrboth
 f30:	.486  immed[gprB_21, 0x800, <<16]
 f38:	.487  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 f40:	.488  immed[gprA_9, 0x0], gpr_wrboth
 f48:	.489  alu[gprA_6, gprA_6, OR, gprB_8], gpr_wrboth
 f50:	.490  alu[gprA_7, gprA_7, OR, gprB_9], gpr_wrboth
 f58:	.491  ld_field_w_clr[gprA_4, 0001, $xfer_0, >>24], gpr_wrboth
 f60:	.492  immed[gprA_5, 0x0], gpr_wrboth
 f68:	.493  alu_shf[gprA_5, --, B, gprB_4, <<24], gpr_wrboth
 f70:	.494  immed[gprA_4, 0x0], gpr_wrboth
 f78:	.495  alu[--, gprA_5, OR, 0x0]
 f80:	.496  asr[gprA_4, gprB_5, >>24], gpr_wrboth
 f88:	.497  asr[gprA_5, gprB_5, >>31], gpr_wrboth
 f90:	.498  alu[gprA_8, --, B, gprB_4], gpr_wrboth
 f98:	.499  alu[gprA_9, --, B, gprB_5], gpr_wrboth
 fa0:	.500  dbl_shf[gprA_9, gprA_9, gprB_8, >>4], gpr_wrboth
 fa8:	.501  alu_shf[gprA_8, --, B, gprB_8, <<28], gpr_wrboth
 fb0:	.502  immed[gprB_21, 0x1000, <<16]
 fb8:	.503  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 fc0:	.504  immed[gprA_9, 0x0], gpr_wrboth
 fc8:	.505  alu[gprA_6, gprA_6, OR, gprB_8], gpr_wrboth
 fd0:	.506  alu[gprA_7, gprA_7, OR, gprB_9], gpr_wrboth
 fd8:	.507  alu[gprA_8, --, B, gprB_4], gpr_wrboth
 fe0:	.508  alu[gprA_9, --, B, gprB_5], gpr_wrboth
 fe8:	.509  dbl_shf[gprA_9, gprA_9, gprB_8, >>5], gpr_wrboth
 ff0:	.510  alu_shf[gprA_8, --, B, gprB_8, <<27], gpr_wrboth
 ff8:	.511  immed[gprB_21, 0x2000, <<16]
1000:	.512  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
1008:	.513  immed[gprA_9, 0x0], gpr_wrboth
1010:	.514  alu[gprA_6, gprA_6, OR, gprB_8], gpr_wrboth
1018:	.515  alu[gprA_7, gprA_7, OR, gprB_9], gpr_wrboth
1020:	.516  alu[gprA_8, --, B, gprB_4], gpr_wrboth
1028:	.517  alu[gprA_9, --, B, gprB_5], gpr_wrboth
1030:	.518  dbl_shf[gprA_9, gprA_9, gprB_8, >>6], gpr_wrboth
1038:	.519  alu_shf[gprA_8, --, B, gprB_8, <<26], gpr_wrboth
1040:	.520  immed[gprB_21, 0x4000, <<16]
1048:	.521  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
1050:	.522  immed[gprA_9, 0x0], gpr_wrboth
1058:	.523  alu[gprA_6, gprA_6, OR, gprB_8], gpr_wrboth
1060:	.524  alu[gprA_7, gprA_7, OR, gprB_9], gpr_wrboth
1068:	.525  dbl_shf[gprA_5, gprA_5, gprB_4, >>7], gpr_wrboth
1070:	.526  alu_shf[gprA_4, --, B, gprB_4, <<25], gpr_wrboth
1078:	.527  immed[gprB_21, 0x8000, <<16]
1080:	.528  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
1088:	.529  alu[gprA_6, gprA_6, OR, gprB_4], gpr_wrboth
1090:	.530  alu[gprA_7, gprA_7, OR, gprB_5], gpr_wrboth
1098:	.531  alu[gprA_4, --, B, gprB_6], gpr_wrboth
10a0:	.532  alu[gprA_5, --, B, gprB_7], gpr_wrboth
10a8:	.533  alu[gprA_5, --, B, gprB_4], gpr_wrboth
10b0:	.534  immed[gprA_4, 0x0], gpr_wrboth
10b8:	.535  alu[gprA_4, --, B, gprB_5], gpr_wrboth
10c0:	.536  immed[gprA_5, 0x0], gpr_wrboth
10c8:	.537  immed[gprB_21, 0xe2]
10d0:	.538  immed_w1[gprB_21, 0xf]
10d8:	.539  mul_step[gprA_4, gprB_21], start
10e0:	.540  mul_step[gprA_4, gprB_21], 32x32_step1
10e8:	.541  mul_step[gprA_4, gprB_21], 32x32_step2
10f0:	.542  mul_step[gprA_4, gprB_21], 32x32_step3
10f8:	.543  mul_step[gprA_4, gprB_21], 32x32_step4
1100:	.544  mul_step[gprA_4, --], 32x32_last, gpr_wrboth
1108:	.545  mul_step[gprA_5, --], 32x32_last2, gpr_wrboth
1110:	.546  alu[gprA_4, --, B, gprB_5], gpr_wrboth
1118:	.547  immed[gprA_5, 0x0], gpr_wrboth
1120:	.548  alu[gprA_6, gprA_6, -, gprB_4], gpr_wrboth
1128:	.549  alu[gprA_7, gprA_7, -carry, gprB_5], gpr_wrboth
1130:	.550  immed[gprA_8, 0xfffffffe], gpr_wrboth
1138:	.551  immed[gprA_9, 0x0], gpr_wrboth
1140:	.552  alu[gprA_6, gprA_6, AND, gprB_8], gpr_wrboth
1148:	.553  alu[gprA_7, gprA_7, AND, gprB_9], gpr_wrboth
1150:	.554  dbl_shf[gprA_6, gprA_7, gprB_6, >>1], gpr_wrboth
1158:	.555  alu_shf[gprA_7, --, B, gprB_7, >>1], gpr_wrboth
1160:	.556  alu[gprA_6, gprA_6, +, gprB_4], gpr_wrboth
1168:	.557  alu[gprA_7, gprA_7, +carry, gprB_5], gpr_wrboth
1170:	.558  dbl_shf[gprA_6, gprA_7, gprB_6, >>15], gpr_wrboth
1178:	.559  alu_shf[gprA_7, --, B, gprB_7, >>15], gpr_wrboth
1180:	.560  immed[gprA_0, 0x1], gpr_wrboth
1188:	.561  immed[gprA_1, 0x0], gpr_wrboth
1190:	.562  alu[--, gprA_6, OR, gprB_7]
1198:	.563  beq[.577]
11a0:	.564  ld_field[gprB_6, 1111, gprA_6, >>rot8], gpr_wrboth
11a8:	.565  ld_field[gprB_6, 0101, gprA_6, >>rot16], gpr_wrboth
11b0:	.566  immed[gprA_7, 0x0], gpr_wrboth
11b8:	.567  alu[$xfer_0, --, B, gprA_6]
11c0:	.568  mem[write8_swap, $xfer_0, gprA_2, 0x1e, 4], ctx_swap[sig1]
11c8:	.569  mem[read32_swap, $xfer_0, gprA_2, 0xe, 1], ctx_swap[sig1]
11d0:	.570  ld_field_w_clr[gprA_4, 0001, $xfer_0], gpr_wrboth
11d8:	.571  immed[gprA_5, 0x0], gpr_wrboth
11e0:	.572  alu[gprA_4, gprA_4, OR, 0xf0], gpr_wrboth
11e8:	.573  alu[$xfer_0, --, B, gprA_4]
11f0:	.574  mem[write8_swap, $xfer_0, gprA_2, 0xe, 1], ctx_swap[sig1]
11f8:	.575  immed[gprA_0, 0x2], gpr_wrboth
1200:	.576  immed[gprA_1, 0x0], gpr_wrboth
1208:	.577  br[.15000]
1210:	.578  br[.15000], defer[2]
1218:	.579  alu[gprA_0, --, B, 0x0]
1220:	.580  ld_field[gprA_0, 1100, 0x82, <<16]
1228:	.581  alu[--, 0x3, -, gprB_0]
1230:	.582  bcc[.578]
1238:	.583  immed[gprB_2, 0x2282]
1240:	.584  immed_w1[gprB_2, 0x4411]
1248:	.585  alu_shf[gprA_1, --, B, gprB_0, <<3]
1250:	.586  alu[--, gprA_1, OR, 0x0]
1258:	.587  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
1260:	.588  br[.15000], defer[2]
1268:	.589  alu[gprA_0, --, B, 0x0]
1270:	.590  ld_field[gprA_0, 1100, gprB_2, <<16]
1278:	.591  nop
1280:	.592  nop
1288:	.593  nop
1290:	.594  nop
1298:	.595  nop
12a0:	.596  nop
12a8:	.597  nop
12b0:	.598  nop
