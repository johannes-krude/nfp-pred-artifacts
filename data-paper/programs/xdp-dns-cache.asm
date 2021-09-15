   0:	   .0  immed[gprB_22, 0x3fff]
   8:	   .1  alu[gprB_22, gprB_22, AND, *l$index1]
  10:	   .2  immed[gprA_4, 0x0], gpr_wrboth
  18:	   .3  immed[gprA_5, 0x0], gpr_wrboth
  20:	   .4  alu[*l$index0[10], --, B, gprB_4]
  28:	   .5  alu[*l$index0[11], --, B, gprB_5]
  30:	   .6  alu[*l$index0[8], --, B, gprB_4]
  38:	   .7  alu[*l$index0[9], --, B, gprB_5]
  40:	   .8  alu[*l$index0[6], --, B, gprB_4]
  48:	   .9  alu[*l$index0[7], --, B, gprB_5]
  50:	  .10  immed[gprA_0, 0x2], gpr_wrboth
  58:	  .11  immed[gprA_1, 0x0], gpr_wrboth
  60:	  .12  alu[gprA_12, --, B, *l$index1[2]], gpr_wrboth
  68:	  .13  immed[gprA_13, 0x0], gpr_wrboth
  70:	  .14  alu[gprA_14, gprB_22, +, *l$index1[2]], gpr_wrboth
  78:	  .15  immed[gprA_15, 0x0], gpr_wrboth
  80:	  .16  alu[gprA_4, --, B, gprB_12], gpr_wrboth
  88:	  .17  alu[gprA_5, --, B, gprB_13], gpr_wrboth
  90:	  .18  alu[gprA_4, gprA_4, +, 0x36], gpr_wrboth
  98:	  .19  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
  a0:	  .20  alu[--, gprA_14, -, gprB_4]
  a8:	  .21  alu[--, gprA_15, -carry, gprB_5]
  b0:	  .22  bcc[.170]
  b8:	  .23  immed[--, 0x880]
  c0:	  .24  mem[read32_swap, $xfer_0, gprA_12, 0xc, 1], indirect_ref, ctx_swap[sig1]
  c8:	  .25  ld_field_w_clr[gprA_2, 0001, $xfer_0], gpr_wrboth
  d0:	  .26  immed[gprA_3, 0x0], gpr_wrboth
  d8:	  .27  ld_field_w_clr[gprA_6, 0001, $xfer_0, >>8], gpr_wrboth
  e0:	  .28  immed[gprA_7, 0x0], gpr_wrboth
  e8:	  .29  dbl_shf[gprA_7, gprA_7, gprB_6, >>24], gpr_wrboth
  f0:	  .30  alu_shf[gprA_6, --, B, gprB_6, <<8], gpr_wrboth
  f8:	  .31  alu[gprA_6, gprA_6, OR, gprB_2], gpr_wrboth
 100:	  .32  alu[gprA_7, gprA_7, OR, gprB_3], gpr_wrboth
 108:	  .33  alu[--, gprA_6, XOR, 0x8]
 110:	  .34  bne[.170]
 118:	  .35  alu[--, gprA_7, XOR, 0x0]
 120:	  .36  bne[.170]
 128:	  .37  ld_field_w_clr[gprA_2, 0001, $xfer_2, >>24], gpr_wrboth
 130:	  .38  immed[gprA_3, 0x0], gpr_wrboth
 138:	  .39  alu[--, gprA_2, XOR, 0x11]
 140:	  .40  bne[.170]
 148:	  .41  alu[--, gprA_3, XOR, 0x0]
 150:	  .42  bne[.170]
 158:	  .43  ld_field_w_clr[gprA_2, 0011, $xfer_6], gpr_wrboth
 160:	  .44  immed[gprA_3, 0x0], gpr_wrboth
 168:	  .45  immed[gprB_21, 0x3500]
 170:	  .46  alu[--, gprA_2, XOR, gprB_21]
 178:	  .47  bne[.170]
 180:	  .48  alu[--, gprA_3, XOR, 0x0]
 188:	  .49  bne[.170]
 190:	  .50  immed[gprA_0, 0x1], gpr_wrboth
 198:	  .51  immed[gprA_1, 0x0], gpr_wrboth
 1a0:	  .52  ld_field_w_clr[gprA_2, 0011, $xfer_8], gpr_wrboth
 1a8:	  .53  immed[gprA_3, 0x0], gpr_wrboth
 1b0:	  .54  alu_shf[gprA_3, --, B, gprB_2, <<24], gpr_wrboth
 1b8:	  .55  immed[gprA_2, 0x0], gpr_wrboth
 1c0:	  .56  alu[--, gprA_3, OR, 0x0]
 1c8:	  .57  asr[gprA_2, gprB_3, >>24], gpr_wrboth
 1d0:	  .58  asr[gprA_3, gprB_3, >>31], gpr_wrboth
 1d8:	  .59  immed[gprA_6, 0x0], gpr_wrboth
 1e0:	  .60  immed[gprA_7, 0x0], gpr_wrboth
 1e8:	  .61  alu[--, gprA_2, -, gprB_6]
 1f0:	  .62  alu[--, gprA_3, -carry, gprB_7]
 1f8:	  .63  blt[.170]
 200:	  .64  ld_field_w_clr[gprA_2, 0011, $xfer_8, >>16], gpr_wrboth
 208:	  .65  immed[gprA_3, 0x0], gpr_wrboth
 210:	  .66  immed[gprB_21, 0x100]
 218:	  .67  alu[--, gprA_2, XOR, gprB_21]
 220:	  .68  bne[.104]
 228:	  .69  alu[--, gprA_3, XOR, 0x0]
 230:	  .70  bne[.104]
 238:	  .71  alu[gprA_2, --, B, gprB_12], gpr_wrboth
 240:	  .72  alu[gprA_3, --, B, gprB_13], gpr_wrboth
 248:	  .73  alu[gprA_2, gprA_2, +, 0x37], gpr_wrboth
 250:	  .74  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
 258:	  .75  alu[--, gprA_14, -, gprB_2]
 260:	  .76  alu[--, gprA_15, -carry, gprB_3]
 268:	  .77  bcc[.104]
 270:	  .78  immed[gprA_2, 0x0], gpr_wrboth
 278:	  .79  immed[gprA_3, 0x0], gpr_wrboth
 280:	  .80  mem[read32_swap, $xfer_0, gprA_4, 0x0, 1], ctx_swap[sig1]
 288:	  .81  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 290:	  .82  immed[gprA_9, 0x0], gpr_wrboth
 298:	  .83  immed[gprA_6, 0x0], gpr_wrboth
 2a0:	  .84  immed[gprA_7, 0x0], gpr_wrboth
 2a8:	  .85  immed[gprA_10, 0x0], gpr_wrboth
 2b0:	  .86  immed[gprA_11, 0x0], gpr_wrboth
 2b8:	  .87  immed[gprA_0, 0x0], gpr_wrboth
 2c0:	  .88  immed[gprA_1, 0x0], gpr_wrboth
 2c8:	  .89  immed[gprA_18, 0x0], gpr_wrboth
 2d0:	  .90  immed[gprA_19, 0x0], gpr_wrboth
 2d8:	  .91  immed[gprA_16, 0x0], gpr_wrboth
 2e0:	  .92  immed[gprA_17, 0x0], gpr_wrboth
 2e8:	  .93  alu[--, gprA_8, OR, gprB_9]
 2f0:	  .94  beq[.775]
 2f8:	  .95  ld_field[*l$index0[6], 0001, gprB_8]
 300:	  .96  alu[gprA_2, --, B, gprB_12], gpr_wrboth
 308:	  .97  alu[gprA_3, --, B, gprB_13], gpr_wrboth
 310:	  .98  alu[gprA_2, gprA_2, +, 0x38], gpr_wrboth
 318:	  .99  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
 320:	 .100  alu[--, gprA_14, -, gprB_2]
 328:	 .101  alu[--, gprA_15, -carry, gprB_3]
 330:	 .102  bcc[.104]
 338:	 .103  br[.171]
 340:	 .104  mem[read32_swap, $xfer_0, gprA_12, 0x2c, 1], ctx_swap[sig1]
 348:	 .105  ld_field_w_clr[gprA_2, 0011, $xfer_0], gpr_wrboth
 350:	 .106  immed[gprA_3, 0x0], gpr_wrboth
 358:	 .107  immed[gprB_21, 0x400]
 360:	 .108  alu[gprA_2, gprA_2, OR, gprB_21], gpr_wrboth
 368:	 .109  alu[$xfer_0, --, B, gprA_2]
 370:	 .110  mem[write8_swap, $xfer_0, gprA_12, 0x2c, 2], ctx_swap[sig1]
 378:	 .111  alu[gprA_2, gprA_2, OR, 0x80], gpr_wrboth
 380:	 .112  alu[$xfer_0, --, B, gprA_2]
 388:	 .113  mem[write8_swap, $xfer_0, gprA_12, 0x2c, 2], ctx_swap[sig1]
 390:	 .114  mem[read32_swap, $xfer_0, gprA_12, 0x6, 2], ctx_swap[sig1]
 398:	 .115  ld_field_w_clr[gprA_2, 0001, $xfer_0], gpr_wrboth
 3a0:	 .116  ld_field[*l$index0[4], 0100, gprB_2, <<16]
 3a8:	 .117  ld_field_w_clr[gprA_4, 0001, $xfer_0, >>8], gpr_wrboth
 3b0:	 .118  ld_field[*l$index0[4], 1000, gprB_4, <<24]
 3b8:	 .119  ld_field_w_clr[gprA_4, 0001, $xfer_0, >>16], gpr_wrboth
 3c0:	 .120  ld_field[*l$index0[5], 0001, gprB_4]
 3c8:	 .121  ld_field_w_clr[gprA_4, 0001, $xfer_0, >>24], gpr_wrboth
 3d0:	 .122  ld_field[*l$index0[5], 0010, gprB_4, <<8]
 3d8:	 .123  ld_field_w_clr[gprA_4, 0001, $xfer_1], gpr_wrboth
 3e0:	 .124  ld_field[*l$index0[5], 0100, gprB_4, <<16]
 3e8:	 .125  ld_field_w_clr[gprA_4, 0001, $xfer_1, >>8], gpr_wrboth
 3f0:	 .126  ld_field[*l$index0[5], 1000, gprB_4, <<24]
 3f8:	 .127  mem[read32_swap, $xfer_0, gprA_12, 0x0, 2], ctx_swap[sig1]
 400:	 .128  alu[$xfer_0, --, B, $xfer_0]
 408:	 .129  alu[$xfer_1, --, B, $xfer_1]
 410:	 .130  mem[write8_swap, $xfer_0, gprA_12, 0x6, 6], ctx_swap[sig1]
 418:	 .131  ld_field_w_clr[gprA_4, 0001, $xfer_0, >>8], gpr_wrboth
 420:	 .132  immed[gprA_5, 0x0], gpr_wrboth
 428:	 .133  alu[$xfer_0, --, B, gprA_2]
 430:	 .134  mem[write8_swap, $xfer_0, gprA_12, 0x0, 1], ctx_swap[sig1]
 438:	 .135  ld_field_w_clr[gprA_2, 0001, *l$index0[4], >>24], gpr_wrboth
 440:	 .136  alu[$xfer_0, --, B, gprA_2]
 448:	 .137  mem[write8_swap, $xfer_0, gprA_12, 0x1, 1], ctx_swap[sig1]
 450:	 .138  ld_field_w_clr[gprA_2, 0001, *l$index0[5]], gpr_wrboth
 458:	 .139  alu[$xfer_0, --, B, gprA_2]
 460:	 .140  mem[write8_swap, $xfer_0, gprA_12, 0x2, 1], ctx_swap[sig1]
 468:	 .141  ld_field_w_clr[gprA_2, 0001, *l$index0[5], >>8], gpr_wrboth
 470:	 .142  alu[$xfer_0, --, B, gprA_2]
 478:	 .143  mem[write8_swap, $xfer_0, gprA_12, 0x3, 1], ctx_swap[sig1]
 480:	 .144  ld_field_w_clr[gprA_2, 0001, *l$index0[5], >>16], gpr_wrboth
 488:	 .145  alu[$xfer_0, --, B, gprA_2]
 490:	 .146  mem[write8_swap, $xfer_0, gprA_12, 0x4, 1], ctx_swap[sig1]
 498:	 .147  ld_field_w_clr[gprA_2, 0001, *l$index0[5], >>24], gpr_wrboth
 4a0:	 .148  alu[$xfer_0, --, B, gprA_2]
 4a8:	 .149  mem[write8_swap, $xfer_0, gprA_12, 0x5, 1], ctx_swap[sig1]
 4b0:	 .150  mem[read32_swap, $xfer_0, gprA_12, 0x1a, 2], ctx_swap[sig1]
 4b8:	 .151  alu[gprA_2, --, B, $xfer_1], gpr_wrboth
 4c0:	 .152  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
 4c8:	 .153  alu[$xfer_0, --, B, gprA_4]
 4d0:	 .154  mem[write8_swap, $xfer_0, gprA_12, 0x1e, 4], ctx_swap[sig1]
 4d8:	 .155  alu[$xfer_0, --, B, gprA_2]
 4e0:	 .156  mem[write8_swap, $xfer_0, gprA_12, 0x1a, 4], ctx_swap[sig1]
 4e8:	 .157  immed[gprA_2, 0x0], gpr_wrboth
 4f0:	 .158  immed[gprA_3, 0x0], gpr_wrboth
 4f8:	 .159  alu[$xfer_0, --, B, gprA_2]
 500:	 .160  mem[write8_swap, $xfer_0, gprA_12, 0x28, 2], ctx_swap[sig1]
 508:	 .161  mem[read32_swap, $xfer_0, gprA_12, 0x22, 1], ctx_swap[sig1]
 510:	 .162  ld_field_w_clr[gprA_2, 0011, $xfer_0, >>16], gpr_wrboth
 518:	 .163  ld_field_w_clr[gprA_4, 0011, $xfer_0], gpr_wrboth
 520:	 .164  alu[$xfer_0, --, B, gprA_4]
 528:	 .165  mem[write8_swap, $xfer_0, gprA_12, 0x24, 2], ctx_swap[sig1]
 530:	 .166  alu[$xfer_0, --, B, gprA_2]
 538:	 .167  mem[write8_swap, $xfer_0, gprA_12, 0x22, 2], ctx_swap[sig1]
 540:	 .168  immed[gprA_0, 0x3], gpr_wrboth
 548:	 .169  immed[gprA_1, 0x0], gpr_wrboth
 550:	 .170  br[.15000]
 558:	 .171  immed[gprA_16, 0x1], gpr_wrboth
 560:	 .172  immed[gprA_17, 0x0], gpr_wrboth
 568:	 .173  immed[gprA_2, 0x0], gpr_wrboth
 570:	 .174  immed[gprA_3, 0x0], gpr_wrboth
 578:	 .175  mem[read32_swap, $xfer_0, gprA_12, 0x37, 1], ctx_swap[sig1]
 580:	 .176  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 588:	 .177  immed[gprA_9, 0x0], gpr_wrboth
 590:	 .178  immed[gprA_6, 0x0], gpr_wrboth
 598:	 .179  immed[gprA_7, 0x0], gpr_wrboth
 5a0:	 .180  immed[gprA_10, 0x0], gpr_wrboth
 5a8:	 .181  immed[gprA_11, 0x0], gpr_wrboth
 5b0:	 .182  immed[gprA_0, 0x0], gpr_wrboth
 5b8:	 .183  immed[gprA_1, 0x0], gpr_wrboth
 5c0:	 .184  immed[gprA_18, 0x0], gpr_wrboth
 5c8:	 .185  immed[gprA_19, 0x0], gpr_wrboth
 5d0:	 .186  alu[--, gprA_8, OR, gprB_9]
 5d8:	 .187  beq[.775]
 5e0:	 .188  ld_field[*l$index0[6], 0010, gprB_8, <<8]
 5e8:	 .189  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 5f0:	 .190  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 5f8:	 .191  alu[gprA_6, gprA_6, +, 0x39], gpr_wrboth
 600:	 .192  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 608:	 .193  alu[--, gprA_14, -, gprB_6]
 610:	 .194  alu[--, gprA_15, -carry, gprB_7]
 618:	 .195  bcc[.104]
 620:	 .196  immed[gprA_16, 0x2], gpr_wrboth
 628:	 .197  immed[gprA_17, 0x0], gpr_wrboth
 630:	 .198  ld_field_w_clr[gprA_8, 0001, $xfer_0, >>8], gpr_wrboth
 638:	 .199  immed[gprA_9, 0x0], gpr_wrboth
 640:	 .200  immed[gprA_6, 0x0], gpr_wrboth
 648:	 .201  immed[gprA_7, 0x0], gpr_wrboth
 650:	 .202  immed[gprA_10, 0x0], gpr_wrboth
 658:	 .203  immed[gprA_11, 0x0], gpr_wrboth
 660:	 .204  immed[gprA_0, 0x0], gpr_wrboth
 668:	 .205  immed[gprA_1, 0x0], gpr_wrboth
 670:	 .206  immed[gprA_18, 0x0], gpr_wrboth
 678:	 .207  immed[gprA_19, 0x0], gpr_wrboth
 680:	 .208  alu[--, gprA_8, OR, gprB_9]
 688:	 .209  beq[.775]
 690:	 .210  ld_field[*l$index0[6], 0100, gprB_8, <<16]
 698:	 .211  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 6a0:	 .212  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 6a8:	 .213  alu[gprA_6, gprA_6, +, 0x3a], gpr_wrboth
 6b0:	 .214  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 6b8:	 .215  alu[--, gprA_14, -, gprB_6]
 6c0:	 .216  alu[--, gprA_15, -carry, gprB_7]
 6c8:	 .217  bcc[.104]
 6d0:	 .218  immed[gprA_16, 0x3], gpr_wrboth
 6d8:	 .219  immed[gprA_17, 0x0], gpr_wrboth
 6e0:	 .220  ld_field_w_clr[gprA_8, 0001, $xfer_0, >>16], gpr_wrboth
 6e8:	 .221  immed[gprA_9, 0x0], gpr_wrboth
 6f0:	 .222  immed[gprA_6, 0x0], gpr_wrboth
 6f8:	 .223  immed[gprA_7, 0x0], gpr_wrboth
 700:	 .224  immed[gprA_10, 0x0], gpr_wrboth
 708:	 .225  immed[gprA_11, 0x0], gpr_wrboth
 710:	 .226  immed[gprA_0, 0x0], gpr_wrboth
 718:	 .227  immed[gprA_1, 0x0], gpr_wrboth
 720:	 .228  immed[gprA_18, 0x0], gpr_wrboth
 728:	 .229  immed[gprA_19, 0x0], gpr_wrboth
 730:	 .230  alu[--, gprA_8, OR, gprB_9]
 738:	 .231  beq[.775]
 740:	 .232  ld_field[*l$index0[6], 1000, gprB_8, <<24]
 748:	 .233  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 750:	 .234  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 758:	 .235  alu[gprA_6, gprA_6, +, 0x3b], gpr_wrboth
 760:	 .236  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 768:	 .237  alu[gprA_18, --, B, gprB_8], gpr_wrboth
 770:	 .238  alu[gprA_19, --, B, gprB_9], gpr_wrboth
 778:	 .239  alu[--, gprA_14, -, gprB_6]
 780:	 .240  alu[--, gprA_15, -carry, gprB_7]
 788:	 .241  bcc[.104]
 790:	 .242  immed[gprA_16, 0x4], gpr_wrboth
 798:	 .243  immed[gprA_17, 0x0], gpr_wrboth
 7a0:	 .244  ld_field_w_clr[gprA_8, 0001, $xfer_0, >>24], gpr_wrboth
 7a8:	 .245  immed[gprA_9, 0x0], gpr_wrboth
 7b0:	 .246  immed[gprA_6, 0x0], gpr_wrboth
 7b8:	 .247  immed[gprA_7, 0x0], gpr_wrboth
 7c0:	 .248  immed[gprA_10, 0x0], gpr_wrboth
 7c8:	 .249  immed[gprA_11, 0x0], gpr_wrboth
 7d0:	 .250  immed[gprA_0, 0x0], gpr_wrboth
 7d8:	 .251  immed[gprA_1, 0x0], gpr_wrboth
 7e0:	 .252  alu[*l$index0[2], --, B, gprB_18]
 7e8:	 .253  alu[*l$index0[3], --, B, gprB_19]
 7f0:	 .254  alu[*l$index0, --, B, gprB_8]
 7f8:	 .255  alu[*l$index0[1], --, B, gprB_9]
 800:	 .256  alu[--, gprA_8, OR, gprB_9]
 808:	 .257  beq[.775]
 810:	 .258  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 818:	 .259  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 820:	 .260  ld_field[*l$index0[7], 0001, gprB_6]
 828:	 .261  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 830:	 .262  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 838:	 .263  alu[gprA_6, gprA_6, +, 0x3c], gpr_wrboth
 840:	 .264  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 848:	 .265  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 850:	 .266  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 858:	 .267  alu[--, gprA_14, -, gprB_6]
 860:	 .268  alu[--, gprA_15, -carry, gprB_7]
 868:	 .269  bcc[.104]
 870:	 .270  immed[gprA_16, 0x5], gpr_wrboth
 878:	 .271  immed[gprA_17, 0x0], gpr_wrboth
 880:	 .272  mem[read32_swap, $xfer_0, gprA_12, 0x3b, 1], ctx_swap[sig1]
 888:	 .273  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 890:	 .274  immed[gprA_9, 0x0], gpr_wrboth
 898:	 .275  immed[gprA_6, 0x0], gpr_wrboth
 8a0:	 .276  immed[gprA_7, 0x0], gpr_wrboth
 8a8:	 .277  immed[gprA_10, 0x0], gpr_wrboth
 8b0:	 .278  immed[gprA_11, 0x0], gpr_wrboth
 8b8:	 .279  immed[gprA_0, 0x0], gpr_wrboth
 8c0:	 .280  immed[gprA_1, 0x0], gpr_wrboth
 8c8:	 .281  alu[*l$index0, --, B, gprB_8]
 8d0:	 .282  alu[*l$index0[1], --, B, gprB_9]
 8d8:	 .283  alu[--, gprA_8, OR, gprB_9]
 8e0:	 .284  beq[.775]
 8e8:	 .285  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 8f0:	 .286  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 8f8:	 .287  ld_field[*l$index0[7], 0010, gprB_6, <<8]
 900:	 .288  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 908:	 .289  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 910:	 .290  alu[gprA_6, gprA_6, +, 0x3d], gpr_wrboth
 918:	 .291  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 920:	 .292  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 928:	 .293  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 930:	 .294  alu[--, gprA_14, -, gprB_6]
 938:	 .295  alu[--, gprA_15, -carry, gprB_7]
 940:	 .296  bcc[.104]
 948:	 .297  immed[gprA_16, 0x6], gpr_wrboth
 950:	 .298  immed[gprA_17, 0x0], gpr_wrboth
 958:	 .299  mem[read32_swap, $xfer_0, gprA_12, 0x3c, 1], ctx_swap[sig1]
 960:	 .300  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 968:	 .301  immed[gprA_9, 0x0], gpr_wrboth
 970:	 .302  immed[gprA_6, 0x0], gpr_wrboth
 978:	 .303  immed[gprA_7, 0x0], gpr_wrboth
 980:	 .304  immed[gprA_10, 0x0], gpr_wrboth
 988:	 .305  immed[gprA_11, 0x0], gpr_wrboth
 990:	 .306  immed[gprA_0, 0x0], gpr_wrboth
 998:	 .307  immed[gprA_1, 0x0], gpr_wrboth
 9a0:	 .308  alu[*l$index0, --, B, gprB_8]
 9a8:	 .309  alu[*l$index0[1], --, B, gprB_9]
 9b0:	 .310  alu[--, gprA_8, OR, gprB_9]
 9b8:	 .311  beq[.775]
 9c0:	 .312  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 9c8:	 .313  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 9d0:	 .314  ld_field[*l$index0[7], 0100, gprB_6, <<16]
 9d8:	 .315  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 9e0:	 .316  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 9e8:	 .317  alu[gprA_6, gprA_6, +, 0x3e], gpr_wrboth
 9f0:	 .318  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 9f8:	 .319  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 a00:	 .320  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 a08:	 .321  alu[--, gprA_14, -, gprB_6]
 a10:	 .322  alu[--, gprA_15, -carry, gprB_7]
 a18:	 .323  bcc[.104]
 a20:	 .324  immed[gprA_16, 0x7], gpr_wrboth
 a28:	 .325  immed[gprA_17, 0x0], gpr_wrboth
 a30:	 .326  mem[read32_swap, $xfer_0, gprA_12, 0x3d, 1], ctx_swap[sig1]
 a38:	 .327  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 a40:	 .328  immed[gprA_9, 0x0], gpr_wrboth
 a48:	 .329  immed[gprA_6, 0x0], gpr_wrboth
 a50:	 .330  immed[gprA_7, 0x0], gpr_wrboth
 a58:	 .331  immed[gprA_10, 0x0], gpr_wrboth
 a60:	 .332  immed[gprA_11, 0x0], gpr_wrboth
 a68:	 .333  immed[gprA_0, 0x0], gpr_wrboth
 a70:	 .334  immed[gprA_1, 0x0], gpr_wrboth
 a78:	 .335  alu[*l$index0, --, B, gprB_8]
 a80:	 .336  alu[*l$index0[1], --, B, gprB_9]
 a88:	 .337  alu[--, gprA_8, OR, gprB_9]
 a90:	 .338  beq[.775]
 a98:	 .339  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 aa0:	 .340  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 aa8:	 .341  ld_field[*l$index0[7], 1000, gprB_6, <<24]
 ab0:	 .342  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 ab8:	 .343  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 ac0:	 .344  alu[gprA_6, gprA_6, +, 0x3f], gpr_wrboth
 ac8:	 .345  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 ad0:	 .346  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 ad8:	 .347  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 ae0:	 .348  alu[--, gprA_14, -, gprB_6]
 ae8:	 .349  alu[--, gprA_15, -carry, gprB_7]
 af0:	 .350  bcc[.104]
 af8:	 .351  immed[gprA_16, 0x8], gpr_wrboth
 b00:	 .352  immed[gprA_17, 0x0], gpr_wrboth
 b08:	 .353  immed[gprA_0, 0x1], gpr_wrboth
 b10:	 .354  immed[gprA_1, 0x0], gpr_wrboth
 b18:	 .355  mem[read32_swap, $xfer_0, gprA_12, 0x3e, 1], ctx_swap[sig1]
 b20:	 .356  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 b28:	 .357  immed[gprA_9, 0x0], gpr_wrboth
 b30:	 .358  immed[gprA_6, 0x0], gpr_wrboth
 b38:	 .359  immed[gprA_7, 0x0], gpr_wrboth
 b40:	 .360  immed[gprA_10, 0x0], gpr_wrboth
 b48:	 .361  immed[gprA_11, 0x0], gpr_wrboth
 b50:	 .362  alu[*l$index0, --, B, gprB_8]
 b58:	 .363  alu[*l$index0[1], --, B, gprB_9]
 b60:	 .364  alu[--, gprA_8, OR, gprB_9]
 b68:	 .365  beq[.775]
 b70:	 .366  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 b78:	 .367  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 b80:	 .368  alu[gprA_21, --, B, *l$index0[8]]
 b88:	 .369  ld_field[gprA_21, 0001, gprB_6]
 b90:	 .370  alu[*l$index0[8], --, B, gprA_21]
 b98:	 .371  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 ba0:	 .372  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 ba8:	 .373  alu[gprA_6, gprA_6, +, 0x40], gpr_wrboth
 bb0:	 .374  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 bb8:	 .375  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 bc0:	 .376  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 bc8:	 .377  alu[--, gprA_14, -, gprB_6]
 bd0:	 .378  alu[--, gprA_15, -carry, gprB_7]
 bd8:	 .379  bcc[.104]
 be0:	 .380  immed[gprA_16, 0x9], gpr_wrboth
 be8:	 .381  immed[gprA_17, 0x0], gpr_wrboth
 bf0:	 .382  mem[read32_swap, $xfer_0, gprA_12, 0x3f, 1], ctx_swap[sig1]
 bf8:	 .383  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 c00:	 .384  immed[gprA_9, 0x0], gpr_wrboth
 c08:	 .385  immed[gprA_6, 0x0], gpr_wrboth
 c10:	 .386  immed[gprA_7, 0x0], gpr_wrboth
 c18:	 .387  immed[gprA_10, 0x0], gpr_wrboth
 c20:	 .388  immed[gprA_11, 0x0], gpr_wrboth
 c28:	 .389  alu[*l$index0, --, B, gprB_8]
 c30:	 .390  alu[*l$index0[1], --, B, gprB_9]
 c38:	 .391  alu[--, gprA_8, OR, gprB_9]
 c40:	 .392  beq[.775]
 c48:	 .393  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 c50:	 .394  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 c58:	 .395  alu[gprA_21, --, B, *l$index0[8]]
 c60:	 .396  ld_field[gprA_21, 0010, gprB_6, <<8]
 c68:	 .397  alu[*l$index0[8], --, B, gprA_21]
 c70:	 .398  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 c78:	 .399  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 c80:	 .400  alu[gprA_6, gprA_6, +, 0x41], gpr_wrboth
 c88:	 .401  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 c90:	 .402  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 c98:	 .403  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 ca0:	 .404  alu[--, gprA_14, -, gprB_6]
 ca8:	 .405  alu[--, gprA_15, -carry, gprB_7]
 cb0:	 .406  bcc[.104]
 cb8:	 .407  immed[gprA_16, 0xa], gpr_wrboth
 cc0:	 .408  immed[gprA_17, 0x0], gpr_wrboth
 cc8:	 .409  mem[read32_swap, $xfer_0, gprA_12, 0x40, 1], ctx_swap[sig1]
 cd0:	 .410  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 cd8:	 .411  immed[gprA_9, 0x0], gpr_wrboth
 ce0:	 .412  immed[gprA_6, 0x0], gpr_wrboth
 ce8:	 .413  immed[gprA_7, 0x0], gpr_wrboth
 cf0:	 .414  immed[gprA_10, 0x0], gpr_wrboth
 cf8:	 .415  immed[gprA_11, 0x0], gpr_wrboth
 d00:	 .416  alu[*l$index0, --, B, gprB_8]
 d08:	 .417  alu[*l$index0[1], --, B, gprB_9]
 d10:	 .418  alu[--, gprA_8, OR, gprB_9]
 d18:	 .419  beq[.775]
 d20:	 .420  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 d28:	 .421  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 d30:	 .422  alu[gprA_21, --, B, *l$index0[8]]
 d38:	 .423  ld_field[gprA_21, 0100, gprB_6, <<16]
 d40:	 .424  alu[*l$index0[8], --, B, gprA_21]
 d48:	 .425  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 d50:	 .426  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 d58:	 .427  alu[gprA_6, gprA_6, +, 0x42], gpr_wrboth
 d60:	 .428  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 d68:	 .429  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 d70:	 .430  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 d78:	 .431  alu[--, gprA_14, -, gprB_6]
 d80:	 .432  alu[--, gprA_15, -carry, gprB_7]
 d88:	 .433  bcc[.104]
 d90:	 .434  immed[gprA_16, 0xb], gpr_wrboth
 d98:	 .435  immed[gprA_17, 0x0], gpr_wrboth
 da0:	 .436  mem[read32_swap, $xfer_0, gprA_12, 0x41, 1], ctx_swap[sig1]
 da8:	 .437  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 db0:	 .438  immed[gprA_9, 0x0], gpr_wrboth
 db8:	 .439  immed[gprA_6, 0x0], gpr_wrboth
 dc0:	 .440  immed[gprA_7, 0x0], gpr_wrboth
 dc8:	 .441  immed[gprA_10, 0x0], gpr_wrboth
 dd0:	 .442  immed[gprA_11, 0x0], gpr_wrboth
 dd8:	 .443  alu[*l$index0, --, B, gprB_8]
 de0:	 .444  alu[*l$index0[1], --, B, gprB_9]
 de8:	 .445  alu[--, gprA_8, OR, gprB_9]
 df0:	 .446  beq[.775]
 df8:	 .447  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 e00:	 .448  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 e08:	 .449  alu[gprA_21, --, B, *l$index0[8]]
 e10:	 .450  ld_field[gprA_21, 1000, gprB_6, <<24]
 e18:	 .451  alu[*l$index0[8], --, B, gprA_21]
 e20:	 .452  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 e28:	 .453  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 e30:	 .454  alu[gprA_6, gprA_6, +, 0x43], gpr_wrboth
 e38:	 .455  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 e40:	 .456  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 e48:	 .457  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 e50:	 .458  alu[--, gprA_14, -, gprB_6]
 e58:	 .459  alu[--, gprA_15, -carry, gprB_7]
 e60:	 .460  bcc[.104]
 e68:	 .461  immed[gprA_16, 0xc], gpr_wrboth
 e70:	 .462  immed[gprA_17, 0x0], gpr_wrboth
 e78:	 .463  immed[gprA_10, 0x1], gpr_wrboth
 e80:	 .464  immed[gprA_11, 0x0], gpr_wrboth
 e88:	 .465  mem[read32_swap, $xfer_0, gprA_12, 0x42, 1], ctx_swap[sig1]
 e90:	 .466  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 e98:	 .467  immed[gprA_9, 0x0], gpr_wrboth
 ea0:	 .468  immed[gprA_6, 0x0], gpr_wrboth
 ea8:	 .469  immed[gprA_7, 0x0], gpr_wrboth
 eb0:	 .470  immed[gprA_0, 0x1], gpr_wrboth
 eb8:	 .471  immed[gprA_1, 0x0], gpr_wrboth
 ec0:	 .472  alu[*l$index0, --, B, gprB_8]
 ec8:	 .473  alu[*l$index0[1], --, B, gprB_9]
 ed0:	 .474  alu[--, gprA_8, OR, gprB_9]
 ed8:	 .475  beq[.775]
 ee0:	 .476  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 ee8:	 .477  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 ef0:	 .478  alu[gprA_21, --, B, *l$index0[9]]
 ef8:	 .479  ld_field[gprA_21, 0001, gprB_6]
 f00:	 .480  alu[*l$index0[9], --, B, gprA_21]
 f08:	 .481  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 f10:	 .482  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 f18:	 .483  alu[gprA_6, gprA_6, +, 0x44], gpr_wrboth
 f20:	 .484  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
 f28:	 .485  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
 f30:	 .486  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
 f38:	 .487  alu[--, gprA_14, -, gprB_6]
 f40:	 .488  alu[--, gprA_15, -carry, gprB_7]
 f48:	 .489  bcc[.104]
 f50:	 .490  immed[gprA_16, 0xd], gpr_wrboth
 f58:	 .491  immed[gprA_17, 0x0], gpr_wrboth
 f60:	 .492  mem[read32_swap, $xfer_0, gprA_12, 0x43, 1], ctx_swap[sig1]
 f68:	 .493  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
 f70:	 .494  immed[gprA_9, 0x0], gpr_wrboth
 f78:	 .495  immed[gprA_6, 0x0], gpr_wrboth
 f80:	 .496  immed[gprA_7, 0x0], gpr_wrboth
 f88:	 .497  immed[gprA_0, 0x1], gpr_wrboth
 f90:	 .498  immed[gprA_1, 0x0], gpr_wrboth
 f98:	 .499  alu[*l$index0, --, B, gprB_8]
 fa0:	 .500  alu[*l$index0[1], --, B, gprB_9]
 fa8:	 .501  alu[--, gprA_8, OR, gprB_9]
 fb0:	 .502  beq[.775]
 fb8:	 .503  alu[gprA_6, --, B, *l$index0], gpr_wrboth
 fc0:	 .504  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
 fc8:	 .505  alu[gprA_21, --, B, *l$index0[9]]
 fd0:	 .506  ld_field[gprA_21, 0010, gprB_6, <<8]
 fd8:	 .507  alu[*l$index0[9], --, B, gprA_21]
 fe0:	 .508  alu[gprA_6, --, B, gprB_12], gpr_wrboth
 fe8:	 .509  alu[gprA_7, --, B, gprB_13], gpr_wrboth
 ff0:	 .510  alu[gprA_6, gprA_6, +, 0x45], gpr_wrboth
 ff8:	 .511  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
1000:	 .512  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
1008:	 .513  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
1010:	 .514  alu[--, gprA_14, -, gprB_6]
1018:	 .515  alu[--, gprA_15, -carry, gprB_7]
1020:	 .516  bcc[.104]
1028:	 .517  immed[gprA_16, 0xe], gpr_wrboth
1030:	 .518  immed[gprA_17, 0x0], gpr_wrboth
1038:	 .519  mem[read32_swap, $xfer_0, gprA_12, 0x44, 1], ctx_swap[sig1]
1040:	 .520  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
1048:	 .521  immed[gprA_9, 0x0], gpr_wrboth
1050:	 .522  immed[gprA_6, 0x0], gpr_wrboth
1058:	 .523  immed[gprA_7, 0x0], gpr_wrboth
1060:	 .524  immed[gprA_0, 0x1], gpr_wrboth
1068:	 .525  immed[gprA_1, 0x0], gpr_wrboth
1070:	 .526  alu[*l$index0, --, B, gprB_8]
1078:	 .527  alu[*l$index0[1], --, B, gprB_9]
1080:	 .528  alu[--, gprA_8, OR, gprB_9]
1088:	 .529  beq[.775]
1090:	 .530  alu[gprA_6, --, B, *l$index0], gpr_wrboth
1098:	 .531  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
10a0:	 .532  alu[gprA_21, --, B, *l$index0[9]]
10a8:	 .533  ld_field[gprA_21, 0100, gprB_6, <<16]
10b0:	 .534  alu[*l$index0[9], --, B, gprA_21]
10b8:	 .535  alu[gprA_6, --, B, gprB_12], gpr_wrboth
10c0:	 .536  alu[gprA_7, --, B, gprB_13], gpr_wrboth
10c8:	 .537  alu[gprA_6, gprA_6, +, 0x46], gpr_wrboth
10d0:	 .538  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
10d8:	 .539  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
10e0:	 .540  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
10e8:	 .541  alu[--, gprA_14, -, gprB_6]
10f0:	 .542  alu[--, gprA_15, -carry, gprB_7]
10f8:	 .543  bcc[.104]
1100:	 .544  immed[gprA_16, 0xf], gpr_wrboth
1108:	 .545  immed[gprA_17, 0x0], gpr_wrboth
1110:	 .546  mem[read32_swap, $xfer_0, gprA_12, 0x45, 1], ctx_swap[sig1]
1118:	 .547  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
1120:	 .548  immed[gprA_9, 0x0], gpr_wrboth
1128:	 .549  immed[gprA_6, 0x0], gpr_wrboth
1130:	 .550  immed[gprA_7, 0x0], gpr_wrboth
1138:	 .551  immed[gprA_0, 0x1], gpr_wrboth
1140:	 .552  immed[gprA_1, 0x0], gpr_wrboth
1148:	 .553  alu[*l$index0, --, B, gprB_8]
1150:	 .554  alu[*l$index0[1], --, B, gprB_9]
1158:	 .555  alu[--, gprA_8, OR, gprB_9]
1160:	 .556  beq[.775]
1168:	 .557  alu[gprA_6, --, B, *l$index0], gpr_wrboth
1170:	 .558  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
1178:	 .559  alu[gprA_21, --, B, *l$index0[9]]
1180:	 .560  ld_field[gprA_21, 1000, gprB_6, <<24]
1188:	 .561  alu[*l$index0[9], --, B, gprA_21]
1190:	 .562  alu[gprA_6, --, B, gprB_12], gpr_wrboth
1198:	 .563  alu[gprA_7, --, B, gprB_13], gpr_wrboth
11a0:	 .564  alu[gprA_6, gprA_6, +, 0x47], gpr_wrboth
11a8:	 .565  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
11b0:	 .566  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
11b8:	 .567  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
11c0:	 .568  alu[--, gprA_14, -, gprB_6]
11c8:	 .569  alu[--, gprA_15, -carry, gprB_7]
11d0:	 .570  bcc[.104]
11d8:	 .571  immed[gprA_16, 0x10], gpr_wrboth
11e0:	 .572  immed[gprA_17, 0x0], gpr_wrboth
11e8:	 .573  immed[gprA_6, 0x1], gpr_wrboth
11f0:	 .574  immed[gprA_7, 0x0], gpr_wrboth
11f8:	 .575  mem[read32_swap, $xfer_0, gprA_12, 0x46, 1], ctx_swap[sig1]
1200:	 .576  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
1208:	 .577  immed[gprA_9, 0x0], gpr_wrboth
1210:	 .578  immed[gprA_10, 0x1], gpr_wrboth
1218:	 .579  immed[gprA_11, 0x0], gpr_wrboth
1220:	 .580  immed[gprA_0, 0x1], gpr_wrboth
1228:	 .581  immed[gprA_1, 0x0], gpr_wrboth
1230:	 .582  alu[--, gprA_8, OR, gprB_9]
1238:	 .583  beq[.775]
1240:	 .584  alu[gprA_21, --, B, *l$index0[10]]
1248:	 .585  ld_field[gprA_21, 0001, gprB_8]
1250:	 .586  alu[*l$index0[10], --, B, gprA_21]
1258:	 .587  alu[gprA_8, --, B, gprB_12], gpr_wrboth
1260:	 .588  alu[gprA_9, --, B, gprB_13], gpr_wrboth
1268:	 .589  alu[gprA_8, gprA_8, +, 0x48], gpr_wrboth
1270:	 .590  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
1278:	 .591  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
1280:	 .592  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
1288:	 .593  alu[--, gprA_14, -, gprB_8]
1290:	 .594  alu[--, gprA_15, -carry, gprB_9]
1298:	 .595  bcc[.104]
12a0:	 .596  immed[gprA_16, 0x11], gpr_wrboth
12a8:	 .597  immed[gprA_17, 0x0], gpr_wrboth
12b0:	 .598  mem[read32_swap, $xfer_0, gprA_12, 0x47, 1], ctx_swap[sig1]
12b8:	 .599  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
12c0:	 .600  immed[gprA_9, 0x0], gpr_wrboth
12c8:	 .601  immed[gprA_10, 0x1], gpr_wrboth
12d0:	 .602  immed[gprA_11, 0x0], gpr_wrboth
12d8:	 .603  immed[gprA_0, 0x1], gpr_wrboth
12e0:	 .604  immed[gprA_1, 0x0], gpr_wrboth
12e8:	 .605  alu[--, gprA_8, OR, gprB_9]
12f0:	 .606  beq[.775]
12f8:	 .607  alu[gprA_21, --, B, *l$index0[10]]
1300:	 .608  ld_field[gprA_21, 0010, gprB_8, <<8]
1308:	 .609  alu[*l$index0[10], --, B, gprA_21]
1310:	 .610  alu[gprA_8, --, B, gprB_12], gpr_wrboth
1318:	 .611  alu[gprA_9, --, B, gprB_13], gpr_wrboth
1320:	 .612  alu[gprA_8, gprA_8, +, 0x49], gpr_wrboth
1328:	 .613  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
1330:	 .614  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
1338:	 .615  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
1340:	 .616  alu[--, gprA_14, -, gprB_8]
1348:	 .617  alu[--, gprA_15, -carry, gprB_9]
1350:	 .618  bcc[.104]
1358:	 .619  immed[gprA_16, 0x12], gpr_wrboth
1360:	 .620  immed[gprA_17, 0x0], gpr_wrboth
1368:	 .621  mem[read32_swap, $xfer_0, gprA_12, 0x48, 1], ctx_swap[sig1]
1370:	 .622  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
1378:	 .623  immed[gprA_9, 0x0], gpr_wrboth
1380:	 .624  immed[gprA_10, 0x1], gpr_wrboth
1388:	 .625  immed[gprA_11, 0x0], gpr_wrboth
1390:	 .626  immed[gprA_0, 0x1], gpr_wrboth
1398:	 .627  immed[gprA_1, 0x0], gpr_wrboth
13a0:	 .628  alu[--, gprA_8, OR, gprB_9]
13a8:	 .629  beq[.775]
13b0:	 .630  alu[gprA_21, --, B, *l$index0[10]]
13b8:	 .631  ld_field[gprA_21, 0100, gprB_8, <<16]
13c0:	 .632  alu[*l$index0[10], --, B, gprA_21]
13c8:	 .633  alu[gprA_8, --, B, gprB_12], gpr_wrboth
13d0:	 .634  alu[gprA_9, --, B, gprB_13], gpr_wrboth
13d8:	 .635  alu[gprA_8, gprA_8, +, 0x4a], gpr_wrboth
13e0:	 .636  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
13e8:	 .637  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
13f0:	 .638  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
13f8:	 .639  alu[--, gprA_14, -, gprB_8]
1400:	 .640  alu[--, gprA_15, -carry, gprB_9]
1408:	 .641  bcc[.104]
1410:	 .642  immed[gprA_16, 0x13], gpr_wrboth
1418:	 .643  immed[gprA_17, 0x0], gpr_wrboth
1420:	 .644  mem[read32_swap, $xfer_0, gprA_12, 0x49, 1], ctx_swap[sig1]
1428:	 .645  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
1430:	 .646  immed[gprA_9, 0x0], gpr_wrboth
1438:	 .647  immed[gprA_10, 0x1], gpr_wrboth
1440:	 .648  immed[gprA_11, 0x0], gpr_wrboth
1448:	 .649  immed[gprA_0, 0x1], gpr_wrboth
1450:	 .650  immed[gprA_1, 0x0], gpr_wrboth
1458:	 .651  alu[*l$index0, --, B, gprB_8]
1460:	 .652  alu[*l$index0[1], --, B, gprB_9]
1468:	 .653  alu[--, gprA_8, OR, gprB_9]
1470:	 .654  beq[.775]
1478:	 .655  alu[gprA_2, --, B, *l$index0], gpr_wrboth
1480:	 .656  alu[gprA_3, --, B, *l$index0[1]], gpr_wrboth
1488:	 .657  alu[gprA_21, --, B, *l$index0[10]]
1490:	 .658  ld_field[gprA_21, 1000, gprB_2, <<24]
1498:	 .659  alu[*l$index0[10], --, B, gprA_21]
14a0:	 .660  alu[gprA_2, --, B, gprB_12], gpr_wrboth
14a8:	 .661  alu[gprA_3, --, B, gprB_13], gpr_wrboth
14b0:	 .662  alu[gprA_2, gprA_2, +, 0x4b], gpr_wrboth
14b8:	 .663  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
14c0:	 .664  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
14c8:	 .665  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
14d0:	 .666  alu[--, gprA_14, -, gprB_2]
14d8:	 .667  alu[--, gprA_15, -carry, gprB_3]
14e0:	 .668  bcc[.104]
14e8:	 .669  immed[gprA_16, 0x14], gpr_wrboth
14f0:	 .670  immed[gprA_17, 0x0], gpr_wrboth
14f8:	 .671  immed[gprA_2, 0x1], gpr_wrboth
1500:	 .672  immed[gprA_3, 0x0], gpr_wrboth
1508:	 .673  mem[read32_swap, $xfer_0, gprA_12, 0x4a, 1], ctx_swap[sig1]
1510:	 .674  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
1518:	 .675  immed[gprA_9, 0x0], gpr_wrboth
1520:	 .676  immed[gprA_6, 0x1], gpr_wrboth
1528:	 .677  immed[gprA_7, 0x0], gpr_wrboth
1530:	 .678  immed[gprA_10, 0x1], gpr_wrboth
1538:	 .679  immed[gprA_11, 0x0], gpr_wrboth
1540:	 .680  immed[gprA_0, 0x1], gpr_wrboth
1548:	 .681  immed[gprA_1, 0x0], gpr_wrboth
1550:	 .682  alu[*l$index0, --, B, gprB_8]
1558:	 .683  alu[*l$index0[1], --, B, gprB_9]
1560:	 .684  alu[--, gprA_8, OR, gprB_9]
1568:	 .685  beq[.775]
1570:	 .686  alu[gprA_6, --, B, *l$index0], gpr_wrboth
1578:	 .687  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
1580:	 .688  alu[gprA_21, --, B, *l$index0[11]]
1588:	 .689  ld_field[gprA_21, 0001, gprB_6]
1590:	 .690  alu[*l$index0[11], --, B, gprA_21]
1598:	 .691  alu[gprA_6, --, B, gprB_12], gpr_wrboth
15a0:	 .692  alu[gprA_7, --, B, gprB_13], gpr_wrboth
15a8:	 .693  alu[gprA_6, gprA_6, +, 0x4c], gpr_wrboth
15b0:	 .694  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
15b8:	 .695  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
15c0:	 .696  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
15c8:	 .697  alu[--, gprA_14, -, gprB_6]
15d0:	 .698  alu[--, gprA_15, -carry, gprB_7]
15d8:	 .699  bcc[.104]
15e0:	 .700  immed[gprA_16, 0x15], gpr_wrboth
15e8:	 .701  immed[gprA_17, 0x0], gpr_wrboth
15f0:	 .702  mem[read32_swap, $xfer_0, gprA_12, 0x4b, 1], ctx_swap[sig1]
15f8:	 .703  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
1600:	 .704  immed[gprA_9, 0x0], gpr_wrboth
1608:	 .705  immed[gprA_6, 0x1], gpr_wrboth
1610:	 .706  immed[gprA_7, 0x0], gpr_wrboth
1618:	 .707  immed[gprA_10, 0x1], gpr_wrboth
1620:	 .708  immed[gprA_11, 0x0], gpr_wrboth
1628:	 .709  immed[gprA_0, 0x1], gpr_wrboth
1630:	 .710  immed[gprA_1, 0x0], gpr_wrboth
1638:	 .711  alu[*l$index0, --, B, gprB_8]
1640:	 .712  alu[*l$index0[1], --, B, gprB_9]
1648:	 .713  alu[--, gprA_8, OR, gprB_9]
1650:	 .714  beq[.775]
1658:	 .715  alu[gprA_6, --, B, *l$index0], gpr_wrboth
1660:	 .716  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
1668:	 .717  alu[gprA_21, --, B, *l$index0[11]]
1670:	 .718  ld_field[gprA_21, 0010, gprB_6, <<8]
1678:	 .719  alu[*l$index0[11], --, B, gprA_21]
1680:	 .720  alu[gprA_6, --, B, gprB_12], gpr_wrboth
1688:	 .721  alu[gprA_7, --, B, gprB_13], gpr_wrboth
1690:	 .722  alu[gprA_6, gprA_6, +, 0x4d], gpr_wrboth
1698:	 .723  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
16a0:	 .724  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
16a8:	 .725  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
16b0:	 .726  alu[--, gprA_14, -, gprB_6]
16b8:	 .727  alu[--, gprA_15, -carry, gprB_7]
16c0:	 .728  bcc[.104]
16c8:	 .729  immed[gprA_16, 0x16], gpr_wrboth
16d0:	 .730  immed[gprA_17, 0x0], gpr_wrboth
16d8:	 .731  mem[read32_swap, $xfer_0, gprA_12, 0x4c, 1], ctx_swap[sig1]
16e0:	 .732  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
16e8:	 .733  immed[gprA_9, 0x0], gpr_wrboth
16f0:	 .734  immed[gprA_6, 0x1], gpr_wrboth
16f8:	 .735  immed[gprA_7, 0x0], gpr_wrboth
1700:	 .736  immed[gprA_10, 0x1], gpr_wrboth
1708:	 .737  immed[gprA_11, 0x0], gpr_wrboth
1710:	 .738  immed[gprA_0, 0x1], gpr_wrboth
1718:	 .739  immed[gprA_1, 0x0], gpr_wrboth
1720:	 .740  alu[*l$index0, --, B, gprB_8]
1728:	 .741  alu[*l$index0[1], --, B, gprB_9]
1730:	 .742  alu[--, gprA_8, OR, gprB_9]
1738:	 .743  beq[.775]
1740:	 .744  alu[gprA_6, --, B, *l$index0], gpr_wrboth
1748:	 .745  alu[gprA_7, --, B, *l$index0[1]], gpr_wrboth
1750:	 .746  alu[gprA_21, --, B, *l$index0[11]]
1758:	 .747  ld_field[gprA_21, 0100, gprB_6, <<16]
1760:	 .748  alu[*l$index0[11], --, B, gprA_21]
1768:	 .749  alu[gprA_6, --, B, gprB_12], gpr_wrboth
1770:	 .750  alu[gprA_7, --, B, gprB_13], gpr_wrboth
1778:	 .751  alu[gprA_6, gprA_6, +, 0x4e], gpr_wrboth
1780:	 .752  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
1788:	 .753  alu[gprA_18, --, B, *l$index0[2]], gpr_wrboth
1790:	 .754  alu[gprA_19, --, B, *l$index0[3]], gpr_wrboth
1798:	 .755  alu[--, gprA_14, -, gprB_6]
17a0:	 .756  alu[--, gprA_15, -carry, gprB_7]
17a8:	 .757  bcc[.104]
17b0:	 .758  immed[gprA_16, 0x17], gpr_wrboth
17b8:	 .759  immed[gprA_17, 0x0], gpr_wrboth
17c0:	 .760  mem[read32_swap, $xfer_0, gprA_12, 0x4d, 1], ctx_swap[sig1]
17c8:	 .761  ld_field_w_clr[gprA_8, 0001, $xfer_0], gpr_wrboth
17d0:	 .762  immed[gprA_9, 0x0], gpr_wrboth
17d8:	 .763  immed[gprA_6, 0x1], gpr_wrboth
17e0:	 .764  immed[gprA_7, 0x0], gpr_wrboth
17e8:	 .765  immed[gprA_10, 0x1], gpr_wrboth
17f0:	 .766  immed[gprA_11, 0x0], gpr_wrboth
17f8:	 .767  immed[gprA_0, 0x1], gpr_wrboth
1800:	 .768  immed[gprA_1, 0x0], gpr_wrboth
1808:	 .769  alu[--, gprA_8, OR, gprB_9]
1810:	 .770  beq[.775]
1818:	 .771  alu[gprA_21, --, B, *l$index0[11]]
1820:	 .772  ld_field[gprA_21, 1000, gprB_8, <<24]
1828:	 .773  alu[*l$index0[11], --, B, gprA_21]
1830:	 .774  br[.104]
1838:	 .775  alu[gprA_4, gprA_4, +, gprB_16], gpr_wrboth
1840:	 .776  alu[gprA_5, gprA_5, +carry, gprB_17], gpr_wrboth
1848:	 .777  alu[gprA_16, --, B, gprB_4], gpr_wrboth
1850:	 .778  alu[gprA_17, --, B, gprB_5], gpr_wrboth
1858:	 .779  alu[gprA_16, gprA_16, +, 0x5], gpr_wrboth
1860:	 .780  alu[gprA_17, gprA_17, +carry, 0x0], gpr_wrboth
1868:	 .781  alu[--, gprA_14, -, gprB_16]
1870:	 .782  alu[--, gprA_15, -carry, gprB_17]
1878:	 .783  bcc[.104]
1880:	 .784  alu[gprA_4, gprA_4, +, 0x1], gpr_wrboth
1888:	 .785  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
1890:	 .786  mem[read32_swap, $xfer_0, gprA_4, 0x0, 1], ctx_swap[sig1]
1898:	 .787  ld_field_w_clr[gprA_8, 0011, $xfer_0], gpr_wrboth
18a0:	 .788  immed[gprA_9, 0x0], gpr_wrboth
18a8:	 .789  immed[gprB_21, 0x100]
18b0:	 .790  alu[--, gprA_8, XOR, gprB_21]
18b8:	 .791  bne[.1435]
18c0:	 .792  alu[--, gprA_9, XOR, 0x0]
18c8:	 .793  bne[.1435]
18d0:	 .794  ld_field_w_clr[gprA_4, 0011, $xfer_0, >>16], gpr_wrboth
18d8:	 .795  immed[gprA_5, 0x0], gpr_wrboth
18e0:	 .796  immed[gprB_21, 0x100]
18e8:	 .797  alu[--, gprA_4, XOR, gprB_21]
18f0:	 .798  bne[.1435]
18f8:	 .799  alu[--, gprA_5, XOR, 0x0]
1900:	 .800  bne[.1435]
1908:	 .801  alu[*l$index0[2], --, B, gprB_16]
1910:	 .802  alu[*l$index0[3], --, B, gprB_17]
1918:	 .803  immed[gprA_4, 0x0], gpr_wrboth
1920:	 .804  immed[gprA_5, 0x0], gpr_wrboth
1928:	 .805  alu[*l$index0[12], --, B, gprB_4]
1930:	 .806  immed[gprA_5, 0x0], gpr_wrboth
1938:	 .807  alu[gprA_4, --, B, *l$index0[6]], gpr_wrboth
1940:	 .808  alu[gprA_8, --, B, gprB_4], gpr_wrboth
1948:	 .809  alu[gprA_9, --, B, gprB_5], gpr_wrboth
1950:	 .810  dbl_shf[gprA_8, gprA_9, gprB_8, >>15], gpr_wrboth
1958:	 .811  alu_shf[gprA_9, --, B, gprB_9, >>15], gpr_wrboth
1960:	 .812  alu[gprA_8, gprA_8, XOR, gprB_4], gpr_wrboth
1968:	 .813  alu[gprA_9, gprA_9, XOR, gprB_5], gpr_wrboth
1970:	 .814  alu[*l$index0[13], --, B, gprB_8]
1978:	 .815  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
1980:	 .816  alu[*l$index0[13], --, B, gprB_4]
1988:	 .817  immed[gprA_5, 0x0], gpr_wrboth
1990:	 .818  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
1998:	 .819  immed[gprB_21, 0x3c6d]
19a0:	 .820  immed_w1[gprB_21, 0x2c1b]
19a8:	 .821  mul_step[gprA_4, gprB_21], start
19b0:	 .822  mul_step[gprA_4, gprB_21], 32x32_step1
19b8:	 .823  mul_step[gprA_4, gprB_21], 32x32_step2
19c0:	 .824  mul_step[gprA_4, gprB_21], 32x32_step3
19c8:	 .825  mul_step[gprA_4, gprB_21], 32x32_step4
19d0:	 .826  mul_step[gprA_4, --], 32x32_last, gpr_wrboth
19d8:	 .827  mul_step[gprA_5, --], 32x32_last2, gpr_wrboth
19e0:	 .828  immed[gprA_16, 0xfffff000], gpr_wrboth
19e8:	 .829  immed[gprA_17, 0x0], gpr_wrboth
19f0:	 .830  alu[gprA_8, --, B, gprB_4], gpr_wrboth
19f8:	 .831  alu[gprA_9, --, B, gprB_5], gpr_wrboth
1a00:	 .832  alu[gprA_8, gprA_8, AND, gprB_16], gpr_wrboth
1a08:	 .833  alu[gprA_9, gprA_9, AND, gprB_17], gpr_wrboth
1a10:	 .834  dbl_shf[gprA_8, gprA_9, gprB_8, >>12], gpr_wrboth
1a18:	 .835  alu_shf[gprA_9, --, B, gprB_9, >>12], gpr_wrboth
1a20:	 .836  alu[gprA_8, gprA_8, XOR, gprB_4], gpr_wrboth
1a28:	 .837  alu[gprA_9, gprA_9, XOR, gprB_5], gpr_wrboth
1a30:	 .838  alu[*l$index0[13], --, B, gprB_8]
1a38:	 .839  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
1a40:	 .840  alu[*l$index0[13], --, B, gprB_4]
1a48:	 .841  immed[gprA_9, 0x0], gpr_wrboth
1a50:	 .842  alu[gprA_8, --, B, *l$index0[13]], gpr_wrboth
1a58:	 .843  immed[gprB_21, 0x2d39]
1a60:	 .844  immed_w1[gprB_21, 0x297a]
1a68:	 .845  mul_step[gprA_8, gprB_21], start
1a70:	 .846  mul_step[gprA_8, gprB_21], 32x32_step1
1a78:	 .847  mul_step[gprA_8, gprB_21], 32x32_step2
1a80:	 .848  mul_step[gprA_8, gprB_21], 32x32_step3
1a88:	 .849  mul_step[gprA_8, gprB_21], 32x32_step4
1a90:	 .850  mul_step[gprA_8, --], 32x32_last, gpr_wrboth
1a98:	 .851  mul_step[gprA_9, --], 32x32_last2, gpr_wrboth
1aa0:	 .852  immed[gprA_16, 0xffff8000], gpr_wrboth
1aa8:	 .853  immed[gprA_17, 0x0], gpr_wrboth
1ab0:	 .854  alu[gprA_4, --, B, gprB_8], gpr_wrboth
1ab8:	 .855  alu[gprA_5, --, B, gprB_9], gpr_wrboth
1ac0:	 .856  alu[gprA_4, gprA_4, AND, gprB_16], gpr_wrboth
1ac8:	 .857  alu[gprA_5, gprA_5, AND, gprB_17], gpr_wrboth
1ad0:	 .858  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1ad8:	 .859  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1ae0:	 .860  alu[gprA_4, gprA_4, XOR, gprB_8], gpr_wrboth
1ae8:	 .861  alu[gprA_5, gprA_5, XOR, gprB_9], gpr_wrboth
1af0:	 .862  alu[--, gprA_18, OR, gprB_19]
1af8:	 .863  beq[.924]
1b00:	 .864  immed[gprA_9, 0x0], gpr_wrboth
1b08:	 .865  alu[gprA_8, --, B, *l$index0[7]], gpr_wrboth
1b10:	 .866  alu[gprA_8, gprA_8, XOR, gprB_4], gpr_wrboth
1b18:	 .867  alu[gprA_9, gprA_9, XOR, gprB_5], gpr_wrboth
1b20:	 .868  alu[gprA_4, --, B, gprB_8], gpr_wrboth
1b28:	 .869  alu[gprA_5, --, B, gprB_9], gpr_wrboth
1b30:	 .870  alu[gprA_4, gprA_4, AND, gprB_16], gpr_wrboth
1b38:	 .871  alu[gprA_5, gprA_5, AND, gprB_17], gpr_wrboth
1b40:	 .872  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1b48:	 .873  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1b50:	 .874  alu[gprA_4, gprA_4, XOR, gprB_8], gpr_wrboth
1b58:	 .875  alu[gprA_5, gprA_5, XOR, gprB_9], gpr_wrboth
1b60:	 .876  alu[*l$index0[13], --, B, gprB_4]
1b68:	 .877  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
1b70:	 .878  alu[*l$index0[13], --, B, gprB_4]
1b78:	 .879  immed[gprA_5, 0x0], gpr_wrboth
1b80:	 .880  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
1b88:	 .881  immed[gprB_21, 0x3c6d]
1b90:	 .882  immed_w1[gprB_21, 0x2c1b]
1b98:	 .883  mul_step[gprA_4, gprB_21], start
1ba0:	 .884  mul_step[gprA_4, gprB_21], 32x32_step1
1ba8:	 .885  mul_step[gprA_4, gprB_21], 32x32_step2
1bb0:	 .886  mul_step[gprA_4, gprB_21], 32x32_step3
1bb8:	 .887  mul_step[gprA_4, gprB_21], 32x32_step4
1bc0:	 .888  mul_step[gprA_4, --], 32x32_last, gpr_wrboth
1bc8:	 .889  mul_step[gprA_5, --], 32x32_last2, gpr_wrboth
1bd0:	 .890  alu[gprA_8, --, B, gprB_4], gpr_wrboth
1bd8:	 .891  alu[gprA_9, --, B, gprB_5], gpr_wrboth
1be0:	 .892  immed[gprA_18, 0xfffff000], gpr_wrboth
1be8:	 .893  immed[gprA_19, 0x0], gpr_wrboth
1bf0:	 .894  alu[gprA_8, gprA_8, AND, gprB_18], gpr_wrboth
1bf8:	 .895  alu[gprA_9, gprA_9, AND, gprB_19], gpr_wrboth
1c00:	 .896  dbl_shf[gprA_8, gprA_9, gprB_8, >>12], gpr_wrboth
1c08:	 .897  alu_shf[gprA_9, --, B, gprB_9, >>12], gpr_wrboth
1c10:	 .898  alu[gprA_8, gprA_8, XOR, gprB_4], gpr_wrboth
1c18:	 .899  alu[gprA_9, gprA_9, XOR, gprB_5], gpr_wrboth
1c20:	 .900  alu[*l$index0[13], --, B, gprB_8]
1c28:	 .901  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
1c30:	 .902  alu[*l$index0[13], --, B, gprB_4]
1c38:	 .903  immed[gprA_9, 0x0], gpr_wrboth
1c40:	 .904  alu[gprA_8, --, B, *l$index0[13]], gpr_wrboth
1c48:	 .905  immed[gprB_21, 0x2d39]
1c50:	 .906  immed_w1[gprB_21, 0x297a]
1c58:	 .907  mul_step[gprA_8, gprB_21], start
1c60:	 .908  mul_step[gprA_8, gprB_21], 32x32_step1
1c68:	 .909  mul_step[gprA_8, gprB_21], 32x32_step2
1c70:	 .910  mul_step[gprA_8, gprB_21], 32x32_step3
1c78:	 .911  mul_step[gprA_8, gprB_21], 32x32_step4
1c80:	 .912  mul_step[gprA_8, --], 32x32_last, gpr_wrboth
1c88:	 .913  mul_step[gprA_9, --], 32x32_last2, gpr_wrboth
1c90:	 .914  alu[gprA_4, --, B, gprB_8], gpr_wrboth
1c98:	 .915  alu[gprA_5, --, B, gprB_9], gpr_wrboth
1ca0:	 .916  alu[gprA_4, gprA_4, AND, gprB_16], gpr_wrboth
1ca8:	 .917  alu[gprA_5, gprA_5, AND, gprB_17], gpr_wrboth
1cb0:	 .918  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
1cb8:	 .919  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
1cc0:	 .920  alu[gprA_4, gprA_4, XOR, gprB_8], gpr_wrboth
1cc8:	 .921  alu[gprA_5, gprA_5, XOR, gprB_9], gpr_wrboth
1cd0:	 .922  alu[--, gprA_0, OR, gprB_1]
1cd8:	 .923  bne[.1441]
1ce0:	 .924  alu[*l$index0[12], --, B, gprB_4]
1ce8:	 .925  alu[gprA_4, gprA_22, +, 0x38], gpr_wrboth
1cf0:	 .926  immed[gprA_5, 0x0], gpr_wrboth
1cf8:	 .927  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
1d00:	 .928  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
1d08:	 .929  immed[gprA_2, 0x0], gpr_wrboth
1d10:	 .930  alu[gprA_3, --, B, gprA_2], gpr_wrboth
1d18:	 .931  local_csr_wr[ActLMAddr0, gprB_4]
1d20:	 .932  alu[gprA_1, --, B, gprB_23], gpr_wrboth
1d28:	 .933  nop
1d30:	 .934  immed[gprA_21, 0xffff003f, <<16]
1d38:	 .935  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<6], gpr_wrboth
1d40:	 .936  local_csr_wr[ActLMAddr0, gprA_22]
1d48:	 .937  nop
1d50:	 .938  nop
1d58:	 .939  nop
1d60:	 .940  alu[gprA_16, --, B, *l$index0[2]], gpr_wrboth
1d68:	 .941  alu[gprA_17, --, B, *l$index0[3]], gpr_wrboth
1d70:	 .942  alu[--, gprA_0, OR, gprB_1]
1d78:	 .943  beq[.1435]
1d80:	 .944  immed[gprA_3, 0x0], gpr_wrboth
1d88:	 .945  alu[gprA_2, --, B, *l$index0[6]], gpr_wrboth
1d90:	 .946  mem[read32_swap, $xfer_0, gprB_1, <<8, gprA_0, 1], ctx_swap[sig1]
1d98:	 .947  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
1da0:	 .948  immed[gprA_5, 0x0], gpr_wrboth
1da8:	 .949  alu[gprA_6, --, B, gprB_4], gpr_wrboth
1db0:	 .950  alu[gprA_7, --, B, gprB_5], gpr_wrboth
1db8:	 .951  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
1dc0:	 .952  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
1dc8:	 .953  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
1dd0:	 .954  immed[gprA_7, 0x0], gpr_wrboth
1dd8:	 .955  alu[--, gprA_6, OR, gprB_7]
1de0:	 .956  beq[.958]
1de8:	 .957  br[.1339]
1df0:	 .958  alu[gprA_6, --, B, gprB_2], gpr_wrboth
1df8:	 .959  alu[gprA_7, --, B, gprB_3], gpr_wrboth
1e00:	 .960  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
1e08:	 .961  immed[gprA_7, 0x0], gpr_wrboth
1e10:	 .962  alu[--, gprA_6, OR, gprB_7]
1e18:	 .963  beq[.2062]
1e20:	 .964  alu[gprA_6, --, B, gprB_2], gpr_wrboth
1e28:	 .965  alu[gprA_7, --, B, gprB_3], gpr_wrboth
1e30:	 .966  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
1e38:	 .967  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
1e40:	 .968  alu[gprA_8, --, B, gprB_4], gpr_wrboth
1e48:	 .969  alu[gprA_9, --, B, gprB_5], gpr_wrboth
1e50:	 .970  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
1e58:	 .971  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
1e60:	 .972  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
1e68:	 .973  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
1e70:	 .974  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
1e78:	 .975  immed[gprA_9, 0x0], gpr_wrboth
1e80:	 .976  alu[--, gprA_8, OR, gprB_9]
1e88:	 .977  bne[.1339]
1e90:	 .978  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
1e98:	 .979  immed[gprA_7, 0x0], gpr_wrboth
1ea0:	 .980  alu[--, gprA_6, OR, gprB_7]
1ea8:	 .981  beq[.2062]
1eb0:	 .982  alu[gprA_6, --, B, gprB_2], gpr_wrboth
1eb8:	 .983  alu[gprA_7, --, B, gprB_3], gpr_wrboth
1ec0:	 .984  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
1ec8:	 .985  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
1ed0:	 .986  alu[gprA_8, --, B, gprB_4], gpr_wrboth
1ed8:	 .987  alu[gprA_9, --, B, gprB_5], gpr_wrboth
1ee0:	 .988  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
1ee8:	 .989  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
1ef0:	 .990  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
1ef8:	 .991  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
1f00:	 .992  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
1f08:	 .993  immed[gprA_9, 0x0], gpr_wrboth
1f10:	 .994  alu[--, gprA_8, OR, gprB_9]
1f18:	 .995  bne[.1339]
1f20:	 .996  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
1f28:	 .997  immed[gprA_7, 0x0], gpr_wrboth
1f30:	 .998  alu[--, gprA_6, OR, gprB_7]
1f38:	 .999  beq[.2062]
1f40:	.1000  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
1f48:	.1001  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
1f50:	.1002  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
1f58:	.1003  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
1f60:	.1004  alu[--, gprA_2, XOR, gprB_4]
1f68:	.1005  bne[.1339]
1f70:	.1006  alu[--, gprA_3, XOR, gprB_5]
1f78:	.1007  bne[.1339]
1f80:	.1008  alu[--, gprA_2, OR, gprB_3]
1f88:	.1009  beq[.2062]
1f90:	.1010  immed[gprA_3, 0x0], gpr_wrboth
1f98:	.1011  alu[gprA_2, --, B, *l$index0[7]], gpr_wrboth
1fa0:	.1012  alu[gprA_21, gprA_0, +, 0x4]
1fa8:	.1013  alu[gprB_21, gprB_1, +carry, 0x0]
1fb0:	.1014  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
1fb8:	.1015  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
1fc0:	.1016  immed[gprA_5, 0x0], gpr_wrboth
1fc8:	.1017  alu[gprA_6, --, B, gprB_4], gpr_wrboth
1fd0:	.1018  alu[gprA_7, --, B, gprB_5], gpr_wrboth
1fd8:	.1019  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
1fe0:	.1020  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
1fe8:	.1021  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
1ff0:	.1022  immed[gprA_7, 0x0], gpr_wrboth
1ff8:	.1023  alu[--, gprA_6, OR, gprB_7]
2000:	.1024  beq[.1026]
2008:	.1025  br[.1339]
2010:	.1026  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2018:	.1027  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2020:	.1028  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2028:	.1029  immed[gprA_7, 0x0], gpr_wrboth
2030:	.1030  alu[--, gprA_6, OR, gprB_7]
2038:	.1031  beq[.2062]
2040:	.1032  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2048:	.1033  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2050:	.1034  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
2058:	.1035  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
2060:	.1036  alu[gprA_8, --, B, gprB_4], gpr_wrboth
2068:	.1037  alu[gprA_9, --, B, gprB_5], gpr_wrboth
2070:	.1038  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
2078:	.1039  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
2080:	.1040  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
2088:	.1041  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
2090:	.1042  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
2098:	.1043  immed[gprA_9, 0x0], gpr_wrboth
20a0:	.1044  alu[--, gprA_8, OR, gprB_9]
20a8:	.1045  bne[.1339]
20b0:	.1046  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
20b8:	.1047  immed[gprA_7, 0x0], gpr_wrboth
20c0:	.1048  alu[--, gprA_6, OR, gprB_7]
20c8:	.1049  beq[.2062]
20d0:	.1050  alu[gprA_6, --, B, gprB_2], gpr_wrboth
20d8:	.1051  alu[gprA_7, --, B, gprB_3], gpr_wrboth
20e0:	.1052  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
20e8:	.1053  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
20f0:	.1054  alu[gprA_8, --, B, gprB_4], gpr_wrboth
20f8:	.1055  alu[gprA_9, --, B, gprB_5], gpr_wrboth
2100:	.1056  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
2108:	.1057  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
2110:	.1058  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
2118:	.1059  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
2120:	.1060  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
2128:	.1061  immed[gprA_9, 0x0], gpr_wrboth
2130:	.1062  alu[--, gprA_8, OR, gprB_9]
2138:	.1063  bne[.1339]
2140:	.1064  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2148:	.1065  immed[gprA_7, 0x0], gpr_wrboth
2150:	.1066  alu[--, gprA_6, OR, gprB_7]
2158:	.1067  beq[.2062]
2160:	.1068  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
2168:	.1069  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
2170:	.1070  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
2178:	.1071  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
2180:	.1072  alu[--, gprA_2, XOR, gprB_4]
2188:	.1073  bne[.1339]
2190:	.1074  alu[--, gprA_3, XOR, gprB_5]
2198:	.1075  bne[.1339]
21a0:	.1076  alu[--, gprA_2, OR, gprB_3]
21a8:	.1077  beq[.2062]
21b0:	.1078  immed[gprA_3, 0x0], gpr_wrboth
21b8:	.1079  alu[gprA_2, --, B, *l$index0[8]], gpr_wrboth
21c0:	.1080  alu[gprA_21, gprA_0, +, 0x8]
21c8:	.1081  alu[gprB_21, gprB_1, +carry, 0x0]
21d0:	.1082  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
21d8:	.1083  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
21e0:	.1084  immed[gprA_5, 0x0], gpr_wrboth
21e8:	.1085  alu[gprA_6, --, B, gprB_4], gpr_wrboth
21f0:	.1086  alu[gprA_7, --, B, gprB_5], gpr_wrboth
21f8:	.1087  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
2200:	.1088  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
2208:	.1089  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2210:	.1090  immed[gprA_7, 0x0], gpr_wrboth
2218:	.1091  alu[--, gprA_6, OR, gprB_7]
2220:	.1092  bne[.1339]
2228:	.1093  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2230:	.1094  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2238:	.1095  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2240:	.1096  immed[gprA_7, 0x0], gpr_wrboth
2248:	.1097  alu[--, gprA_6, OR, gprB_7]
2250:	.1098  beq[.2062]
2258:	.1099  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2260:	.1100  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2268:	.1101  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
2270:	.1102  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
2278:	.1103  alu[gprA_8, --, B, gprB_4], gpr_wrboth
2280:	.1104  alu[gprA_9, --, B, gprB_5], gpr_wrboth
2288:	.1105  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
2290:	.1106  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
2298:	.1107  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
22a0:	.1108  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
22a8:	.1109  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
22b0:	.1110  immed[gprA_9, 0x0], gpr_wrboth
22b8:	.1111  alu[--, gprA_8, OR, gprB_9]
22c0:	.1112  bne[.1339]
22c8:	.1113  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
22d0:	.1114  immed[gprA_7, 0x0], gpr_wrboth
22d8:	.1115  alu[--, gprA_6, OR, gprB_7]
22e0:	.1116  beq[.2062]
22e8:	.1117  alu[gprA_6, --, B, gprB_2], gpr_wrboth
22f0:	.1118  alu[gprA_7, --, B, gprB_3], gpr_wrboth
22f8:	.1119  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
2300:	.1120  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
2308:	.1121  alu[gprA_8, --, B, gprB_4], gpr_wrboth
2310:	.1122  alu[gprA_9, --, B, gprB_5], gpr_wrboth
2318:	.1123  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
2320:	.1124  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
2328:	.1125  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
2330:	.1126  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
2338:	.1127  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
2340:	.1128  immed[gprA_9, 0x0], gpr_wrboth
2348:	.1129  alu[--, gprA_8, OR, gprB_9]
2350:	.1130  bne[.1339]
2358:	.1131  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2360:	.1132  immed[gprA_7, 0x0], gpr_wrboth
2368:	.1133  alu[--, gprA_6, OR, gprB_7]
2370:	.1134  beq[.2062]
2378:	.1135  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
2380:	.1136  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
2388:	.1137  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
2390:	.1138  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
2398:	.1139  alu[--, gprA_2, XOR, gprB_4]
23a0:	.1140  bne[.1339]
23a8:	.1141  alu[--, gprA_3, XOR, gprB_5]
23b0:	.1142  bne[.1339]
23b8:	.1143  alu[--, gprA_2, OR, gprB_3]
23c0:	.1144  beq[.2062]
23c8:	.1145  immed[gprA_3, 0x0], gpr_wrboth
23d0:	.1146  alu[gprA_2, --, B, *l$index0[9]], gpr_wrboth
23d8:	.1147  alu[gprA_21, gprA_0, +, 0xc]
23e0:	.1148  alu[gprB_21, gprB_1, +carry, 0x0]
23e8:	.1149  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
23f0:	.1150  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
23f8:	.1151  immed[gprA_5, 0x0], gpr_wrboth
2400:	.1152  alu[gprA_6, --, B, gprB_4], gpr_wrboth
2408:	.1153  alu[gprA_7, --, B, gprB_5], gpr_wrboth
2410:	.1154  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
2418:	.1155  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
2420:	.1156  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2428:	.1157  immed[gprA_7, 0x0], gpr_wrboth
2430:	.1158  alu[--, gprA_6, OR, gprB_7]
2438:	.1159  bne[.1339]
2440:	.1160  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2448:	.1161  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2450:	.1162  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2458:	.1163  immed[gprA_7, 0x0], gpr_wrboth
2460:	.1164  alu[--, gprA_6, OR, gprB_7]
2468:	.1165  beq[.2062]
2470:	.1166  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2478:	.1167  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2480:	.1168  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
2488:	.1169  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
2490:	.1170  alu[gprA_8, --, B, gprB_4], gpr_wrboth
2498:	.1171  alu[gprA_9, --, B, gprB_5], gpr_wrboth
24a0:	.1172  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
24a8:	.1173  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
24b0:	.1174  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
24b8:	.1175  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
24c0:	.1176  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
24c8:	.1177  immed[gprA_9, 0x0], gpr_wrboth
24d0:	.1178  alu[--, gprA_8, OR, gprB_9]
24d8:	.1179  bne[.1339]
24e0:	.1180  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
24e8:	.1181  immed[gprA_7, 0x0], gpr_wrboth
24f0:	.1182  alu[--, gprA_6, OR, gprB_7]
24f8:	.1183  beq[.2062]
2500:	.1184  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2508:	.1185  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2510:	.1186  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
2518:	.1187  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
2520:	.1188  alu[gprA_8, --, B, gprB_4], gpr_wrboth
2528:	.1189  alu[gprA_9, --, B, gprB_5], gpr_wrboth
2530:	.1190  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
2538:	.1191  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
2540:	.1192  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
2548:	.1193  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
2550:	.1194  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
2558:	.1195  immed[gprA_9, 0x0], gpr_wrboth
2560:	.1196  alu[--, gprA_8, OR, gprB_9]
2568:	.1197  bne[.1339]
2570:	.1198  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2578:	.1199  immed[gprA_7, 0x0], gpr_wrboth
2580:	.1200  alu[--, gprA_6, OR, gprB_7]
2588:	.1201  beq[.2062]
2590:	.1202  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
2598:	.1203  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
25a0:	.1204  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
25a8:	.1205  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
25b0:	.1206  alu[--, gprA_2, XOR, gprB_4]
25b8:	.1207  bne[.1339]
25c0:	.1208  alu[--, gprA_3, XOR, gprB_5]
25c8:	.1209  bne[.1339]
25d0:	.1210  alu[--, gprA_2, OR, gprB_3]
25d8:	.1211  beq[.2062]
25e0:	.1212  immed[gprA_3, 0x0], gpr_wrboth
25e8:	.1213  alu[gprA_2, --, B, *l$index0[10]], gpr_wrboth
25f0:	.1214  alu[gprA_21, gprA_0, +, 0x10]
25f8:	.1215  alu[gprB_21, gprB_1, +carry, 0x0]
2600:	.1216  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
2608:	.1217  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
2610:	.1218  immed[gprA_5, 0x0], gpr_wrboth
2618:	.1219  alu[gprA_6, --, B, gprB_4], gpr_wrboth
2620:	.1220  alu[gprA_7, --, B, gprB_5], gpr_wrboth
2628:	.1221  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
2630:	.1222  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
2638:	.1223  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2640:	.1224  immed[gprA_7, 0x0], gpr_wrboth
2648:	.1225  alu[--, gprA_6, OR, gprB_7]
2650:	.1226  bne[.1339]
2658:	.1227  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2660:	.1228  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2668:	.1229  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2670:	.1230  immed[gprA_7, 0x0], gpr_wrboth
2678:	.1231  alu[--, gprA_6, OR, gprB_7]
2680:	.1232  beq[.2062]
2688:	.1233  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2690:	.1234  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2698:	.1235  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
26a0:	.1236  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
26a8:	.1237  alu[gprA_8, --, B, gprB_4], gpr_wrboth
26b0:	.1238  alu[gprA_9, --, B, gprB_5], gpr_wrboth
26b8:	.1239  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
26c0:	.1240  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
26c8:	.1241  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
26d0:	.1242  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
26d8:	.1243  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
26e0:	.1244  immed[gprA_9, 0x0], gpr_wrboth
26e8:	.1245  alu[--, gprA_8, OR, gprB_9]
26f0:	.1246  bne[.1339]
26f8:	.1247  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2700:	.1248  immed[gprA_7, 0x0], gpr_wrboth
2708:	.1249  alu[--, gprA_6, OR, gprB_7]
2710:	.1250  beq[.2062]
2718:	.1251  alu[gprA_6, --, B, gprB_2], gpr_wrboth
2720:	.1252  alu[gprA_7, --, B, gprB_3], gpr_wrboth
2728:	.1253  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
2730:	.1254  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
2738:	.1255  alu[gprA_8, --, B, gprB_4], gpr_wrboth
2740:	.1256  alu[gprA_9, --, B, gprB_5], gpr_wrboth
2748:	.1257  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
2750:	.1258  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
2758:	.1259  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
2760:	.1260  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
2768:	.1261  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
2770:	.1262  immed[gprA_9, 0x0], gpr_wrboth
2778:	.1263  alu[--, gprA_8, OR, gprB_9]
2780:	.1264  bne[.1339]
2788:	.1265  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2790:	.1266  immed[gprA_7, 0x0], gpr_wrboth
2798:	.1267  alu[--, gprA_6, OR, gprB_7]
27a0:	.1268  beq[.2062]
27a8:	.1269  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
27b0:	.1270  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
27b8:	.1271  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
27c0:	.1272  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
27c8:	.1273  alu[--, gprA_2, XOR, gprB_4]
27d0:	.1274  bne[.1339]
27d8:	.1275  alu[--, gprA_3, XOR, gprB_5]
27e0:	.1276  bne[.1339]
27e8:	.1277  alu[--, gprA_2, OR, gprB_3]
27f0:	.1278  beq[.2062]
27f8:	.1279  immed[gprA_5, 0x0], gpr_wrboth
2800:	.1280  alu[gprA_4, --, B, *l$index0[11]], gpr_wrboth
2808:	.1281  alu[gprA_21, gprA_0, +, 0x14]
2810:	.1282  alu[gprB_21, gprB_1, +carry, 0x0]
2818:	.1283  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
2820:	.1284  alu[gprA_6, --, B, $xfer_0], gpr_wrboth
2828:	.1285  immed[gprA_7, 0x0], gpr_wrboth
2830:	.1286  alu[gprA_2, --, B, gprB_6], gpr_wrboth
2838:	.1287  alu[gprA_3, --, B, gprB_7], gpr_wrboth
2840:	.1288  alu[gprA_2, gprA_2, XOR, gprB_4], gpr_wrboth
2848:	.1289  alu[gprA_3, gprA_3, XOR, gprB_5], gpr_wrboth
2850:	.1290  alu[gprA_8, --, B, gprB_2], gpr_wrboth
2858:	.1291  alu[gprA_9, --, B, gprB_3], gpr_wrboth
2860:	.1292  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
2868:	.1293  immed[gprA_9, 0x0], gpr_wrboth
2870:	.1294  alu[--, gprA_8, OR, gprB_9]
2878:	.1295  bne[.1339]
2880:	.1296  alu[gprA_8, --, B, gprB_4], gpr_wrboth
2888:	.1297  alu[gprA_9, --, B, gprB_5], gpr_wrboth
2890:	.1298  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
2898:	.1299  immed[gprA_9, 0x0], gpr_wrboth
28a0:	.1300  alu[--, gprA_8, OR, gprB_9]
28a8:	.1301  beq[.2062]
28b0:	.1302  alu[gprA_8, --, B, gprB_4], gpr_wrboth
28b8:	.1303  alu[gprA_9, --, B, gprB_5], gpr_wrboth
28c0:	.1304  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
28c8:	.1305  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
28d0:	.1306  alu[gprA_10, --, B, gprB_6], gpr_wrboth
28d8:	.1307  alu[gprA_11, --, B, gprB_7], gpr_wrboth
28e0:	.1308  dbl_shf[gprA_10, gprA_11, gprB_10, >>8], gpr_wrboth
28e8:	.1309  alu_shf[gprA_11, --, B, gprB_11, >>8], gpr_wrboth
28f0:	.1310  alu[gprA_10, gprA_10, XOR, gprB_8], gpr_wrboth
28f8:	.1311  alu[gprA_11, gprA_11, XOR, gprB_9], gpr_wrboth
2900:	.1312  alu[gprA_10, gprA_10, AND, 0xff], gpr_wrboth
2908:	.1313  immed[gprA_11, 0x0], gpr_wrboth
2910:	.1314  alu[--, gprA_10, OR, gprB_11]
2918:	.1315  bne[.1339]
2920:	.1316  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
2928:	.1317  immed[gprA_9, 0x0], gpr_wrboth
2930:	.1318  alu[--, gprA_8, OR, gprB_9]
2938:	.1319  beq[.2062]
2940:	.1320  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
2948:	.1321  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
2950:	.1322  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
2958:	.1323  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
2960:	.1324  alu[gprA_6, gprA_6, XOR, gprB_4], gpr_wrboth
2968:	.1325  alu[gprA_7, gprA_7, XOR, gprB_5], gpr_wrboth
2970:	.1326  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2978:	.1327  immed[gprA_7, 0x0], gpr_wrboth
2980:	.1328  alu[--, gprA_6, OR, gprB_7]
2988:	.1329  bne[.1339]
2990:	.1330  alu[gprA_4, gprA_4, AND, 0xff], gpr_wrboth
2998:	.1331  immed[gprA_5, 0x0], gpr_wrboth
29a0:	.1332  alu[--, gprA_4, OR, gprB_5]
29a8:	.1333  beq[.2062]
29b0:	.1334  immed[gprA_4, 0x100, <<16], gpr_wrboth
29b8:	.1335  immed[gprA_5, 0x0], gpr_wrboth
29c0:	.1336  alu[--, gprA_2, -, gprB_4]
29c8:	.1337  alu[--, gprA_3, -carry, gprB_5]
29d0:	.1338  bcc[.2062]
29d8:	.1339  alu[gprA_21, gprA_0, +, 0x28]
29e0:	.1340  alu[gprB_21, gprB_1, +carry, 0x0]
29e8:	.1341  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
29f0:	.1342  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
29f8:	.1343  immed[gprA_5, 0x0], gpr_wrboth
2a00:	.1344  immed[gprA_3, 0x0], gpr_wrboth
2a08:	.1345  alu[gprA_2, --, B, *l$index0[12]], gpr_wrboth
2a10:	.1346  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
2a18:	.1347  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
2a20:	.1348  immed[gprA_2, 0xffff8000], gpr_wrboth
2a28:	.1349  immed[gprA_3, 0x0], gpr_wrboth
2a30:	.1350  alu[gprA_6, --, B, gprB_4], gpr_wrboth
2a38:	.1351  alu[gprA_7, --, B, gprB_5], gpr_wrboth
2a40:	.1352  alu[gprA_6, gprA_6, AND, gprB_2], gpr_wrboth
2a48:	.1353  alu[gprA_7, gprA_7, AND, gprB_3], gpr_wrboth
2a50:	.1354  dbl_shf[gprA_6, gprA_7, gprB_6, >>15], gpr_wrboth
2a58:	.1355  alu_shf[gprA_7, --, B, gprB_7, >>15], gpr_wrboth
2a60:	.1356  alu[gprA_6, gprA_6, XOR, gprB_4], gpr_wrboth
2a68:	.1357  alu[gprA_7, gprA_7, XOR, gprB_5], gpr_wrboth
2a70:	.1358  alu[*l$index0[13], --, B, gprB_6]
2a78:	.1359  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2a80:	.1360  alu[*l$index0[13], --, B, gprB_4]
2a88:	.1361  immed[gprA_5, 0x0], gpr_wrboth
2a90:	.1362  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2a98:	.1363  immed[gprB_21, 0x3c6d]
2aa0:	.1364  immed_w1[gprB_21, 0x2c1b]
2aa8:	.1365  mul_step[gprA_4, gprB_21], start
2ab0:	.1366  mul_step[gprA_4, gprB_21], 32x32_step1
2ab8:	.1367  mul_step[gprA_4, gprB_21], 32x32_step2
2ac0:	.1368  mul_step[gprA_4, gprB_21], 32x32_step3
2ac8:	.1369  mul_step[gprA_4, gprB_21], 32x32_step4
2ad0:	.1370  mul_step[gprA_4, --], 32x32_last, gpr_wrboth
2ad8:	.1371  mul_step[gprA_5, --], 32x32_last2, gpr_wrboth
2ae0:	.1372  immed[gprA_6, 0xfffff000], gpr_wrboth
2ae8:	.1373  immed[gprA_7, 0x0], gpr_wrboth
2af0:	.1374  alu[gprA_8, --, B, gprB_4], gpr_wrboth
2af8:	.1375  alu[gprA_9, --, B, gprB_5], gpr_wrboth
2b00:	.1376  alu[gprA_8, gprA_8, AND, gprB_6], gpr_wrboth
2b08:	.1377  alu[gprA_9, gprA_9, AND, gprB_7], gpr_wrboth
2b10:	.1378  dbl_shf[gprA_8, gprA_9, gprB_8, >>12], gpr_wrboth
2b18:	.1379  alu_shf[gprA_9, --, B, gprB_9, >>12], gpr_wrboth
2b20:	.1380  alu[gprA_8, gprA_8, XOR, gprB_4], gpr_wrboth
2b28:	.1381  alu[gprA_9, gprA_9, XOR, gprB_5], gpr_wrboth
2b30:	.1382  alu[*l$index0[13], --, B, gprB_8]
2b38:	.1383  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2b40:	.1384  alu[*l$index0[13], --, B, gprB_4]
2b48:	.1385  immed[gprA_5, 0x0], gpr_wrboth
2b50:	.1386  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2b58:	.1387  immed[gprB_21, 0x2d39]
2b60:	.1388  immed_w1[gprB_21, 0x297a]
2b68:	.1389  mul_step[gprA_4, gprB_21], start
2b70:	.1390  mul_step[gprA_4, gprB_21], 32x32_step1
2b78:	.1391  mul_step[gprA_4, gprB_21], 32x32_step2
2b80:	.1392  mul_step[gprA_4, gprB_21], 32x32_step3
2b88:	.1393  mul_step[gprA_4, gprB_21], 32x32_step4
2b90:	.1394  mul_step[gprA_4, --], 32x32_last, gpr_wrboth
2b98:	.1395  mul_step[gprA_5, --], 32x32_last2, gpr_wrboth
2ba0:	.1396  alu[gprA_6, --, B, gprB_4], gpr_wrboth
2ba8:	.1397  alu[gprA_7, --, B, gprB_5], gpr_wrboth
2bb0:	.1398  alu[gprA_6, gprA_6, AND, gprB_2], gpr_wrboth
2bb8:	.1399  alu[gprA_7, gprA_7, AND, gprB_3], gpr_wrboth
2bc0:	.1400  dbl_shf[gprA_6, gprA_7, gprB_6, >>15], gpr_wrboth
2bc8:	.1401  alu_shf[gprA_7, --, B, gprB_7, >>15], gpr_wrboth
2bd0:	.1402  alu[gprA_6, gprA_6, XOR, gprB_4], gpr_wrboth
2bd8:	.1403  alu[gprA_7, gprA_7, XOR, gprB_5], gpr_wrboth
2be0:	.1404  alu[*l$index0[12], --, B, gprB_6]
2be8:	.1405  alu[gprA_4, gprA_22, +, 0x38], gpr_wrboth
2bf0:	.1406  immed[gprA_5, 0x0], gpr_wrboth
2bf8:	.1407  alu[gprA_4, gprA_4, -, 0x8], gpr_wrboth
2c00:	.1408  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
2c08:	.1409  immed[gprA_2, 0x0], gpr_wrboth
2c10:	.1410  alu[gprA_3, --, B, gprA_2], gpr_wrboth
2c18:	.1411  local_csr_wr[ActLMAddr0, gprB_4]
2c20:	.1412  alu[gprA_1, --, B, gprB_23], gpr_wrboth
2c28:	.1413  nop
2c30:	.1414  immed[gprA_21, 0xffff003f, <<16]
2c38:	.1415  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<6], gpr_wrboth
2c40:	.1416  local_csr_wr[ActLMAddr0, gprA_22]
2c48:	.1417  nop
2c50:	.1418  nop
2c58:	.1419  nop
2c60:	.1420  alu[--, gprA_0, OR, gprB_1]
2c68:	.1421  beq[.1435]
2c70:	.1422  immed[gprA_3, 0x0], gpr_wrboth
2c78:	.1423  alu[gprA_2, --, B, *l$index0[6]], gpr_wrboth
2c80:	.1424  mem[read32_swap, $xfer_0, gprB_1, <<8, gprA_0, 1], ctx_swap[sig1]
2c88:	.1425  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
2c90:	.1426  immed[gprA_5, 0x0], gpr_wrboth
2c98:	.1427  alu[gprA_6, --, B, gprB_4], gpr_wrboth
2ca0:	.1428  alu[gprA_7, --, B, gprB_5], gpr_wrboth
2ca8:	.1429  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
2cb0:	.1430  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
2cb8:	.1431  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
2cc0:	.1432  immed[gprA_7, 0x0], gpr_wrboth
2cc8:	.1433  alu[--, gprA_6, OR, gprB_7]
2cd0:	.1434  beq[.1680]
2cd8:	.1435  mem[read32_swap, $xfer_0, gprA_12, 0x2c, 1], ctx_swap[sig1]
2ce0:	.1436  ld_field_w_clr[gprA_2, 0011, $xfer_0], gpr_wrboth
2ce8:	.1437  immed[gprA_3, 0x0], gpr_wrboth
2cf0:	.1438  immed[gprB_21, 0x300]
2cf8:	.1439  alu[gprA_2, gprA_2, OR, gprB_21], gpr_wrboth
2d00:	.1440  br[.109]
2d08:	.1441  immed[gprA_1, 0x0], gpr_wrboth
2d10:	.1442  alu[gprA_0, --, B, *l$index0[8]], gpr_wrboth
2d18:	.1443  alu[gprA_0, gprA_0, XOR, gprB_4], gpr_wrboth
2d20:	.1444  alu[gprA_1, gprA_1, XOR, gprB_5], gpr_wrboth
2d28:	.1445  immed[gprA_8, 0xffff8000], gpr_wrboth
2d30:	.1446  immed[gprA_9, 0x0], gpr_wrboth
2d38:	.1447  alu[gprA_4, --, B, gprB_0], gpr_wrboth
2d40:	.1448  alu[gprA_5, --, B, gprB_1], gpr_wrboth
2d48:	.1449  alu[gprA_4, gprA_4, AND, gprB_8], gpr_wrboth
2d50:	.1450  alu[gprA_5, gprA_5, AND, gprB_9], gpr_wrboth
2d58:	.1451  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
2d60:	.1452  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
2d68:	.1453  alu[gprA_4, gprA_4, XOR, gprB_0], gpr_wrboth
2d70:	.1454  alu[gprA_5, gprA_5, XOR, gprB_1], gpr_wrboth
2d78:	.1455  alu[*l$index0[13], --, B, gprB_4]
2d80:	.1456  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2d88:	.1457  alu[*l$index0[13], --, B, gprB_4]
2d90:	.1458  immed[gprA_5, 0x0], gpr_wrboth
2d98:	.1459  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2da0:	.1460  immed[gprB_21, 0x3c6d]
2da8:	.1461  immed_w1[gprB_21, 0x2c1b]
2db0:	.1462  mul_step[gprA_4, gprB_21], start
2db8:	.1463  mul_step[gprA_4, gprB_21], 32x32_step1
2dc0:	.1464  mul_step[gprA_4, gprB_21], 32x32_step2
2dc8:	.1465  mul_step[gprA_4, gprB_21], 32x32_step3
2dd0:	.1466  mul_step[gprA_4, gprB_21], 32x32_step4
2dd8:	.1467  mul_step[gprA_4, --], 32x32_last, gpr_wrboth
2de0:	.1468  mul_step[gprA_5, --], 32x32_last2, gpr_wrboth
2de8:	.1469  immed[gprA_0, 0xfffff000], gpr_wrboth
2df0:	.1470  immed[gprA_1, 0x0], gpr_wrboth
2df8:	.1471  alu[gprA_18, --, B, gprB_4], gpr_wrboth
2e00:	.1472  alu[gprA_19, --, B, gprB_5], gpr_wrboth
2e08:	.1473  alu[gprA_18, gprA_18, AND, gprB_0], gpr_wrboth
2e10:	.1474  alu[gprA_19, gprA_19, AND, gprB_1], gpr_wrboth
2e18:	.1475  dbl_shf[gprA_18, gprA_19, gprB_18, >>12], gpr_wrboth
2e20:	.1476  alu_shf[gprA_19, --, B, gprB_19, >>12], gpr_wrboth
2e28:	.1477  alu[gprA_18, gprA_18, XOR, gprB_4], gpr_wrboth
2e30:	.1478  alu[gprA_19, gprA_19, XOR, gprB_5], gpr_wrboth
2e38:	.1479  alu[*l$index0[13], --, B, gprB_18]
2e40:	.1480  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2e48:	.1481  alu[*l$index0[13], --, B, gprB_4]
2e50:	.1482  immed[gprA_19, 0x0], gpr_wrboth
2e58:	.1483  alu[gprA_18, --, B, *l$index0[13]], gpr_wrboth
2e60:	.1484  immed[gprB_21, 0x2d39]
2e68:	.1485  immed_w1[gprB_21, 0x297a]
2e70:	.1486  mul_step[gprA_18, gprB_21], start
2e78:	.1487  mul_step[gprA_18, gprB_21], 32x32_step1
2e80:	.1488  mul_step[gprA_18, gprB_21], 32x32_step2
2e88:	.1489  mul_step[gprA_18, gprB_21], 32x32_step3
2e90:	.1490  mul_step[gprA_18, gprB_21], 32x32_step4
2e98:	.1491  mul_step[gprA_18, --], 32x32_last, gpr_wrboth
2ea0:	.1492  mul_step[gprA_19, --], 32x32_last2, gpr_wrboth
2ea8:	.1493  alu[gprA_4, --, B, gprB_18], gpr_wrboth
2eb0:	.1494  alu[gprA_5, --, B, gprB_19], gpr_wrboth
2eb8:	.1495  alu[gprA_4, gprA_4, AND, gprB_8], gpr_wrboth
2ec0:	.1496  alu[gprA_5, gprA_5, AND, gprB_9], gpr_wrboth
2ec8:	.1497  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
2ed0:	.1498  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
2ed8:	.1499  alu[gprA_4, gprA_4, XOR, gprB_18], gpr_wrboth
2ee0:	.1500  alu[gprA_5, gprA_5, XOR, gprB_19], gpr_wrboth
2ee8:	.1501  alu[--, gprA_10, OR, gprB_11]
2ef0:	.1502  beq[.924]
2ef8:	.1503  immed[gprA_11, 0x0], gpr_wrboth
2f00:	.1504  alu[gprA_10, --, B, *l$index0[9]], gpr_wrboth
2f08:	.1505  alu[gprA_10, gprA_10, XOR, gprB_4], gpr_wrboth
2f10:	.1506  alu[gprA_11, gprA_11, XOR, gprB_5], gpr_wrboth
2f18:	.1507  alu[gprA_4, --, B, gprB_10], gpr_wrboth
2f20:	.1508  alu[gprA_5, --, B, gprB_11], gpr_wrboth
2f28:	.1509  alu[gprA_4, gprA_4, AND, gprB_8], gpr_wrboth
2f30:	.1510  alu[gprA_5, gprA_5, AND, gprB_9], gpr_wrboth
2f38:	.1511  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
2f40:	.1512  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
2f48:	.1513  alu[gprA_4, gprA_4, XOR, gprB_10], gpr_wrboth
2f50:	.1514  alu[gprA_5, gprA_5, XOR, gprB_11], gpr_wrboth
2f58:	.1515  alu[*l$index0[13], --, B, gprB_4]
2f60:	.1516  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2f68:	.1517  alu[*l$index0[13], --, B, gprB_4]
2f70:	.1518  immed[gprA_5, 0x0], gpr_wrboth
2f78:	.1519  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
2f80:	.1520  immed[gprB_21, 0x3c6d]
2f88:	.1521  immed_w1[gprB_21, 0x2c1b]
2f90:	.1522  mul_step[gprA_4, gprB_21], start
2f98:	.1523  mul_step[gprA_4, gprB_21], 32x32_step1
2fa0:	.1524  mul_step[gprA_4, gprB_21], 32x32_step2
2fa8:	.1525  mul_step[gprA_4, gprB_21], 32x32_step3
2fb0:	.1526  mul_step[gprA_4, gprB_21], 32x32_step4
2fb8:	.1527  mul_step[gprA_4, --], 32x32_last, gpr_wrboth
2fc0:	.1528  mul_step[gprA_5, --], 32x32_last2, gpr_wrboth
2fc8:	.1529  alu[gprA_10, --, B, gprB_4], gpr_wrboth
2fd0:	.1530  alu[gprA_11, --, B, gprB_5], gpr_wrboth
2fd8:	.1531  alu[gprA_10, gprA_10, AND, gprB_0], gpr_wrboth
2fe0:	.1532  alu[gprA_11, gprA_11, AND, gprB_1], gpr_wrboth
2fe8:	.1533  dbl_shf[gprA_10, gprA_11, gprB_10, >>12], gpr_wrboth
2ff0:	.1534  alu_shf[gprA_11, --, B, gprB_11, >>12], gpr_wrboth
2ff8:	.1535  alu[gprA_10, gprA_10, XOR, gprB_4], gpr_wrboth
3000:	.1536  alu[gprA_11, gprA_11, XOR, gprB_5], gpr_wrboth
3008:	.1537  alu[*l$index0[13], --, B, gprB_10]
3010:	.1538  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
3018:	.1539  alu[*l$index0[13], --, B, gprB_4]
3020:	.1540  immed[gprA_11, 0x0], gpr_wrboth
3028:	.1541  alu[gprA_10, --, B, *l$index0[13]], gpr_wrboth
3030:	.1542  immed[gprB_21, 0x2d39]
3038:	.1543  immed_w1[gprB_21, 0x297a]
3040:	.1544  mul_step[gprA_10, gprB_21], start
3048:	.1545  mul_step[gprA_10, gprB_21], 32x32_step1
3050:	.1546  mul_step[gprA_10, gprB_21], 32x32_step2
3058:	.1547  mul_step[gprA_10, gprB_21], 32x32_step3
3060:	.1548  mul_step[gprA_10, gprB_21], 32x32_step4
3068:	.1549  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
3070:	.1550  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
3078:	.1551  alu[gprA_4, --, B, gprB_10], gpr_wrboth
3080:	.1552  alu[gprA_5, --, B, gprB_11], gpr_wrboth
3088:	.1553  alu[gprA_4, gprA_4, AND, gprB_8], gpr_wrboth
3090:	.1554  alu[gprA_5, gprA_5, AND, gprB_9], gpr_wrboth
3098:	.1555  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
30a0:	.1556  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
30a8:	.1557  alu[gprA_4, gprA_4, XOR, gprB_10], gpr_wrboth
30b0:	.1558  alu[gprA_5, gprA_5, XOR, gprB_11], gpr_wrboth
30b8:	.1559  alu[--, gprA_6, OR, gprB_7]
30c0:	.1560  beq[.924]
30c8:	.1561  immed[gprA_9, 0x0], gpr_wrboth
30d0:	.1562  alu[gprA_8, --, B, *l$index0[10]], gpr_wrboth
30d8:	.1563  alu[gprA_8, gprA_8, XOR, gprB_4], gpr_wrboth
30e0:	.1564  alu[gprA_9, gprA_9, XOR, gprB_5], gpr_wrboth
30e8:	.1565  immed[gprA_6, 0xffff8000], gpr_wrboth
30f0:	.1566  immed[gprA_7, 0x0], gpr_wrboth
30f8:	.1567  alu[gprA_4, --, B, gprB_8], gpr_wrboth
3100:	.1568  alu[gprA_5, --, B, gprB_9], gpr_wrboth
3108:	.1569  alu[gprA_4, gprA_4, AND, gprB_6], gpr_wrboth
3110:	.1570  alu[gprA_5, gprA_5, AND, gprB_7], gpr_wrboth
3118:	.1571  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
3120:	.1572  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
3128:	.1573  alu[gprA_4, gprA_4, XOR, gprB_8], gpr_wrboth
3130:	.1574  alu[gprA_5, gprA_5, XOR, gprB_9], gpr_wrboth
3138:	.1575  alu[*l$index0[13], --, B, gprB_4]
3140:	.1576  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
3148:	.1577  alu[*l$index0[13], --, B, gprB_4]
3150:	.1578  immed[gprA_5, 0x0], gpr_wrboth
3158:	.1579  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
3160:	.1580  immed[gprB_21, 0x3c6d]
3168:	.1581  immed_w1[gprB_21, 0x2c1b]
3170:	.1582  mul_step[gprA_4, gprB_21], start
3178:	.1583  mul_step[gprA_4, gprB_21], 32x32_step1
3180:	.1584  mul_step[gprA_4, gprB_21], 32x32_step2
3188:	.1585  mul_step[gprA_4, gprB_21], 32x32_step3
3190:	.1586  mul_step[gprA_4, gprB_21], 32x32_step4
3198:	.1587  mul_step[gprA_4, --], 32x32_last, gpr_wrboth
31a0:	.1588  mul_step[gprA_5, --], 32x32_last2, gpr_wrboth
31a8:	.1589  immed[gprA_8, 0xfffff000], gpr_wrboth
31b0:	.1590  immed[gprA_9, 0x0], gpr_wrboth
31b8:	.1591  alu[gprA_10, --, B, gprB_4], gpr_wrboth
31c0:	.1592  alu[gprA_11, --, B, gprB_5], gpr_wrboth
31c8:	.1593  alu[gprA_10, gprA_10, AND, gprB_8], gpr_wrboth
31d0:	.1594  alu[gprA_11, gprA_11, AND, gprB_9], gpr_wrboth
31d8:	.1595  dbl_shf[gprA_10, gprA_11, gprB_10, >>12], gpr_wrboth
31e0:	.1596  alu_shf[gprA_11, --, B, gprB_11, >>12], gpr_wrboth
31e8:	.1597  alu[gprA_10, gprA_10, XOR, gprB_4], gpr_wrboth
31f0:	.1598  alu[gprA_11, gprA_11, XOR, gprB_5], gpr_wrboth
31f8:	.1599  alu[*l$index0[13], --, B, gprB_10]
3200:	.1600  alu[gprA_4, --, B, *l$index0[13]], gpr_wrboth
3208:	.1601  alu[*l$index0[13], --, B, gprB_4]
3210:	.1602  immed[gprA_11, 0x0], gpr_wrboth
3218:	.1603  alu[gprA_10, --, B, *l$index0[13]], gpr_wrboth
3220:	.1604  immed[gprB_21, 0x2d39]
3228:	.1605  immed_w1[gprB_21, 0x297a]
3230:	.1606  mul_step[gprA_10, gprB_21], start
3238:	.1607  mul_step[gprA_10, gprB_21], 32x32_step1
3240:	.1608  mul_step[gprA_10, gprB_21], 32x32_step2
3248:	.1609  mul_step[gprA_10, gprB_21], 32x32_step3
3250:	.1610  mul_step[gprA_10, gprB_21], 32x32_step4
3258:	.1611  mul_step[gprA_10, --], 32x32_last, gpr_wrboth
3260:	.1612  mul_step[gprA_11, --], 32x32_last2, gpr_wrboth
3268:	.1613  alu[gprA_4, --, B, gprB_10], gpr_wrboth
3270:	.1614  alu[gprA_5, --, B, gprB_11], gpr_wrboth
3278:	.1615  alu[gprA_4, gprA_4, AND, gprB_6], gpr_wrboth
3280:	.1616  alu[gprA_5, gprA_5, AND, gprB_7], gpr_wrboth
3288:	.1617  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
3290:	.1618  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
3298:	.1619  alu[gprA_4, gprA_4, XOR, gprB_10], gpr_wrboth
32a0:	.1620  alu[gprA_5, gprA_5, XOR, gprB_11], gpr_wrboth
32a8:	.1621  alu[--, gprA_2, OR, gprB_3]
32b0:	.1622  beq[.924]
32b8:	.1623  immed[gprA_3, 0x0], gpr_wrboth
32c0:	.1624  alu[gprA_2, --, B, *l$index0[11]], gpr_wrboth
32c8:	.1625  alu[gprA_2, gprA_2, XOR, gprB_4], gpr_wrboth
32d0:	.1626  alu[gprA_3, gprA_3, XOR, gprB_5], gpr_wrboth
32d8:	.1627  alu[gprA_4, --, B, gprB_2], gpr_wrboth
32e0:	.1628  alu[gprA_5, --, B, gprB_3], gpr_wrboth
32e8:	.1629  alu[gprA_4, gprA_4, AND, gprB_6], gpr_wrboth
32f0:	.1630  alu[gprA_5, gprA_5, AND, gprB_7], gpr_wrboth
32f8:	.1631  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
3300:	.1632  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
3308:	.1633  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
3310:	.1634  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
3318:	.1635  alu[*l$index0[13], --, B, gprB_4]
3320:	.1636  alu[gprA_2, --, B, *l$index0[13]], gpr_wrboth
3328:	.1637  alu[*l$index0[13], --, B, gprB_2]
3330:	.1638  immed[gprA_3, 0x0], gpr_wrboth
3338:	.1639  alu[gprA_2, --, B, *l$index0[13]], gpr_wrboth
3340:	.1640  immed[gprB_21, 0x3c6d]
3348:	.1641  immed_w1[gprB_21, 0x2c1b]
3350:	.1642  mul_step[gprA_2, gprB_21], start
3358:	.1643  mul_step[gprA_2, gprB_21], 32x32_step1
3360:	.1644  mul_step[gprA_2, gprB_21], 32x32_step2
3368:	.1645  mul_step[gprA_2, gprB_21], 32x32_step3
3370:	.1646  mul_step[gprA_2, gprB_21], 32x32_step4
3378:	.1647  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
3380:	.1648  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
3388:	.1649  alu[gprA_4, --, B, gprB_2], gpr_wrboth
3390:	.1650  alu[gprA_5, --, B, gprB_3], gpr_wrboth
3398:	.1651  alu[gprA_4, gprA_4, AND, gprB_8], gpr_wrboth
33a0:	.1652  alu[gprA_5, gprA_5, AND, gprB_9], gpr_wrboth
33a8:	.1653  dbl_shf[gprA_4, gprA_5, gprB_4, >>12], gpr_wrboth
33b0:	.1654  alu_shf[gprA_5, --, B, gprB_5, >>12], gpr_wrboth
33b8:	.1655  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
33c0:	.1656  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
33c8:	.1657  alu[*l$index0[13], --, B, gprB_4]
33d0:	.1658  alu[gprA_2, --, B, *l$index0[13]], gpr_wrboth
33d8:	.1659  alu[*l$index0[13], --, B, gprB_2]
33e0:	.1660  immed[gprA_3, 0x0], gpr_wrboth
33e8:	.1661  alu[gprA_2, --, B, *l$index0[13]], gpr_wrboth
33f0:	.1662  immed[gprB_21, 0x2d39]
33f8:	.1663  immed_w1[gprB_21, 0x297a]
3400:	.1664  mul_step[gprA_2, gprB_21], start
3408:	.1665  mul_step[gprA_2, gprB_21], 32x32_step1
3410:	.1666  mul_step[gprA_2, gprB_21], 32x32_step2
3418:	.1667  mul_step[gprA_2, gprB_21], 32x32_step3
3420:	.1668  mul_step[gprA_2, gprB_21], 32x32_step4
3428:	.1669  mul_step[gprA_2, --], 32x32_last, gpr_wrboth
3430:	.1670  mul_step[gprA_3, --], 32x32_last2, gpr_wrboth
3438:	.1671  alu[gprA_4, --, B, gprB_2], gpr_wrboth
3440:	.1672  alu[gprA_5, --, B, gprB_3], gpr_wrboth
3448:	.1673  alu[gprA_4, gprA_4, AND, gprB_6], gpr_wrboth
3450:	.1674  alu[gprA_5, gprA_5, AND, gprB_7], gpr_wrboth
3458:	.1675  dbl_shf[gprA_4, gprA_5, gprB_4, >>15], gpr_wrboth
3460:	.1676  alu_shf[gprA_5, --, B, gprB_5, >>15], gpr_wrboth
3468:	.1677  alu[gprA_4, gprA_4, XOR, gprB_2], gpr_wrboth
3470:	.1678  alu[gprA_5, gprA_5, XOR, gprB_3], gpr_wrboth
3478:	.1679  br[.924]
3480:	.1680  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3488:	.1681  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3490:	.1682  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3498:	.1683  immed[gprA_7, 0x0], gpr_wrboth
34a0:	.1684  alu[--, gprA_6, OR, gprB_7]
34a8:	.1685  beq[.2062]
34b0:	.1686  alu[gprA_6, --, B, gprB_2], gpr_wrboth
34b8:	.1687  alu[gprA_7, --, B, gprB_3], gpr_wrboth
34c0:	.1688  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
34c8:	.1689  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
34d0:	.1690  alu[gprA_8, --, B, gprB_4], gpr_wrboth
34d8:	.1691  alu[gprA_9, --, B, gprB_5], gpr_wrboth
34e0:	.1692  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
34e8:	.1693  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
34f0:	.1694  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
34f8:	.1695  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
3500:	.1696  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3508:	.1697  immed[gprA_9, 0x0], gpr_wrboth
3510:	.1698  alu[--, gprA_8, OR, gprB_9]
3518:	.1699  bne[.1435]
3520:	.1700  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3528:	.1701  immed[gprA_7, 0x0], gpr_wrboth
3530:	.1702  alu[--, gprA_6, OR, gprB_7]
3538:	.1703  beq[.2062]
3540:	.1704  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3548:	.1705  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3550:	.1706  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
3558:	.1707  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
3560:	.1708  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3568:	.1709  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3570:	.1710  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
3578:	.1711  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
3580:	.1712  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
3588:	.1713  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
3590:	.1714  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3598:	.1715  immed[gprA_9, 0x0], gpr_wrboth
35a0:	.1716  alu[--, gprA_8, OR, gprB_9]
35a8:	.1717  bne[.1435]
35b0:	.1718  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
35b8:	.1719  immed[gprA_7, 0x0], gpr_wrboth
35c0:	.1720  alu[--, gprA_6, OR, gprB_7]
35c8:	.1721  beq[.2062]
35d0:	.1722  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
35d8:	.1723  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
35e0:	.1724  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
35e8:	.1725  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
35f0:	.1726  alu[--, gprA_2, XOR, gprB_4]
35f8:	.1727  bne[.1435]
3600:	.1728  alu[--, gprA_3, XOR, gprB_5]
3608:	.1729  bne[.1435]
3610:	.1730  alu[--, gprA_2, OR, gprB_3]
3618:	.1731  beq[.2062]
3620:	.1732  immed[gprA_3, 0x0], gpr_wrboth
3628:	.1733  alu[gprA_2, --, B, *l$index0[7]], gpr_wrboth
3630:	.1734  alu[gprA_21, gprA_0, +, 0x4]
3638:	.1735  alu[gprB_21, gprB_1, +carry, 0x0]
3640:	.1736  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
3648:	.1737  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
3650:	.1738  immed[gprA_5, 0x0], gpr_wrboth
3658:	.1739  alu[gprA_6, --, B, gprB_4], gpr_wrboth
3660:	.1740  alu[gprA_7, --, B, gprB_5], gpr_wrboth
3668:	.1741  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
3670:	.1742  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
3678:	.1743  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3680:	.1744  immed[gprA_7, 0x0], gpr_wrboth
3688:	.1745  alu[--, gprA_6, OR, gprB_7]
3690:	.1746  beq[.1748]
3698:	.1747  br[.1435]
36a0:	.1748  alu[gprA_6, --, B, gprB_2], gpr_wrboth
36a8:	.1749  alu[gprA_7, --, B, gprB_3], gpr_wrboth
36b0:	.1750  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
36b8:	.1751  immed[gprA_7, 0x0], gpr_wrboth
36c0:	.1752  alu[--, gprA_6, OR, gprB_7]
36c8:	.1753  beq[.2062]
36d0:	.1754  alu[gprA_6, --, B, gprB_2], gpr_wrboth
36d8:	.1755  alu[gprA_7, --, B, gprB_3], gpr_wrboth
36e0:	.1756  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
36e8:	.1757  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
36f0:	.1758  alu[gprA_8, --, B, gprB_4], gpr_wrboth
36f8:	.1759  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3700:	.1760  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
3708:	.1761  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
3710:	.1762  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
3718:	.1763  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
3720:	.1764  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3728:	.1765  immed[gprA_9, 0x0], gpr_wrboth
3730:	.1766  alu[--, gprA_8, OR, gprB_9]
3738:	.1767  bne[.1435]
3740:	.1768  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3748:	.1769  immed[gprA_7, 0x0], gpr_wrboth
3750:	.1770  alu[--, gprA_6, OR, gprB_7]
3758:	.1771  beq[.2062]
3760:	.1772  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3768:	.1773  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3770:	.1774  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
3778:	.1775  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
3780:	.1776  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3788:	.1777  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3790:	.1778  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
3798:	.1779  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
37a0:	.1780  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
37a8:	.1781  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
37b0:	.1782  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
37b8:	.1783  immed[gprA_9, 0x0], gpr_wrboth
37c0:	.1784  alu[--, gprA_8, OR, gprB_9]
37c8:	.1785  bne[.1435]
37d0:	.1786  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
37d8:	.1787  immed[gprA_7, 0x0], gpr_wrboth
37e0:	.1788  alu[--, gprA_6, OR, gprB_7]
37e8:	.1789  beq[.2062]
37f0:	.1790  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
37f8:	.1791  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
3800:	.1792  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
3808:	.1793  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
3810:	.1794  alu[--, gprA_2, XOR, gprB_4]
3818:	.1795  bne[.1435]
3820:	.1796  alu[--, gprA_3, XOR, gprB_5]
3828:	.1797  bne[.1435]
3830:	.1798  alu[--, gprA_2, OR, gprB_3]
3838:	.1799  beq[.2062]
3840:	.1800  immed[gprA_3, 0x0], gpr_wrboth
3848:	.1801  alu[gprA_2, --, B, *l$index0[8]], gpr_wrboth
3850:	.1802  alu[gprA_21, gprA_0, +, 0x8]
3858:	.1803  alu[gprB_21, gprB_1, +carry, 0x0]
3860:	.1804  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
3868:	.1805  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
3870:	.1806  immed[gprA_5, 0x0], gpr_wrboth
3878:	.1807  alu[gprA_6, --, B, gprB_4], gpr_wrboth
3880:	.1808  alu[gprA_7, --, B, gprB_5], gpr_wrboth
3888:	.1809  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
3890:	.1810  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
3898:	.1811  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
38a0:	.1812  immed[gprA_7, 0x0], gpr_wrboth
38a8:	.1813  alu[--, gprA_6, OR, gprB_7]
38b0:	.1814  bne[.1435]
38b8:	.1815  alu[gprA_6, --, B, gprB_2], gpr_wrboth
38c0:	.1816  alu[gprA_7, --, B, gprB_3], gpr_wrboth
38c8:	.1817  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
38d0:	.1818  immed[gprA_7, 0x0], gpr_wrboth
38d8:	.1819  alu[--, gprA_6, OR, gprB_7]
38e0:	.1820  beq[.2062]
38e8:	.1821  alu[gprA_6, --, B, gprB_2], gpr_wrboth
38f0:	.1822  alu[gprA_7, --, B, gprB_3], gpr_wrboth
38f8:	.1823  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
3900:	.1824  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
3908:	.1825  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3910:	.1826  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3918:	.1827  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
3920:	.1828  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
3928:	.1829  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
3930:	.1830  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
3938:	.1831  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3940:	.1832  immed[gprA_9, 0x0], gpr_wrboth
3948:	.1833  alu[--, gprA_8, OR, gprB_9]
3950:	.1834  bne[.1435]
3958:	.1835  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3960:	.1836  immed[gprA_7, 0x0], gpr_wrboth
3968:	.1837  alu[--, gprA_6, OR, gprB_7]
3970:	.1838  beq[.2062]
3978:	.1839  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3980:	.1840  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3988:	.1841  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
3990:	.1842  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
3998:	.1843  alu[gprA_8, --, B, gprB_4], gpr_wrboth
39a0:	.1844  alu[gprA_9, --, B, gprB_5], gpr_wrboth
39a8:	.1845  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
39b0:	.1846  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
39b8:	.1847  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
39c0:	.1848  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
39c8:	.1849  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
39d0:	.1850  immed[gprA_9, 0x0], gpr_wrboth
39d8:	.1851  alu[--, gprA_8, OR, gprB_9]
39e0:	.1852  bne[.1435]
39e8:	.1853  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
39f0:	.1854  immed[gprA_7, 0x0], gpr_wrboth
39f8:	.1855  alu[--, gprA_6, OR, gprB_7]
3a00:	.1856  beq[.2062]
3a08:	.1857  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
3a10:	.1858  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
3a18:	.1859  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
3a20:	.1860  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
3a28:	.1861  alu[--, gprA_2, XOR, gprB_4]
3a30:	.1862  bne[.1435]
3a38:	.1863  alu[--, gprA_3, XOR, gprB_5]
3a40:	.1864  bne[.1435]
3a48:	.1865  alu[--, gprA_2, OR, gprB_3]
3a50:	.1866  beq[.2062]
3a58:	.1867  immed[gprA_3, 0x0], gpr_wrboth
3a60:	.1868  alu[gprA_2, --, B, *l$index0[9]], gpr_wrboth
3a68:	.1869  alu[gprA_21, gprA_0, +, 0xc]
3a70:	.1870  alu[gprB_21, gprB_1, +carry, 0x0]
3a78:	.1871  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
3a80:	.1872  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
3a88:	.1873  immed[gprA_5, 0x0], gpr_wrboth
3a90:	.1874  alu[gprA_6, --, B, gprB_4], gpr_wrboth
3a98:	.1875  alu[gprA_7, --, B, gprB_5], gpr_wrboth
3aa0:	.1876  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
3aa8:	.1877  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
3ab0:	.1878  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3ab8:	.1879  immed[gprA_7, 0x0], gpr_wrboth
3ac0:	.1880  alu[--, gprA_6, OR, gprB_7]
3ac8:	.1881  bne[.1435]
3ad0:	.1882  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3ad8:	.1883  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3ae0:	.1884  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3ae8:	.1885  immed[gprA_7, 0x0], gpr_wrboth
3af0:	.1886  alu[--, gprA_6, OR, gprB_7]
3af8:	.1887  beq[.2062]
3b00:	.1888  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3b08:	.1889  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3b10:	.1890  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
3b18:	.1891  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
3b20:	.1892  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3b28:	.1893  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3b30:	.1894  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
3b38:	.1895  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
3b40:	.1896  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
3b48:	.1897  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
3b50:	.1898  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3b58:	.1899  immed[gprA_9, 0x0], gpr_wrboth
3b60:	.1900  alu[--, gprA_8, OR, gprB_9]
3b68:	.1901  bne[.1435]
3b70:	.1902  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3b78:	.1903  immed[gprA_7, 0x0], gpr_wrboth
3b80:	.1904  alu[--, gprA_6, OR, gprB_7]
3b88:	.1905  beq[.2062]
3b90:	.1906  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3b98:	.1907  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3ba0:	.1908  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
3ba8:	.1909  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
3bb0:	.1910  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3bb8:	.1911  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3bc0:	.1912  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
3bc8:	.1913  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
3bd0:	.1914  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
3bd8:	.1915  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
3be0:	.1916  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3be8:	.1917  immed[gprA_9, 0x0], gpr_wrboth
3bf0:	.1918  alu[--, gprA_8, OR, gprB_9]
3bf8:	.1919  bne[.1435]
3c00:	.1920  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3c08:	.1921  immed[gprA_7, 0x0], gpr_wrboth
3c10:	.1922  alu[--, gprA_6, OR, gprB_7]
3c18:	.1923  beq[.2062]
3c20:	.1924  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
3c28:	.1925  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
3c30:	.1926  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
3c38:	.1927  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
3c40:	.1928  alu[--, gprA_2, XOR, gprB_4]
3c48:	.1929  bne[.1435]
3c50:	.1930  alu[--, gprA_3, XOR, gprB_5]
3c58:	.1931  bne[.1435]
3c60:	.1932  alu[--, gprA_2, OR, gprB_3]
3c68:	.1933  beq[.2062]
3c70:	.1934  immed[gprA_3, 0x0], gpr_wrboth
3c78:	.1935  alu[gprA_2, --, B, *l$index0[10]], gpr_wrboth
3c80:	.1936  alu[gprA_21, gprA_0, +, 0x10]
3c88:	.1937  alu[gprB_21, gprB_1, +carry, 0x0]
3c90:	.1938  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
3c98:	.1939  alu[gprA_4, --, B, $xfer_0], gpr_wrboth
3ca0:	.1940  immed[gprA_5, 0x0], gpr_wrboth
3ca8:	.1941  alu[gprA_6, --, B, gprB_4], gpr_wrboth
3cb0:	.1942  alu[gprA_7, --, B, gprB_5], gpr_wrboth
3cb8:	.1943  alu[gprA_6, gprA_6, XOR, gprB_2], gpr_wrboth
3cc0:	.1944  alu[gprA_7, gprA_7, XOR, gprB_3], gpr_wrboth
3cc8:	.1945  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3cd0:	.1946  immed[gprA_7, 0x0], gpr_wrboth
3cd8:	.1947  alu[--, gprA_6, OR, gprB_7]
3ce0:	.1948  bne[.1435]
3ce8:	.1949  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3cf0:	.1950  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3cf8:	.1951  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3d00:	.1952  immed[gprA_7, 0x0], gpr_wrboth
3d08:	.1953  alu[--, gprA_6, OR, gprB_7]
3d10:	.1954  beq[.2062]
3d18:	.1955  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3d20:	.1956  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3d28:	.1957  dbl_shf[gprA_6, gprA_7, gprB_6, >>8], gpr_wrboth
3d30:	.1958  alu_shf[gprA_7, --, B, gprB_7, >>8], gpr_wrboth
3d38:	.1959  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3d40:	.1960  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3d48:	.1961  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
3d50:	.1962  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
3d58:	.1963  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
3d60:	.1964  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
3d68:	.1965  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3d70:	.1966  immed[gprA_9, 0x0], gpr_wrboth
3d78:	.1967  alu[--, gprA_8, OR, gprB_9]
3d80:	.1968  bne[.1435]
3d88:	.1969  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3d90:	.1970  immed[gprA_7, 0x0], gpr_wrboth
3d98:	.1971  alu[--, gprA_6, OR, gprB_7]
3da0:	.1972  beq[.2062]
3da8:	.1973  alu[gprA_6, --, B, gprB_2], gpr_wrboth
3db0:	.1974  alu[gprA_7, --, B, gprB_3], gpr_wrboth
3db8:	.1975  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
3dc0:	.1976  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
3dc8:	.1977  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3dd0:	.1978  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3dd8:	.1979  dbl_shf[gprA_8, gprA_9, gprB_8, >>16], gpr_wrboth
3de0:	.1980  alu_shf[gprA_9, --, B, gprB_9, >>16], gpr_wrboth
3de8:	.1981  alu[gprA_8, gprA_8, XOR, gprB_6], gpr_wrboth
3df0:	.1982  alu[gprA_9, gprA_9, XOR, gprB_7], gpr_wrboth
3df8:	.1983  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3e00:	.1984  immed[gprA_9, 0x0], gpr_wrboth
3e08:	.1985  alu[--, gprA_8, OR, gprB_9]
3e10:	.1986  bne[.1435]
3e18:	.1987  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
3e20:	.1988  immed[gprA_7, 0x0], gpr_wrboth
3e28:	.1989  alu[--, gprA_6, OR, gprB_7]
3e30:	.1990  beq[.2062]
3e38:	.1991  dbl_shf[gprA_2, gprA_3, gprB_2, >>24], gpr_wrboth
3e40:	.1992  alu_shf[gprA_3, --, B, gprB_3, >>24], gpr_wrboth
3e48:	.1993  dbl_shf[gprA_4, gprA_5, gprB_4, >>24], gpr_wrboth
3e50:	.1994  alu_shf[gprA_5, --, B, gprB_5, >>24], gpr_wrboth
3e58:	.1995  alu[--, gprA_2, XOR, gprB_4]
3e60:	.1996  bne[.1435]
3e68:	.1997  alu[--, gprA_3, XOR, gprB_5]
3e70:	.1998  bne[.1435]
3e78:	.1999  alu[--, gprA_2, OR, gprB_3]
3e80:	.2000  beq[.2062]
3e88:	.2001  immed[gprA_5, 0x0], gpr_wrboth
3e90:	.2002  alu[gprA_4, --, B, *l$index0[11]], gpr_wrboth
3e98:	.2003  alu[gprA_21, gprA_0, +, 0x14]
3ea0:	.2004  alu[gprB_21, gprB_1, +carry, 0x0]
3ea8:	.2005  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 1], ctx_swap[sig1]
3eb0:	.2006  alu[gprA_6, --, B, $xfer_0], gpr_wrboth
3eb8:	.2007  immed[gprA_7, 0x0], gpr_wrboth
3ec0:	.2008  alu[gprA_2, --, B, gprB_6], gpr_wrboth
3ec8:	.2009  alu[gprA_3, --, B, gprB_7], gpr_wrboth
3ed0:	.2010  alu[gprA_2, gprA_2, XOR, gprB_4], gpr_wrboth
3ed8:	.2011  alu[gprA_3, gprA_3, XOR, gprB_5], gpr_wrboth
3ee0:	.2012  alu[gprA_8, --, B, gprB_2], gpr_wrboth
3ee8:	.2013  alu[gprA_9, --, B, gprB_3], gpr_wrboth
3ef0:	.2014  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3ef8:	.2015  immed[gprA_9, 0x0], gpr_wrboth
3f00:	.2016  alu[--, gprA_8, OR, gprB_9]
3f08:	.2017  bne[.1435]
3f10:	.2018  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3f18:	.2019  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3f20:	.2020  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3f28:	.2021  immed[gprA_9, 0x0], gpr_wrboth
3f30:	.2022  alu[--, gprA_8, OR, gprB_9]
3f38:	.2023  beq[.2062]
3f40:	.2024  alu[gprA_8, --, B, gprB_4], gpr_wrboth
3f48:	.2025  alu[gprA_9, --, B, gprB_5], gpr_wrboth
3f50:	.2026  dbl_shf[gprA_8, gprA_9, gprB_8, >>8], gpr_wrboth
3f58:	.2027  alu_shf[gprA_9, --, B, gprB_9, >>8], gpr_wrboth
3f60:	.2028  alu[gprA_10, --, B, gprB_6], gpr_wrboth
3f68:	.2029  alu[gprA_11, --, B, gprB_7], gpr_wrboth
3f70:	.2030  dbl_shf[gprA_10, gprA_11, gprB_10, >>8], gpr_wrboth
3f78:	.2031  alu_shf[gprA_11, --, B, gprB_11, >>8], gpr_wrboth
3f80:	.2032  alu[gprA_10, gprA_10, XOR, gprB_8], gpr_wrboth
3f88:	.2033  alu[gprA_11, gprA_11, XOR, gprB_9], gpr_wrboth
3f90:	.2034  alu[gprA_10, gprA_10, AND, 0xff], gpr_wrboth
3f98:	.2035  immed[gprA_11, 0x0], gpr_wrboth
3fa0:	.2036  alu[--, gprA_10, OR, gprB_11]
3fa8:	.2037  bne[.1435]
3fb0:	.2038  alu[gprA_8, gprA_8, AND, 0xff], gpr_wrboth
3fb8:	.2039  immed[gprA_9, 0x0], gpr_wrboth
3fc0:	.2040  alu[--, gprA_8, OR, gprB_9]
3fc8:	.2041  beq[.2062]
3fd0:	.2042  dbl_shf[gprA_4, gprA_5, gprB_4, >>16], gpr_wrboth
3fd8:	.2043  alu_shf[gprA_5, --, B, gprB_5, >>16], gpr_wrboth
3fe0:	.2044  dbl_shf[gprA_6, gprA_7, gprB_6, >>16], gpr_wrboth
3fe8:	.2045  alu_shf[gprA_7, --, B, gprB_7, >>16], gpr_wrboth
3ff0:	.2046  alu[gprA_6, gprA_6, XOR, gprB_4], gpr_wrboth
3ff8:	.2047  alu[gprA_7, gprA_7, XOR, gprB_5], gpr_wrboth
4000:	.2048  alu[gprA_6, gprA_6, AND, 0xff], gpr_wrboth
4008:	.2049  immed[gprA_7, 0x0], gpr_wrboth
4010:	.2050  alu[--, gprA_6, OR, gprB_7]
4018:	.2051  bne[.1435]
4020:	.2052  alu[gprA_4, gprA_4, AND, 0xff], gpr_wrboth
4028:	.2053  immed[gprA_5, 0x0], gpr_wrboth
4030:	.2054  alu[--, gprA_4, OR, gprB_5]
4038:	.2055  beq[.2062]
4040:	.2056  immed[gprA_4, 0x100, <<16], gpr_wrboth
4048:	.2057  immed[gprA_5, 0x0], gpr_wrboth
4050:	.2058  alu[--, gprA_2, -, gprB_4]
4058:	.2059  alu[--, gprA_3, -carry, gprB_5]
4060:	.2060  bcc[.2062]
4068:	.2061  br[.1435]
4070:	.2062  immed[gprA_2, 0x1], gpr_wrboth
4078:	.2063  immed[gprA_3, 0x0], gpr_wrboth
4080:	.2064  alu[gprA_20, gprA_0, +, 0x2c]
4088:	.2065  alu[gprB_20, gprA_1, +carry, 0x0]
4090:	.2066  immed[gprA_21, 0x890]
4098:	.2067  ld_field[gprA_21, 1100, gprB_2, <<16]
40a0:	.2068  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
40a8:	.2069  alu[gprA_2, --, B, gprB_16], gpr_wrboth
40b0:	.2070  alu[gprA_3, --, B, gprB_17], gpr_wrboth
40b8:	.2071  alu[gprA_2, gprA_2, +, 0x10], gpr_wrboth
40c0:	.2072  alu[gprA_3, gprA_3, +carry, 0x0], gpr_wrboth
40c8:	.2073  alu[--, gprA_14, -, gprB_2]
40d0:	.2074  alu[--, gprA_15, -carry, gprB_3]
40d8:	.2075  bcc[.104]
40e0:	.2076  alu[gprA_4, --, B, gprB_12], gpr_wrboth
40e8:	.2077  alu[gprA_5, --, B, gprB_13], gpr_wrboth
40f0:	.2078  alu[gprA_4, gprA_4, +, 0x22], gpr_wrboth
40f8:	.2079  alu[gprA_5, gprA_5, +carry, 0x0], gpr_wrboth
4100:	.2080  alu[gprA_6, --, B, gprB_12], gpr_wrboth
4108:	.2081  alu[gprA_7, --, B, gprB_13], gpr_wrboth
4110:	.2082  alu[gprA_6, gprA_6, +, 0xe], gpr_wrboth
4118:	.2083  alu[gprA_7, gprA_7, +carry, 0x0], gpr_wrboth
4120:	.2084  immed[gprA_8, 0x0], gpr_wrboth
4128:	.2085  immed[gprA_9, 0x0], gpr_wrboth
4130:	.2086  alu[$xfer_0, --, B, gprA_8]
4138:	.2087  mem[write8_swap, $xfer_0, gprA_12, 0x32, 2], ctx_swap[sig1]
4140:	.2088  immed[gprA_8, 0x100], gpr_wrboth
4148:	.2089  immed[gprA_9, 0x0], gpr_wrboth
4150:	.2090  alu[$xfer_0, --, B, gprA_8]
4158:	.2091  mem[write8_swap, $xfer_0, gprA_12, 0x30, 2], ctx_swap[sig1]
4160:	.2092  alu[gprA_21, gprA_0, +, 0x18]
4168:	.2093  alu[gprB_21, gprB_1, +carry, 0x0]
4170:	.2094  mem[read32_swap, $xfer_0, gprB_21, <<8, gprA_21, 4], ctx_swap[sig1]
4178:	.2095  alu[$xfer_0, --, B, $xfer_0]
4180:	.2096  alu[$xfer_1, --, B, $xfer_1]
4188:	.2097  alu[$xfer_2, --, B, $xfer_2]
4190:	.2098  alu[$xfer_3, --, B, $xfer_3]
4198:	.2099  mem[write32_swap, $xfer_0, gprA_16, 0x0, 4], ctx_swap[sig1]
41a0:	.2100  alu[gprA_8, --, B, $xfer_0], gpr_wrboth
41a8:	.2101  immed[gprA_9, 0x0], gpr_wrboth
41b0:	.2102  alu[gprA_8, --, B, gprB_2], gpr_wrboth
41b8:	.2103  alu[gprA_9, --, B, gprB_3], gpr_wrboth
41c0:	.2104  alu[gprA_8, gprA_8, -, gprB_6], gpr_wrboth
41c8:	.2105  alu[gprA_9, gprA_9, -carry, gprB_7], gpr_wrboth
41d0:	.2106  alu[gprA_2, gprA_2, -, gprB_4], gpr_wrboth
41d8:	.2107  alu[gprA_3, gprA_3, -carry, gprB_5], gpr_wrboth
41e0:	.2108  alu[$xfer_0, --, B, gprA_2]
41e8:	.2109  mem[write8_swap, $xfer_0, gprA_12, 0x26, 2], ctx_swap[sig1]
41f0:	.2110  alu[$xfer_0, --, B, gprA_8]
41f8:	.2111  mem[write8_swap, $xfer_0, gprA_12, 0x10, 2], ctx_swap[sig1]
4200:	.2112  mem[read32_swap, $xfer_0, gprA_12, 0x2c, 1], ctx_swap[sig1]
4208:	.2113  ld_field_w_clr[gprA_2, 0011, $xfer_0], gpr_wrboth
4210:	.2114  immed[gprA_3, 0x0], gpr_wrboth
4218:	.2115  br[.111]
4220:	.2116  br[.15000], defer[2]
4228:	.2117  alu[gprA_0, --, B, 0x0]
4230:	.2118  ld_field[gprA_0, 1100, 0x82, <<16]
4238:	.2119  alu[--, 0x3, -, gprB_0]
4240:	.2120  bcc[.2116]
4248:	.2121  immed[gprB_2, 0x2282]
4250:	.2122  immed_w1[gprB_2, 0x4411]
4258:	.2123  alu_shf[gprA_1, --, B, gprB_0, <<3]
4260:	.2124  alu[--, gprA_1, OR, 0x0]
4268:	.2125  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
4270:	.2126  br[.15000], defer[2]
4278:	.2127  alu[gprA_0, --, B, 0x0]
4280:	.2128  ld_field[gprA_0, 1100, gprB_2, <<16]
4288:	.2129  nop
4290:	.2130  nop
4298:	.2131  nop
42a0:	.2132  nop
42a8:	.2133  nop
42b0:	.2134  nop
42b8:	.2135  nop
42c0:	.2136  nop
