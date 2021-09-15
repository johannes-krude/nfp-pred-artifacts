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
  60:	 .12  bcc[.152]
  68:	 .13  mem[read32_swap, $xfer_0, gprA_2, 0xc, 6], ctx_swap[sig1]
  70:	 .14  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
  78:	 .15  immed[gprA_9, 0x0], gpr_wrboth
  80:	 .16  ld_field_w_clr[gprA_10, 0001, $xfer_0, >>8], gpr_wrboth
  88:	 .17  immed[gprA_11, 0x0], gpr_wrboth
  90:	 .18  dbl_shf[gprA_11, gprA_11, gprB_10, >>24], gpr_wrboth
  98:	 .19  alu_shf[gprA_10, --, B, gprB_10, <<8], gpr_wrboth
  a0:	 .20  alu[gprA_10, gprA_10, OR, gprB_8], gpr_wrboth
  a8:	 .21  alu[gprA_11, gprA_11, OR, gprB_9], gpr_wrboth
  b0:	 .22  immed[gprA_0, 0x1], gpr_wrboth
  b8:	 .23  immed[gprA_1, 0x0], gpr_wrboth
  c0:	 .24  alu[--, gprA_10, XOR, 0x8]
  c8:	 .25  bne[.384]
  d0:	 .26  alu[--, gprA_11, XOR, 0x0]
  d8:	 .27  bne[.384]
  e0:	 .28  alu[gprA_8, --, B, gprB_2], gpr_wrboth
  e8:	 .29  alu[gprA_9, --, B, gprB_3], gpr_wrboth
  f0:	 .30  alu[gprA_8, gprA_8, +, 0x22], gpr_wrboth
  f8:	 .31  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 100:	 .32  alu[--, gprA_4, -, gprB_8]
 108:	 .33  alu[--, gprA_5, -carry, gprB_9]
 110:	 .34  bcc[.152]
 118:	 .35  ld_field_w_clr[gprA_8, 0011, $xfer_4, >>16], gpr_wrboth
 120:	 .36  ld_field[gprA_8, 1100, $xfer_5, <<16], gpr_wrboth
 128:	 .37  immed[gprA_9, 0x0], gpr_wrboth
 130:	 .38  immed[gprB_21, 0x201]
 138:	 .39  immed_w1[gprB_21, 0x403]
 140:	 .40  alu[--, gprA_8, XOR, gprB_21]
 148:	 .41  bne[.384]
 150:	 .42  alu[--, gprA_9, XOR, 0x0]
 158:	 .43  bne[.384]
 160:	 .44  mem[read32_swap, $xfer_0, gprA_6, 0x0, 1], ctx_swap[sig1]
 168:	 .45  ld_field_w_clr[gprA_6, 0001, $xfer_0], gpr_wrboth
 170:	 .46  immed[gprA_7, 0x0], gpr_wrboth
 178:	 .47  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 180:	 .48  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 188:	 .49  alu[gprA_8, gprA_8, AND, 0xf0], gpr_wrboth
 190:	 .50  immed[gprA_9, 0x0], gpr_wrboth
 198:	 .51  alu[--, gprA_8, XOR, 0x40]
 1a0:	 .52  bne[.384]
 1a8:	 .53  alu[--, gprA_9, XOR, 0x0]
 1b0:	 .54  bne[.384]
 1b8:	 .55  alu[gprA_6, gprA_6, AND, 0xf], gpr_wrboth
 1c0:	 .56  immed[gprA_7, 0x0], gpr_wrboth
 1c8:	 .57  alu[--, gprA_6, XOR, 0x5]
 1d0:	 .58  bne[.152]
 1d8:	 .59  alu[--, gprA_7, XOR, 0x0]
 1e0:	 .60  bne[.152]
 1e8:	 .61  immed[--, 0xe80]
 1f0:	 .62  mem[read32_swap, $xfer_0, gprA_2, 0x10, 7], indirect_ref, ctx_swap[sig1]
 1f8:	 .63  ld_field_w_clr[gprA_6, 0001, $xfer_1, >>16], gpr_wrboth
 200:	 .64  immed[gprA_7, 0x0], gpr_wrboth
 208:	 .65  alu[gprA_6, gprA_6, -, 0x1e], gpr_wrboth
 210:	 .66  alu[gprA_7, gprA_7, -carry, 0x0], gpr_wrboth
 218:	 .67  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
 220:	 .68  immed[gprA_7, 0x0], gpr_wrboth
 228:	 .69  alu[--, 0x22, -, gprA_6]
 230:	 .70  alu[--, 0x0, -carry, gprA_7]
 238:	 .71  bcc[.152]
 240:	 .72  ld_field_w_clr[gprA_6, 0011, $xfer_1], gpr_wrboth
 248:	 .73  immed[gprA_7, 0x0], gpr_wrboth
 250:	 .74  immed[gprB_21, 0x2000]
 258:	 .75  alu[gprA_6, gprA_6, AND, gprB_21], gpr_wrboth
 260:	 .76  immed[gprA_7, 0x0], gpr_wrboth
 268:	 .77  alu[--, gprA_6, OR, gprB_7]
 270:	 .78  bne[.152]
 278:	 .79  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 280:	 .80  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 288:	 .81  alu[gprA_6, gprA_6, +, 0x36], gpr_wrboth
 290:	 .82  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 298:	 .83  alu[--, gprA_4, -, gprB_6]
 2a0:	 .84  alu[--, gprA_5, -carry, gprB_7]
 2a8:	 .85  bcc[.152]
 2b0:	 .86  ld_field_w_clr[gprA_8, 0011, $xfer_5], gpr_wrboth
 2b8:	 .87  immed[gprA_9, 0x0], gpr_wrboth
 2c0:	 .88  immed[gprB_21, 0xd204]
 2c8:	 .89  alu[--, gprA_8, XOR, gprB_21]
 2d0:	 .90  bne[.384]
 2d8:	 .91  alu[--, gprA_9, XOR, 0x0]
 2e0:	 .92  bne[.384]
 2e8:	 .93  ld_field_w_clr[gprA_8, 0011, $xfer_7, >>16], gpr_wrboth
 2f0:	 .94  immed[gprA_9, 0x0], gpr_wrboth
 2f8:	 .95  alu[gprA_8, gprA_8, AND, 0xf0], gpr_wrboth
 300:	 .96  immed[gprA_9, 0x0], gpr_wrboth
 308:	 .97  alu[--, gprA_8, XOR, 0xa0]
 310:	 .98  bne[.152]
 318:	 .99  alu[--, gprA_9, XOR, 0x0]
 320:	.100  bne[.152]
 328:	.101  alu[gprA_8, --, B, gprB_2], gpr_wrboth
 330:	.102  alu[gprA_9, --, B, gprB_3], gpr_wrboth
 338:	.103  alu[gprA_8, gprA_8, +, 0x4a], gpr_wrboth
 340:	.104  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 348:	.105  alu[--, gprA_4, -, gprB_8]
 350:	.106  alu[--, gprA_5, -carry, gprB_9]
 358:	.107  bcc[.152]
 360:	.108  ld_field_w_clr[gprA_8, 0011, $xfer_0], gpr_wrboth
 368:	.109  immed[gprA_9, 0x0], gpr_wrboth
 370:	.110  immed[gprB_21, 0x3c00]
 378:	.111  alu[--, gprA_8, XOR, gprB_21]
 380:	.112  bne[.152]
 388:	.113  alu[--, gprA_9, XOR, 0x0]
 390:	.114  bne[.152]
 398:	.115  ld_field_w_clr[gprA_8, 0001, $xfer_14, >>8], gpr_wrboth
 3a0:	.116  immed[gprA_9, 0x0], gpr_wrboth
 3a8:	.117  alu[--, gprA_8, XOR, 0x6]
 3b0:	.118  bne[.152]
 3b8:	.119  alu[--, gprA_9, XOR, 0x0]
 3c0:	.120  bne[.152]
 3c8:	.121  mem[read32_swap, $xfer_0, gprA_6, 0x0, 1], ctx_swap[sig1]
 3d0:	.122  ld_field_w_clr[gprA_6, 0001, $xfer_0], gpr_wrboth
 3d8:	.123  immed[gprA_7, 0x0], gpr_wrboth
 3e0:	.124  alu[--, gprA_6, XOR, 0x2]
 3e8:	.125  bne[.152]
 3f0:	.126  alu[--, gprA_7, XOR, 0x0]
 3f8:	.127  bne[.152]
 400:	.128  mem[read32_swap, $xfer_0, gprA_2, 0x3a, 4], ctx_swap[sig1]
 408:	.129  ld_field_w_clr[gprA_6, 0001, $xfer_0], gpr_wrboth
 410:	.130  immed[gprA_7, 0x0], gpr_wrboth
 418:	.131  alu[--, gprA_6, XOR, 0x4]
 420:	.132  bne[.152]
 428:	.133  alu[--, gprA_7, XOR, 0x0]
 430:	.134  bne[.152]
 438:	.135  ld_field_w_clr[gprA_6, 0001, $xfer_0, >>16], gpr_wrboth
 440:	.136  immed[gprA_7, 0x0], gpr_wrboth
 448:	.137  alu[--, gprA_6, XOR, 0x8]
 450:	.138  bne[.152]
 458:	.139  alu[--, gprA_7, XOR, 0x0]
 460:	.140  bne[.152]
 468:	.141  ld_field_w_clr[gprA_6, 0001, $xfer_3], gpr_wrboth
 470:	.142  immed[gprA_7, 0x0], gpr_wrboth
 478:	.143  alu[--, gprA_6, XOR, 0x1]
 480:	.144  bne[.152]
 488:	.145  alu[--, gprA_7, XOR, 0x0]
 490:	.146  bne[.152]
 498:	.147  ld_field_w_clr[gprA_6, 0001, $xfer_3, >>8], gpr_wrboth
 4a0:	.148  immed[gprA_7, 0x0], gpr_wrboth
 4a8:	.149  alu[gprA_21, gprA_6, XOR, 0x3]
 4b0:	.150  alu[--, gprA_21, OR, gprB_7]
 4b8:	.151  beq[.384]
 4c0:	.152  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 4c8:	.153  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 4d0:	.154  alu[gprA_6, gprA_6, +, 0xf], gpr_wrboth
 4d8:	.155  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 4e0:	.156  immed[gprA_0, 0x2], gpr_wrboth
 4e8:	.157  immed[gprA_1, 0x0], gpr_wrboth
 4f0:	.158  alu[--, gprA_4, -, gprB_6]
 4f8:	.159  alu[--, gprA_5, -carry, gprB_7]
 500:	.160  bcc[.384]
 508:	.161  mem[read32_swap, $xfer_0, gprA_2, 0xe, 1], ctx_swap[sig1]
 510:	.162  ld_field_w_clr[gprA_6, 0001, $xfer_0], gpr_wrboth
 518:	.163  immed[gprA_7, 0x0], gpr_wrboth
 520:	.164  dbl_shf[gprA_7, gprA_7, gprB_6, >>30], gpr_wrboth
 528:	.165  alu_shf[gprA_6, --, B, gprB_6, <<2], gpr_wrboth
 530:	.166  alu[gprA_6, gprA_6, AND, 0x3c], gpr_wrboth
 538:	.167  immed[gprA_7, 0x0], gpr_wrboth
 540:	.168  alu[gprA_10, --, B, gprB_6], gpr_wrboth
 548:	.169  alu[gprA_11, --, B, gprB_7], gpr_wrboth
 550:	.170  alu[gprA_10, gprA_10, +, 0x22], gpr_wrboth
 558:	.171  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 560:	.172  alu[gprA_8, --, B, gprB_2], gpr_wrboth
 568:	.173  alu[gprA_9, --, B, gprB_3], gpr_wrboth
 570:	.174  alu[gprA_8, gprA_8, +, gprB_10], gpr_wrboth
 578:	.175  alu[gprA_9, gprA_9, +carry, gprB_11], gpr_wrboth
 580:	.176  alu[gprA_0, --, B, gprB_8], gpr_wrboth
 588:	.177  alu[gprA_1, --, B, gprB_9], gpr_wrboth
 590:	.178  alu[gprA_0, gprA_0, +, 0x1], gpr_wrboth
 598:	.179  alu[gprA_1, gprA_1, +carry, 0x0], gpr_wrboth
 5a0:	.180  alu[--, gprA_4, -, gprB_0]
 5a8:	.181  alu[--, gprA_5, -carry, gprB_1]
 5b0:	.182  bcc[.282]
 5b8:	.183  mem[read32_swap, $xfer_0, gprA_8, 0x0, 1], ctx_swap[sig1]
 5c0:	.184  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 5c8:	.185  immed[gprA_9, 0x0], gpr_wrboth
 5d0:	.186  alu[gprA_10, gprA_10, OR, 0x1], gpr_wrboth
 5d8:	.187  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
 5e0:	.188  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
 5e8:	.189  alu[gprA_8, --, B, gprB_2], gpr_wrboth
 5f0:	.190  alu[gprA_9, --, B, gprB_3], gpr_wrboth
 5f8:	.191  alu[gprA_8, gprA_8, +, gprB_10], gpr_wrboth
 600:	.192  alu[gprA_9, gprA_9, +carry, gprB_11], gpr_wrboth
 608:	.193  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 610:	.194  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 618:	.195  alu[gprA_10, gprA_10, +, 0x4], gpr_wrboth
 620:	.196  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 628:	.197  alu[--, gprA_4, -, gprB_10]
 630:	.198  alu[--, gprA_5, -carry, gprB_11]
 638:	.199  bcc[.282]
 640:	.200  alu[gprA_0, --, B, gprB_10], gpr_wrboth
 648:	.201  alu[gprA_1, --, B, gprB_11], gpr_wrboth
 650:	.202  alu[gprA_0, gprA_0, +, 0x4], gpr_wrboth
 658:	.203  alu[gprA_1, gprA_1, +carry, 0x0], gpr_wrboth
 660:	.204  alu[--, gprA_4, -, gprB_0]
 668:	.205  alu[--, gprA_5, -carry, gprB_1]
 670:	.206  bcc[.282]
 678:	.207  mem[read32_swap, $xfer_0, gprA_8, 0x0, 1], ctx_swap[sig1]
 680:	.208  alu[gprA_0, --, B, $xfer_0], gpr_wrboth
 688:	.209  immed[gprA_1, 0x0], gpr_wrboth
 690:	.210  immed[gprB_21, 0x2020]
 698:	.211  immed_w1[gprB_21, 0x20]
 6a0:	.212  alu[gprA_0, gprA_0, OR, gprB_21], gpr_wrboth
 6a8:	.213  alu[gprA_1, --, B, gprB_0], gpr_wrboth
 6b0:	.214  immed[gprA_0, 0x0], gpr_wrboth
 6b8:	.215  alu[gprA_0, --, B, gprB_1], gpr_wrboth
 6c0:	.216  immed[gprA_1, 0x0], gpr_wrboth
 6c8:	.217  immed[gprB_21, 0x7861]
 6d0:	.218  immed_w1[gprB_21, 0x765]
 6d8:	.219  alu[--, gprA_0, XOR, gprB_21]
 6e0:	.220  bne[.282]
 6e8:	.221  alu[--, gprA_1, XOR, 0x0]
 6f0:	.222  bne[.282]
 6f8:	.223  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 700:	.224  alu[gprA_10, --, B, $xfer_0], gpr_wrboth
 708:	.225  immed[gprA_11, 0x0], gpr_wrboth
 710:	.226  immed[gprB_21, 0x2020]
 718:	.227  immed_w1[gprB_21, 0x2020]
 720:	.228  alu[gprA_10, gprA_10, OR, gprB_21], gpr_wrboth
 728:	.229  alu[gprA_11, --, B, gprB_10], gpr_wrboth
 730:	.230  immed[gprA_10, 0x0], gpr_wrboth
 738:	.231  alu[gprA_10, --, B, gprB_11], gpr_wrboth
 740:	.232  immed[gprA_11, 0x0], gpr_wrboth
 748:	.233  immed[gprB_21, 0x6c65]
 750:	.234  immed_w1[gprB_21, 0x6d70]
 758:	.235  alu[--, gprA_10, XOR, gprB_21]
 760:	.236  bne[.282]
 768:	.237  alu[--, gprA_11, XOR, 0x0]
 770:	.238  bne[.282]
 778:	.239  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 780:	.240  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 788:	.241  alu[gprA_10, gprA_10, +, 0xc], gpr_wrboth
 790:	.242  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 798:	.243  alu[--, gprA_4, -, gprB_10]
 7a0:	.244  alu[--, gprA_5, -carry, gprB_11]
 7a8:	.245  bcc[.282]
 7b0:	.246  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 7b8:	.247  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 7c0:	.248  alu[gprA_10, gprA_10, +, 0x8], gpr_wrboth
 7c8:	.249  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 7d0:	.250  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 7d8:	.251  alu[gprA_10, --, B, $xfer_0], gpr_wrboth
 7e0:	.252  immed[gprA_11, 0x0], gpr_wrboth
 7e8:	.253  immed[gprB_21, 0x2020]
 7f0:	.254  immed_w1[gprB_21, 0x20]
 7f8:	.255  alu[gprA_10, gprA_10, OR, gprB_21], gpr_wrboth
 800:	.256  alu[gprA_11, --, B, gprB_10], gpr_wrboth
 808:	.257  immed[gprA_10, 0x0], gpr_wrboth
 810:	.258  alu[gprA_10, --, B, gprB_11], gpr_wrboth
 818:	.259  immed[gprA_11, 0x0], gpr_wrboth
 820:	.260  immed[gprB_21, 0x696d]
 828:	.261  immed_w1[gprB_21, 0x363]
 830:	.262  alu[--, gprA_10, XOR, gprB_21]
 838:	.263  bne[.282]
 840:	.264  alu[--, gprA_11, XOR, 0x0]
 848:	.265  bne[.282]
 850:	.266  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 858:	.267  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 860:	.268  alu[gprA_10, gprA_10, +, 0xd], gpr_wrboth
 868:	.269  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 870:	.270  alu[--, gprA_4, -, gprB_10]
 878:	.271  alu[--, gprA_5, -carry, gprB_11]
 880:	.272  bcc[.282]
 888:	.273  alu[gprA_8, gprA_8, +, 0xc], gpr_wrboth
 890:	.274  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 898:	.275  immed[gprA_0, 0x1], gpr_wrboth
 8a0:	.276  immed[gprA_1, 0x0], gpr_wrboth
 8a8:	.277  mem[read32_swap, $xfer_0, gprA_8, 0x0, 1], ctx_swap[sig1]
 8b0:	.278  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 8b8:	.279  immed[gprA_9, 0x0], gpr_wrboth
 8c0:	.280  alu[--, gprA_8, OR, gprB_9]
 8c8:	.281  beq[.384]
 8d0:	.282  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 8d8:	.283  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 8e0:	.284  alu[gprA_8, gprA_8, +, gprB_2], gpr_wrboth
 8e8:	.285  alu[gprA_9, gprA_9, +carry, gprB_3], gpr_wrboth
 8f0:	.286  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 8f8:	.287  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 900:	.288  alu[gprA_10, gprA_10, +, 0x12], gpr_wrboth
 908:	.289  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 910:	.290  immed[gprA_0, 0x2], gpr_wrboth
 918:	.291  immed[gprA_1, 0x0], gpr_wrboth
 920:	.292  alu[--, gprA_4, -, gprB_10]
 928:	.293  alu[--, gprA_5, -carry, gprB_11]
 930:	.294  bcc[.384]
 938:	.295  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 940:	.296  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 948:	.297  alu[gprA_10, gprA_10, +, 0x10], gpr_wrboth
 950:	.298  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 958:	.299  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 960:	.300  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
 968:	.301  immed[gprA_11, 0x0], gpr_wrboth
 970:	.302  immed[gprA_0, 0x2], gpr_wrboth
 978:	.303  immed[gprA_1, 0x0], gpr_wrboth
 980:	.304  immed[gprB_21, 0x3500]
 988:	.305  alu[--, gprA_10, XOR, gprB_21]
 990:	.306  bne[.384]
 998:	.307  alu[--, gprA_11, XOR, 0x0]
 9a0:	.308  bne[.384]
 9a8:	.309  alu[gprA_8, gprA_8, +, 0xe], gpr_wrboth
 9b0:	.310  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 9b8:	.311  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 9c0:	.312  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 9c8:	.313  alu[gprA_10, gprA_10, +, 0x6], gpr_wrboth
 9d0:	.314  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 9d8:	.315  immed[gprA_0, 0x2], gpr_wrboth
 9e0:	.316  immed[gprA_1, 0x0], gpr_wrboth
 9e8:	.317  alu[--, gprA_4, -, gprB_10]
 9f0:	.318  alu[--, gprA_5, -carry, gprB_11]
 9f8:	.319  bcc[.384]
 a00:	.320  alu[gprA_8, gprA_8, +, 0x4], gpr_wrboth
 a08:	.321  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 a10:	.322  mem[read32_swap, $xfer_0, gprA_8, 0x0, 1], ctx_swap[sig1]
 a18:	.323  ld_field_w_clr[gprA_8, 0011, $xfer_0], gpr_wrboth
 a20:	.324  immed[gprA_9, 0x0], gpr_wrboth
 a28:	.325  immed[gprA_10, 0x1d], gpr_wrboth
 a30:	.326  immed[gprA_11, 0x0], gpr_wrboth
 a38:	.327  alu[--, gprA_8, -, gprB_10]
 a40:	.328  alu[--, gprA_9, -carry, gprB_11]
 a48:	.329  bcc[.382]
 a50:	.330  alu[gprA_6, gprA_6, +, gprB_2], gpr_wrboth
 a58:	.331  alu[gprA_7, gprA_7, +carry, gprB_3], gpr_wrboth
 a60:	.332  alu[gprA_2, --, B, gprB_6], gpr_wrboth
 a68:	.333  alu[gprA_3, --, B, gprB_7], gpr_wrboth
 a70:	.334  alu[gprA_2, gprA_2, +, 0x1a], gpr_wrboth
 a78:	.335  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
 a80:	.336  immed[gprA_0, 0x2], gpr_wrboth
 a88:	.337  immed[gprA_1, 0x0], gpr_wrboth
 a90:	.338  alu[--, gprA_4, -, gprB_2]
 a98:	.339  alu[--, gprA_5, -carry, gprB_3]
 aa0:	.340  bcc[.384]
 aa8:	.341  alu[gprA_2, --, B, gprB_6], gpr_wrboth
 ab0:	.342  alu[gprA_3, --, B, gprB_7], gpr_wrboth
 ab8:	.343  alu[gprA_2, gprA_2, +, 0x18], gpr_wrboth
 ac0:	.344  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
 ac8:	.345  mem[read32_swap, $xfer_0, gprA_2, 0x0, 1], ctx_swap[sig1]
 ad0:	.346  ld_field_w_clr[gprA_2, 0011, $xfer_0], gpr_wrboth
 ad8:	.347  immed[gprA_3, 0x0], gpr_wrboth
 ae0:	.348  immed[gprB_21, 0xfc8f]
 ae8:	.349  alu[gprA_2, gprA_2, AND, gprB_21], gpr_wrboth
 af0:	.350  immed[gprA_3, 0x0], gpr_wrboth
 af8:	.351  alu[--, gprA_2, OR, gprB_3]
 b00:	.352  bne[.382]
 b08:	.353  alu[gprA_6, gprA_6, +, 0x16], gpr_wrboth
 b10:	.354  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 b18:	.355  alu[gprA_2, --, B, gprB_6], gpr_wrboth
 b20:	.356  alu[gprA_3, --, B, gprB_7], gpr_wrboth
 b28:	.357  alu[gprA_2, gprA_2, +, 0x6], gpr_wrboth
 b30:	.358  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
 b38:	.359  immed[gprA_0, 0x2], gpr_wrboth
 b40:	.360  immed[gprA_1, 0x0], gpr_wrboth
 b48:	.361  alu[--, gprA_4, -, gprB_2]
 b50:	.362  alu[--, gprA_5, -carry, gprB_3]
 b58:	.363  bcc[.384]
 b60:	.364  alu[gprA_2, --, B, gprB_6], gpr_wrboth
 b68:	.365  alu[gprA_3, --, B, gprB_7], gpr_wrboth
 b70:	.366  alu[gprA_2, gprA_2, +, 0x4], gpr_wrboth
 b78:	.367  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
 b80:	.368  mem[read32_swap, $xfer_0, gprA_2, 0x0, 1], ctx_swap[sig1]
 b88:	.369  ld_field_w_clr[gprA_2, 0011, $xfer_0], gpr_wrboth
 b90:	.370  immed[gprA_3, 0x0], gpr_wrboth
 b98:	.371  alu[--, gprA_2, XOR, 0x1]
 ba0:	.372  bne[.382]
 ba8:	.373  alu[--, gprA_3, XOR, 0x0]
 bb0:	.374  bne[.382]
 bb8:	.375  alu[gprA_6, gprA_6, +, 0x8], gpr_wrboth
 bc0:	.376  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 bc8:	.377  immed[gprA_0, 0x2], gpr_wrboth
 bd0:	.378  immed[gprA_1, 0x0], gpr_wrboth
 bd8:	.379  alu[--, gprA_4, -, gprB_6]
 be0:	.380  alu[--, gprA_5, -carry, gprB_7]
 be8:	.381  bcc[.384]
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
