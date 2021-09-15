   0:	   .0  immed[gprB_22, 0x3fff]
   8:	   .1  alu[gprB_22, gprB_22, AND, *l$index1]
  10:	   .2  immed[gprA_0, 0x0], gpr_wrboth
  18:	   .3  immed[gprA_1, 0x0], gpr_wrboth
  20:	   .4  alu[gprA_4, gprB_22, +, *l$index1[2]], gpr_wrboth
  28:	   .5  immed[gprA_5, 0x0], gpr_wrboth
  30:	   .6  alu[gprA_2, --, B, *l$index1[2]], gpr_wrboth
  38:	   .7  immed[gprA_3, 0x0], gpr_wrboth
  40:	   .8  alu[gprA_10, --, B, gprB_2], gpr_wrboth
  48:	   .9  alu[gprA_11, --, B, gprB_3], gpr_wrboth
  50:	  .10  alu[gprA_10, gprA_10, +, 0xe], gpr_wrboth
  58:	  .11  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
  60:	  .12  alu[--, gprA_4, -, gprB_10]
  68:	  .13  alu[--, gprA_5, -carry, gprB_11]
  70:	  .14  bcc[.1512]
  78:	  .15  mem[read32_swap, $xfer_0, gprA_2, 0xc, 1], ctx_swap[sig1]
  80:	  .16  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
  88:	  .17  immed[gprA_7, 0x0], gpr_wrboth
  90:	  .18  alu[gprA_8, --, B, gprB_6], gpr_wrboth
  98:	  .19  alu[gprA_9, --, B, gprB_7], gpr_wrboth
  a0:	  .20  alu[gprA_21, --, B, gprB_9]
  a8:	  .21  ld_field[gprB_9, 1111, gprA_8, >>rot8], gpr_wrboth
  b0:	  .22  ld_field[gprB_9, 0101, gprA_9, >>rot16], gpr_wrboth
  b8:	  .23  ld_field[gprB_8, 1111, gprA_21, >>rot8], gpr_wrboth
  c0:	  .24  ld_field[gprB_8, 0101, gprA_8, >>rot16], gpr_wrboth
  c8:	  .25  alu_shf[gprA_8, --, B, gprB_9, >>24], gpr_wrboth
  d0:	  .26  immed[gprA_9, 0x0], gpr_wrboth
  d8:	  .27  immed[gprA_0, 0x6], gpr_wrboth
  e0:	  .28  immed[gprA_1, 0x0], gpr_wrboth
  e8:	  .29  alu[--, gprA_8, -, gprB_0]
  f0:	  .30  alu[--, gprA_9, -carry, gprB_1]
  f8:	  .31  bcc[.532]
 100:	  .32  ld_field[gprA_6, 1001, gprB_6, >>rot8], gpr_wrboth
 108:	  .33  ld_field[gprB_6, 1110, gprA_6, >>16], gpr_wrboth
 110:	  .34  immed[gprA_7, 0x0], gpr_wrboth
 118:	  .35  immed[gprA_8, 0x70], gpr_wrboth
 120:	  .36  immed[gprA_9, 0x0], gpr_wrboth
 128:	  .37  immed[gprB_21, 0x86dc]
 130:	  .38  alu[--, gprB_21, -, gprA_6]
 138:	  .39  alu[--, 0x0, -carry, gprA_7]
 140:	  .40  blt[.145]
 148:	  .41  immed[gprB_21, 0x800]
 150:	  .42  alu[gprA_21, gprA_6, XOR, gprB_21]
 158:	  .43  alu[--, gprA_21, OR, gprB_7]
 160:	  .44  beq[.743]
 168:	  .45  immed[gprB_21, 0x806]
 170:	  .46  alu[gprA_21, gprA_6, XOR, gprB_21]
 178:	  .47  alu[--, gprA_21, OR, gprB_7]
 180:	  .48  beq[.101]
 188:	  .49  immed[gprB_21, 0x8100]
 190:	  .50  alu[gprA_21, gprA_6, XOR, gprB_21]
 198:	  .51  alu[--, gprA_21, OR, gprB_7]
 1a0:	  .52  beq[.54]
 1a8:	  .53  br[.1510]
 1b0:	  .54  alu[gprA_6, --, B, gprB_8], gpr_wrboth
 1b8:	  .55  alu[gprA_7, --, B, gprB_9], gpr_wrboth
 1c0:	  .56  alu[gprA_6, gprA_6, +, 0x20], gpr_wrboth
 1c8:	  .57  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 1d0:	  .58  alu[gprA_10, --, B, gprB_6], gpr_wrboth
 1d8:	  .59  alu[gprA_11, --, B, gprB_7], gpr_wrboth
 1e0:	  .60  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
 1e8:	  .61  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
 1f0:	  .62  alu[gprA_12, --, B, gprB_2], gpr_wrboth
 1f8:	  .63  alu[gprA_13, --, B, gprB_3], gpr_wrboth
 200:	  .64  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
 208:	  .65  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
 210:	  .66  immed[gprA_0, 0x0], gpr_wrboth
 218:	  .67  immed[gprA_1, 0x0], gpr_wrboth
 220:	  .68  alu[--, gprA_4, -, gprB_12]
 228:	  .69  alu[--, gprA_5, -carry, gprB_13]
 230:	  .70  bcc[.1512]
 238:	  .71  alu[gprA_8, gprA_8, +, 0x10], gpr_wrboth
 240:	  .72  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 248:	  .73  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
 250:	  .74  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
 258:	  .75  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 260:	  .76  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 268:	  .77  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
 270:	  .78  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
 278:	  .79  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 280:	  .80  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
 288:	  .81  ld_field[gprA_10, 1001, gprB_10, >>rot8], gpr_wrboth
 290:	  .82  ld_field[gprB_10, 1110, gprA_10, >>16], gpr_wrboth
 298:	  .83  immed[gprA_11, 0x0], gpr_wrboth
 2a0:	  .84  immed[gprB_21, 0x86dc]
 2a8:	  .85  alu[--, gprB_21, -, gprA_10]
 2b0:	  .86  alu[--, 0x0, -carry, gprA_11]
 2b8:	  .87  blt[.389]
 2c0:	  .88  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 2c8:	  .89  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 2d0:	  .90  immed[gprB_21, 0x800]
 2d8:	  .91  alu[gprA_21, gprA_10, XOR, gprB_21]
 2e0:	  .92  alu[--, gprA_21, OR, gprB_11]
 2e8:	  .93  beq[.743]
 2f0:	  .94  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 2f8:	  .95  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 300:	  .96  immed[gprB_21, 0x806]
 308:	  .97  alu[gprA_21, gprA_10, XOR, gprB_21]
 310:	  .98  alu[--, gprA_21, OR, gprB_11]
 318:	  .99  beq[.101]
 320:	 .100  br[.1510]
 328:	 .101  alu[gprA_6, --, B, gprB_8], gpr_wrboth
 330:	 .102  alu[gprA_7, --, B, gprB_9], gpr_wrboth
 338:	 .103  alu[gprA_6, gprA_6, +, 0x40], gpr_wrboth
 340:	 .104  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 348:	 .105  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
 350:	 .106  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
 358:	 .107  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 360:	 .108  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 368:	 .109  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
 370:	 .110  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
 378:	 .111  immed[gprA_0, 0x0], gpr_wrboth
 380:	 .112  immed[gprA_1, 0x0], gpr_wrboth
 388:	 .113  alu[--, gprA_4, -, gprB_10]
 390:	 .114  alu[--, gprA_5, -carry, gprB_11]
 398:	 .115  bcc[.1512]
 3a0:	 .116  alu[gprA_6, --, B, gprB_8], gpr_wrboth
 3a8:	 .117  alu[gprA_7, --, B, gprB_9], gpr_wrboth
 3b0:	 .118  alu[gprA_6, gprA_6, +, 0x10], gpr_wrboth
 3b8:	 .119  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 3c0:	 .120  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
 3c8:	 .121  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
 3d0:	 .122  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 3d8:	 .123  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 3e0:	 .124  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
 3e8:	 .125  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
 3f0:	 .126  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 3f8:	 .127  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
 400:	 .128  immed[gprA_7, 0x0], gpr_wrboth
 408:	 .129  alu[--, gprA_6, XOR, 0x8]
 410:	 .130  bne[.1510]
 418:	 .131  alu[--, gprA_7, XOR, 0x0]
 420:	 .132  bne[.1510]
 428:	 .133  alu[gprA_8, gprA_8, +, 0xe0], gpr_wrboth
 430:	 .134  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 438:	 .135  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
 440:	 .136  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
 448:	 .137  alu[gprA_2, gprA_2, +, gprB_8], gpr_wrboth
 450:	 .138  alu[gprA_3, gprA_3, +carry, gprB_9], gpr_wrboth
 458:	 .139  immed[gprA_0, 0x0], gpr_wrboth
 460:	 .140  immed[gprA_1, 0x0], gpr_wrboth
 468:	 .141  alu[--, gprA_4, -, gprB_2]
 470:	 .142  alu[--, gprA_5, -carry, gprB_3]
 478:	 .143  bcc[.1512]
 480:	 .144  br[.1510]
 488:	 .145  immed[gprB_21, 0x8fff]
 490:	 .146  alu[--, gprB_21, -, gprA_6]
 498:	 .147  alu[--, 0x0, -carry, gprA_7]
 4a0:	 .148  blt[.344]
 4a8:	 .149  immed[gprB_21, 0x86dd]
 4b0:	 .150  alu[gprA_21, gprA_6, XOR, gprB_21]
 4b8:	 .151  alu[--, gprA_21, OR, gprB_7]
 4c0:	 .152  beq[.991]
 4c8:	 .153  immed[gprB_21, 0x8847]
 4d0:	 .154  alu[gprA_21, gprA_6, XOR, gprB_21]
 4d8:	 .155  alu[--, gprA_21, OR, gprB_7]
 4e0:	 .156  beq[.158]
 4e8:	 .157  br[.1510]
 4f0:	 .158  alu[gprA_6, --, B, gprB_8], gpr_wrboth
 4f8:	 .159  alu[gprA_7, --, B, gprB_9], gpr_wrboth
 500:	 .160  alu[gprA_6, gprA_6, +, 0x20], gpr_wrboth
 508:	 .161  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 510:	 .162  alu[gprA_10, --, B, gprB_6], gpr_wrboth
 518:	 .163  alu[gprA_11, --, B, gprB_7], gpr_wrboth
 520:	 .164  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
 528:	 .165  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
 530:	 .166  alu[gprA_12, --, B, gprB_2], gpr_wrboth
 538:	 .167  alu[gprA_13, --, B, gprB_3], gpr_wrboth
 540:	 .168  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
 548:	 .169  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
 550:	 .170  immed[gprA_0, 0x0], gpr_wrboth
 558:	 .171  immed[gprA_1, 0x0], gpr_wrboth
 560:	 .172  alu[--, gprA_4, -, gprB_12]
 568:	 .173  alu[--, gprA_5, -carry, gprB_13]
 570:	 .174  bcc[.1512]
 578:	 .175  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 580:	 .176  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 588:	 .177  alu[gprA_10, gprA_10, +, 0x17], gpr_wrboth
 590:	 .178  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 598:	 .179  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
 5a0:	 .180  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
 5a8:	 .181  alu[gprA_0, --, B, gprB_2], gpr_wrboth
 5b0:	 .182  alu[gprA_1, --, B, gprB_3], gpr_wrboth
 5b8:	 .183  alu[gprA_0, gprA_0, +, gprB_10], gpr_wrboth
 5c0:	 .184  alu[gprA_1, gprA_1, +carry, gprB_11], gpr_wrboth
 5c8:	 .185  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
 5d0:	 .186  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
 5d8:	 .187  immed[gprA_11, 0x0], gpr_wrboth
 5e0:	 .188  alu[gprA_10, gprA_10, AND, 0x1], gpr_wrboth
 5e8:	 .189  immed[gprA_11, 0x0], gpr_wrboth
 5f0:	 .190  alu[--, gprA_10, OR, gprB_11]
 5f8:	 .191  bne[.258]
 600:	 .192  alu[gprA_6, --, B, gprB_8], gpr_wrboth
 608:	 .193  alu[gprA_7, --, B, gprB_9], gpr_wrboth
 610:	 .194  alu[gprA_6, gprA_6, +, 0x40], gpr_wrboth
 618:	 .195  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 620:	 .196  alu[gprA_10, --, B, gprB_6], gpr_wrboth
 628:	 .197  alu[gprA_11, --, B, gprB_7], gpr_wrboth
 630:	 .198  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
 638:	 .199  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
 640:	 .200  alu[gprA_12, --, B, gprB_2], gpr_wrboth
 648:	 .201  alu[gprA_13, --, B, gprB_3], gpr_wrboth
 650:	 .202  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
 658:	 .203  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
 660:	 .204  immed[gprA_0, 0x0], gpr_wrboth
 668:	 .205  immed[gprA_1, 0x0], gpr_wrboth
 670:	 .206  alu[--, gprA_4, -, gprB_12]
 678:	 .207  alu[--, gprA_5, -carry, gprB_13]
 680:	 .208  bcc[.1512]
 688:	 .209  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 690:	 .210  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 698:	 .211  alu[gprA_10, gprA_10, +, 0x37], gpr_wrboth
 6a0:	 .212  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
 6a8:	 .213  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
 6b0:	 .214  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
 6b8:	 .215  alu[gprA_0, --, B, gprB_2], gpr_wrboth
 6c0:	 .216  alu[gprA_1, --, B, gprB_3], gpr_wrboth
 6c8:	 .217  alu[gprA_0, gprA_0, +, gprB_10], gpr_wrboth
 6d0:	 .218  alu[gprA_1, gprA_1, +carry, gprB_11], gpr_wrboth
 6d8:	 .219  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
 6e0:	 .220  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
 6e8:	 .221  immed[gprA_11, 0x0], gpr_wrboth
 6f0:	 .222  alu[gprA_10, gprA_10, AND, 0x1], gpr_wrboth
 6f8:	 .223  immed[gprA_11, 0x0], gpr_wrboth
 700:	 .224  alu[--, gprA_10, OR, gprB_11]
 708:	 .225  bne[.258]
 710:	 .226  alu[gprA_6, --, B, gprB_8], gpr_wrboth
 718:	 .227  alu[gprA_7, --, B, gprB_9], gpr_wrboth
 720:	 .228  alu[gprA_6, gprA_6, +, 0x60], gpr_wrboth
 728:	 .229  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 730:	 .230  alu[gprA_10, --, B, gprB_6], gpr_wrboth
 738:	 .231  alu[gprA_11, --, B, gprB_7], gpr_wrboth
 740:	 .232  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
 748:	 .233  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
 750:	 .234  alu[gprA_12, --, B, gprB_2], gpr_wrboth
 758:	 .235  alu[gprA_13, --, B, gprB_3], gpr_wrboth
 760:	 .236  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
 768:	 .237  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
 770:	 .238  immed[gprA_0, 0x0], gpr_wrboth
 778:	 .239  immed[gprA_1, 0x0], gpr_wrboth
 780:	 .240  alu[--, gprA_4, -, gprB_12]
 788:	 .241  alu[--, gprA_5, -carry, gprB_13]
 790:	 .242  bcc[.1512]
 798:	 .243  alu[gprA_8, gprA_8, +, 0x57], gpr_wrboth
 7a0:	 .244  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 7a8:	 .245  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
 7b0:	 .246  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
 7b8:	 .247  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 7c0:	 .248  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 7c8:	 .249  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
 7d0:	 .250  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
 7d8:	 .251  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 7e0:	 .252  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 7e8:	 .253  immed[gprA_9, 0x0], gpr_wrboth
 7f0:	 .254  alu[gprA_8, gprA_8, AND, 0x1], gpr_wrboth
 7f8:	 .255  immed[gprA_9, 0x0], gpr_wrboth
 800:	 .256  alu[--, gprA_8, OR, gprB_9]
 808:	 .257  beq[.1510]
 810:	 .258  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 818:	 .259  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 820:	 .260  alu[gprA_8, gprA_8, +, 0x8], gpr_wrboth
 828:	 .261  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 830:	 .262  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
 838:	 .263  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
 840:	 .264  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 848:	 .265  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 850:	 .266  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
 858:	 .267  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
 860:	 .268  immed[gprA_0, 0x0], gpr_wrboth
 868:	 .269  immed[gprA_1, 0x0], gpr_wrboth
 870:	 .270  alu[--, gprA_4, -, gprB_10]
 878:	 .271  alu[--, gprA_5, -carry, gprB_11]
 880:	 .272  bcc[.1512]
 888:	 .273  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 890:	 .274  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 898:	 .275  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
 8a0:	 .276  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
 8a8:	 .277  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 8b0:	 .278  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 8b8:	 .279  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
 8c0:	 .280  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
 8c8:	 .281  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 8d0:	 .282  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 8d8:	 .283  immed[gprA_9, 0x0], gpr_wrboth
 8e0:	 .284  alu[gprA_8, gprA_8, AND, 0xf0], gpr_wrboth
 8e8:	 .285  immed[gprA_9, 0x0], gpr_wrboth
 8f0:	 .286  alu[gprA_21, gprA_8, XOR, 0x40]
 8f8:	 .287  alu[--, gprA_21, OR, gprB_9]
 900:	 .288  beq[.1418]
 908:	 .289  alu[gprA_21, gprA_8, XOR, 0x60]
 910:	 .290  alu[--, gprA_21, OR, gprB_9]
 918:	 .291  beq[.293]
 920:	 .292  br[.1375]
 928:	 .293  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 930:	 .294  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 938:	 .295  immed[gprB_21, 0x140]
 940:	 .296  alu[gprA_8, gprA_8, +, gprB_21], gpr_wrboth
 948:	 .297  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 950:	 .298  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 958:	 .299  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 960:	 .300  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
 968:	 .301  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
 970:	 .302  alu[gprA_12, --, B, gprB_2], gpr_wrboth
 978:	 .303  alu[gprA_13, --, B, gprB_3], gpr_wrboth
 980:	 .304  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
 988:	 .305  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
 990:	 .306  immed[gprA_0, 0x0], gpr_wrboth
 998:	 .307  immed[gprA_1, 0x0], gpr_wrboth
 9a0:	 .308  alu[--, gprA_4, -, gprB_12]
 9a8:	 .309  alu[--, gprA_5, -carry, gprB_13]
 9b0:	 .310  bcc[.1512]
 9b8:	 .311  alu[gprA_6, gprA_6, +, 0x30], gpr_wrboth
 9c0:	 .312  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 9c8:	 .313  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
 9d0:	 .314  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
 9d8:	 .315  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 9e0:	 .316  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 9e8:	 .317  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
 9f0:	 .318  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
 9f8:	 .319  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 a00:	 .320  ld_field_w_clr[gprA_6, 0001, $xfer_0], gpr_wrboth
 a08:	 .321  immed[gprA_7, 0x0], gpr_wrboth
 a10:	 .322  alu[gprA_21, gprA_6, XOR, 0x3a]
 a18:	 .323  alu[--, gprA_21, OR, gprB_7]
 a20:	 .324  beq[.1513]
 a28:	 .325  alu[gprA_21, gprA_6, XOR, 0x11]
 a30:	 .326  alu[--, gprA_21, OR, gprB_7]
 a38:	 .327  beq[.1499]
 a40:	 .328  alu[--, gprA_6, XOR, 0x6]
 a48:	 .329  bne[.1510]
 a50:	 .330  alu[--, gprA_7, XOR, 0x0]
 a58:	 .331  bne[.1510]
 a60:	 .332  alu[gprA_8, gprA_8, +, 0xa0], gpr_wrboth
 a68:	 .333  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 a70:	 .334  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
 a78:	 .335  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
 a80:	 .336  alu[gprA_2, gprA_2, +, gprB_8], gpr_wrboth
 a88:	 .337  alu[gprA_3, gprA_3, +carry, gprB_9], gpr_wrboth
 a90:	 .338  immed[gprA_0, 0x0], gpr_wrboth
 a98:	 .339  immed[gprA_1, 0x0], gpr_wrboth
 aa0:	 .340  alu[--, gprA_4, -, gprB_2]
 aa8:	 .341  alu[--, gprA_5, -carry, gprB_3]
 ab0:	 .342  bcc[.1512]
 ab8:	 .343  br[.1510]
 ac0:	 .344  immed[gprB_21, 0x9100]
 ac8:	 .345  alu[gprA_21, gprA_6, XOR, gprB_21]
 ad0:	 .346  alu[--, gprA_21, OR, gprB_7]
 ad8:	 .347  beq[.664]
 ae0:	 .348  immed[gprB_21, 0x9000]
 ae8:	 .349  alu[--, gprA_6, XOR, gprB_21]
 af0:	 .350  bne[.1510]
 af8:	 .351  alu[--, gprA_7, XOR, 0x0]
 b00:	 .352  bne[.1510]
 b08:	 .353  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 b10:	 .354  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 b18:	 .355  alu[gprA_6, gprA_6, +, 0x13], gpr_wrboth
 b20:	 .356  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 b28:	 .357  immed[gprA_0, 0x0], gpr_wrboth
 b30:	 .358  immed[gprA_1, 0x0], gpr_wrboth
 b38:	 .359  alu[--, gprA_4, -, gprB_6]
 b40:	 .360  alu[--, gprA_5, -carry, gprB_7]
 b48:	 .361  bcc[.1512]
 b50:	 .362  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 b58:	 .363  ld_field_w_clr[gprA_6, 0001, $xfer_0], gpr_wrboth
 b60:	 .364  immed[gprA_7, 0x0], gpr_wrboth
 b68:	 .365  dbl_shf[gprA_6, gprA_7, gprB_6, >>5], gpr_wrboth
 b70:	 .366  alu_shf[gprA_7, --, B, gprB_7, >>5], gpr_wrboth
 b78:	 .367  alu[--, 0x2, -, gprA_6]
 b80:	 .368  alu[--, 0x0, -carry, gprA_7]
 b88:	 .369  blt[.402]
 b90:	 .370  alu[gprA_21, gprA_6, XOR, 0x1]
 b98:	 .371  alu[--, gprA_21, OR, gprB_7]
 ba0:	 .372  beq[.452]
 ba8:	 .373  alu[gprA_21, gprA_6, XOR, 0x2]
 bb0:	 .374  alu[--, gprA_21, OR, gprB_7]
 bb8:	 .375  beq[.377]
 bc0:	 .376  br[.1510]
 bc8:	 .377  immed[gprA_6, 0xd0], gpr_wrboth
 bd0:	 .378  immed[gprA_7, 0x0], gpr_wrboth
 bd8:	 .379  alu[gprA_8, --, B, gprB_2], gpr_wrboth
 be0:	 .380  alu[gprA_9, --, B, gprB_3], gpr_wrboth
 be8:	 .381  alu[gprA_8, gprA_8, +, 0x1a], gpr_wrboth
 bf0:	 .382  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 bf8:	 .383  immed[gprA_0, 0x0], gpr_wrboth
 c00:	 .384  immed[gprA_1, 0x0], gpr_wrboth
 c08:	 .385  alu[--, gprA_4, -, gprB_8]
 c10:	 .386  alu[--, gprA_5, -carry, gprB_9]
 c18:	 .387  bcc[.1512]
 c20:	 .388  br[.463]
 c28:	 .389  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 c30:	 .390  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 c38:	 .391  immed[gprB_21, 0x86dd]
 c40:	 .392  alu[gprA_21, gprA_10, XOR, gprB_21]
 c48:	 .393  alu[--, gprA_21, OR, gprB_11]
 c50:	 .394  beq[.991]
 c58:	 .395  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 c60:	 .396  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 c68:	 .397  immed[gprB_21, 0x8847]
 c70:	 .398  alu[gprA_21, gprA_10, XOR, gprB_21]
 c78:	 .399  alu[--, gprA_21, OR, gprB_11]
 c80:	 .400  beq[.158]
 c88:	 .401  br[.1510]
 c90:	 .402  alu[gprA_21, gprA_6, XOR, 0x3]
 c98:	 .403  alu[--, gprA_21, OR, gprB_7]
 ca0:	 .404  beq[.440]
 ca8:	 .405  alu[--, gprA_6, XOR, 0x5]
 cb0:	 .406  bne[.1510]
 cb8:	 .407  alu[--, gprA_7, XOR, 0x0]
 cc0:	 .408  bne[.1510]
 cc8:	 .409  alu[gprA_6, --, B, gprB_2], gpr_wrboth
 cd0:	 .410  alu[gprA_7, --, B, gprB_3], gpr_wrboth
 cd8:	 .411  alu[gprA_6, gprA_6, +, 0x1c], gpr_wrboth
 ce0:	 .412  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 ce8:	 .413  immed[gprA_0, 0x0], gpr_wrboth
 cf0:	 .414  immed[gprA_1, 0x0], gpr_wrboth
 cf8:	 .415  alu[--, gprA_4, -, gprB_6]
 d00:	 .416  alu[--, gprA_5, -carry, gprB_7]
 d08:	 .417  bcc[.1512]
 d10:	 .418  immed[gprA_6, 0xe0], gpr_wrboth
 d18:	 .419  immed[gprA_7, 0x0], gpr_wrboth
 d20:	 .420  mem[read32_swap, $xfer_0, gprA_2, 0x1a, 1], ctx_swap[sig1]
 d28:	 .421  ld_field_w_clr[gprA_8, 0011, $xfer_0], gpr_wrboth
 d30:	 .422  immed[gprA_9, 0x0], gpr_wrboth
 d38:	 .423  immed[gprB_21, 0x400]
 d40:	 .424  alu[gprA_21, gprA_8, XOR, gprB_21]
 d48:	 .425  alu[--, gprA_21, OR, gprB_9]
 d50:	 .426  beq[.428]
 d58:	 .427  br[.463]
 d60:	 .428  immed[gprA_6, 0xf0], gpr_wrboth
 d68:	 .429  immed[gprA_7, 0x0], gpr_wrboth
 d70:	 .430  alu[gprA_8, --, B, gprB_2], gpr_wrboth
 d78:	 .431  alu[gprA_9, --, B, gprB_3], gpr_wrboth
 d80:	 .432  alu[gprA_8, gprA_8, +, 0x1e], gpr_wrboth
 d88:	 .433  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 d90:	 .434  immed[gprA_0, 0x0], gpr_wrboth
 d98:	 .435  immed[gprA_1, 0x0], gpr_wrboth
 da0:	 .436  alu[--, gprA_4, -, gprB_8]
 da8:	 .437  alu[--, gprA_5, -carry, gprB_9]
 db0:	 .438  bcc[.1512]
 db8:	 .439  br[.463]
 dc0:	 .440  immed[gprA_6, 0xb8], gpr_wrboth
 dc8:	 .441  immed[gprA_7, 0x0], gpr_wrboth
 dd0:	 .442  alu[gprA_8, --, B, gprB_2], gpr_wrboth
 dd8:	 .443  alu[gprA_9, --, B, gprB_3], gpr_wrboth
 de0:	 .444  alu[gprA_8, gprA_8, +, 0x17], gpr_wrboth
 de8:	 .445  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 df0:	 .446  immed[gprA_0, 0x0], gpr_wrboth
 df8:	 .447  immed[gprA_1, 0x0], gpr_wrboth
 e00:	 .448  alu[--, gprA_4, -, gprB_8]
 e08:	 .449  alu[--, gprA_5, -carry, gprB_9]
 e10:	 .450  bcc[.1512]
 e18:	 .451  br[.463]
 e20:	 .452  immed[gprA_6, 0xb0], gpr_wrboth
 e28:	 .453  immed[gprA_7, 0x0], gpr_wrboth
 e30:	 .454  alu[gprA_8, --, B, gprB_2], gpr_wrboth
 e38:	 .455  alu[gprA_9, --, B, gprB_3], gpr_wrboth
 e40:	 .456  alu[gprA_8, gprA_8, +, 0x16], gpr_wrboth
 e48:	 .457  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 e50:	 .458  immed[gprA_0, 0x0], gpr_wrboth
 e58:	 .459  immed[gprA_1, 0x0], gpr_wrboth
 e60:	 .460  alu[--, gprA_4, -, gprB_8]
 e68:	 .461  alu[--, gprA_5, -carry, gprB_9]
 e70:	 .462  bcc[.1512]
 e78:	 .463  alu[gprA_8, --, B, gprB_6], gpr_wrboth
 e80:	 .464  alu[gprA_9, --, B, gprB_7], gpr_wrboth
 e88:	 .465  alu[gprA_8, gprA_8, +, 0x10], gpr_wrboth
 e90:	 .466  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
 e98:	 .467  alu[gprA_10, --, B, gprB_8], gpr_wrboth
 ea0:	 .468  alu[gprA_11, --, B, gprB_9], gpr_wrboth
 ea8:	 .469  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
 eb0:	 .470  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
 eb8:	 .471  alu[gprA_12, --, B, gprB_2], gpr_wrboth
 ec0:	 .472  alu[gprA_13, --, B, gprB_3], gpr_wrboth
 ec8:	 .473  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
 ed0:	 .474  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
 ed8:	 .475  immed[gprA_0, 0x0], gpr_wrboth
 ee0:	 .476  immed[gprA_1, 0x0], gpr_wrboth
 ee8:	 .477  alu[--, gprA_4, -, gprB_12]
 ef0:	 .478  alu[--, gprA_5, -carry, gprB_13]
 ef8:	 .479  bcc[.1512]
 f00:	 .480  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
 f08:	 .481  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
 f10:	 .482  alu[gprA_10, --, B, gprB_2], gpr_wrboth
 f18:	 .483  alu[gprA_11, --, B, gprB_3], gpr_wrboth
 f20:	 .484  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
 f28:	 .485  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
 f30:	 .486  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
 f38:	 .487  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
 f40:	 .488  immed[gprA_7, 0x0], gpr_wrboth
 f48:	 .489  alu[gprA_10, --, B, gprB_6], gpr_wrboth
 f50:	 .490  alu[gprA_11, --, B, gprB_7], gpr_wrboth
 f58:	 .491  alu[gprA_21, --, B, gprB_11]
 f60:	 .492  ld_field[gprB_11, 1111, gprA_10, >>rot8], gpr_wrboth
 f68:	 .493  ld_field[gprB_11, 0101, gprA_11, >>rot16], gpr_wrboth
 f70:	 .494  ld_field[gprB_10, 1111, gprA_21, >>rot8], gpr_wrboth
 f78:	 .495  ld_field[gprB_10, 0101, gprA_10, >>rot16], gpr_wrboth
 f80:	 .496  alu_shf[gprA_10, --, B, gprB_11, >>24], gpr_wrboth
 f88:	 .497  immed[gprA_11, 0x0], gpr_wrboth
 f90:	 .498  alu[--, 0x5, -, gprA_10]
 f98:	 .499  alu[--, 0x0, -carry, gprA_11]
 fa0:	 .500  bcc[.512]
 fa8:	 .501  immed[gprA_0, 0x1], gpr_wrboth
 fb0:	 .502  immed[gprA_1, 0x0], gpr_wrboth
 fb8:	 .503  alu[gprA_21, 0x20, -, gprB_10], gpr_wrboth
 fc0:	 .504  alu[--, gprA_21, OR, 0x0]
 fc8:	 .505  dbl_shf[gprA_1, gprA_1, gprB_0, >>indirect], gpr_wrboth
 fd0:	 .506  alu[--, gprA_10, OR, 0x0]
 fd8:	 .507  alu_shf[gprA_0, --, B, gprB_0, <<indirect], gpr_wrboth
 fe0:	 .508  alu[gprA_0, gprA_0, AND, 0x33], gpr_wrboth
 fe8:	 .509  immed[gprA_1, 0x0], gpr_wrboth
 ff0:	 .510  alu[--, gprA_0, OR, gprB_1]
 ff8:	 .511  bne[.544]
1000:	 .512  ld_field[gprA_6, 1001, gprB_6, >>rot8], gpr_wrboth
1008:	 .513  ld_field[gprB_6, 1110, gprA_6, >>16], gpr_wrboth
1010:	 .514  immed[gprA_7, 0x0], gpr_wrboth
1018:	 .515  immed[gprB_21, 0x86dc]
1020:	 .516  alu[--, gprB_21, -, gprA_6]
1028:	 .517  alu[--, 0x0, -carry, gprA_7]
1030:	 .518  blt[.978]
1038:	 .519  immed[gprB_21, 0x800]
1040:	 .520  alu[gprA_21, gprA_6, XOR, gprB_21]
1048:	 .521  alu[--, gprA_21, OR, gprB_7]
1050:	 .522  beq[.743]
1058:	 .523  immed[gprB_21, 0x806]
1060:	 .524  alu[gprA_21, gprA_6, XOR, gprB_21]
1068:	 .525  alu[--, gprA_21, OR, gprB_7]
1070:	 .526  beq[.101]
1078:	 .527  immed[gprB_21, 0x8100]
1080:	 .528  alu[gprA_21, gprA_6, XOR, gprB_21]
1088:	 .529  alu[--, gprA_21, OR, gprB_7]
1090:	 .530  beq[.54]
1098:	 .531  br[.1510]
10a0:	 .532  immed[gprA_0, 0x33], gpr_wrboth
10a8:	 .533  immed[gprA_1, 0x0], gpr_wrboth
10b0:	 .534  alu[--, gprA_8, OR, 0x0]
10b8:	 .535  dbl_shf[gprA_0, gprA_1, gprB_0, >>indirect], gpr_wrboth
10c0:	 .536  alu[--, gprA_8, OR, 0x0]
10c8:	 .537  alu_shf[gprA_1, --, B, gprB_1, >>indirect], gpr_wrboth
10d0:	 .538  immed[gprA_8, 0x70], gpr_wrboth
10d8:	 .539  immed[gprA_9, 0x0], gpr_wrboth
10e0:	 .540  alu[gprA_0, gprA_0, AND, 0x1], gpr_wrboth
10e8:	 .541  immed[gprA_1, 0x0], gpr_wrboth
10f0:	 .542  alu[--, gprA_0, OR, gprB_1]
10f8:	 .543  beq[.32]
1100:	 .544  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1108:	 .545  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1110:	 .546  alu[gprA_6, gprA_6, +, 0x18], gpr_wrboth
1118:	 .547  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
1120:	 .548  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
1128:	 .549  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
1130:	 .550  alu[gprA_10, --, B, gprB_2], gpr_wrboth
1138:	 .551  alu[gprA_11, --, B, gprB_3], gpr_wrboth
1140:	 .552  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
1148:	 .553  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
1150:	 .554  immed[gprA_0, 0x0], gpr_wrboth
1158:	 .555  immed[gprA_1, 0x0], gpr_wrboth
1160:	 .556  alu[--, gprA_4, -, gprB_10]
1168:	 .557  alu[--, gprA_5, -carry, gprB_11]
1170:	 .558  bcc[.1512]
1178:	 .559  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1180:	 .560  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1188:	 .561  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
1190:	 .562  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
1198:	 .563  alu[gprA_10, --, B, gprB_2], gpr_wrboth
11a0:	 .564  alu[gprA_11, --, B, gprB_3], gpr_wrboth
11a8:	 .565  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
11b0:	 .566  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
11b8:	 .567  alu[gprA_6, --, B, gprB_8], gpr_wrboth
11c0:	 .568  alu[gprA_7, --, B, gprB_9], gpr_wrboth
11c8:	 .569  alu[gprA_6, gprA_6, +, 0x8], gpr_wrboth
11d0:	 .570  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
11d8:	 .571  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
11e0:	 .572  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
11e8:	 .573  alu[gprA_0, --, B, gprB_2], gpr_wrboth
11f0:	 .574  alu[gprA_1, --, B, gprB_3], gpr_wrboth
11f8:	 .575  alu[gprA_0, gprA_0, +, gprB_6], gpr_wrboth
1200:	 .576  alu[gprA_1, gprA_1, +carry, gprB_7], gpr_wrboth
1208:	 .577  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
1210:	 .578  ld_field_w_clr[gprA_6, 0001, $xfer_0], gpr_wrboth
1218:	 .579  immed[gprA_7, 0x0], gpr_wrboth
1220:	 .580  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
1228:	 .581  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
1230:	 .582  immed[gprA_11, 0x0], gpr_wrboth
1238:	 .583  dbl_shf[gprA_11, gprA_11, gprB_10, >>24], gpr_wrboth
1240:	 .584  alu_shf[gprA_10, --, B, gprB_10, <<8], gpr_wrboth
1248:	 .585  alu[gprA_10, gprA_10, OR, gprB_6], gpr_wrboth
1250:	 .586  alu[gprA_11, gprA_11, OR, gprB_7], gpr_wrboth
1258:	 .587  immed[gprB_21, 0xaaaa]
1260:	 .588  alu[gprA_21, gprA_10, XOR, gprB_21]
1268:	 .589  alu[--, gprA_21, OR, gprB_11]
1270:	 .590  beq[.592]
1278:	 .591  br[.1510]
1280:	 .592  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1288:	 .593  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1290:	 .594  alu[gprA_6, gprA_6, +, 0x40], gpr_wrboth
1298:	 .595  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
12a0:	 .596  alu[gprA_10, --, B, gprB_6], gpr_wrboth
12a8:	 .597  alu[gprA_11, --, B, gprB_7], gpr_wrboth
12b0:	 .598  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
12b8:	 .599  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
12c0:	 .600  alu[gprA_12, --, B, gprB_2], gpr_wrboth
12c8:	 .601  alu[gprA_13, --, B, gprB_3], gpr_wrboth
12d0:	 .602  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
12d8:	 .603  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
12e0:	 .604  immed[gprA_0, 0x0], gpr_wrboth
12e8:	 .605  immed[gprA_1, 0x0], gpr_wrboth
12f0:	 .606  alu[--, gprA_4, -, gprB_12]
12f8:	 .607  alu[--, gprA_5, -carry, gprB_13]
1300:	 .608  bcc[.1512]
1308:	 .609  alu[gprA_8, gprA_8, +, 0x30], gpr_wrboth
1310:	 .610  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
1318:	 .611  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
1320:	 .612  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
1328:	 .613  alu[gprA_10, --, B, gprB_2], gpr_wrboth
1330:	 .614  alu[gprA_11, --, B, gprB_3], gpr_wrboth
1338:	 .615  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
1340:	 .616  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
1348:	 .617  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
1350:	 .618  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
1358:	 .619  ld_field[gprA_10, 1001, gprB_10, >>rot8], gpr_wrboth
1360:	 .620  ld_field[gprB_10, 1110, gprA_10, >>16], gpr_wrboth
1368:	 .621  immed[gprA_11, 0x0], gpr_wrboth
1370:	 .622  immed[gprB_21, 0x86dc]
1378:	 .623  alu[--, gprB_21, -, gprA_10]
1380:	 .624  alu[--, 0x0, -carry, gprA_11]
1388:	 .625  blt[.645]
1390:	 .626  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1398:	 .627  alu[gprA_9, --, B, gprB_7], gpr_wrboth
13a0:	 .628  immed[gprB_21, 0x800]
13a8:	 .629  alu[gprA_21, gprA_10, XOR, gprB_21]
13b0:	 .630  alu[--, gprA_21, OR, gprB_11]
13b8:	 .631  beq[.743]
13c0:	 .632  alu[gprA_8, --, B, gprB_6], gpr_wrboth
13c8:	 .633  alu[gprA_9, --, B, gprB_7], gpr_wrboth
13d0:	 .634  immed[gprB_21, 0x806]
13d8:	 .635  alu[gprA_21, gprA_10, XOR, gprB_21]
13e0:	 .636  alu[--, gprA_21, OR, gprB_11]
13e8:	 .637  beq[.101]
13f0:	 .638  alu[gprA_8, --, B, gprB_6], gpr_wrboth
13f8:	 .639  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1400:	 .640  immed[gprB_21, 0x8100]
1408:	 .641  alu[gprA_21, gprA_10, XOR, gprB_21]
1410:	 .642  alu[--, gprA_21, OR, gprB_11]
1418:	 .643  beq[.54]
1420:	 .644  br[.1510]
1428:	 .645  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1430:	 .646  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1438:	 .647  immed[gprB_21, 0x86dd]
1440:	 .648  alu[gprA_21, gprA_10, XOR, gprB_21]
1448:	 .649  alu[--, gprA_21, OR, gprB_11]
1450:	 .650  beq[.991]
1458:	 .651  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1460:	 .652  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1468:	 .653  immed[gprB_21, 0x8847]
1470:	 .654  alu[gprA_21, gprA_10, XOR, gprB_21]
1478:	 .655  alu[--, gprA_21, OR, gprB_11]
1480:	 .656  beq[.158]
1488:	 .657  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1490:	 .658  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1498:	 .659  immed[gprB_21, 0x9100]
14a0:	 .660  alu[gprA_21, gprA_10, XOR, gprB_21]
14a8:	 .661  alu[--, gprA_21, OR, gprB_11]
14b0:	 .662  beq[.664]
14b8:	 .663  br[.1510]
14c0:	 .664  alu[gprA_6, --, B, gprB_8], gpr_wrboth
14c8:	 .665  alu[gprA_7, --, B, gprB_9], gpr_wrboth
14d0:	 .666  alu[gprA_6, gprA_6, +, 0x20], gpr_wrboth
14d8:	 .667  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
14e0:	 .668  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
14e8:	 .669  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
14f0:	 .670  alu[gprA_10, --, B, gprB_2], gpr_wrboth
14f8:	 .671  alu[gprA_11, --, B, gprB_3], gpr_wrboth
1500:	 .672  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
1508:	 .673  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
1510:	 .674  immed[gprA_0, 0x0], gpr_wrboth
1518:	 .675  immed[gprA_1, 0x0], gpr_wrboth
1520:	 .676  alu[--, gprA_4, -, gprB_10]
1528:	 .677  alu[--, gprA_5, -carry, gprB_11]
1530:	 .678  bcc[.1512]
1538:	 .679  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1540:	 .680  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1548:	 .681  alu[gprA_6, gprA_6, +, 0x10], gpr_wrboth
1550:	 .682  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
1558:	 .683  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
1560:	 .684  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
1568:	 .685  alu[gprA_10, --, B, gprB_2], gpr_wrboth
1570:	 .686  alu[gprA_11, --, B, gprB_3], gpr_wrboth
1578:	 .687  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
1580:	 .688  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
1588:	 .689  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
1590:	 .690  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
1598:	 .691  immed[gprA_7, 0x0], gpr_wrboth
15a0:	 .692  alu[--, gprA_6, XOR, 0x81]
15a8:	 .693  bne[.1510]
15b0:	 .694  alu[--, gprA_7, XOR, 0x0]
15b8:	 .695  bne[.1510]
15c0:	 .696  alu[gprA_6, --, B, gprB_8], gpr_wrboth
15c8:	 .697  alu[gprA_7, --, B, gprB_9], gpr_wrboth
15d0:	 .698  alu[gprA_6, gprA_6, +, 0x40], gpr_wrboth
15d8:	 .699  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
15e0:	 .700  alu[gprA_10, --, B, gprB_6], gpr_wrboth
15e8:	 .701  alu[gprA_11, --, B, gprB_7], gpr_wrboth
15f0:	 .702  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
15f8:	 .703  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
1600:	 .704  alu[gprA_12, --, B, gprB_2], gpr_wrboth
1608:	 .705  alu[gprA_13, --, B, gprB_3], gpr_wrboth
1610:	 .706  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
1618:	 .707  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
1620:	 .708  immed[gprA_0, 0x0], gpr_wrboth
1628:	 .709  immed[gprA_1, 0x0], gpr_wrboth
1630:	 .710  alu[--, gprA_4, -, gprB_12]
1638:	 .711  alu[--, gprA_5, -carry, gprB_13]
1640:	 .712  bcc[.1512]
1648:	 .713  alu[gprA_8, gprA_8, +, 0x30], gpr_wrboth
1650:	 .714  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
1658:	 .715  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
1660:	 .716  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
1668:	 .717  alu[gprA_10, --, B, gprB_2], gpr_wrboth
1670:	 .718  alu[gprA_11, --, B, gprB_3], gpr_wrboth
1678:	 .719  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
1680:	 .720  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
1688:	 .721  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
1690:	 .722  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
1698:	 .723  ld_field[gprA_10, 1001, gprB_10, >>rot8], gpr_wrboth
16a0:	 .724  ld_field[gprB_10, 1110, gprA_10, >>16], gpr_wrboth
16a8:	 .725  immed[gprA_11, 0x0], gpr_wrboth
16b0:	 .726  immed[gprB_21, 0x86dc]
16b8:	 .727  alu[--, gprB_21, -, gprA_10]
16c0:	 .728  alu[--, 0x0, -carry, gprA_11]
16c8:	 .729  blt[.937]
16d0:	 .730  alu[gprA_8, --, B, gprB_6], gpr_wrboth
16d8:	 .731  alu[gprA_9, --, B, gprB_7], gpr_wrboth
16e0:	 .732  immed[gprB_21, 0x800]
16e8:	 .733  alu[gprA_21, gprA_10, XOR, gprB_21]
16f0:	 .734  alu[--, gprA_21, OR, gprB_11]
16f8:	 .735  beq[.743]
1700:	 .736  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1708:	 .737  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1710:	 .738  immed[gprB_21, 0x806]
1718:	 .739  alu[gprA_21, gprA_10, XOR, gprB_21]
1720:	 .740  alu[--, gprA_21, OR, gprB_11]
1728:	 .741  beq[.101]
1730:	 .742  br[.1510]
1738:	 .743  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1740:	 .744  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1748:	 .745  alu[gprA_6, gprA_6, +, 0xa0], gpr_wrboth
1750:	 .746  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
1758:	 .747  alu[gprA_10, --, B, gprB_6], gpr_wrboth
1760:	 .748  alu[gprA_11, --, B, gprB_7], gpr_wrboth
1768:	 .749  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
1770:	 .750  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
1778:	 .751  alu[gprA_12, --, B, gprB_2], gpr_wrboth
1780:	 .752  alu[gprA_13, --, B, gprB_3], gpr_wrboth
1788:	 .753  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
1790:	 .754  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
1798:	 .755  immed[gprA_0, 0x0], gpr_wrboth
17a0:	 .756  immed[gprA_1, 0x0], gpr_wrboth
17a8:	 .757  alu[--, gprA_4, -, gprB_12]
17b0:	 .758  alu[--, gprA_5, -carry, gprB_13]
17b8:	 .759  bcc[.1512]
17c0:	 .760  alu[gprA_10, --, B, gprB_8], gpr_wrboth
17c8:	 .761  alu[gprA_11, --, B, gprB_9], gpr_wrboth
17d0:	 .762  alu[gprA_10, gprA_10, +, 0x48], gpr_wrboth
17d8:	 .763  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
17e0:	 .764  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
17e8:	 .765  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
17f0:	 .766  alu[gprA_0, --, B, gprB_2], gpr_wrboth
17f8:	 .767  alu[gprA_1, --, B, gprB_3], gpr_wrboth
1800:	 .768  alu[gprA_0, gprA_0, +, gprB_10], gpr_wrboth
1808:	 .769  alu[gprA_1, gprA_1, +carry, gprB_11], gpr_wrboth
1810:	 .770  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
1818:	 .771  ld_field_w_clr[gprA_0, 0001, $xfer_0], gpr_wrboth
1820:	 .772  immed[gprA_1, 0x0], gpr_wrboth
1828:	 .773  alu[gprA_10, --, B, gprB_8], gpr_wrboth
1830:	 .774  alu[gprA_11, --, B, gprB_9], gpr_wrboth
1838:	 .775  alu[gprA_10, gprA_10, +, 0x4], gpr_wrboth
1840:	 .776  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
1848:	 .777  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
1850:	 .778  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
1858:	 .779  alu[gprA_12, --, B, gprB_2], gpr_wrboth
1860:	 .780  alu[gprA_13, --, B, gprB_3], gpr_wrboth
1868:	 .781  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
1870:	 .782  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
1878:	 .783  mem[read32_swap, $xfer_0, gprA_12, 0x0, 1], ctx_swap[sig1]
1880:	 .784  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
1888:	 .785  immed[gprA_11, 0x0], gpr_wrboth
1890:	 .786  alu[gprA_10, gprA_10, AND, 0xf], gpr_wrboth
1898:	 .787  immed[gprA_11, 0x0], gpr_wrboth
18a0:	 .788  dbl_shf[gprA_11, gprA_11, gprB_10, >>24], gpr_wrboth
18a8:	 .789  alu_shf[gprA_10, --, B, gprB_10, <<8], gpr_wrboth
18b0:	 .790  alu[gprA_10, gprA_10, OR, gprB_0], gpr_wrboth
18b8:	 .791  alu[gprA_11, gprA_11, OR, gprB_1], gpr_wrboth
18c0:	 .792  alu[gprA_8, gprA_8, +, 0x33], gpr_wrboth
18c8:	 .793  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
18d0:	 .794  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
18d8:	 .795  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
18e0:	 .796  alu[gprA_0, --, B, gprB_2], gpr_wrboth
18e8:	 .797  alu[gprA_1, --, B, gprB_3], gpr_wrboth
18f0:	 .798  alu[gprA_0, gprA_0, +, gprB_8], gpr_wrboth
18f8:	 .799  alu[gprA_1, gprA_1, +carry, gprB_9], gpr_wrboth
1900:	 .800  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
1908:	 .801  ld_field_w_clr[gprA_8, 0011, $xfer_0], gpr_wrboth
1910:	 .802  immed[gprA_9, 0x0], gpr_wrboth
1918:	 .803  immed[gprB_21, 0xff1f]
1920:	 .804  alu[gprA_8, gprA_8, AND, gprB_21], gpr_wrboth
1928:	 .805  immed[gprA_9, 0x0], gpr_wrboth
1930:	 .806  ld_field[gprB_8, 1111, gprA_8, >>rot8], gpr_wrboth
1938:	 .807  ld_field[gprB_8, 0101, gprA_8, >>rot16], gpr_wrboth
1940:	 .808  immed[gprA_9, 0x0], gpr_wrboth
1948:	 .809  alu[gprA_10, gprA_10, OR, gprB_8], gpr_wrboth
1950:	 .810  alu[gprA_11, gprA_11, OR, gprB_9], gpr_wrboth
1958:	 .811  immed[gprB_21, 0x510]
1960:	 .812  alu[--, gprB_21, -, gprA_10]
1968:	 .813  alu[--, 0x0, -carry, gprA_11]
1970:	 .814  blt[.840]
1978:	 .815  immed[gprB_21, 0x501]
1980:	 .816  alu[gprA_21, gprA_10, XOR, gprB_21]
1988:	 .817  alu[--, gprA_21, OR, gprB_11]
1990:	 .818  beq[.1269]
1998:	 .819  immed[gprB_21, 0x504]
19a0:	 .820  alu[gprA_21, gprA_10, XOR, gprB_21]
19a8:	 .821  alu[--, gprA_21, OR, gprB_11]
19b0:	 .822  beq[.1418]
19b8:	 .823  immed[gprB_21, 0x506]
19c0:	 .824  alu[gprA_21, gprA_10, XOR, gprB_21]
19c8:	 .825  alu[--, gprA_21, OR, gprB_11]
19d0:	 .826  beq[.828]
19d8:	 .827  br[.1510]
19e0:	 .828  alu[gprA_6, gprA_6, +, 0xa0], gpr_wrboth
19e8:	 .829  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
19f0:	 .830  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
19f8:	 .831  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
1a00:	 .832  alu[gprA_2, gprA_2, +, gprB_6], gpr_wrboth
1a08:	 .833  alu[gprA_3, gprA_3, +carry, gprB_7], gpr_wrboth
1a10:	 .834  immed[gprA_0, 0x0], gpr_wrboth
1a18:	 .835  immed[gprA_1, 0x0], gpr_wrboth
1a20:	 .836  alu[--, gprA_4, -, gprB_2]
1a28:	 .837  alu[--, gprA_5, -carry, gprB_3]
1a30:	 .838  bcc[.1512]
1a38:	 .839  br[.1510]
1a40:	 .840  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1a48:	 .841  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1a50:	 .842  immed[gprB_21, 0x511]
1a58:	 .843  alu[gprA_21, gprA_10, XOR, gprB_21]
1a60:	 .844  alu[--, gprA_21, OR, gprB_11]
1a68:	 .845  beq[.1035]
1a70:	 .846  immed[gprB_21, 0x529]
1a78:	 .847  alu[gprA_21, gprA_10, XOR, gprB_21]
1a80:	 .848  alu[--, gprA_21, OR, gprB_11]
1a88:	 .849  beq[.293]
1a90:	 .850  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1a98:	 .851  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1aa0:	 .852  immed[gprB_21, 0x52f]
1aa8:	 .853  alu[gprA_21, gprA_10, XOR, gprB_21]
1ab0:	 .854  alu[--, gprA_21, OR, gprB_11]
1ab8:	 .855  beq[.857]
1ac0:	 .856  br[.1510]
1ac8:	 .857  alu[gprA_6, gprA_6, +, 0x20], gpr_wrboth
1ad0:	 .858  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
1ad8:	 .859  alu[gprA_10, --, B, gprB_6], gpr_wrboth
1ae0:	 .860  alu[gprA_11, --, B, gprB_7], gpr_wrboth
1ae8:	 .861  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
1af0:	 .862  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
1af8:	 .863  alu[gprA_12, --, B, gprB_2], gpr_wrboth
1b00:	 .864  alu[gprA_13, --, B, gprB_3], gpr_wrboth
1b08:	 .865  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
1b10:	 .866  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
1b18:	 .867  immed[gprA_0, 0x0], gpr_wrboth
1b20:	 .868  immed[gprA_1, 0x0], gpr_wrboth
1b28:	 .869  alu[--, gprA_4, -, gprB_12]
1b30:	 .870  alu[--, gprA_5, -carry, gprB_13]
1b38:	 .871  bcc[.1512]
1b40:	 .872  alu[gprA_10, --, B, gprB_8], gpr_wrboth
1b48:	 .873  alu[gprA_11, --, B, gprB_9], gpr_wrboth
1b50:	 .874  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
1b58:	 .875  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
1b60:	 .876  alu[gprA_0, --, B, gprB_2], gpr_wrboth
1b68:	 .877  alu[gprA_1, --, B, gprB_3], gpr_wrboth
1b70:	 .878  alu[gprA_0, gprA_0, +, gprB_10], gpr_wrboth
1b78:	 .879  alu[gprA_1, gprA_1, +carry, gprB_11], gpr_wrboth
1b80:	 .880  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
1b88:	 .881  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
1b90:	 .882  ld_field[gprB_10, 1111, gprA_10, >>rot8], gpr_wrboth
1b98:	 .883  ld_field[gprB_10, 0101, gprA_10, >>rot16], gpr_wrboth
1ba0:	 .884  immed[gprA_11, 0x0], gpr_wrboth
1ba8:	 .885  immed[gprA_0, 0xffff, <<16], gpr_wrboth
1bb0:	 .886  immed[gprA_1, 0x0], gpr_wrboth
1bb8:	 .887  alu[gprA_10, gprA_10, AND, gprB_0], gpr_wrboth
1bc0:	 .888  alu[gprA_11, gprA_11, AND, gprB_1], gpr_wrboth
1bc8:	 .889  alu[gprA_0, --, B, gprB_8], gpr_wrboth
1bd0:	 .890  alu[gprA_1, --, B, gprB_9], gpr_wrboth
1bd8:	 .891  alu[gprA_0, gprA_0, +, 0x10], gpr_wrboth
1be0:	 .892  alu[gprA_1, gprA_1, +carry, 0x0], gpr_wrboth
1be8:	 .893  dbl_shf[gprA_0, gprA_1, gprB_0, >>3], gpr_wrboth
1bf0:	 .894  alu_shf[gprA_1, --, B, gprB_1, >>3], gpr_wrboth
1bf8:	 .895  alu[gprA_12, --, B, gprB_2], gpr_wrboth
1c00:	 .896  alu[gprA_13, --, B, gprB_3], gpr_wrboth
1c08:	 .897  alu[gprA_12, gprA_12, +, gprB_0], gpr_wrboth
1c10:	 .898  alu[gprA_13, gprA_13, +carry, gprB_1], gpr_wrboth
1c18:	 .899  mem[read32_swap, $xfer_0, gprA_12, 0x0, 1], ctx_swap[sig1]
1c20:	 .900  ld_field_w_clr[gprA_0, 0011, $xfer_0], gpr_wrboth
1c28:	 .901  ld_field[gprA_0, 1001, gprB_0, >>rot8], gpr_wrboth
1c30:	 .902  ld_field[gprB_0, 1110, gprA_0, >>16], gpr_wrboth
1c38:	 .903  immed[gprA_1, 0x0], gpr_wrboth
1c40:	 .904  alu[gprA_10, gprA_10, OR, gprB_0], gpr_wrboth
1c48:	 .905  alu[gprA_11, gprA_11, OR, gprB_1], gpr_wrboth
1c50:	 .906  immed[gprB_21, 0x86dc]
1c58:	 .907  alu[--, gprB_21, -, gprA_10]
1c60:	 .908  alu[--, 0x0, -carry, gprA_11]
1c68:	 .909  blt[.950]
1c70:	 .910  immed[gprB_21, 0x800]
1c78:	 .911  alu[gprA_21, gprA_10, XOR, gprB_21]
1c80:	 .912  alu[--, gprA_21, OR, gprB_11]
1c88:	 .913  beq[.1418]
1c90:	 .914  immed[gprB_21, 0x22eb]
1c98:	 .915  alu[gprA_21, gprA_10, XOR, gprB_21]
1ca0:	 .916  alu[--, gprA_21, OR, gprB_11]
1ca8:	 .917  beq[.919]
1cb0:	 .918  br[.1510]
1cb8:	 .919  alu[gprA_8, gprA_8, +, 0x80], gpr_wrboth
1cc0:	 .920  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
1cc8:	 .921  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1cd0:	 .922  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1cd8:	 .923  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
1ce0:	 .924  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
1ce8:	 .925  alu[gprA_10, --, B, gprB_2], gpr_wrboth
1cf0:	 .926  alu[gprA_11, --, B, gprB_3], gpr_wrboth
1cf8:	 .927  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
1d00:	 .928  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
1d08:	 .929  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1d10:	 .930  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1d18:	 .931  immed[gprA_0, 0x0], gpr_wrboth
1d20:	 .932  immed[gprA_1, 0x0], gpr_wrboth
1d28:	 .933  alu[--, gprA_4, -, gprB_10]
1d30:	 .934  alu[--, gprA_5, -carry, gprB_11]
1d38:	 .935  bcc[.1512]
1d40:	 .936  br[.1375]
1d48:	 .937  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1d50:	 .938  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1d58:	 .939  immed[gprB_21, 0x86dd]
1d60:	 .940  alu[gprA_21, gprA_10, XOR, gprB_21]
1d68:	 .941  alu[--, gprA_21, OR, gprB_11]
1d70:	 .942  beq[.991]
1d78:	 .943  alu[gprA_8, --, B, gprB_6], gpr_wrboth
1d80:	 .944  alu[gprA_9, --, B, gprB_7], gpr_wrboth
1d88:	 .945  immed[gprB_21, 0x8847]
1d90:	 .946  alu[gprA_21, gprA_10, XOR, gprB_21]
1d98:	 .947  alu[--, gprA_21, OR, gprB_11]
1da0:	 .948  beq[.158]
1da8:	 .949  br[.1510]
1db0:	 .950  immed[gprB_21, 0x86dd]
1db8:	 .951  alu[gprA_21, gprA_10, XOR, gprB_21]
1dc0:	 .952  alu[--, gprA_21, OR, gprB_11]
1dc8:	 .953  beq[.293]
1dd0:	 .954  immed[gprB_21, 0x6558]
1dd8:	 .955  immed_w1[gprB_21, 0x2000]
1de0:	 .956  alu[gprA_21, gprA_10, XOR, gprB_21]
1de8:	 .957  alu[--, gprA_21, OR, gprB_11]
1df0:	 .958  beq[.960]
1df8:	 .959  br[.1510]
1e00:	 .960  alu[gprA_8, gprA_8, +, 0x40], gpr_wrboth
1e08:	 .961  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
1e10:	 .962  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1e18:	 .963  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1e20:	 .964  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
1e28:	 .965  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
1e30:	 .966  alu[gprA_10, --, B, gprB_2], gpr_wrboth
1e38:	 .967  alu[gprA_11, --, B, gprB_3], gpr_wrboth
1e40:	 .968  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
1e48:	 .969  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
1e50:	 .970  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1e58:	 .971  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1e60:	 .972  immed[gprA_0, 0x0], gpr_wrboth
1e68:	 .973  immed[gprA_1, 0x0], gpr_wrboth
1e70:	 .974  alu[--, gprA_4, -, gprB_10]
1e78:	 .975  alu[--, gprA_5, -carry, gprB_11]
1e80:	 .976  bcc[.1512]
1e88:	 .977  br[.1375]
1e90:	 .978  immed[gprB_21, 0x86dd]
1e98:	 .979  alu[gprA_21, gprA_6, XOR, gprB_21]
1ea0:	 .980  alu[--, gprA_21, OR, gprB_7]
1ea8:	 .981  beq[.991]
1eb0:	 .982  immed[gprB_21, 0x8847]
1eb8:	 .983  alu[gprA_21, gprA_6, XOR, gprB_21]
1ec0:	 .984  alu[--, gprA_21, OR, gprB_7]
1ec8:	 .985  beq[.158]
1ed0:	 .986  immed[gprB_21, 0x9100]
1ed8:	 .987  alu[gprA_21, gprA_6, XOR, gprB_21]
1ee0:	 .988  alu[--, gprA_21, OR, gprB_7]
1ee8:	 .989  beq[.664]
1ef0:	 .990  br[.1510]
1ef8:	 .991  alu[gprA_6, --, B, gprB_8], gpr_wrboth
1f00:	 .992  alu[gprA_7, --, B, gprB_9], gpr_wrboth
1f08:	 .993  immed[gprB_21, 0x140]
1f10:	 .994  alu[gprA_6, gprA_6, +, gprB_21], gpr_wrboth
1f18:	 .995  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
1f20:	 .996  alu[gprA_10, --, B, gprB_6], gpr_wrboth
1f28:	 .997  alu[gprA_11, --, B, gprB_7], gpr_wrboth
1f30:	 .998  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
1f38:	 .999  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
1f40:	.1000  alu[gprA_12, --, B, gprB_2], gpr_wrboth
1f48:	.1001  alu[gprA_13, --, B, gprB_3], gpr_wrboth
1f50:	.1002  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
1f58:	.1003  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
1f60:	.1004  immed[gprA_0, 0x0], gpr_wrboth
1f68:	.1005  immed[gprA_1, 0x0], gpr_wrboth
1f70:	.1006  alu[--, gprA_4, -, gprB_12]
1f78:	.1007  alu[--, gprA_5, -carry, gprB_13]
1f80:	.1008  bcc[.1512]
1f88:	.1009  alu[gprA_8, gprA_8, +, 0x30], gpr_wrboth
1f90:	.1010  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
1f98:	.1011  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
1fa0:	.1012  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
1fa8:	.1013  alu[gprA_10, --, B, gprB_2], gpr_wrboth
1fb0:	.1014  alu[gprA_11, --, B, gprB_3], gpr_wrboth
1fb8:	.1015  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
1fc0:	.1016  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
1fc8:	.1017  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
1fd0:	.1018  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
1fd8:	.1019  immed[gprA_11, 0x0], gpr_wrboth
1fe0:	.1020  alu[--, 0x28, -, gprA_10]
1fe8:	.1021  alu[--, 0x0, -carry, gprA_11]
1ff0:	.1022  blt[.1257]
1ff8:	.1023  alu[gprA_21, gprA_10, XOR, 0x4]
2000:	.1024  alu[--, gprA_21, OR, gprB_11]
2008:	.1025  beq[.1418]
2010:	.1026  alu[gprA_21, gprA_10, XOR, 0x6]
2018:	.1027  alu[--, gprA_21, OR, gprB_11]
2020:	.1028  beq[.828]
2028:	.1029  alu[gprA_8, --, B, gprB_6], gpr_wrboth
2030:	.1030  alu[gprA_9, --, B, gprB_7], gpr_wrboth
2038:	.1031  alu[gprA_21, gprA_10, XOR, 0x11]
2040:	.1032  alu[--, gprA_21, OR, gprB_11]
2048:	.1033  beq[.1035]
2050:	.1034  br[.1510]
2058:	.1035  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2060:	.1036  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2068:	.1037  alu[gprA_6, gprA_6, +, 0x40], gpr_wrboth
2070:	.1038  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
2078:	.1039  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
2080:	.1040  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
2088:	.1041  alu[gprA_10, --, B, gprB_2], gpr_wrboth
2090:	.1042  alu[gprA_11, --, B, gprB_3], gpr_wrboth
2098:	.1043  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
20a0:	.1044  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
20a8:	.1045  immed[gprA_0, 0x0], gpr_wrboth
20b0:	.1046  immed[gprA_1, 0x0], gpr_wrboth
20b8:	.1047  alu[--, gprA_4, -, gprB_10]
20c0:	.1048  alu[--, gprA_5, -carry, gprB_11]
20c8:	.1049  bcc[.1512]
20d0:	.1050  alu[gprA_6, --, B, gprB_8], gpr_wrboth
20d8:	.1051  alu[gprA_7, --, B, gprB_9], gpr_wrboth
20e0:	.1052  alu[gprA_6, gprA_6, +, 0x10], gpr_wrboth
20e8:	.1053  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
20f0:	.1054  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
20f8:	.1055  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
2100:	.1056  alu[gprA_0, --, B, gprB_2], gpr_wrboth
2108:	.1057  alu[gprA_1, --, B, gprB_3], gpr_wrboth
2110:	.1058  alu[gprA_0, gprA_0, +, gprB_6], gpr_wrboth
2118:	.1059  alu[gprA_1, gprA_1, +carry, gprB_7], gpr_wrboth
2120:	.1060  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
2128:	.1061  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
2130:	.1062  ld_field[gprA_6, 1001, gprB_6, >>rot8], gpr_wrboth
2138:	.1063  ld_field[gprB_6, 1110, gprA_6, >>16], gpr_wrboth
2140:	.1064  immed[gprA_7, 0x0], gpr_wrboth
2148:	.1065  immed[gprB_21, 0x17c0]
2150:	.1066  alu[--, gprB_21, -, gprA_6]
2158:	.1067  alu[--, 0x0, -carry, gprA_7]
2160:	.1068  blt[.1281]
2168:	.1069  immed[gprB_21, 0x12b5]
2170:	.1070  alu[gprA_21, gprA_6, XOR, gprB_21]
2178:	.1071  alu[--, gprA_21, OR, gprB_7]
2180:	.1072  beq[.1358]
2188:	.1073  immed[gprB_21, 0x12b6]
2190:	.1074  alu[gprA_21, gprA_6, XOR, gprB_21]
2198:	.1075  alu[--, gprA_21, OR, gprB_7]
21a0:	.1076  beq[.1078]
21a8:	.1077  br[.1510]
21b0:	.1078  alu[gprA_6, --, B, gprB_8], gpr_wrboth
21b8:	.1079  alu[gprA_7, --, B, gprB_9], gpr_wrboth
21c0:	.1080  alu[gprA_6, gprA_6, +, 0x80], gpr_wrboth
21c8:	.1081  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
21d0:	.1082  alu[gprA_0, --, B, gprB_6], gpr_wrboth
21d8:	.1083  alu[gprA_1, --, B, gprB_7], gpr_wrboth
21e0:	.1084  dbl_shf[gprA_0, gprA_1, gprB_0, >>3], gpr_wrboth
21e8:	.1085  alu_shf[gprA_1, --, B, gprB_1, >>3], gpr_wrboth
21f0:	.1086  alu[gprA_12, --, B, gprB_2], gpr_wrboth
21f8:	.1087  alu[gprA_13, --, B, gprB_3], gpr_wrboth
2200:	.1088  alu[gprA_12, gprA_12, +, gprB_0], gpr_wrboth
2208:	.1089  alu[gprA_13, gprA_13, +carry, gprB_1], gpr_wrboth
2210:	.1090  immed[gprA_0, 0x0], gpr_wrboth
2218:	.1091  immed[gprA_1, 0x0], gpr_wrboth
2220:	.1092  alu[--, gprA_4, -, gprB_12]
2228:	.1093  alu[--, gprA_5, -carry, gprB_13]
2230:	.1094  bcc[.1512]
2238:	.1095  alu[gprA_0, --, B, gprB_8], gpr_wrboth
2240:	.1096  alu[gprA_1, --, B, gprB_9], gpr_wrboth
2248:	.1097  alu[gprA_0, gprA_0, +, 0x58], gpr_wrboth
2250:	.1098  alu[gprA_1, gprA_1, +carry, 0x0], gpr_wrboth
2258:	.1099  dbl_shf[gprA_0, gprA_1, gprB_0, >>3], gpr_wrboth
2260:	.1100  alu_shf[gprA_1, --, B, gprB_1, >>3], gpr_wrboth
2268:	.1101  alu[gprA_12, --, B, gprB_2], gpr_wrboth
2270:	.1102  alu[gprA_13, --, B, gprB_3], gpr_wrboth
2278:	.1103  alu[gprA_12, gprA_12, +, gprB_0], gpr_wrboth
2280:	.1104  alu[gprA_13, gprA_13, +carry, gprB_1], gpr_wrboth
2288:	.1105  mem[read32_swap, $xfer_0, gprA_12, 0x0, 1], ctx_swap[sig1]
2290:	.1106  ld_field_w_clr[gprA_0, 0001, $xfer_0], gpr_wrboth
2298:	.1107  immed[gprA_1, 0x0], gpr_wrboth
22a0:	.1108  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
22a8:	.1109  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
22b0:	.1110  immed[gprA_11, 0x0], gpr_wrboth
22b8:	.1111  dbl_shf[gprA_11, gprA_11, gprB_10, >>31], gpr_wrboth
22c0:	.1112  alu_shf[gprA_10, --, B, gprB_10, <<1], gpr_wrboth
22c8:	.1113  immed[gprB_21, 0x100]
22d0:	.1114  alu[gprA_10, gprA_10, AND, gprB_21], gpr_wrboth
22d8:	.1115  immed[gprA_11, 0x0], gpr_wrboth
22e0:	.1116  alu[gprA_10, gprA_10, OR, gprB_0], gpr_wrboth
22e8:	.1117  alu[gprA_11, gprA_11, OR, gprB_1], gpr_wrboth
22f0:	.1118  immed[gprB_21, 0x105]
22f8:	.1119  alu[--, gprA_10, XOR, gprB_21]
2300:	.1120  bne[.1375]
2308:	.1121  alu[--, gprA_11, XOR, 0x0]
2310:	.1122  bne[.1375]
2318:	.1123  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2320:	.1124  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2328:	.1125  alu[gprA_6, gprA_6, +, 0xa0], gpr_wrboth
2330:	.1126  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
2338:	.1127  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
2340:	.1128  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
2348:	.1129  alu[gprA_10, --, B, gprB_2], gpr_wrboth
2350:	.1130  alu[gprA_11, --, B, gprB_3], gpr_wrboth
2358:	.1131  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
2360:	.1132  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
2368:	.1133  immed[gprA_0, 0x0], gpr_wrboth
2370:	.1134  immed[gprA_1, 0x0], gpr_wrboth
2378:	.1135  alu[--, gprA_4, -, gprB_10]
2380:	.1136  alu[--, gprA_5, -carry, gprB_11]
2388:	.1137  bcc[.1512]
2390:	.1138  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2398:	.1139  alu[gprA_7, --, B, gprB_9], gpr_wrboth
23a0:	.1140  alu[gprA_6, gprA_6, +, 0xe0], gpr_wrboth
23a8:	.1141  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
23b0:	.1142  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
23b8:	.1143  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
23c0:	.1144  alu[gprA_10, --, B, gprB_2], gpr_wrboth
23c8:	.1145  alu[gprA_11, --, B, gprB_3], gpr_wrboth
23d0:	.1146  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
23d8:	.1147  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
23e0:	.1148  immed[gprA_0, 0x0], gpr_wrboth
23e8:	.1149  immed[gprA_1, 0x0], gpr_wrboth
23f0:	.1150  alu[--, gprA_4, -, gprB_10]
23f8:	.1151  alu[--, gprA_5, -carry, gprB_11]
2400:	.1152  bcc[.1512]
2408:	.1153  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2410:	.1154  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2418:	.1155  alu[gprA_6, gprA_6, +, 0xa6], gpr_wrboth
2420:	.1156  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
2428:	.1157  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
2430:	.1158  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
2438:	.1159  alu[gprA_0, --, B, gprB_2], gpr_wrboth
2440:	.1160  alu[gprA_1, --, B, gprB_3], gpr_wrboth
2448:	.1161  alu[gprA_0, gprA_0, +, gprB_6], gpr_wrboth
2450:	.1162  alu[gprA_1, gprA_1, +carry, gprB_7], gpr_wrboth
2458:	.1163  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
2460:	.1164  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
2468:	.1165  immed[gprA_7, 0x0], gpr_wrboth
2470:	.1166  alu[gprA_21, --, B, gprB_7]
2478:	.1167  ld_field[gprB_7, 1111, gprA_6, >>rot8], gpr_wrboth
2480:	.1168  ld_field[gprB_7, 0101, gprA_7, >>rot16], gpr_wrboth
2488:	.1169  ld_field[gprB_6, 1111, gprA_21, >>rot8], gpr_wrboth
2490:	.1170  ld_field[gprB_6, 0101, gprA_6, >>rot16], gpr_wrboth
2498:	.1171  alu_shf[gprA_6, --, B, gprB_7, >>21], gpr_wrboth
24a0:	.1172  immed[gprA_7, 0x0], gpr_wrboth
24a8:	.1173  alu[gprA_6, gprA_6, AND, 0x1f], gpr_wrboth
24b0:	.1174  immed[gprA_7, 0x0], gpr_wrboth
24b8:	.1175  alu[--, gprA_6, OR, gprB_7]
24c0:	.1176  bne[.1510]
24c8:	.1177  alu[gprA_0, --, B, gprB_8], gpr_wrboth
24d0:	.1178  alu[gprA_1, --, B, gprB_9], gpr_wrboth
24d8:	.1179  alu[gprA_0, gprA_0, +, 0xb8], gpr_wrboth
24e0:	.1180  alu[gprA_1, gprA_1, +carry, 0x0], gpr_wrboth
24e8:	.1181  dbl_shf[gprA_0, gprA_1, gprB_0, >>3], gpr_wrboth
24f0:	.1182  alu_shf[gprA_1, --, B, gprB_1, >>3], gpr_wrboth
24f8:	.1183  alu[gprA_12, --, B, gprB_2], gpr_wrboth
2500:	.1184  alu[gprA_13, --, B, gprB_3], gpr_wrboth
2508:	.1185  alu[gprA_12, gprA_12, +, gprB_0], gpr_wrboth
2510:	.1186  alu[gprA_13, gprA_13, +carry, gprB_1], gpr_wrboth
2518:	.1187  mem[read32_swap, $xfer_0, gprA_12, 0x0, 1], ctx_swap[sig1]
2520:	.1188  ld_field_w_clr[gprA_0, 0001, $xfer_0], gpr_wrboth
2528:	.1189  immed[gprA_1, 0x0], gpr_wrboth
2530:	.1190  dbl_shf[gprA_7, gprA_7, gprB_6, >>24], gpr_wrboth
2538:	.1191  alu_shf[gprA_6, --, B, gprB_6, <<8], gpr_wrboth
2540:	.1192  alu[gprA_6, gprA_6, OR, gprB_0], gpr_wrboth
2548:	.1193  alu[gprA_7, gprA_7, OR, gprB_1], gpr_wrboth
2550:	.1194  alu[--, gprA_6, OR, gprB_7]
2558:	.1195  beq[.1510]
2560:	.1196  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2568:	.1197  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2570:	.1198  immed[gprB_21, 0x100]
2578:	.1199  alu[gprA_6, gprA_6, +, gprB_21], gpr_wrboth
2580:	.1200  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
2588:	.1201  alu[gprA_0, --, B, gprB_6], gpr_wrboth
2590:	.1202  alu[gprA_1, --, B, gprB_7], gpr_wrboth
2598:	.1203  dbl_shf[gprA_0, gprA_1, gprB_0, >>3], gpr_wrboth
25a0:	.1204  alu_shf[gprA_1, --, B, gprB_1, >>3], gpr_wrboth
25a8:	.1205  alu[gprA_12, --, B, gprB_2], gpr_wrboth
25b0:	.1206  alu[gprA_13, --, B, gprB_3], gpr_wrboth
25b8:	.1207  alu[gprA_12, gprA_12, +, gprB_0], gpr_wrboth
25c0:	.1208  alu[gprA_13, gprA_13, +carry, gprB_1], gpr_wrboth
25c8:	.1209  immed[gprA_0, 0x0], gpr_wrboth
25d0:	.1210  immed[gprA_1, 0x0], gpr_wrboth
25d8:	.1211  alu[--, gprA_4, -, gprB_12]
25e0:	.1212  alu[--, gprA_5, -carry, gprB_13]
25e8:	.1213  bcc[.1512]
25f0:	.1214  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
25f8:	.1215  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
2600:	.1216  immed[gprA_11, 0x0], gpr_wrboth
2608:	.1217  alu_shf[gprA_11, --, B, gprB_10, <<24], gpr_wrboth
2610:	.1218  immed[gprA_10, 0x0], gpr_wrboth
2618:	.1219  alu[--, gprA_11, OR, 0x0]
2620:	.1220  asr[gprA_10, gprB_11, >>24], gpr_wrboth
2628:	.1221  asr[gprA_11, gprB_11, >>31], gpr_wrboth
2630:	.1222  immed[gprA_0, 0x0], gpr_wrboth
2638:	.1223  immed[gprA_1, 0x0], gpr_wrboth
2640:	.1224  alu[--, gprA_10, -, gprB_0]
2648:	.1225  alu[--, gprA_11, -carry, gprB_1]
2650:	.1226  blt[.1375]
2658:	.1227  immed[gprB_21, 0x120]
2660:	.1228  alu[gprA_8, gprA_8, +, gprB_21], gpr_wrboth
2668:	.1229  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
2670:	.1230  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2678:	.1231  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2680:	.1232  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
2688:	.1233  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
2690:	.1234  alu[gprA_10, --, B, gprB_2], gpr_wrboth
2698:	.1235  alu[gprA_11, --, B, gprB_3], gpr_wrboth
26a0:	.1236  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
26a8:	.1237  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
26b0:	.1238  alu[--, gprA_4, -, gprB_10]
26b8:	.1239  alu[--, gprA_5, -carry, gprB_11]
26c0:	.1240  bcc[.1512]
26c8:	.1241  mem[read32_swap, $xfer_0, gprA_12, 0x0, 1], ctx_swap[sig1]
26d0:	.1242  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
26d8:	.1243  immed[gprA_11, 0x0], gpr_wrboth
26e0:	.1244  alu_shf[gprA_11, --, B, gprB_10, <<24], gpr_wrboth
26e8:	.1245  immed[gprA_10, 0x0], gpr_wrboth
26f0:	.1246  alu[--, gprA_11, OR, 0x0]
26f8:	.1247  asr[gprA_10, gprB_11, >>24], gpr_wrboth
2700:	.1248  asr[gprA_11, gprB_11, >>31], gpr_wrboth
2708:	.1249  immed[gprA_0, 0x0], gpr_wrboth
2710:	.1250  immed[gprA_1, 0x0], gpr_wrboth
2718:	.1251  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2720:	.1252  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2728:	.1253  alu[--, gprA_10, -, gprB_0]
2730:	.1254  alu[--, gprA_11, -carry, gprB_1]
2738:	.1255  blt[.1375]
2740:	.1256  br[.1510]
2748:	.1257  alu[gprA_21, gprA_10, XOR, 0x29]
2750:	.1258  alu[--, gprA_21, OR, gprB_11]
2758:	.1259  beq[.293]
2760:	.1260  alu[gprA_8, --, B, gprB_6], gpr_wrboth
2768:	.1261  alu[gprA_9, --, B, gprB_7], gpr_wrboth
2770:	.1262  alu[gprA_21, gprA_10, XOR, 0x2f]
2778:	.1263  alu[--, gprA_21, OR, gprB_11]
2780:	.1264  beq[.857]
2788:	.1265  alu[gprA_21, gprA_10, XOR, 0x3a]
2790:	.1266  alu[--, gprA_21, OR, gprB_11]
2798:	.1267  beq[.1269]
27a0:	.1268  br[.1510]
27a8:	.1269  alu[gprA_6, gprA_6, +, 0x20], gpr_wrboth
27b0:	.1270  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
27b8:	.1271  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
27c0:	.1272  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
27c8:	.1273  alu[gprA_2, gprA_2, +, gprB_6], gpr_wrboth
27d0:	.1274  alu[gprA_3, gprA_3, +carry, gprB_7], gpr_wrboth
27d8:	.1275  immed[gprA_0, 0x0], gpr_wrboth
27e0:	.1276  immed[gprA_1, 0x0], gpr_wrboth
27e8:	.1277  alu[--, gprA_4, -, gprB_2]
27f0:	.1278  alu[--, gprA_5, -carry, gprB_3]
27f8:	.1279  bcc[.1512]
2800:	.1280  br[.1510]
2808:	.1281  immed[gprB_21, 0x18c7]
2810:	.1282  alu[gprA_21, gprA_6, XOR, gprB_21]
2818:	.1283  alu[--, gprA_21, OR, gprB_7]
2820:	.1284  beq[.1525]
2828:	.1285  immed[gprB_21, 0x17c1]
2830:	.1286  alu[--, gprA_6, XOR, gprB_21]
2838:	.1287  bne[.1510]
2840:	.1288  alu[--, gprA_7, XOR, 0x0]
2848:	.1289  bne[.1510]
2850:	.1290  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2858:	.1291  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2860:	.1292  alu[gprA_6, gprA_6, +, 0x80], gpr_wrboth
2868:	.1293  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
2870:	.1294  alu[gprA_0, --, B, gprB_6], gpr_wrboth
2878:	.1295  alu[gprA_1, --, B, gprB_7], gpr_wrboth
2880:	.1296  dbl_shf[gprA_0, gprA_1, gprB_0, >>3], gpr_wrboth
2888:	.1297  alu_shf[gprA_1, --, B, gprB_1, >>3], gpr_wrboth
2890:	.1298  alu[gprA_12, --, B, gprB_2], gpr_wrboth
2898:	.1299  alu[gprA_13, --, B, gprB_3], gpr_wrboth
28a0:	.1300  alu[gprA_12, gprA_12, +, gprB_0], gpr_wrboth
28a8:	.1301  alu[gprA_13, gprA_13, +carry, gprB_1], gpr_wrboth
28b0:	.1302  immed[gprA_0, 0x0], gpr_wrboth
28b8:	.1303  immed[gprA_1, 0x0], gpr_wrboth
28c0:	.1304  alu[--, gprA_4, -, gprB_12]
28c8:	.1305  alu[--, gprA_5, -carry, gprB_13]
28d0:	.1306  bcc[.1512]
28d8:	.1307  alu[gprA_0, --, B, gprB_8], gpr_wrboth
28e0:	.1308  alu[gprA_1, --, B, gprB_9], gpr_wrboth
28e8:	.1309  alu[gprA_0, gprA_0, +, 0x42], gpr_wrboth
28f0:	.1310  alu[gprA_1, gprA_1, +carry, 0x0], gpr_wrboth
28f8:	.1311  dbl_shf[gprA_0, gprA_1, gprB_0, >>3], gpr_wrboth
2900:	.1312  alu_shf[gprA_1, --, B, gprB_1, >>3], gpr_wrboth
2908:	.1313  alu[gprA_12, --, B, gprB_2], gpr_wrboth
2910:	.1314  alu[gprA_13, --, B, gprB_3], gpr_wrboth
2918:	.1315  alu[gprA_12, gprA_12, +, gprB_0], gpr_wrboth
2920:	.1316  alu[gprA_13, gprA_13, +carry, gprB_1], gpr_wrboth
2928:	.1317  mem[read32_swap, $xfer_0, gprA_12, 0x0, 1], ctx_swap[sig1]
2930:	.1318  ld_field_w_clr[gprA_0, 0001, $xfer_0], gpr_wrboth
2938:	.1319  immed[gprA_1, 0x0], gpr_wrboth
2940:	.1320  alu[gprA_0, gprA_0, AND, 0x3f], gpr_wrboth
2948:	.1321  immed[gprA_1, 0x0], gpr_wrboth
2950:	.1322  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
2958:	.1323  immed[gprA_11, 0x0], gpr_wrboth
2960:	.1324  alu[gprA_10, gprA_10, AND, 0xc0], gpr_wrboth
2968:	.1325  immed[gprA_11, 0x0], gpr_wrboth
2970:	.1326  alu[gprA_0, gprA_0, OR, gprB_10], gpr_wrboth
2978:	.1327  alu[gprA_1, gprA_1, OR, gprB_11], gpr_wrboth
2980:	.1328  alu[gprA_8, gprA_8, +, 0x50], gpr_wrboth
2988:	.1329  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
2990:	.1330  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
2998:	.1331  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
29a0:	.1332  alu[gprA_10, --, B, gprB_2], gpr_wrboth
29a8:	.1333  alu[gprA_11, --, B, gprB_3], gpr_wrboth
29b0:	.1334  alu[gprA_10, gprA_10, +, gprB_8], gpr_wrboth
29b8:	.1335  alu[gprA_11, gprA_11, +carry, gprB_9], gpr_wrboth
29c0:	.1336  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
29c8:	.1337  ld_field_w_clr[gprA_8, 0011, $xfer_0], gpr_wrboth
29d0:	.1338  ld_field[gprA_8, 1001, gprB_8, >>rot8], gpr_wrboth
29d8:	.1339  ld_field[gprB_8, 1110, gprA_8, >>16], gpr_wrboth
29e0:	.1340  immed[gprA_9, 0x0], gpr_wrboth
29e8:	.1341  dbl_shf[gprA_1, gprA_1, gprB_0, >>16], gpr_wrboth
29f0:	.1342  alu_shf[gprA_0, --, B, gprB_0, <<16], gpr_wrboth
29f8:	.1343  alu[gprA_0, gprA_0, OR, gprB_8], gpr_wrboth
2a00:	.1344  alu[gprA_1, gprA_1, OR, gprB_9], gpr_wrboth
2a08:	.1345  immed[gprB_21, 0x800]
2a10:	.1346  alu[gprA_21, gprA_0, XOR, gprB_21]
2a18:	.1347  alu[--, gprA_21, OR, gprB_1]
2a20:	.1348  beq[.1418]
2a28:	.1349  immed[gprB_21, 0x6558]
2a30:	.1350  alu[gprA_21, gprA_0, XOR, gprB_21]
2a38:	.1351  alu[--, gprA_21, OR, gprB_1]
2a40:	.1352  beq[.1375]
2a48:	.1353  immed[gprB_21, 0x86dd]
2a50:	.1354  alu[gprA_21, gprA_0, XOR, gprB_21]
2a58:	.1355  alu[--, gprA_21, OR, gprB_1]
2a60:	.1356  beq[.293]
2a68:	.1357  br[.1510]
2a70:	.1358  alu[gprA_8, gprA_8, +, 0x80], gpr_wrboth
2a78:	.1359  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
2a80:	.1360  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2a88:	.1361  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2a90:	.1362  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
2a98:	.1363  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
2aa0:	.1364  alu[gprA_10, --, B, gprB_2], gpr_wrboth
2aa8:	.1365  alu[gprA_11, --, B, gprB_3], gpr_wrboth
2ab0:	.1366  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
2ab8:	.1367  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
2ac0:	.1368  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2ac8:	.1369  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2ad0:	.1370  immed[gprA_0, 0x0], gpr_wrboth
2ad8:	.1371  immed[gprA_1, 0x0], gpr_wrboth
2ae0:	.1372  alu[--, gprA_4, -, gprB_10]
2ae8:	.1373  alu[--, gprA_5, -carry, gprB_11]
2af0:	.1374  bcc[.1512]
2af8:	.1375  alu[gprA_8, --, B, gprB_6], gpr_wrboth
2b00:	.1376  alu[gprA_9, --, B, gprB_7], gpr_wrboth
2b08:	.1377  alu[gprA_8, gprA_8, +, 0x70], gpr_wrboth
2b10:	.1378  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
2b18:	.1379  alu[gprA_10, --, B, gprB_8], gpr_wrboth
2b20:	.1380  alu[gprA_11, --, B, gprB_9], gpr_wrboth
2b28:	.1381  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
2b30:	.1382  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
2b38:	.1383  alu[gprA_12, --, B, gprB_2], gpr_wrboth
2b40:	.1384  alu[gprA_13, --, B, gprB_3], gpr_wrboth
2b48:	.1385  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
2b50:	.1386  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
2b58:	.1387  immed[gprA_0, 0x0], gpr_wrboth
2b60:	.1388  immed[gprA_1, 0x0], gpr_wrboth
2b68:	.1389  alu[--, gprA_4, -, gprB_12]
2b70:	.1390  alu[--, gprA_5, -carry, gprB_13]
2b78:	.1391  bcc[.1512]
2b80:	.1392  alu[gprA_6, gprA_6, +, 0x60], gpr_wrboth
2b88:	.1393  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
2b90:	.1394  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
2b98:	.1395  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
2ba0:	.1396  alu[gprA_10, --, B, gprB_2], gpr_wrboth
2ba8:	.1397  alu[gprA_11, --, B, gprB_3], gpr_wrboth
2bb0:	.1398  alu[gprA_10, gprA_10, +, gprB_6], gpr_wrboth
2bb8:	.1399  alu[gprA_11, gprA_11, +carry, gprB_7], gpr_wrboth
2bc0:	.1400  mem[read32_swap, $xfer_0, gprA_10, 0x0, 1], ctx_swap[sig1]
2bc8:	.1401  ld_field_w_clr[gprA_10, 0011, $xfer_0], gpr_wrboth
2bd0:	.1402  ld_field[gprA_10, 1001, gprB_10, >>rot8], gpr_wrboth
2bd8:	.1403  ld_field[gprB_10, 1110, gprA_10, >>16], gpr_wrboth
2be0:	.1404  immed[gprA_11, 0x0], gpr_wrboth
2be8:	.1405  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2bf0:	.1406  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2bf8:	.1407  immed[gprB_21, 0x800]
2c00:	.1408  alu[gprA_21, gprA_10, XOR, gprB_21]
2c08:	.1409  alu[--, gprA_21, OR, gprB_11]
2c10:	.1410  beq[.1418]
2c18:	.1411  alu[gprA_6, --, B, gprB_8], gpr_wrboth
2c20:	.1412  alu[gprA_7, --, B, gprB_9], gpr_wrboth
2c28:	.1413  immed[gprB_21, 0x86dd]
2c30:	.1414  alu[gprA_21, gprA_10, XOR, gprB_21]
2c38:	.1415  alu[--, gprA_21, OR, gprB_11]
2c40:	.1416  beq[.293]
2c48:	.1417  br[.1510]
2c50:	.1418  alu[gprA_8, --, B, gprB_6], gpr_wrboth
2c58:	.1419  alu[gprA_9, --, B, gprB_7], gpr_wrboth
2c60:	.1420  alu[gprA_8, gprA_8, +, 0xa0], gpr_wrboth
2c68:	.1421  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
2c70:	.1422  alu[gprA_10, --, B, gprB_8], gpr_wrboth
2c78:	.1423  alu[gprA_11, --, B, gprB_9], gpr_wrboth
2c80:	.1424  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
2c88:	.1425  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
2c90:	.1426  alu[gprA_12, --, B, gprB_2], gpr_wrboth
2c98:	.1427  alu[gprA_13, --, B, gprB_3], gpr_wrboth
2ca0:	.1428  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
2ca8:	.1429  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
2cb0:	.1430  immed[gprA_0, 0x0], gpr_wrboth
2cb8:	.1431  immed[gprA_1, 0x0], gpr_wrboth
2cc0:	.1432  alu[--, gprA_4, -, gprB_12]
2cc8:	.1433  alu[--, gprA_5, -carry, gprB_13]
2cd0:	.1434  bcc[.1512]
2cd8:	.1435  alu[gprA_10, --, B, gprB_6], gpr_wrboth
2ce0:	.1436  alu[gprA_11, --, B, gprB_7], gpr_wrboth
2ce8:	.1437  alu[gprA_10, gprA_10, +, 0x48], gpr_wrboth
2cf0:	.1438  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
2cf8:	.1439  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
2d00:	.1440  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
2d08:	.1441  alu[gprA_0, --, B, gprB_2], gpr_wrboth
2d10:	.1442  alu[gprA_1, --, B, gprB_3], gpr_wrboth
2d18:	.1443  alu[gprA_0, gprA_0, +, gprB_10], gpr_wrboth
2d20:	.1444  alu[gprA_1, gprA_1, +carry, gprB_11], gpr_wrboth
2d28:	.1445  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
2d30:	.1446  ld_field_w_clr[gprA_0, 0001, $xfer_0], gpr_wrboth
2d38:	.1447  immed[gprA_1, 0x0], gpr_wrboth
2d40:	.1448  alu[gprA_10, --, B, gprB_6], gpr_wrboth
2d48:	.1449  alu[gprA_11, --, B, gprB_7], gpr_wrboth
2d50:	.1450  alu[gprA_10, gprA_10, +, 0x4], gpr_wrboth
2d58:	.1451  alu[gprA_11, gprA_11, +carry, 0x0], gpr_wrboth
2d60:	.1452  dbl_shf[gprA_10, gprA_11, gprB_10, >>3], gpr_wrboth
2d68:	.1453  alu_shf[gprA_11, --, B, gprB_11, >>3], gpr_wrboth
2d70:	.1454  alu[gprA_12, --, B, gprB_2], gpr_wrboth
2d78:	.1455  alu[gprA_13, --, B, gprB_3], gpr_wrboth
2d80:	.1456  alu[gprA_12, gprA_12, +, gprB_10], gpr_wrboth
2d88:	.1457  alu[gprA_13, gprA_13, +carry, gprB_11], gpr_wrboth
2d90:	.1458  mem[read32_swap, $xfer_0, gprA_12, 0x0, 1], ctx_swap[sig1]
2d98:	.1459  ld_field_w_clr[gprA_10, 0001, $xfer_0], gpr_wrboth
2da0:	.1460  immed[gprA_11, 0x0], gpr_wrboth
2da8:	.1461  alu[gprA_10, gprA_10, AND, 0xf], gpr_wrboth
2db0:	.1462  immed[gprA_11, 0x0], gpr_wrboth
2db8:	.1463  dbl_shf[gprA_11, gprA_11, gprB_10, >>24], gpr_wrboth
2dc0:	.1464  alu_shf[gprA_10, --, B, gprB_10, <<8], gpr_wrboth
2dc8:	.1465  alu[gprA_10, gprA_10, OR, gprB_0], gpr_wrboth
2dd0:	.1466  alu[gprA_11, gprA_11, OR, gprB_1], gpr_wrboth
2dd8:	.1467  alu[gprA_6, gprA_6, +, 0x33], gpr_wrboth
2de0:	.1468  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
2de8:	.1469  dbl_shf[gprA_6, gprA_7, gprB_6, >>3], gpr_wrboth
2df0:	.1470  alu_shf[gprA_7, --, B, gprB_7, >>3], gpr_wrboth
2df8:	.1471  alu[gprA_0, --, B, gprB_2], gpr_wrboth
2e00:	.1472  alu[gprA_1, --, B, gprB_3], gpr_wrboth
2e08:	.1473  alu[gprA_0, gprA_0, +, gprB_6], gpr_wrboth
2e10:	.1474  alu[gprA_1, gprA_1, +carry, gprB_7], gpr_wrboth
2e18:	.1475  mem[read32_swap, $xfer_0, gprA_0, 0x0, 1], ctx_swap[sig1]
2e20:	.1476  ld_field_w_clr[gprA_6, 0011, $xfer_0], gpr_wrboth
2e28:	.1477  immed[gprA_7, 0x0], gpr_wrboth
2e30:	.1478  immed[gprB_21, 0xff1f]
2e38:	.1479  alu[gprA_6, gprA_6, AND, gprB_21], gpr_wrboth
2e40:	.1480  immed[gprA_7, 0x0], gpr_wrboth
2e48:	.1481  ld_field[gprB_6, 1111, gprA_6, >>rot8], gpr_wrboth
2e50:	.1482  ld_field[gprB_6, 0101, gprA_6, >>rot16], gpr_wrboth
2e58:	.1483  immed[gprA_7, 0x0], gpr_wrboth
2e60:	.1484  alu[gprA_10, gprA_10, OR, gprB_6], gpr_wrboth
2e68:	.1485  alu[gprA_11, gprA_11, OR, gprB_7], gpr_wrboth
2e70:	.1486  immed[gprB_21, 0x501]
2e78:	.1487  alu[gprA_21, gprA_10, XOR, gprB_21]
2e80:	.1488  alu[--, gprA_21, OR, gprB_11]
2e88:	.1489  beq[.1513]
2e90:	.1490  immed[gprB_21, 0x506]
2e98:	.1491  alu[gprA_21, gprA_10, XOR, gprB_21]
2ea0:	.1492  alu[--, gprA_21, OR, gprB_11]
2ea8:	.1493  beq[.332]
2eb0:	.1494  immed[gprB_21, 0x511]
2eb8:	.1495  alu[gprA_21, gprA_10, XOR, gprB_21]
2ec0:	.1496  alu[--, gprA_21, OR, gprB_11]
2ec8:	.1497  beq[.1499]
2ed0:	.1498  br[.1510]
2ed8:	.1499  alu[gprA_8, gprA_8, +, 0x40], gpr_wrboth
2ee0:	.1500  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
2ee8:	.1501  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
2ef0:	.1502  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
2ef8:	.1503  alu[gprA_2, gprA_2, +, gprB_8], gpr_wrboth
2f00:	.1504  alu[gprA_3, gprA_3, +carry, gprB_9], gpr_wrboth
2f08:	.1505  immed[gprA_0, 0x0], gpr_wrboth
2f10:	.1506  immed[gprA_1, 0x0], gpr_wrboth
2f18:	.1507  alu[--, gprA_4, -, gprB_2]
2f20:	.1508  alu[--, gprA_5, -carry, gprB_3]
2f28:	.1509  bcc[.1512]
2f30:	.1510  immed[gprA_0, 0x2], gpr_wrboth
2f38:	.1511  immed[gprA_1, 0x0], gpr_wrboth
2f40:	.1512  br[.15000]
2f48:	.1513  alu[gprA_8, gprA_8, +, 0x20], gpr_wrboth
2f50:	.1514  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
2f58:	.1515  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
2f60:	.1516  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
2f68:	.1517  alu[gprA_2, gprA_2, +, gprB_8], gpr_wrboth
2f70:	.1518  alu[gprA_3, gprA_3, +carry, gprB_9], gpr_wrboth
2f78:	.1519  immed[gprA_0, 0x0], gpr_wrboth
2f80:	.1520  immed[gprA_1, 0x0], gpr_wrboth
2f88:	.1521  alu[--, gprA_4, -, gprB_2]
2f90:	.1522  alu[--, gprA_5, -carry, gprB_3]
2f98:	.1523  bcc[.1512]
2fa0:	.1524  br[.1510]
2fa8:	.1525  immed[gprB_21, 0x120]
2fb0:	.1526  alu[gprA_8, gprA_8, +, gprB_21], gpr_wrboth
2fb8:	.1527  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
2fc0:	.1528  dbl_shf[gprA_8, gprA_9, gprB_8, >>3], gpr_wrboth
2fc8:	.1529  alu_shf[gprA_9, --, B, gprB_9, >>3], gpr_wrboth
2fd0:	.1530  alu[gprA_2, gprA_2, +, gprB_8], gpr_wrboth
2fd8:	.1531  alu[gprA_3, gprA_3, +carry, gprB_9], gpr_wrboth
2fe0:	.1532  immed[gprA_0, 0x0], gpr_wrboth
2fe8:	.1533  immed[gprA_1, 0x0], gpr_wrboth
2ff0:	.1534  alu[--, gprA_4, -, gprB_2]
2ff8:	.1535  alu[--, gprA_5, -carry, gprB_3]
3000:	.1536  bcc[.1512]
3008:	.1537  br[.1510]
3010:	.1538  br[.15000], defer[2]
3018:	.1539  alu[gprA_0, --, B, 0x0]
3020:	.1540  ld_field[gprA_0, 1100, 0x82, <<16]
3028:	.1541  alu[--, 0x3, -, gprB_0]
3030:	.1542  bcc[.1538]
3038:	.1543  immed[gprB_2, 0x2282]
3040:	.1544  immed_w1[gprB_2, 0x4411]
3048:	.1545  alu_shf[gprA_1, --, B, gprB_0, <<3]
3050:	.1546  alu[--, gprA_1, OR, 0x0]
3058:	.1547  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
3060:	.1548  br[.15000], defer[2]
3068:	.1549  alu[gprA_0, --, B, 0x0]
3070:	.1550  ld_field[gprA_0, 1100, gprB_2, <<16]
3078:	.1551  nop
3080:	.1552  nop
3088:	.1553  nop
3090:	.1554  nop
3098:	.1555  nop
30a0:	.1556  nop
30a8:	.1557  nop
30b0:	.1558  nop
