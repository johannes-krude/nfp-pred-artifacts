   0:	  .0  immed[gprB_22, 0x3fff]
   8:	  .1  alu[gprB_22, gprB_22, AND, *l$index1]
  10:	  .2  immed[gprA_0, 0x1], gpr_wrboth
  18:	  .3  immed[gprA_1, 0x0], gpr_wrboth
  20:	  .4  alu[gprA_8, gprB_22, +, *l$index1[2]], gpr_wrboth
  28:	  .5  immed[gprA_9, 0x0], gpr_wrboth
  30:	  .6  alu[gprA_2, --, B, *l$index1[2]], gpr_wrboth
  38:	  .7  immed[gprA_3, 0x0], gpr_wrboth
  40:	  .8  alu[gprA_4, --, B, gprB_2], gpr_wrboth
  48:	  .9  alu[gprA_5, --, B, gprB_3], gpr_wrboth
  50:	 .10  alu[gprA_4, gprA_4, +, 0xe], gpr_wrboth
  58:	 .11  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
  60:	 .12  alu[--, gprA_8, -, gprB_4]
  68:	 .13  alu[--, gprA_9, -carry, gprB_5]
  70:	 .14  bcc[.99]
  78:	 .15  mem[read32_swap, $xfer_0, gprA_2, 0xc, 3], ctx_swap[sig1]
  80:	 .16  ld_field_w_clr[gprA_4, 0001, $xfer_0], gpr_wrboth
  88:	 .17  immed[gprA_5, 0x0], gpr_wrboth
  90:	 .18  ld_field_w_clr[gprA_6, 0001, $xfer_0, >>8], gpr_wrboth
  98:	 .19  immed[gprA_7, 0x0], gpr_wrboth
  a0:	 .20  dbl_shf[gprA_7, gprA_7, gprB_6, >>24], gpr_wrboth
  a8:	 .21  alu_shf[gprA_6, --, B, gprB_6, <<8], gpr_wrboth
  b0:	 .22  alu[gprA_6, gprA_6, OR, gprB_4], gpr_wrboth
  b8:	 .23  alu[gprA_7, gprA_7, OR, gprB_5], gpr_wrboth
  c0:	 .24  immed[gprA_0, 0x1], gpr_wrboth
  c8:	 .25  immed[gprA_1, 0x0], gpr_wrboth
  d0:	 .26  immed[gprB_21, 0xdd86]
  d8:	 .27  alu[--, gprA_6, XOR, gprB_21]
  e0:	 .28  bne[.99]
  e8:	 .29  alu[--, gprA_7, XOR, 0x0]
  f0:	 .30  bne[.99]
  f8:	 .31  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 100:	 .32  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 108:	 .33  alu[gprA_6, gprA_6, +, 0x36], gpr_wrboth
 110:	 .34  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 118:	 .35  immed[gprA_0, 0x1], gpr_wrboth
 120:	 .36  immed[gprA_1, 0x0], gpr_wrboth
 128:	 .37  alu[--, gprA_8, -, gprB_6]
 130:	 .38  alu[--, gprA_9, -carry, gprB_7]
 138:	 .39  bcc[.99]
 140:	 .40  immed[gprA_10, 0xa], gpr_wrboth
 148:	 .41  immed[gprA_11, 0x0], gpr_wrboth
 150:	 .42  ld_field_w_clr[gprA_0, 0001, $xfer_2], gpr_wrboth
 158:	 .43  immed[gprA_1, 0x0], gpr_wrboth
 160:	 .44  alu[gprA_4, --, B, gprB_0], gpr_wrboth
 168:	 .45  alu[gprA_5, --, B, gprB_1], gpr_wrboth
 170:	 .46  alu[--, 0x2a, -, gprA_4]
 178:	 .47  alu[--, 0x0, -carry, gprA_5]
 180:	 .48  blt[.57]
 188:	 .49  alu[--, gprA_4, OR, gprB_5]
 190:	 .50  beq[.66]
 198:	 .51  immed[gprA_0, 0x2], gpr_wrboth
 1a0:	 .52  immed[gprA_1, 0x0], gpr_wrboth
 1a8:	 .53  alu[gprA_21, gprA_4, XOR, 0x11]
 1b0:	 .54  alu[--, gprA_21, OR, gprB_5]
 1b8:	 .55  beq[.100]
 1c0:	 .56  br[.99]
 1c8:	 .57  alu[gprA_21, gprA_4, XOR, 0x3c]
 1d0:	 .58  alu[--, gprA_21, OR, gprB_5]
 1d8:	 .59  beq[.66]
 1e0:	 .60  immed[gprA_0, 0x2], gpr_wrboth
 1e8:	 .61  immed[gprA_1, 0x0], gpr_wrboth
 1f0:	 .62  alu[--, gprA_4, XOR, 0x2b]
 1f8:	 .63  bne[.99]
 200:	 .64  alu[--, gprA_5, XOR, 0x0]
 208:	 .65  bne[.99]
 210:	 .66  alu[gprA_4, --, B, gprB_6], gpr_wrboth
 218:	 .67  alu[gprA_5, --, B, gprB_7], gpr_wrboth
 220:	 .68  alu[gprA_4, gprA_4, +, 0x8], gpr_wrboth
 228:	 .69  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
 230:	 .70  immed[gprA_0, 0x1], gpr_wrboth
 238:	 .71  immed[gprA_1, 0x0], gpr_wrboth
 240:	 .72  alu[--, gprA_8, -, gprB_4]
 248:	 .73  alu[--, gprA_9, -carry, gprB_5]
 250:	 .74  bcc[.99]
 258:	 .75  mem[read32_swap, $xfer_0, gprA_6, 0x0, 1], ctx_swap[sig1]
 260:	 .76  ld_field_w_clr[gprA_4, 0001, $xfer_0, >>8], gpr_wrboth
 268:	 .77  immed[gprA_5, 0x0], gpr_wrboth
 270:	 .78  dbl_shf[gprA_5, gprA_5, gprB_4, >>29], gpr_wrboth
 278:	 .79  alu_shf[gprA_4, --, B, gprB_4, <<3], gpr_wrboth
 280:	 .80  alu[gprA_4, gprA_4, +, gprB_6], gpr_wrboth
 288:	 .81  alu[gprA_5, gprA_5, +carry, gprB_7], gpr_wrboth
 290:	 .82  ld_field_w_clr[gprA_0, 0001, $xfer_0], gpr_wrboth
 298:	 .83  immed[gprA_1, 0x0], gpr_wrboth
 2a0:	 .84  alu[gprA_4, gprA_4, +, 0x8], gpr_wrboth
 2a8:	 .85  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
 2b0:	 .86  alu[gprA_10, gprA_10, -, 0x1], gpr_wrboth
 2b8:	 .87  alu[gprA_11, gprA_11, -carry, 0x0], gpr_wrboth
 2c0:	 .88  alu[gprA_6, --, B, gprB_4], gpr_wrboth
 2c8:	 .89  alu[gprA_7, --, B, gprB_5], gpr_wrboth
 2d0:	 .90  alu[--, gprA_10, OR, gprB_11]
 2d8:	 .91  bne[.44]
 2e0:	 .92  alu[gprA_6, --, B, gprB_0], gpr_wrboth
 2e8:	 .93  alu[gprA_7, --, B, gprB_1], gpr_wrboth
 2f0:	 .94  immed[gprA_0, 0x2], gpr_wrboth
 2f8:	 .95  immed[gprA_1, 0x0], gpr_wrboth
 300:	 .96  alu[gprA_21, gprA_6, XOR, 0x11]
 308:	 .97  alu[--, gprA_21, OR, gprB_7]
 310:	 .98  beq[.102]
 318:	 .99  br[.15000]
 320:	.100  alu[gprA_4, --, B, gprB_6], gpr_wrboth
 328:	.101  alu[gprA_5, --, B, gprB_7], gpr_wrboth
 330:	.102  alu[gprA_6, --, B, gprB_4], gpr_wrboth
 338:	.103  alu[gprA_7, --, B, gprB_5], gpr_wrboth
 340:	.104  alu[gprA_6, gprA_6, +, 0x8], gpr_wrboth
 348:	.105  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 350:	.106  immed[gprA_0, 0x1], gpr_wrboth
 358:	.107  immed[gprA_1, 0x0], gpr_wrboth
 360:	.108  alu[--, gprA_8, -, gprB_6]
 368:	.109  alu[--, gprA_9, -carry, gprB_7]
 370:	.110  bcc[.99]
 378:	.111  mem[read32_swap, $xfer_0, gprA_4, 0x2, 1], ctx_swap[sig1]
 380:	.112  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
 388:	.113  immed[gprA_11, 0x0], gpr_wrboth
 390:	.114  immed[gprB_21, 0xbb01]
 398:	.115  alu[gprA_21, gprA_10, XOR, gprB_21]
 3a0:	.116  alu[--, gprA_21, OR, gprB_11]
 3a8:	.117  beq[.125]
 3b0:	.118  immed[gprA_0, 0x2], gpr_wrboth
 3b8:	.119  immed[gprA_1, 0x0], gpr_wrboth
 3c0:	.120  immed[gprB_21, 0x5000]
 3c8:	.121  alu[--, gprA_10, XOR, gprB_21]
 3d0:	.122  bne[.99]
 3d8:	.123  alu[--, gprA_11, XOR, 0x0]
 3e0:	.124  bne[.99]
 3e8:	.125  alu[gprA_10, --, B, gprB_4], gpr_wrboth
 3f0:	.126  alu[gprA_11, --, B, gprB_5], gpr_wrboth
 3f8:	.127  alu[gprA_10, gprA_10, +, 0x9], gpr_wrboth
 400:	.128  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 408:	.129  immed[gprA_0, 0x1], gpr_wrboth
 410:	.130  immed[gprA_1, 0x0], gpr_wrboth
 418:	.131  alu[--, gprA_8, -, gprB_10]
 420:	.132  alu[--, gprA_9, -carry, gprB_11]
 428:	.133  bcc[.99]
 430:	.134  mem[read32_swap, $xfer_0, gprA_6, 0x0, 1], ctx_swap[sig1]
 438:	.135  ld_field_w_clr[gprA_12, 0001, $xfer_0], gpr_wrboth
 440:	.136  immed[gprA_13, 0x0], gpr_wrboth
 448:	.137  alu[gprA_10, --, B, gprB_12], gpr_wrboth
 450:	.138  alu[gprA_11, --, B, gprB_13], gpr_wrboth
 458:	.139  alu[gprA_10, gprA_10, AND, 0x40], gpr_wrboth
 460:	.140  immed[gprA_11, 0x0], gpr_wrboth
 468:	.141  immed[gprA_0, 0x1], gpr_wrboth
 470:	.142  immed[gprA_1, 0x0], gpr_wrboth
 478:	.143  alu[--, gprA_10, OR, gprB_11]
 480:	.144  beq[.99]
 488:	.145  alu_shf[gprA_13, --, B, gprB_12, <<24], gpr_wrboth
 490:	.146  immed[gprA_12, 0x0], gpr_wrboth
 498:	.147  alu[--, gprA_13, OR, 0x0]
 4a0:	.148  asr[gprA_12, gprB_13, >>24], gpr_wrboth
 4a8:	.149  asr[gprA_13, gprB_13, >>31], gpr_wrboth
 4b0:	.150  immed[gprA_10, 0x7fff], gpr_wrboth
 4b8:	.151  immed[gprA_11, 0x0], gpr_wrboth
 4c0:	.152  immed[gprA_14, 0x1], gpr_wrboth
 4c8:	.153  immed[gprA_15, 0x0], gpr_wrboth
 4d0:	.154  immed[gprB_21, 0xffffffff]
 4d8:	.155  alu[--, gprB_21, -, gprA_12]
 4e0:	.156  immed[gprB_21, 0xffffffff]
 4e8:	.157  alu[--, gprB_21, -carry, gprA_13]
 4f0:	.158  blt[.194]
 4f8:	.159  alu[gprA_12, --, B, gprB_4], gpr_wrboth
 500:	.160  alu[gprA_13, --, B, gprB_5], gpr_wrboth
 508:	.161  alu[gprA_12, gprA_12, +, 0xe], gpr_wrboth
 510:	.162  alu[gprA_13, gprA_13, +carry, 0x0], gpr_wrboth
 518:	.163  immed[gprA_0, 0x1], gpr_wrboth
 520:	.164  immed[gprA_1, 0x0], gpr_wrboth
 528:	.165  alu[--, gprA_8, -, gprB_12]
 530:	.166  alu[--, gprA_9, -carry, gprB_13]
 538:	.167  bcc[.99]
 540:	.168  mem[read32_swap, $xfer_0, gprA_4, 0xd, 1], ctx_swap[sig1]
 548:	.169  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
 550:	.170  immed[gprA_11, 0x0], gpr_wrboth
 558:	.171  alu_shf[gprA_11, --, B, gprB_10, <<24], gpr_wrboth
 560:	.172  immed[gprA_10, 0x0], gpr_wrboth
 568:	.173  alu[--, gprA_11, OR, 0x0]
 570:	.174  asr[gprA_10, gprB_11, >>24], gpr_wrboth
 578:	.175  asr[gprA_11, gprB_11, >>31], gpr_wrboth
 580:	.176  immed[gprA_0, 0x2], gpr_wrboth
 588:	.177  immed[gprA_1, 0x0], gpr_wrboth
 590:	.178  alu[--, gprA_10, OR, gprB_11]
 598:	.179  beq[.99]
 5a0:	.180  alu[gprA_0, --, B, gprB_10], gpr_wrboth
 5a8:	.181  alu[gprA_1, --, B, gprB_11], gpr_wrboth
 5b0:	.182  immed[gprB_21, 0xffff]
 5b8:	.183  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
 5c0:	.184  immed[gprA_1, 0x0], gpr_wrboth
 5c8:	.185  alu[gprA_12, gprA_12, +, gprB_0], gpr_wrboth
 5d0:	.186  alu[gprA_13, gprA_13, +carry, gprB_1], gpr_wrboth
 5d8:	.187  immed[gprA_14, 0x6], gpr_wrboth
 5e0:	.188  immed[gprA_15, 0x0], gpr_wrboth
 5e8:	.189  immed[gprA_0, 0x1], gpr_wrboth
 5f0:	.190  immed[gprA_1, 0x0], gpr_wrboth
 5f8:	.191  alu[--, gprA_8, -, gprB_12]
 600:	.192  alu[--, gprA_9, -carry, gprB_13]
 608:	.193  bcc[.99]
 610:	.194  alu[gprA_6, gprA_6, +, gprB_14], gpr_wrboth
 618:	.195  alu[gprA_7, gprA_7, +carry, gprB_15], gpr_wrboth
 620:	.196  alu[gprA_12, --, B, gprB_6], gpr_wrboth
 628:	.197  alu[gprA_13, --, B, gprB_7], gpr_wrboth
 630:	.198  alu[gprA_12, gprA_12, +, 0x1], gpr_wrboth
 638:	.199  alu[gprA_13, gprA_13, +carry, 0x0], gpr_wrboth
 640:	.200  immed[gprA_0, 0x1], gpr_wrboth
 648:	.201  immed[gprA_1, 0x0], gpr_wrboth
 650:	.202  alu[--, gprA_8, -, gprB_12]
 658:	.203  alu[--, gprA_9, -carry, gprB_13]
 660:	.204  bcc[.99]
 668:	.205  mem[read32_swap, $xfer_0, gprA_6, 0x0, 1], ctx_swap[sig1]
 670:	.206  ld_field_w_clr[gprA_12, 0001, $xfer_0], gpr_wrboth
 678:	.207  immed[gprA_13, 0x0], gpr_wrboth
 680:	.208  alu[gprA_12, gprA_12, AND, 0x3f], gpr_wrboth
 688:	.209  immed[gprA_13, 0x0], gpr_wrboth
 690:	.210  immed[gprB_21, 0x7fff]
 698:	.211  alu[gprA_21, gprA_10, XOR, gprB_21]
 6a0:	.212  alu[--, gprA_21, OR, gprB_11]
 6a8:	.213  beq[.233]
 6b0:	.214  immed[gprA_14, 0x8], gpr_wrboth
 6b8:	.215  immed[gprA_15, 0x0], gpr_wrboth
 6c0:	.216  immed[gprA_0, 0x2], gpr_wrboth
 6c8:	.217  immed[gprA_1, 0x0], gpr_wrboth
 6d0:	.218  alu[--, gprA_12, -, gprB_14]
 6d8:	.219  alu[--, gprA_13, -carry, gprB_15]
 6e0:	.220  bcc[.99]
 6e8:	.221  immed[gprB_21, 0xffff]
 6f0:	.222  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 6f8:	.223  immed[gprA_11, 0x0], gpr_wrboth
 700:	.224  alu[gprA_10, gprA_10, -, 0x1], gpr_wrboth
 708:	.225  alu[gprA_11, gprA_11, -carry, 0x0], gpr_wrboth
 710:	.226  immed[gprA_0, 0x2], gpr_wrboth
 718:	.227  immed[gprA_1, 0x0], gpr_wrboth
 720:	.228  alu[--, gprA_10, XOR, gprB_12]
 728:	.229  bne[.99]
 730:	.230  alu[--, gprA_11, XOR, gprB_13]
 738:	.231  bne[.99]
 740:	.232  br[.240]
 748:	.233  immed[gprA_10, 0x8], gpr_wrboth
 750:	.234  immed[gprA_11, 0x0], gpr_wrboth
 758:	.235  immed[gprA_0, 0x2], gpr_wrboth
 760:	.236  immed[gprA_1, 0x0], gpr_wrboth
 768:	.237  alu[--, gprA_12, -, gprB_10]
 770:	.238  alu[--, gprA_13, -carry, gprB_11]
 778:	.239  bcc[.99]
 780:	.240  alu[gprA_10, --, B, gprB_6], gpr_wrboth
 788:	.241  alu[gprA_11, --, B, gprB_7], gpr_wrboth
 790:	.242  alu[gprA_10, gprA_10, +, 0x9], gpr_wrboth
 798:	.243  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 7a0:	.244  immed[gprA_0, 0x1], gpr_wrboth
 7a8:	.245  immed[gprA_1, 0x0], gpr_wrboth
 7b0:	.246  alu[--, gprA_8, -, gprB_10]
 7b8:	.247  alu[--, gprA_9, -carry, gprB_11]
 7c0:	.248  bcc[.99]
 7c8:	.249  mem[read32_swap, $xfer_0, gprA_6, 0x1, 1], ctx_swap[sig1]
 7d0:	.250  ld_field_w_clr[gprA_10, 0001, $xfer_0, >>24], gpr_wrboth
 7d8:	.251  immed[gprA_11, 0x0], gpr_wrboth
 7e0:	.252  alu_shf[gprA_11, --, B, gprB_10, <<24], gpr_wrboth
 7e8:	.253  immed[gprA_10, 0x0], gpr_wrboth
 7f0:	.254  alu[--, gprA_11, OR, 0x0]
 7f8:	.255  asr[gprA_10, gprB_11, >>24], gpr_wrboth
 800:	.256  asr[gprA_11, gprB_11, >>31], gpr_wrboth
 808:	.257  alu[gprA_8, --, B, gprB_10], gpr_wrboth
 810:	.258  alu[gprA_9, --, B, gprB_11], gpr_wrboth
 818:	.259  alu[gprA_0, --, B, gprB_10], gpr_wrboth
 820:	.260  alu[gprA_1, --, B, gprB_11], gpr_wrboth
 828:	.261  dbl_shf[gprA_9, gprA_9, gprB_8, >>21], gpr_wrboth
 830:	.262  alu_shf[gprA_8, --, B, gprB_8, <<11], gpr_wrboth
 838:	.263  immed[gprB_21, 0x2000]
 840:	.264  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 848:	.265  immed[gprA_9, 0x0], gpr_wrboth
 850:	.266  ld_field_w_clr[gprA_12, 0001, $xfer_0, >>8], gpr_wrboth
 858:	.267  immed[gprA_13, 0x0], gpr_wrboth
 860:	.268  alu_shf[gprA_13, --, B, gprB_12, <<24], gpr_wrboth
 868:	.269  immed[gprA_12, 0x0], gpr_wrboth
 870:	.270  alu[--, gprA_13, OR, 0x0]
 878:	.271  asr[gprA_12, gprB_13, >>24], gpr_wrboth
 880:	.272  asr[gprA_13, gprB_13, >>31], gpr_wrboth
 888:	.273  alu[gprA_10, --, B, gprB_12], gpr_wrboth
 890:	.274  alu[gprA_11, --, B, gprB_13], gpr_wrboth
 898:	.275  dbl_shf[gprA_11, gprA_11, gprB_10, >>29], gpr_wrboth
 8a0:	.276  alu_shf[gprA_10, --, B, gprB_10, <<3], gpr_wrboth
 8a8:	.277  alu[gprA_10, gprA_10, AND, 0x20], gpr_wrboth
 8b0:	.278  immed[gprA_11, 0x0], gpr_wrboth
 8b8:	.279  alu[gprA_10, gprA_10, OR, gprB_8], gpr_wrboth
 8c0:	.280  alu[gprA_11, gprA_11, OR, gprB_9], gpr_wrboth
 8c8:	.281  alu[*l$index0[4], --, B, gprB_10]
 8d0:	.282  alu[*l$index0[5], --, B, gprB_11]
 8d8:	.283  ld_field_w_clr[gprA_10, 0001, $xfer_0, >>16], gpr_wrboth
 8e0:	.284  immed[gprA_11, 0x0], gpr_wrboth
 8e8:	.285  alu_shf[gprA_11, --, B, gprB_10, <<24], gpr_wrboth
 8f0:	.286  immed[gprA_10, 0x0], gpr_wrboth
 8f8:	.287  alu[--, gprA_11, OR, 0x0]
 900:	.288  asr[gprA_10, gprB_11, >>24], gpr_wrboth
 908:	.289  asr[gprA_11, gprB_11, >>31], gpr_wrboth
 910:	.290  alu[gprA_8, --, B, gprB_10], gpr_wrboth
 918:	.291  alu[gprA_9, --, B, gprB_11], gpr_wrboth
 920:	.292  alu[gprA_18, --, B, gprB_10], gpr_wrboth
 928:	.293  alu[gprA_19, --, B, gprB_11], gpr_wrboth
 930:	.294  alu[*l$index0[6], --, B, gprB_18]
 938:	.295  alu[*l$index0[7], --, B, gprB_19]
 940:	.296  dbl_shf[gprA_9, gprA_9, gprB_8, >>25], gpr_wrboth
 948:	.297  alu_shf[gprA_8, --, B, gprB_8, <<7], gpr_wrboth
 950:	.298  immed[gprB_21, 0x200]
 958:	.299  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 960:	.300  immed[gprA_9, 0x0], gpr_wrboth
 968:	.301  ld_field_w_clr[gprA_16, 0001, $xfer_0], gpr_wrboth
 970:	.302  immed[gprA_17, 0x0], gpr_wrboth
 978:	.303  alu_shf[gprA_17, --, B, gprB_16, <<24], gpr_wrboth
 980:	.304  immed[gprA_16, 0x0], gpr_wrboth
 988:	.305  alu[--, gprA_17, OR, 0x0]
 990:	.306  asr[gprA_16, gprB_17, >>24], gpr_wrboth
 998:	.307  asr[gprA_17, gprB_17, >>31], gpr_wrboth
 9a0:	.308  alu[gprA_10, --, B, gprB_16], gpr_wrboth
 9a8:	.309  alu[gprA_11, --, B, gprB_17], gpr_wrboth
 9b0:	.310  alu[gprA_10, gprA_10, AND, 0x1], gpr_wrboth
 9b8:	.311  immed[gprA_11, 0x0], gpr_wrboth
 9c0:	.312  alu[gprA_10, gprA_10, OR, gprB_8], gpr_wrboth
 9c8:	.313  alu[gprA_11, gprA_11, OR, gprB_9], gpr_wrboth
 9d0:	.314  alu[*l$index0[2], --, B, gprB_10]
 9d8:	.315  alu[*l$index0[3], --, B, gprB_11]
 9e0:	.316  alu[gprA_8, --, B, gprB_0], gpr_wrboth
 9e8:	.317  alu[gprA_9, --, B, gprB_1], gpr_wrboth
 9f0:	.318  alu[*l$index0, --, B, gprB_0]
 9f8:	.319  alu[*l$index0[1], --, B, gprB_1]
 a00:	.320  dbl_shf[gprA_9, gprA_9, gprB_8, >>20], gpr_wrboth
 a08:	.321  alu_shf[gprA_8, --, B, gprB_8, <<12], gpr_wrboth
 a10:	.322  immed[gprB_21, 0x1000]
 a18:	.323  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
 a20:	.324  immed[gprA_9, 0x0], gpr_wrboth
 a28:	.325  alu[gprA_14, --, B, gprB_12], gpr_wrboth
 a30:	.326  alu[gprA_15, --, B, gprB_13], gpr_wrboth
 a38:	.327  dbl_shf[gprA_15, gprA_15, gprB_14, >>28], gpr_wrboth
 a40:	.328  alu_shf[gprA_14, --, B, gprB_14, <<4], gpr_wrboth
 a48:	.329  alu[gprA_14, gprA_14, AND, 0x10], gpr_wrboth
 a50:	.330  immed[gprA_15, 0x0], gpr_wrboth
 a58:	.331  alu[gprA_14, gprA_14, OR, gprB_8], gpr_wrboth
 a60:	.332  alu[gprA_15, gprA_15, OR, gprB_9], gpr_wrboth
 a68:	.333  alu[gprA_10, --, B, gprB_18], gpr_wrboth
 a70:	.334  alu[gprA_11, --, B, gprB_19], gpr_wrboth
 a78:	.335  dbl_shf[gprA_11, gprA_11, gprB_10, >>24], gpr_wrboth
 a80:	.336  alu_shf[gprA_10, --, B, gprB_10, <<8], gpr_wrboth
 a88:	.337  immed[gprB_21, 0x100]
 a90:	.338  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 a98:	.339  immed[gprA_11, 0x0], gpr_wrboth
 aa0:	.340  alu[gprA_17, --, B, gprB_16], gpr_wrboth
 aa8:	.341  immed[gprA_16, 0x0], gpr_wrboth
 ab0:	.342  alu[gprA_16, --, B, gprB_17], gpr_wrboth
 ab8:	.343  immed[gprA_17, 0x0], gpr_wrboth
 ac0:	.344  alu[gprA_8, --, B, gprB_16], gpr_wrboth
 ac8:	.345  alu[gprA_9, --, B, gprB_17], gpr_wrboth
 ad0:	.346  dbl_shf[gprA_8, gprA_9, gprB_8, >>1], gpr_wrboth
 ad8:	.347  alu_shf[gprA_9, --, B, gprB_9, >>1], gpr_wrboth
 ae0:	.348  alu[gprA_8, gprA_8, AND, 0x2], gpr_wrboth
 ae8:	.349  immed[gprA_9, 0x0], gpr_wrboth
 af0:	.350  alu[gprA_8, gprA_8, OR, gprB_10], gpr_wrboth
 af8:	.351  alu[gprA_9, gprA_9, OR, gprB_11], gpr_wrboth
 b00:	.352  alu[gprA_10, --, B, gprB_0], gpr_wrboth
 b08:	.353  alu[gprA_11, --, B, gprB_1], gpr_wrboth
 b10:	.354  dbl_shf[gprA_11, gprA_11, gprB_10, >>22], gpr_wrboth
 b18:	.355  alu_shf[gprA_10, --, B, gprB_10, <<10], gpr_wrboth
 b20:	.356  immed[gprB_21, 0x4000]
 b28:	.357  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 b30:	.358  immed[gprA_11, 0x0], gpr_wrboth
 b38:	.359  alu[gprA_0, --, B, gprB_12], gpr_wrboth
 b40:	.360  alu[gprA_1, --, B, gprB_13], gpr_wrboth
 b48:	.361  dbl_shf[gprA_1, gprA_1, gprB_0, >>30], gpr_wrboth
 b50:	.362  alu_shf[gprA_0, --, B, gprB_0, <<2], gpr_wrboth
 b58:	.363  alu[gprA_0, gprA_0, AND, 0x40], gpr_wrboth
 b60:	.364  immed[gprA_1, 0x0], gpr_wrboth
 b68:	.365  alu[gprA_0, gprA_0, OR, gprB_10], gpr_wrboth
 b70:	.366  alu[gprA_1, gprA_1, OR, gprB_11], gpr_wrboth
 b78:	.367  alu[gprA_18, --, B, *l$index0[6]], gpr_wrboth
 b80:	.368  alu[gprA_19, --, B, *l$index0[7]], gpr_wrboth
 b88:	.369  dbl_shf[gprA_19, gprA_19, gprB_18, >>26], gpr_wrboth
 b90:	.370  alu_shf[gprA_18, --, B, gprB_18, <<6], gpr_wrboth
 b98:	.371  immed[gprB_21, 0x400]
 ba0:	.372  alu[gprA_18, gprA_18, AND, gprB_21], gpr_wrboth
 ba8:	.373  immed[gprA_19, 0x0], gpr_wrboth
 bb0:	.374  alu[gprA_10, --, B, gprB_16], gpr_wrboth
 bb8:	.375  alu[gprA_11, --, B, gprB_17], gpr_wrboth
 bc0:	.376  dbl_shf[gprA_10, gprA_11, gprB_10, >>2], gpr_wrboth
 bc8:	.377  alu_shf[gprA_11, --, B, gprB_11, >>2], gpr_wrboth
 bd0:	.378  alu[gprA_10, gprA_10, AND, 0x4], gpr_wrboth
 bd8:	.379  immed[gprA_11, 0x0], gpr_wrboth
 be0:	.380  alu[gprA_10, gprA_10, OR, gprB_18], gpr_wrboth
 be8:	.381  alu[gprA_11, gprA_11, OR, gprB_19], gpr_wrboth
 bf0:	.382  alu[gprA_10, gprA_10, OR, gprB_0], gpr_wrboth
 bf8:	.383  alu[gprA_11, gprA_11, OR, gprB_1], gpr_wrboth
 c00:	.384  alu[gprA_8, gprA_8, OR, gprB_14], gpr_wrboth
 c08:	.385  alu[gprA_9, gprA_9, OR, gprB_15], gpr_wrboth
 c10:	.386  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 c18:	.387  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 c20:	.388  alu[gprA_0, --, B, *l$index0[4]], gpr_wrboth
 c28:	.389  alu[gprA_1, --, B, *l$index0[5]], gpr_wrboth
 c30:	.390  alu[gprA_18, gprA_18, OR, gprB_0], gpr_wrboth
 c38:	.391  alu[gprA_19, gprA_19, OR, gprB_1], gpr_wrboth
 c40:	.392  alu[gprA_0, --, B, *l$index0], gpr_wrboth
 c48:	.393  alu[gprA_1, --, B, *l$index0[1]], gpr_wrboth
 c50:	.394  dbl_shf[gprA_1, gprA_1, gprB_0, >>23], gpr_wrboth
 c58:	.395  alu_shf[gprA_0, --, B, gprB_0, <<9], gpr_wrboth
 c60:	.396  immed[gprB_21, 0x8000]
 c68:	.397  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
 c70:	.398  immed[gprA_1, 0x0], gpr_wrboth
 c78:	.399  dbl_shf[gprA_13, gprA_13, gprB_12, >>31], gpr_wrboth
 c80:	.400  alu_shf[gprA_12, --, B, gprB_12, <<1], gpr_wrboth
 c88:	.401  alu[gprA_12, gprA_12, AND, 0x80], gpr_wrboth
 c90:	.402  immed[gprA_13, 0x0], gpr_wrboth
 c98:	.403  alu[gprA_12, gprA_12, OR, gprB_0], gpr_wrboth
 ca0:	.404  alu[gprA_13, gprA_13, OR, gprB_1], gpr_wrboth
 ca8:	.405  alu[gprA_0, --, B, *l$index0[6]], gpr_wrboth
 cb0:	.406  alu[gprA_1, --, B, *l$index0[7]], gpr_wrboth
 cb8:	.407  dbl_shf[gprA_1, gprA_1, gprB_0, >>27], gpr_wrboth
 cc0:	.408  alu_shf[gprA_0, --, B, gprB_0, <<5], gpr_wrboth
 cc8:	.409  immed[gprB_21, 0x800]
 cd0:	.410  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
 cd8:	.411  immed[gprA_1, 0x0], gpr_wrboth
 ce0:	.412  dbl_shf[gprA_16, gprA_17, gprB_16, >>3], gpr_wrboth
 ce8:	.413  alu_shf[gprA_17, --, B, gprB_17, >>3], gpr_wrboth
 cf0:	.414  alu[gprA_16, gprA_16, AND, 0x8], gpr_wrboth
 cf8:	.415  immed[gprA_17, 0x0], gpr_wrboth
 d00:	.416  alu[gprA_16, gprA_16, OR, gprB_0], gpr_wrboth
 d08:	.417  alu[gprA_17, gprA_17, OR, gprB_1], gpr_wrboth
 d10:	.418  alu[gprA_16, gprA_16, OR, gprB_12], gpr_wrboth
 d18:	.419  alu[gprA_17, gprA_17, OR, gprB_13], gpr_wrboth
 d20:	.420  alu[gprA_18, gprA_18, OR, gprB_16], gpr_wrboth
 d28:	.421  alu[gprA_19, gprA_19, OR, gprB_17], gpr_wrboth
 d30:	.422  alu[gprA_8, gprA_8, OR, gprB_10], gpr_wrboth
 d38:	.423  alu[gprA_9, gprA_9, OR, gprB_11], gpr_wrboth
 d40:	.424  mem[read32_swap, $xfer_0, gprA_6, 0x5, 1], ctx_swap[sig1]
 d48:	.425  ld_field_w_clr[gprA_0, 0001, $xfer_0, >>8], gpr_wrboth
 d50:	.426  immed[gprA_1, 0x0], gpr_wrboth
 d58:	.427  alu_shf[gprA_1, --, B, gprB_0, <<24], gpr_wrboth
 d60:	.428  immed[gprA_0, 0x0], gpr_wrboth
 d68:	.429  alu[--, gprA_1, OR, 0x0]
 d70:	.430  asr[gprA_0, gprB_1, >>24], gpr_wrboth
 d78:	.431  asr[gprA_1, gprB_1, >>31], gpr_wrboth
 d80:	.432  alu[gprA_10, --, B, gprB_0], gpr_wrboth
 d88:	.433  alu[gprA_11, --, B, gprB_1], gpr_wrboth
 d90:	.434  dbl_shf[gprA_11, gprA_11, gprB_10, >>15], gpr_wrboth
 d98:	.435  alu_shf[gprA_10, --, B, gprB_10, <<17], gpr_wrboth
 da0:	.436  immed[gprB_21, 0x8000, <<8]
 da8:	.437  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 db0:	.438  immed[gprA_11, 0x0], gpr_wrboth
 db8:	.439  ld_field_w_clr[gprA_12, 0001, $xfer_0], gpr_wrboth
 dc0:	.440  immed[gprA_13, 0x0], gpr_wrboth
 dc8:	.441  alu_shf[gprA_13, --, B, gprB_12, <<24], gpr_wrboth
 dd0:	.442  immed[gprA_12, 0x0], gpr_wrboth
 dd8:	.443  alu[--, gprA_13, OR, 0x0]
 de0:	.444  asr[gprA_12, gprB_13, >>24], gpr_wrboth
 de8:	.445  asr[gprA_13, gprB_13, >>31], gpr_wrboth
 df0:	.446  alu[gprA_14, --, B, gprB_12], gpr_wrboth
 df8:	.447  alu[gprA_15, --, B, gprB_13], gpr_wrboth
 e00:	.448  dbl_shf[gprA_15, gprA_15, gprB_14, >>19], gpr_wrboth
 e08:	.449  alu_shf[gprA_14, --, B, gprB_14, <<13], gpr_wrboth
 e10:	.450  immed[gprB_21, 0x800, <<8]
 e18:	.451  alu[gprA_14, gprA_14, AND, gprB_21], gpr_wrboth
 e20:	.452  immed[gprA_15, 0x0], gpr_wrboth
 e28:	.453  alu[gprA_14, gprA_14, OR, gprB_10], gpr_wrboth
 e30:	.454  alu[gprA_15, gprA_15, OR, gprB_11], gpr_wrboth
 e38:	.455  alu[gprA_16, --, B, gprB_0], gpr_wrboth
 e40:	.456  alu[gprA_17, --, B, gprB_1], gpr_wrboth
 e48:	.457  dbl_shf[gprA_17, gprA_17, gprB_16, >>13], gpr_wrboth
 e50:	.458  alu_shf[gprA_16, --, B, gprB_16, <<19], gpr_wrboth
 e58:	.459  immed[gprB_21, 0x2000, <<8]
 e60:	.460  alu[gprA_16, gprA_16, AND, gprB_21], gpr_wrboth
 e68:	.461  immed[gprA_17, 0x0], gpr_wrboth
 e70:	.462  alu[gprA_10, --, B, gprB_12], gpr_wrboth
 e78:	.463  alu[gprA_11, --, B, gprB_13], gpr_wrboth
 e80:	.464  dbl_shf[gprA_11, gprA_11, gprB_10, >>17], gpr_wrboth
 e88:	.465  alu_shf[gprA_10, --, B, gprB_10, <<15], gpr_wrboth
 e90:	.466  immed[gprB_21, 0x200, <<8]
 e98:	.467  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
 ea0:	.468  immed[gprA_11, 0x0], gpr_wrboth
 ea8:	.469  alu[gprA_10, gprA_10, OR, gprB_16], gpr_wrboth
 eb0:	.470  alu[gprA_11, gprA_11, OR, gprB_17], gpr_wrboth
 eb8:	.471  alu[gprA_8, gprA_8, OR, gprB_18], gpr_wrboth
 ec0:	.472  alu[gprA_9, gprA_9, OR, gprB_19], gpr_wrboth
 ec8:	.473  alu[gprA_10, gprA_10, OR, gprB_14], gpr_wrboth
 ed0:	.474  alu[gprA_11, gprA_11, OR, gprB_15], gpr_wrboth
 ed8:	.475  alu[gprA_14, --, B, gprB_0], gpr_wrboth
 ee0:	.476  alu[gprA_15, --, B, gprB_1], gpr_wrboth
 ee8:	.477  dbl_shf[gprA_15, gprA_15, gprB_14, >>14], gpr_wrboth
 ef0:	.478  alu_shf[gprA_14, --, B, gprB_14, <<18], gpr_wrboth
 ef8:	.479  immed[gprB_21, 0x4000, <<8]
 f00:	.480  alu[gprA_14, gprA_14, AND, gprB_21], gpr_wrboth
 f08:	.481  immed[gprA_15, 0x0], gpr_wrboth
 f10:	.482  alu[gprA_16, --, B, gprB_12], gpr_wrboth
 f18:	.483  alu[gprA_17, --, B, gprB_13], gpr_wrboth
 f20:	.484  dbl_shf[gprA_17, gprA_17, gprB_16, >>18], gpr_wrboth
 f28:	.485  alu_shf[gprA_16, --, B, gprB_16, <<14], gpr_wrboth
 f30:	.486  immed[gprB_21, 0x400, <<8]
 f38:	.487  alu[gprA_16, gprA_16, AND, gprB_21], gpr_wrboth
 f40:	.488  immed[gprA_17, 0x0], gpr_wrboth
 f48:	.489  alu[gprA_16, gprA_16, OR, gprB_14], gpr_wrboth
 f50:	.490  alu[gprA_17, gprA_17, OR, gprB_15], gpr_wrboth
 f58:	.491  dbl_shf[gprA_1, gprA_1, gprB_0, >>12], gpr_wrboth
 f60:	.492  alu_shf[gprA_0, --, B, gprB_0, <<20], gpr_wrboth
 f68:	.493  immed[gprB_21, 0x1000, <<8]
 f70:	.494  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
 f78:	.495  immed[gprA_1, 0x0], gpr_wrboth
 f80:	.496  dbl_shf[gprA_13, gprA_13, gprB_12, >>16], gpr_wrboth
 f88:	.497  alu_shf[gprA_12, --, B, gprB_12, <<16], gpr_wrboth
 f90:	.498  immed[gprB_21, 0x100, <<8]
 f98:	.499  alu[gprA_12, gprA_12, AND, gprB_21], gpr_wrboth
 fa0:	.500  immed[gprA_13, 0x0], gpr_wrboth
 fa8:	.501  alu[gprA_12, gprA_12, OR, gprB_0], gpr_wrboth
 fb0:	.502  alu[gprA_13, gprA_13, OR, gprB_1], gpr_wrboth
 fb8:	.503  alu[gprA_12, gprA_12, OR, gprB_16], gpr_wrboth
 fc0:	.504  alu[gprA_13, gprA_13, OR, gprB_17], gpr_wrboth
 fc8:	.505  alu[gprA_12, gprA_12, OR, gprB_10], gpr_wrboth
 fd0:	.506  alu[gprA_13, gprA_13, OR, gprB_11], gpr_wrboth
 fd8:	.507  alu[gprA_8, gprA_8, OR, gprB_12], gpr_wrboth
 fe0:	.508  alu[gprA_9, gprA_9, OR, gprB_13], gpr_wrboth
 fe8:	.509  ld_field_w_clr[gprA_10, 0001, $xfer_0, >>16], gpr_wrboth
 ff0:	.510  immed[gprA_11, 0x0], gpr_wrboth
 ff8:	.511  alu_shf[gprA_11, --, B, gprB_10, <<24], gpr_wrboth
1000:	.512  immed[gprA_10, 0x0], gpr_wrboth
1008:	.513  alu[--, gprA_11, OR, 0x0]
1010:	.514  asr[gprA_10, gprB_11, >>24], gpr_wrboth
1018:	.515  asr[gprA_11, gprB_11, >>31], gpr_wrboth
1020:	.516  alu[gprA_0, --, B, gprB_10], gpr_wrboth
1028:	.517  alu[gprA_1, --, B, gprB_11], gpr_wrboth
1030:	.518  dbl_shf[gprA_1, gprA_1, gprB_0, >>8], gpr_wrboth
1038:	.519  alu_shf[gprA_0, --, B, gprB_0, <<24], gpr_wrboth
1040:	.520  immed[gprB_21, 0x100, <<16]
1048:	.521  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
1050:	.522  immed[gprA_1, 0x0], gpr_wrboth
1058:	.523  alu[gprA_8, gprA_8, OR, gprB_0], gpr_wrboth
1060:	.524  alu[gprA_9, gprA_9, OR, gprB_1], gpr_wrboth
1068:	.525  alu[gprA_0, --, B, gprB_10], gpr_wrboth
1070:	.526  alu[gprA_1, --, B, gprB_11], gpr_wrboth
1078:	.527  dbl_shf[gprA_1, gprA_1, gprB_0, >>9], gpr_wrboth
1080:	.528  alu_shf[gprA_0, --, B, gprB_0, <<23], gpr_wrboth
1088:	.529  immed[gprB_21, 0x200, <<16]
1090:	.530  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
1098:	.531  immed[gprA_1, 0x0], gpr_wrboth
10a0:	.532  alu[gprA_8, gprA_8, OR, gprB_0], gpr_wrboth
10a8:	.533  alu[gprA_9, gprA_9, OR, gprB_1], gpr_wrboth
10b0:	.534  alu[gprA_0, --, B, gprB_10], gpr_wrboth
10b8:	.535  alu[gprA_1, --, B, gprB_11], gpr_wrboth
10c0:	.536  dbl_shf[gprA_1, gprA_1, gprB_0, >>10], gpr_wrboth
10c8:	.537  alu_shf[gprA_0, --, B, gprB_0, <<22], gpr_wrboth
10d0:	.538  immed[gprB_21, 0x400, <<16]
10d8:	.539  alu[gprA_0, gprA_0, AND, gprB_21], gpr_wrboth
10e0:	.540  immed[gprA_1, 0x0], gpr_wrboth
10e8:	.541  alu[gprA_8, gprA_8, OR, gprB_0], gpr_wrboth
10f0:	.542  alu[gprA_9, gprA_9, OR, gprB_1], gpr_wrboth
10f8:	.543  dbl_shf[gprA_11, gprA_11, gprB_10, >>11], gpr_wrboth
1100:	.544  alu_shf[gprA_10, --, B, gprB_10, <<21], gpr_wrboth
1108:	.545  immed[gprB_21, 0x800, <<16]
1110:	.546  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
1118:	.547  immed[gprA_11, 0x0], gpr_wrboth
1120:	.548  alu[gprA_8, gprA_8, OR, gprB_10], gpr_wrboth
1128:	.549  alu[gprA_9, gprA_9, OR, gprB_11], gpr_wrboth
1130:	.550  ld_field_w_clr[gprA_6, 0001, $xfer_0, >>24], gpr_wrboth
1138:	.551  immed[gprA_7, 0x0], gpr_wrboth
1140:	.552  alu_shf[gprA_7, --, B, gprB_6, <<24], gpr_wrboth
1148:	.553  immed[gprA_6, 0x0], gpr_wrboth
1150:	.554  alu[--, gprA_7, OR, 0x0]
1158:	.555  asr[gprA_6, gprB_7, >>24], gpr_wrboth
1160:	.556  asr[gprA_7, gprB_7, >>31], gpr_wrboth
1168:	.557  alu[gprA_10, --, B, gprB_6], gpr_wrboth
1170:	.558  alu[gprA_11, --, B, gprB_7], gpr_wrboth
1178:	.559  dbl_shf[gprA_11, gprA_11, gprB_10, >>4], gpr_wrboth
1180:	.560  alu_shf[gprA_10, --, B, gprB_10, <<28], gpr_wrboth
1188:	.561  immed[gprB_21, 0x1000, <<16]
1190:	.562  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
1198:	.563  immed[gprA_11, 0x0], gpr_wrboth
11a0:	.564  alu[gprA_8, gprA_8, OR, gprB_10], gpr_wrboth
11a8:	.565  alu[gprA_9, gprA_9, OR, gprB_11], gpr_wrboth
11b0:	.566  alu[gprA_10, --, B, gprB_6], gpr_wrboth
11b8:	.567  alu[gprA_11, --, B, gprB_7], gpr_wrboth
11c0:	.568  dbl_shf[gprA_11, gprA_11, gprB_10, >>5], gpr_wrboth
11c8:	.569  alu_shf[gprA_10, --, B, gprB_10, <<27], gpr_wrboth
11d0:	.570  immed[gprB_21, 0x2000, <<16]
11d8:	.571  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
11e0:	.572  immed[gprA_11, 0x0], gpr_wrboth
11e8:	.573  alu[gprA_8, gprA_8, OR, gprB_10], gpr_wrboth
11f0:	.574  alu[gprA_9, gprA_9, OR, gprB_11], gpr_wrboth
11f8:	.575  alu[gprA_10, --, B, gprB_6], gpr_wrboth
1200:	.576  alu[gprA_11, --, B, gprB_7], gpr_wrboth
1208:	.577  dbl_shf[gprA_11, gprA_11, gprB_10, >>6], gpr_wrboth
1210:	.578  alu_shf[gprA_10, --, B, gprB_10, <<26], gpr_wrboth
1218:	.579  immed[gprB_21, 0x4000, <<16]
1220:	.580  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
1228:	.581  immed[gprA_11, 0x0], gpr_wrboth
1230:	.582  alu[gprA_8, gprA_8, OR, gprB_10], gpr_wrboth
1238:	.583  alu[gprA_9, gprA_9, OR, gprB_11], gpr_wrboth
1240:	.584  dbl_shf[gprA_7, gprA_7, gprB_6, >>7], gpr_wrboth
1248:	.585  alu_shf[gprA_6, --, B, gprB_6, <<25], gpr_wrboth
1250:	.586  immed[gprB_21, 0x8000, <<16]
1258:	.587  alu[gprA_6, gprA_6, AND, gprB_21], gpr_wrboth
1260:	.588  alu[gprA_8, gprA_8, OR, gprB_6], gpr_wrboth
1268:	.589  alu[gprA_9, gprA_9, OR, gprB_7], gpr_wrboth
1270:	.590  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1278:	.591  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1280:	.592  alu[gprA_7, --, B, gprB_6], gpr_wrboth
1288:	.593  immed[gprA_6, 0x0], gpr_wrboth
1290:	.594  alu[gprA_6, --, B, gprB_7], gpr_wrboth
1298:	.595  immed[gprA_7, 0x0], gpr_wrboth
12a0:	.596  immed[gprB_21, 0xe2]
12a8:	.597  immed_w1[gprB_21, 0xf]
12b0:	.598  mul_step[gprA_6, gprB_21], start
12b8:	.599  mul_step[gprA_6, gprB_21], 32x32_step1
12c0:	.600  mul_step[gprA_6, gprB_21], 32x32_step2
12c8:	.601  mul_step[gprA_6, gprB_21], 32x32_step3
12d0:	.602  mul_step[gprA_6, gprB_21], 32x32_step4
12d8:	.603  mul_step[gprA_6, --], 32x32_last, gpr_wrboth
12e0:	.604  mul_step[gprA_7, --], 32x32_last2, gpr_wrboth
12e8:	.605  alu[gprA_6, --, B, gprB_7], gpr_wrboth
12f0:	.606  immed[gprA_7, 0x0], gpr_wrboth
12f8:	.607  alu[gprA_8, gprA_8, -, gprB_6], gpr_wrboth
1300:	.608  alu[gprA_9, gprA_9, -carry, gprB_7], gpr_wrboth
1308:	.609  immed[gprA_10, 0xfffffffe], gpr_wrboth
1310:	.610  immed[gprA_11, 0x0], gpr_wrboth
1318:	.611  alu[gprA_8, gprA_8, AND, gprB_10], gpr_wrboth
1320:	.612  alu[gprA_9, gprA_9, AND, gprB_11], gpr_wrboth
1328:	.613  dbl_shf[gprA_8, gprA_9, gprB_8, >>1], gpr_wrboth
1330:	.614  alu_shf[gprA_9, --, B, gprB_9, >>1], gpr_wrboth
1338:	.615  alu[gprA_8, gprA_8, +, gprB_6], gpr_wrboth
1340:	.616  alu[gprA_9, gprA_9, +carry, gprB_7], gpr_wrboth
1348:	.617  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
1350:	.618  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
1358:	.619  immed[gprA_0, 0x1], gpr_wrboth
1360:	.620  immed[gprA_1, 0x0], gpr_wrboth
1368:	.621  alu[--, gprA_8, OR, gprB_9]
1370:	.622  beq[.99]
1378:	.623  alu[gprA_4, gprA_4, -, gprB_2], gpr_wrboth
1380:	.624  alu[gprA_5, gprA_5, -carry, gprB_3], gpr_wrboth
1388:	.625  alu[$xfer_0, --, B, gprA_4]
1390:	.626  mem[write8_swap, $xfer_0, gprA_2, 0x2a, 4], ctx_swap[sig1]
1398:	.627  ld_field[gprB_8, 1111, gprA_8, >>rot8], gpr_wrboth
13a0:	.628  ld_field[gprB_8, 0101, gprA_8, >>rot16], gpr_wrboth
13a8:	.629  immed[gprA_9, 0x0], gpr_wrboth
13b0:	.630  alu[$xfer_0, --, B, gprA_8]
13b8:	.631  mem[write8_swap, $xfer_0, gprA_2, 0x26, 4], ctx_swap[sig1]
13c0:	.632  mem[read32_swap, $xfer_0, gprA_2, 0xe, 1], ctx_swap[sig1]
13c8:	.633  ld_field_w_clr[gprA_4, 0001, $xfer_0], gpr_wrboth
13d0:	.634  immed[gprA_5, 0x0], gpr_wrboth
13d8:	.635  alu[gprA_4, gprA_4, OR, 0xf0], gpr_wrboth
13e0:	.636  alu[$xfer_0, --, B, gprA_4]
13e8:	.637  mem[write8_swap, $xfer_0, gprA_2, 0xe, 1], ctx_swap[sig1]
13f0:	.638  immed[gprA_0, 0x2], gpr_wrboth
13f8:	.639  immed[gprA_1, 0x0], gpr_wrboth
1400:	.640  br[.99]
1408:	.641  br[.15000], defer[2]
1410:	.642  alu[gprA_0, --, B, 0x0]
1418:	.643  ld_field[gprA_0, 1100, 0x82, <<16]
1420:	.644  alu[--, 0x3, -, gprB_0]
1428:	.645  bcc[.641]
1430:	.646  immed[gprB_2, 0x2282]
1438:	.647  immed_w1[gprB_2, 0x4411]
1440:	.648  alu_shf[gprA_1, --, B, gprB_0, <<3]
1448:	.649  alu[--, gprA_1, OR, 0x0]
1450:	.650  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
1458:	.651  br[.15000], defer[2]
1460:	.652  alu[gprA_0, --, B, 0x0]
1468:	.653  ld_field[gprA_0, 1100, gprB_2, <<16]
1470:	.654  nop
1478:	.655  nop
1480:	.656  nop
1488:	.657  nop
1490:	.658  nop
1498:	.659  nop
14a0:	.660  nop
14a8:	.661  nop
