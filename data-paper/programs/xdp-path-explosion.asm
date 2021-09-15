   0:	   .0  immed[gprB_22, 0x3fff]
   8:	   .1  alu[gprB_22, gprB_22, AND, *l$index1]
  10:	   .2  alu[gprA_6, gprB_22, +, *l$index1[2]], gpr_wrboth
  18:	   .3  immed[gprA_7, 0x0], gpr_wrboth
  20:	   .4  alu[gprA_4, --, B, *l$index1[2]], gpr_wrboth
  28:	   .5  immed[gprA_5, 0x0], gpr_wrboth
  30:	   .6  immed[gprA_2, 0x0], gpr_wrboth
  38:	   .7  immed[gprA_3, 0x0], gpr_wrboth
  40:	   .8  alu[*l$index0, --, B, gprB_2]
  48:	   .9  alu[gprA_8, --, B, gprB_4], gpr_wrboth
  50:	  .10  alu[gprA_9, --, B, gprB_5], gpr_wrboth
  58:	  .11  alu[gprA_8, gprA_8, +, 0x4], gpr_wrboth
  60:	  .12  alu[gprA_9, gprA_9, +carry, 0x0], gpr_wrboth
  68:	  .13  immed[gprA_2, 0x2], gpr_wrboth
  70:	  .14  immed[gprA_3, 0x0], gpr_wrboth
  78:	  .15  alu[--, gprA_6, -, gprB_8]
  80:	  .16  alu[--, gprA_7, -carry, gprB_9]
  88:	  .17  bcc[.1011]
  90:	  .18  mem[read32_swap, $xfer_0, gprA_4, 0x0, 1], ctx_swap[sig1]
  98:	  .19  alu[gprA_12, --, B, $xfer_0], gpr_wrboth
  a0:	  .20  immed[gprA_13, 0x0], gpr_wrboth
  a8:	  .21  alu[gprA_4, gprA_22, +, 0x4], gpr_wrboth
  b0:	  .22  immed[gprA_5, 0x0], gpr_wrboth
  b8:	  .23  alu[gprA_4, gprA_4, -, 0x4], gpr_wrboth
  c0:	  .24  alu[gprA_5, gprA_5, -carry, 0x0], gpr_wrboth
  c8:	  .25  immed[gprA_2, 0x0], gpr_wrboth
  d0:	  .26  alu[gprA_3, --, B, gprA_2], gpr_wrboth
  d8:	  .27  alu[gprA_1, --, B, gprB_23], gpr_wrboth
  e0:	  .28  immed[gprA_21, 0xffff]
  e8:	  .29  alu_shf[gprA_0, gprA_21, AND, *l$index0, <<16], gpr_wrboth
  f0:	  .30  immed[gprA_2, 0x1], gpr_wrboth
  f8:	  .31  immed[gprA_3, 0x0], gpr_wrboth
 100:	  .32  alu[--, gprA_0, OR, gprB_1]
 108:	  .33  beq[.1011]
 110:	  .34  alu[gprA_2, --, B, gprB_12], gpr_wrboth
 118:	  .35  alu[gprA_3, --, B, gprB_13], gpr_wrboth
 120:	  .36  alu[gprA_21, --, B, gprB_3]
 128:	  .37  ld_field[gprB_3, 1111, gprA_2, >>rot8], gpr_wrboth
 130:	  .38  ld_field[gprB_3, 0101, gprA_3, >>rot16], gpr_wrboth
 138:	  .39  ld_field[gprB_2, 1111, gprA_21, >>rot8], gpr_wrboth
 140:	  .40  ld_field[gprB_2, 0101, gprA_2, >>rot16], gpr_wrboth
 148:	  .41  alu[gprA_2, --, B, gprB_3], gpr_wrboth
 150:	  .42  asr[gprA_3, gprB_3, >>31], gpr_wrboth
 158:	  .43  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 160:	  .44  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 168:	  .45  alu[gprA_4, gprA_4, AND, 0x1], gpr_wrboth
 170:	  .46  immed[gprA_5, 0x0], gpr_wrboth
 178:	  .47  alu[--, gprA_4, OR, gprB_5]
 180:	  .48  beq[.54]
 188:	  .49  immed[gprA_4, 0x1], gpr_wrboth
 190:	  .50  immed[gprA_5, 0x0], gpr_wrboth
 198:	  .51  immed[gprA_21, 0x890]
 1a0:	  .52  ld_field[gprA_21, 1100, gprB_4, <<16]
 1a8:	  .53  mem[add_imm, $xfer_0, gprB_1, <<8, gprA_0, 1], indirect_ref
 1b0:	  .54  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 1b8:	  .55  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 1c0:	  .56  alu[gprA_4, gprA_4, AND, 0x2], gpr_wrboth
 1c8:	  .57  immed[gprA_5, 0x0], gpr_wrboth
 1d0:	  .58  alu[--, gprA_4, OR, gprB_5]
 1d8:	  .59  beq[.67]
 1e0:	  .60  immed[gprA_4, 0x1], gpr_wrboth
 1e8:	  .61  immed[gprA_5, 0x0], gpr_wrboth
 1f0:	  .62  alu[gprA_20, gprA_0, +, 0x4]
 1f8:	  .63  alu[gprB_20, gprA_1, +carry, 0x0]
 200:	  .64  immed[gprA_21, 0x890]
 208:	  .65  ld_field[gprA_21, 1100, gprB_4, <<16]
 210:	  .66  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 218:	  .67  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 220:	  .68  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 228:	  .69  alu[gprA_4, gprA_4, AND, 0x4], gpr_wrboth
 230:	  .70  immed[gprA_5, 0x0], gpr_wrboth
 238:	  .71  alu[--, gprA_4, OR, gprB_5]
 240:	  .72  beq[.80]
 248:	  .73  immed[gprA_4, 0x1], gpr_wrboth
 250:	  .74  immed[gprA_5, 0x0], gpr_wrboth
 258:	  .75  alu[gprA_20, gprA_0, +, 0x8]
 260:	  .76  alu[gprB_20, gprA_1, +carry, 0x0]
 268:	  .77  immed[gprA_21, 0x890]
 270:	  .78  ld_field[gprA_21, 1100, gprB_4, <<16]
 278:	  .79  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 280:	  .80  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 288:	  .81  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 290:	  .82  alu[gprA_4, gprA_4, AND, 0x8], gpr_wrboth
 298:	  .83  immed[gprA_5, 0x0], gpr_wrboth
 2a0:	  .84  alu[--, gprA_4, OR, gprB_5]
 2a8:	  .85  beq[.93]
 2b0:	  .86  immed[gprA_4, 0x1], gpr_wrboth
 2b8:	  .87  immed[gprA_5, 0x0], gpr_wrboth
 2c0:	  .88  alu[gprA_20, gprA_0, +, 0xc]
 2c8:	  .89  alu[gprB_20, gprA_1, +carry, 0x0]
 2d0:	  .90  immed[gprA_21, 0x890]
 2d8:	  .91  ld_field[gprA_21, 1100, gprB_4, <<16]
 2e0:	  .92  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 2e8:	  .93  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 2f0:	  .94  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 2f8:	  .95  alu[gprA_4, gprA_4, AND, 0x10], gpr_wrboth
 300:	  .96  immed[gprA_5, 0x0], gpr_wrboth
 308:	  .97  alu[--, gprA_4, OR, gprB_5]
 310:	  .98  beq[.106]
 318:	  .99  immed[gprA_4, 0x1], gpr_wrboth
 320:	 .100  immed[gprA_5, 0x0], gpr_wrboth
 328:	 .101  alu[gprA_20, gprA_0, +, 0x10]
 330:	 .102  alu[gprB_20, gprA_1, +carry, 0x0]
 338:	 .103  immed[gprA_21, 0x890]
 340:	 .104  ld_field[gprA_21, 1100, gprB_4, <<16]
 348:	 .105  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 350:	 .106  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 358:	 .107  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 360:	 .108  alu[gprA_4, gprA_4, AND, 0x20], gpr_wrboth
 368:	 .109  immed[gprA_5, 0x0], gpr_wrboth
 370:	 .110  alu[--, gprA_4, OR, gprB_5]
 378:	 .111  beq[.119]
 380:	 .112  immed[gprA_4, 0x1], gpr_wrboth
 388:	 .113  immed[gprA_5, 0x0], gpr_wrboth
 390:	 .114  alu[gprA_20, gprA_0, +, 0x14]
 398:	 .115  alu[gprB_20, gprA_1, +carry, 0x0]
 3a0:	 .116  immed[gprA_21, 0x890]
 3a8:	 .117  ld_field[gprA_21, 1100, gprB_4, <<16]
 3b0:	 .118  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 3b8:	 .119  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 3c0:	 .120  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 3c8:	 .121  alu[gprA_4, gprA_4, AND, 0x40], gpr_wrboth
 3d0:	 .122  immed[gprA_5, 0x0], gpr_wrboth
 3d8:	 .123  alu[--, gprA_4, OR, gprB_5]
 3e0:	 .124  beq[.132]
 3e8:	 .125  immed[gprA_4, 0x1], gpr_wrboth
 3f0:	 .126  immed[gprA_5, 0x0], gpr_wrboth
 3f8:	 .127  alu[gprA_20, gprA_0, +, 0x18]
 400:	 .128  alu[gprB_20, gprA_1, +carry, 0x0]
 408:	 .129  immed[gprA_21, 0x890]
 410:	 .130  ld_field[gprA_21, 1100, gprB_4, <<16]
 418:	 .131  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 420:	 .132  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 428:	 .133  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 430:	 .134  alu_shf[gprA_5, --, B, gprB_4, <<24], gpr_wrboth
 438:	 .135  immed[gprA_4, 0x0], gpr_wrboth
 440:	 .136  alu[--, gprA_5, OR, 0x0]
 448:	 .137  asr[gprA_4, gprB_5, >>24], gpr_wrboth
 450:	 .138  asr[gprA_5, gprB_5, >>31], gpr_wrboth
 458:	 .139  immed[gprB_21, 0xffffffff]
 460:	 .140  alu[--, gprB_21, -, gprA_4]
 468:	 .141  immed[gprB_21, 0xffffffff]
 470:	 .142  alu[--, gprB_21, -carry, gprA_5]
 478:	 .143  blt[.151]
 480:	 .144  immed[gprA_4, 0x1], gpr_wrboth
 488:	 .145  immed[gprA_5, 0x0], gpr_wrboth
 490:	 .146  alu[gprA_20, gprA_0, +, 0x1c]
 498:	 .147  alu[gprB_20, gprA_1, +carry, 0x0]
 4a0:	 .148  immed[gprA_21, 0x890]
 4a8:	 .149  ld_field[gprA_21, 1100, gprB_4, <<16]
 4b0:	 .150  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 4b8:	 .151  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 4c0:	 .152  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 4c8:	 .153  immed[gprB_21, 0x100]
 4d0:	 .154  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 4d8:	 .155  immed[gprA_5, 0x0], gpr_wrboth
 4e0:	 .156  alu[--, gprA_4, OR, gprB_5]
 4e8:	 .157  beq[.165]
 4f0:	 .158  immed[gprA_4, 0x1], gpr_wrboth
 4f8:	 .159  immed[gprA_5, 0x0], gpr_wrboth
 500:	 .160  alu[gprA_20, gprA_0, +, 0x20]
 508:	 .161  alu[gprB_20, gprA_1, +carry, 0x0]
 510:	 .162  immed[gprA_21, 0x890]
 518:	 .163  ld_field[gprA_21, 1100, gprB_4, <<16]
 520:	 .164  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 528:	 .165  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 530:	 .166  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 538:	 .167  immed[gprB_21, 0x200]
 540:	 .168  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 548:	 .169  immed[gprA_5, 0x0], gpr_wrboth
 550:	 .170  alu[--, gprA_4, OR, gprB_5]
 558:	 .171  beq[.179]
 560:	 .172  immed[gprA_4, 0x1], gpr_wrboth
 568:	 .173  immed[gprA_5, 0x0], gpr_wrboth
 570:	 .174  alu[gprA_20, gprA_0, +, 0x24]
 578:	 .175  alu[gprB_20, gprA_1, +carry, 0x0]
 580:	 .176  immed[gprA_21, 0x890]
 588:	 .177  ld_field[gprA_21, 1100, gprB_4, <<16]
 590:	 .178  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 598:	 .179  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 5a0:	 .180  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 5a8:	 .181  immed[gprB_21, 0x400]
 5b0:	 .182  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 5b8:	 .183  immed[gprA_5, 0x0], gpr_wrboth
 5c0:	 .184  alu[--, gprA_4, OR, gprB_5]
 5c8:	 .185  beq[.193]
 5d0:	 .186  immed[gprA_4, 0x1], gpr_wrboth
 5d8:	 .187  immed[gprA_5, 0x0], gpr_wrboth
 5e0:	 .188  alu[gprA_20, gprA_0, +, 0x28]
 5e8:	 .189  alu[gprB_20, gprA_1, +carry, 0x0]
 5f0:	 .190  immed[gprA_21, 0x890]
 5f8:	 .191  ld_field[gprA_21, 1100, gprB_4, <<16]
 600:	 .192  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 608:	 .193  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 610:	 .194  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 618:	 .195  immed[gprB_21, 0x800]
 620:	 .196  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 628:	 .197  immed[gprA_5, 0x0], gpr_wrboth
 630:	 .198  alu[--, gprA_4, OR, gprB_5]
 638:	 .199  beq[.207]
 640:	 .200  immed[gprA_4, 0x1], gpr_wrboth
 648:	 .201  immed[gprA_5, 0x0], gpr_wrboth
 650:	 .202  alu[gprA_20, gprA_0, +, 0x2c]
 658:	 .203  alu[gprB_20, gprA_1, +carry, 0x0]
 660:	 .204  immed[gprA_21, 0x890]
 668:	 .205  ld_field[gprA_21, 1100, gprB_4, <<16]
 670:	 .206  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 678:	 .207  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 680:	 .208  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 688:	 .209  immed[gprB_21, 0x1000]
 690:	 .210  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 698:	 .211  immed[gprA_5, 0x0], gpr_wrboth
 6a0:	 .212  alu[--, gprA_4, OR, gprB_5]
 6a8:	 .213  beq[.221]
 6b0:	 .214  immed[gprA_4, 0x1], gpr_wrboth
 6b8:	 .215  immed[gprA_5, 0x0], gpr_wrboth
 6c0:	 .216  alu[gprA_20, gprA_0, +, 0x30]
 6c8:	 .217  alu[gprB_20, gprA_1, +carry, 0x0]
 6d0:	 .218  immed[gprA_21, 0x890]
 6d8:	 .219  ld_field[gprA_21, 1100, gprB_4, <<16]
 6e0:	 .220  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 6e8:	 .221  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 6f0:	 .222  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 6f8:	 .223  immed[gprB_21, 0x2000]
 700:	 .224  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 708:	 .225  immed[gprA_5, 0x0], gpr_wrboth
 710:	 .226  alu[--, gprA_4, OR, gprB_5]
 718:	 .227  beq[.235]
 720:	 .228  immed[gprA_4, 0x1], gpr_wrboth
 728:	 .229  immed[gprA_5, 0x0], gpr_wrboth
 730:	 .230  alu[gprA_20, gprA_0, +, 0x34]
 738:	 .231  alu[gprB_20, gprA_1, +carry, 0x0]
 740:	 .232  immed[gprA_21, 0x890]
 748:	 .233  ld_field[gprA_21, 1100, gprB_4, <<16]
 750:	 .234  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 758:	 .235  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 760:	 .236  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 768:	 .237  immed[gprB_21, 0x4000]
 770:	 .238  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 778:	 .239  immed[gprA_5, 0x0], gpr_wrboth
 780:	 .240  alu[--, gprA_4, OR, gprB_5]
 788:	 .241  beq[.249]
 790:	 .242  immed[gprA_4, 0x1], gpr_wrboth
 798:	 .243  immed[gprA_5, 0x0], gpr_wrboth
 7a0:	 .244  alu[gprA_20, gprA_0, +, 0x38]
 7a8:	 .245  alu[gprB_20, gprA_1, +carry, 0x0]
 7b0:	 .246  immed[gprA_21, 0x890]
 7b8:	 .247  ld_field[gprA_21, 1100, gprB_4, <<16]
 7c0:	 .248  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 7c8:	 .249  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 7d0:	 .250  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 7d8:	 .251  alu_shf[gprA_5, --, B, gprB_4, <<16], gpr_wrboth
 7e0:	 .252  immed[gprA_4, 0x0], gpr_wrboth
 7e8:	 .253  alu[--, gprA_5, OR, 0x0]
 7f0:	 .254  asr[gprA_4, gprB_5, >>16], gpr_wrboth
 7f8:	 .255  asr[gprA_5, gprB_5, >>31], gpr_wrboth
 800:	 .256  immed[gprB_21, 0xffffffff]
 808:	 .257  alu[--, gprB_21, -, gprA_4]
 810:	 .258  immed[gprB_21, 0xffffffff]
 818:	 .259  alu[--, gprB_21, -carry, gprA_5]
 820:	 .260  blt[.268]
 828:	 .261  immed[gprA_4, 0x1], gpr_wrboth
 830:	 .262  immed[gprA_5, 0x0], gpr_wrboth
 838:	 .263  alu[gprA_20, gprA_0, +, 0x3c]
 840:	 .264  alu[gprB_20, gprA_1, +carry, 0x0]
 848:	 .265  immed[gprA_21, 0x890]
 850:	 .266  ld_field[gprA_21, 1100, gprB_4, <<16]
 858:	 .267  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 860:	 .268  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 868:	 .269  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 870:	 .270  immed[gprB_21, 0x100, <<8]
 878:	 .271  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 880:	 .272  immed[gprA_5, 0x0], gpr_wrboth
 888:	 .273  alu[--, gprA_4, OR, gprB_5]
 890:	 .274  beq[.282]
 898:	 .275  immed[gprA_4, 0x1], gpr_wrboth
 8a0:	 .276  immed[gprA_5, 0x0], gpr_wrboth
 8a8:	 .277  alu[gprA_20, gprA_0, +, 0x40]
 8b0:	 .278  alu[gprB_20, gprA_1, +carry, 0x0]
 8b8:	 .279  immed[gprA_21, 0x890]
 8c0:	 .280  ld_field[gprA_21, 1100, gprB_4, <<16]
 8c8:	 .281  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 8d0:	 .282  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 8d8:	 .283  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 8e0:	 .284  immed[gprB_21, 0x200, <<8]
 8e8:	 .285  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 8f0:	 .286  immed[gprA_5, 0x0], gpr_wrboth
 8f8:	 .287  alu[--, gprA_4, OR, gprB_5]
 900:	 .288  beq[.296]
 908:	 .289  immed[gprA_4, 0x1], gpr_wrboth
 910:	 .290  immed[gprA_5, 0x0], gpr_wrboth
 918:	 .291  alu[gprA_20, gprA_0, +, 0x44]
 920:	 .292  alu[gprB_20, gprA_1, +carry, 0x0]
 928:	 .293  immed[gprA_21, 0x890]
 930:	 .294  ld_field[gprA_21, 1100, gprB_4, <<16]
 938:	 .295  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 940:	 .296  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 948:	 .297  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 950:	 .298  immed[gprB_21, 0x400, <<8]
 958:	 .299  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 960:	 .300  immed[gprA_5, 0x0], gpr_wrboth
 968:	 .301  alu[--, gprA_4, OR, gprB_5]
 970:	 .302  beq[.310]
 978:	 .303  immed[gprA_4, 0x1], gpr_wrboth
 980:	 .304  immed[gprA_5, 0x0], gpr_wrboth
 988:	 .305  alu[gprA_20, gprA_0, +, 0x48]
 990:	 .306  alu[gprB_20, gprA_1, +carry, 0x0]
 998:	 .307  immed[gprA_21, 0x890]
 9a0:	 .308  ld_field[gprA_21, 1100, gprB_4, <<16]
 9a8:	 .309  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 9b0:	 .310  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 9b8:	 .311  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 9c0:	 .312  immed[gprB_21, 0x800, <<8]
 9c8:	 .313  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 9d0:	 .314  immed[gprA_5, 0x0], gpr_wrboth
 9d8:	 .315  alu[--, gprA_4, OR, gprB_5]
 9e0:	 .316  beq[.324]
 9e8:	 .317  immed[gprA_4, 0x1], gpr_wrboth
 9f0:	 .318  immed[gprA_5, 0x0], gpr_wrboth
 9f8:	 .319  alu[gprA_20, gprA_0, +, 0x4c]
 a00:	 .320  alu[gprB_20, gprA_1, +carry, 0x0]
 a08:	 .321  immed[gprA_21, 0x890]
 a10:	 .322  ld_field[gprA_21, 1100, gprB_4, <<16]
 a18:	 .323  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 a20:	 .324  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 a28:	 .325  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 a30:	 .326  immed[gprB_21, 0x1000, <<8]
 a38:	 .327  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 a40:	 .328  immed[gprA_5, 0x0], gpr_wrboth
 a48:	 .329  alu[--, gprA_4, OR, gprB_5]
 a50:	 .330  beq[.338]
 a58:	 .331  immed[gprA_4, 0x1], gpr_wrboth
 a60:	 .332  immed[gprA_5, 0x0], gpr_wrboth
 a68:	 .333  alu[gprA_20, gprA_0, +, 0x50]
 a70:	 .334  alu[gprB_20, gprA_1, +carry, 0x0]
 a78:	 .335  immed[gprA_21, 0x890]
 a80:	 .336  ld_field[gprA_21, 1100, gprB_4, <<16]
 a88:	 .337  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 a90:	 .338  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 a98:	 .339  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 aa0:	 .340  immed[gprB_21, 0x2000, <<8]
 aa8:	 .341  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 ab0:	 .342  immed[gprA_5, 0x0], gpr_wrboth
 ab8:	 .343  alu[--, gprA_4, OR, gprB_5]
 ac0:	 .344  beq[.352]
 ac8:	 .345  immed[gprA_4, 0x1], gpr_wrboth
 ad0:	 .346  immed[gprA_5, 0x0], gpr_wrboth
 ad8:	 .347  alu[gprA_20, gprA_0, +, 0x54]
 ae0:	 .348  alu[gprB_20, gprA_1, +carry, 0x0]
 ae8:	 .349  immed[gprA_21, 0x890]
 af0:	 .350  ld_field[gprA_21, 1100, gprB_4, <<16]
 af8:	 .351  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 b00:	 .352  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 b08:	 .353  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 b10:	 .354  immed[gprB_21, 0x4000, <<8]
 b18:	 .355  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 b20:	 .356  immed[gprA_5, 0x0], gpr_wrboth
 b28:	 .357  alu[--, gprA_4, OR, gprB_5]
 b30:	 .358  beq[.366]
 b38:	 .359  immed[gprA_4, 0x1], gpr_wrboth
 b40:	 .360  immed[gprA_5, 0x0], gpr_wrboth
 b48:	 .361  alu[gprA_20, gprA_0, +, 0x58]
 b50:	 .362  alu[gprB_20, gprA_1, +carry, 0x0]
 b58:	 .363  immed[gprA_21, 0x890]
 b60:	 .364  ld_field[gprA_21, 1100, gprB_4, <<16]
 b68:	 .365  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 b70:	 .366  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 b78:	 .367  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 b80:	 .368  immed[gprB_21, 0x8000, <<8]
 b88:	 .369  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 b90:	 .370  immed[gprA_5, 0x0], gpr_wrboth
 b98:	 .371  alu[--, gprA_4, OR, gprB_5]
 ba0:	 .372  beq[.380]
 ba8:	 .373  immed[gprA_4, 0x1], gpr_wrboth
 bb0:	 .374  immed[gprA_5, 0x0], gpr_wrboth
 bb8:	 .375  alu[gprA_20, gprA_0, +, 0x5c]
 bc0:	 .376  alu[gprB_20, gprA_1, +carry, 0x0]
 bc8:	 .377  immed[gprA_21, 0x890]
 bd0:	 .378  ld_field[gprA_21, 1100, gprB_4, <<16]
 bd8:	 .379  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 be0:	 .380  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 be8:	 .381  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 bf0:	 .382  immed[gprB_21, 0x100, <<16]
 bf8:	 .383  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 c00:	 .384  immed[gprA_5, 0x0], gpr_wrboth
 c08:	 .385  alu[--, gprA_4, OR, gprB_5]
 c10:	 .386  beq[.394]
 c18:	 .387  immed[gprA_4, 0x1], gpr_wrboth
 c20:	 .388  immed[gprA_5, 0x0], gpr_wrboth
 c28:	 .389  alu[gprA_20, gprA_0, +, 0x60]
 c30:	 .390  alu[gprB_20, gprA_1, +carry, 0x0]
 c38:	 .391  immed[gprA_21, 0x890]
 c40:	 .392  ld_field[gprA_21, 1100, gprB_4, <<16]
 c48:	 .393  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 c50:	 .394  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 c58:	 .395  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 c60:	 .396  immed[gprB_21, 0x200, <<16]
 c68:	 .397  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 c70:	 .398  immed[gprA_5, 0x0], gpr_wrboth
 c78:	 .399  alu[--, gprA_4, OR, gprB_5]
 c80:	 .400  beq[.408]
 c88:	 .401  immed[gprA_4, 0x1], gpr_wrboth
 c90:	 .402  immed[gprA_5, 0x0], gpr_wrboth
 c98:	 .403  alu[gprA_20, gprA_0, +, 0x64]
 ca0:	 .404  alu[gprB_20, gprA_1, +carry, 0x0]
 ca8:	 .405  immed[gprA_21, 0x890]
 cb0:	 .406  ld_field[gprA_21, 1100, gprB_4, <<16]
 cb8:	 .407  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 cc0:	 .408  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 cc8:	 .409  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 cd0:	 .410  immed[gprB_21, 0x400, <<16]
 cd8:	 .411  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 ce0:	 .412  immed[gprA_5, 0x0], gpr_wrboth
 ce8:	 .413  alu[--, gprA_4, OR, gprB_5]
 cf0:	 .414  beq[.422]
 cf8:	 .415  immed[gprA_4, 0x1], gpr_wrboth
 d00:	 .416  immed[gprA_5, 0x0], gpr_wrboth
 d08:	 .417  alu[gprA_20, gprA_0, +, 0x68]
 d10:	 .418  alu[gprB_20, gprA_1, +carry, 0x0]
 d18:	 .419  immed[gprA_21, 0x890]
 d20:	 .420  ld_field[gprA_21, 1100, gprB_4, <<16]
 d28:	 .421  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 d30:	 .422  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 d38:	 .423  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 d40:	 .424  immed[gprB_21, 0x800, <<16]
 d48:	 .425  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 d50:	 .426  immed[gprA_5, 0x0], gpr_wrboth
 d58:	 .427  alu[--, gprA_4, OR, gprB_5]
 d60:	 .428  beq[.436]
 d68:	 .429  immed[gprA_4, 0x1], gpr_wrboth
 d70:	 .430  immed[gprA_5, 0x0], gpr_wrboth
 d78:	 .431  alu[gprA_20, gprA_0, +, 0x6c]
 d80:	 .432  alu[gprB_20, gprA_1, +carry, 0x0]
 d88:	 .433  immed[gprA_21, 0x890]
 d90:	 .434  ld_field[gprA_21, 1100, gprB_4, <<16]
 d98:	 .435  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 da0:	 .436  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 da8:	 .437  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 db0:	 .438  immed[gprB_21, 0x1000, <<16]
 db8:	 .439  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 dc0:	 .440  immed[gprA_5, 0x0], gpr_wrboth
 dc8:	 .441  alu[--, gprA_4, OR, gprB_5]
 dd0:	 .442  beq[.450]
 dd8:	 .443  immed[gprA_4, 0x1], gpr_wrboth
 de0:	 .444  immed[gprA_5, 0x0], gpr_wrboth
 de8:	 .445  alu[gprA_20, gprA_0, +, 0x70]
 df0:	 .446  alu[gprB_20, gprA_1, +carry, 0x0]
 df8:	 .447  immed[gprA_21, 0x890]
 e00:	 .448  ld_field[gprA_21, 1100, gprB_4, <<16]
 e08:	 .449  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 e10:	 .450  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 e18:	 .451  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 e20:	 .452  immed[gprB_21, 0x2000, <<16]
 e28:	 .453  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 e30:	 .454  immed[gprA_5, 0x0], gpr_wrboth
 e38:	 .455  alu[--, gprA_4, OR, gprB_5]
 e40:	 .456  beq[.464]
 e48:	 .457  immed[gprA_4, 0x1], gpr_wrboth
 e50:	 .458  immed[gprA_5, 0x0], gpr_wrboth
 e58:	 .459  alu[gprA_20, gprA_0, +, 0x74]
 e60:	 .460  alu[gprB_20, gprA_1, +carry, 0x0]
 e68:	 .461  immed[gprA_21, 0x890]
 e70:	 .462  ld_field[gprA_21, 1100, gprB_4, <<16]
 e78:	 .463  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 e80:	 .464  alu[gprA_4, --, B, gprB_2], gpr_wrboth
 e88:	 .465  alu[gprA_5, --, B, gprB_3], gpr_wrboth
 e90:	 .466  immed[gprB_21, 0x4000, <<16]
 e98:	 .467  alu[gprA_4, gprA_4, AND, gprB_21], gpr_wrboth
 ea0:	 .468  immed[gprA_5, 0x0], gpr_wrboth
 ea8:	 .469  alu[--, gprA_4, OR, gprB_5]
 eb0:	 .470  beq[.478]
 eb8:	 .471  immed[gprA_4, 0x1], gpr_wrboth
 ec0:	 .472  immed[gprA_5, 0x0], gpr_wrboth
 ec8:	 .473  alu[gprA_20, gprA_0, +, 0x78]
 ed0:	 .474  alu[gprB_20, gprA_1, +carry, 0x0]
 ed8:	 .475  immed[gprA_21, 0x890]
 ee0:	 .476  ld_field[gprA_21, 1100, gprB_4, <<16]
 ee8:	 .477  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 ef0:	 .478  immed[gprB_21, 0xffffffff]
 ef8:	 .479  alu[--, gprB_21, -, gprA_2]
 f00:	 .480  immed[gprB_21, 0xffffffff]
 f08:	 .481  alu[--, gprB_21, -carry, gprA_3]
 f10:	 .482  blt[.490]
 f18:	 .483  immed[gprA_2, 0x1], gpr_wrboth
 f20:	 .484  immed[gprA_3, 0x0], gpr_wrboth
 f28:	 .485  alu[gprA_20, gprA_0, +, 0x7c]
 f30:	 .486  alu[gprB_20, gprA_1, +carry, 0x0]
 f38:	 .487  immed[gprA_21, 0x890]
 f40:	 .488  ld_field[gprA_21, 1100, gprB_2, <<16]
 f48:	 .489  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 f50:	 .490  alu[gprA_4, --, B, gprB_12], gpr_wrboth
 f58:	 .491  alu[gprA_5, --, B, gprB_13], gpr_wrboth
 f60:	 .492  immed[gprA_2, 0x2], gpr_wrboth
 f68:	 .493  immed[gprA_3, 0x0], gpr_wrboth
 f70:	 .494  alu[--, gprA_4, OR, gprB_5]
 f78:	 .495  beq[.497]
 f80:	 .496  br[.1011]
 f88:	 .497  immed[gprA_2, 0x1], gpr_wrboth
 f90:	 .498  immed[gprA_3, 0x0], gpr_wrboth
 f98:	 .499  immed[gprA_4, 0x1], gpr_wrboth
 fa0:	 .500  immed[gprA_5, 0x0], gpr_wrboth
 fa8:	 .501  immed[gprB_21, 0x100]
 fb0:	 .502  alu[gprA_20, gprA_0, +, gprB_21]
 fb8:	 .503  alu[gprB_20, gprA_1, +carry, 0x0]
 fc0:	 .504  immed[gprA_21, 0x890]
 fc8:	 .505  ld_field[gprA_21, 1100, gprB_4, <<16]
 fd0:	 .506  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
 fd8:	 .507  immed[gprA_4, 0x1], gpr_wrboth
 fe0:	 .508  immed[gprA_5, 0x0], gpr_wrboth
 fe8:	 .509  immed[gprB_21, 0x104]
 ff0:	 .510  alu[gprA_20, gprA_0, +, gprB_21]
 ff8:	 .511  alu[gprB_20, gprA_1, +carry, 0x0]
1000:	 .512  immed[gprA_21, 0x890]
1008:	 .513  ld_field[gprA_21, 1100, gprB_4, <<16]
1010:	 .514  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1018:	 .515  immed[gprA_4, 0x1], gpr_wrboth
1020:	 .516  immed[gprA_5, 0x0], gpr_wrboth
1028:	 .517  immed[gprB_21, 0x108]
1030:	 .518  alu[gprA_20, gprA_0, +, gprB_21]
1038:	 .519  alu[gprB_20, gprA_1, +carry, 0x0]
1040:	 .520  immed[gprA_21, 0x890]
1048:	 .521  ld_field[gprA_21, 1100, gprB_4, <<16]
1050:	 .522  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1058:	 .523  immed[gprA_4, 0x1], gpr_wrboth
1060:	 .524  immed[gprA_5, 0x0], gpr_wrboth
1068:	 .525  immed[gprB_21, 0x10c]
1070:	 .526  alu[gprA_20, gprA_0, +, gprB_21]
1078:	 .527  alu[gprB_20, gprA_1, +carry, 0x0]
1080:	 .528  immed[gprA_21, 0x890]
1088:	 .529  ld_field[gprA_21, 1100, gprB_4, <<16]
1090:	 .530  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1098:	 .531  immed[gprA_4, 0x1], gpr_wrboth
10a0:	 .532  immed[gprA_5, 0x0], gpr_wrboth
10a8:	 .533  immed[gprB_21, 0x110]
10b0:	 .534  alu[gprA_20, gprA_0, +, gprB_21]
10b8:	 .535  alu[gprB_20, gprA_1, +carry, 0x0]
10c0:	 .536  immed[gprA_21, 0x890]
10c8:	 .537  ld_field[gprA_21, 1100, gprB_4, <<16]
10d0:	 .538  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
10d8:	 .539  immed[gprA_4, 0x1], gpr_wrboth
10e0:	 .540  immed[gprA_5, 0x0], gpr_wrboth
10e8:	 .541  immed[gprB_21, 0x114]
10f0:	 .542  alu[gprA_20, gprA_0, +, gprB_21]
10f8:	 .543  alu[gprB_20, gprA_1, +carry, 0x0]
1100:	 .544  immed[gprA_21, 0x890]
1108:	 .545  ld_field[gprA_21, 1100, gprB_4, <<16]
1110:	 .546  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1118:	 .547  immed[gprA_4, 0x1], gpr_wrboth
1120:	 .548  immed[gprA_5, 0x0], gpr_wrboth
1128:	 .549  immed[gprB_21, 0x118]
1130:	 .550  alu[gprA_20, gprA_0, +, gprB_21]
1138:	 .551  alu[gprB_20, gprA_1, +carry, 0x0]
1140:	 .552  immed[gprA_21, 0x890]
1148:	 .553  ld_field[gprA_21, 1100, gprB_4, <<16]
1150:	 .554  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1158:	 .555  immed[gprA_4, 0x1], gpr_wrboth
1160:	 .556  immed[gprA_5, 0x0], gpr_wrboth
1168:	 .557  immed[gprB_21, 0x11c]
1170:	 .558  alu[gprA_20, gprA_0, +, gprB_21]
1178:	 .559  alu[gprB_20, gprA_1, +carry, 0x0]
1180:	 .560  immed[gprA_21, 0x890]
1188:	 .561  ld_field[gprA_21, 1100, gprB_4, <<16]
1190:	 .562  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1198:	 .563  immed[gprA_4, 0x1], gpr_wrboth
11a0:	 .564  immed[gprA_5, 0x0], gpr_wrboth
11a8:	 .565  immed[gprB_21, 0x120]
11b0:	 .566  alu[gprA_20, gprA_0, +, gprB_21]
11b8:	 .567  alu[gprB_20, gprA_1, +carry, 0x0]
11c0:	 .568  immed[gprA_21, 0x890]
11c8:	 .569  ld_field[gprA_21, 1100, gprB_4, <<16]
11d0:	 .570  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
11d8:	 .571  immed[gprA_4, 0x1], gpr_wrboth
11e0:	 .572  immed[gprA_5, 0x0], gpr_wrboth
11e8:	 .573  immed[gprB_21, 0x124]
11f0:	 .574  alu[gprA_20, gprA_0, +, gprB_21]
11f8:	 .575  alu[gprB_20, gprA_1, +carry, 0x0]
1200:	 .576  immed[gprA_21, 0x890]
1208:	 .577  ld_field[gprA_21, 1100, gprB_4, <<16]
1210:	 .578  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1218:	 .579  immed[gprA_4, 0x1], gpr_wrboth
1220:	 .580  immed[gprA_5, 0x0], gpr_wrboth
1228:	 .581  immed[gprB_21, 0x128]
1230:	 .582  alu[gprA_20, gprA_0, +, gprB_21]
1238:	 .583  alu[gprB_20, gprA_1, +carry, 0x0]
1240:	 .584  immed[gprA_21, 0x890]
1248:	 .585  ld_field[gprA_21, 1100, gprB_4, <<16]
1250:	 .586  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1258:	 .587  immed[gprA_4, 0x1], gpr_wrboth
1260:	 .588  immed[gprA_5, 0x0], gpr_wrboth
1268:	 .589  immed[gprB_21, 0x12c]
1270:	 .590  alu[gprA_20, gprA_0, +, gprB_21]
1278:	 .591  alu[gprB_20, gprA_1, +carry, 0x0]
1280:	 .592  immed[gprA_21, 0x890]
1288:	 .593  ld_field[gprA_21, 1100, gprB_4, <<16]
1290:	 .594  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1298:	 .595  immed[gprA_4, 0x1], gpr_wrboth
12a0:	 .596  immed[gprA_5, 0x0], gpr_wrboth
12a8:	 .597  immed[gprB_21, 0x130]
12b0:	 .598  alu[gprA_20, gprA_0, +, gprB_21]
12b8:	 .599  alu[gprB_20, gprA_1, +carry, 0x0]
12c0:	 .600  immed[gprA_21, 0x890]
12c8:	 .601  ld_field[gprA_21, 1100, gprB_4, <<16]
12d0:	 .602  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
12d8:	 .603  immed[gprA_4, 0x1], gpr_wrboth
12e0:	 .604  immed[gprA_5, 0x0], gpr_wrboth
12e8:	 .605  immed[gprB_21, 0x134]
12f0:	 .606  alu[gprA_20, gprA_0, +, gprB_21]
12f8:	 .607  alu[gprB_20, gprA_1, +carry, 0x0]
1300:	 .608  immed[gprA_21, 0x890]
1308:	 .609  ld_field[gprA_21, 1100, gprB_4, <<16]
1310:	 .610  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1318:	 .611  immed[gprA_4, 0x1], gpr_wrboth
1320:	 .612  immed[gprA_5, 0x0], gpr_wrboth
1328:	 .613  immed[gprB_21, 0x138]
1330:	 .614  alu[gprA_20, gprA_0, +, gprB_21]
1338:	 .615  alu[gprB_20, gprA_1, +carry, 0x0]
1340:	 .616  immed[gprA_21, 0x890]
1348:	 .617  ld_field[gprA_21, 1100, gprB_4, <<16]
1350:	 .618  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1358:	 .619  immed[gprA_4, 0x1], gpr_wrboth
1360:	 .620  immed[gprA_5, 0x0], gpr_wrboth
1368:	 .621  immed[gprB_21, 0x13c]
1370:	 .622  alu[gprA_20, gprA_0, +, gprB_21]
1378:	 .623  alu[gprB_20, gprA_1, +carry, 0x0]
1380:	 .624  immed[gprA_21, 0x890]
1388:	 .625  ld_field[gprA_21, 1100, gprB_4, <<16]
1390:	 .626  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1398:	 .627  immed[gprA_4, 0x1], gpr_wrboth
13a0:	 .628  immed[gprA_5, 0x0], gpr_wrboth
13a8:	 .629  immed[gprB_21, 0x140]
13b0:	 .630  alu[gprA_20, gprA_0, +, gprB_21]
13b8:	 .631  alu[gprB_20, gprA_1, +carry, 0x0]
13c0:	 .632  immed[gprA_21, 0x890]
13c8:	 .633  ld_field[gprA_21, 1100, gprB_4, <<16]
13d0:	 .634  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
13d8:	 .635  immed[gprA_4, 0x1], gpr_wrboth
13e0:	 .636  immed[gprA_5, 0x0], gpr_wrboth
13e8:	 .637  immed[gprB_21, 0x144]
13f0:	 .638  alu[gprA_20, gprA_0, +, gprB_21]
13f8:	 .639  alu[gprB_20, gprA_1, +carry, 0x0]
1400:	 .640  immed[gprA_21, 0x890]
1408:	 .641  ld_field[gprA_21, 1100, gprB_4, <<16]
1410:	 .642  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1418:	 .643  immed[gprA_4, 0x1], gpr_wrboth
1420:	 .644  immed[gprA_5, 0x0], gpr_wrboth
1428:	 .645  immed[gprB_21, 0x148]
1430:	 .646  alu[gprA_20, gprA_0, +, gprB_21]
1438:	 .647  alu[gprB_20, gprA_1, +carry, 0x0]
1440:	 .648  immed[gprA_21, 0x890]
1448:	 .649  ld_field[gprA_21, 1100, gprB_4, <<16]
1450:	 .650  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1458:	 .651  immed[gprA_4, 0x1], gpr_wrboth
1460:	 .652  immed[gprA_5, 0x0], gpr_wrboth
1468:	 .653  immed[gprB_21, 0x14c]
1470:	 .654  alu[gprA_20, gprA_0, +, gprB_21]
1478:	 .655  alu[gprB_20, gprA_1, +carry, 0x0]
1480:	 .656  immed[gprA_21, 0x890]
1488:	 .657  ld_field[gprA_21, 1100, gprB_4, <<16]
1490:	 .658  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1498:	 .659  immed[gprA_4, 0x1], gpr_wrboth
14a0:	 .660  immed[gprA_5, 0x0], gpr_wrboth
14a8:	 .661  immed[gprB_21, 0x150]
14b0:	 .662  alu[gprA_20, gprA_0, +, gprB_21]
14b8:	 .663  alu[gprB_20, gprA_1, +carry, 0x0]
14c0:	 .664  immed[gprA_21, 0x890]
14c8:	 .665  ld_field[gprA_21, 1100, gprB_4, <<16]
14d0:	 .666  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
14d8:	 .667  immed[gprA_4, 0x1], gpr_wrboth
14e0:	 .668  immed[gprA_5, 0x0], gpr_wrboth
14e8:	 .669  immed[gprB_21, 0x154]
14f0:	 .670  alu[gprA_20, gprA_0, +, gprB_21]
14f8:	 .671  alu[gprB_20, gprA_1, +carry, 0x0]
1500:	 .672  immed[gprA_21, 0x890]
1508:	 .673  ld_field[gprA_21, 1100, gprB_4, <<16]
1510:	 .674  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1518:	 .675  immed[gprA_4, 0x1], gpr_wrboth
1520:	 .676  immed[gprA_5, 0x0], gpr_wrboth
1528:	 .677  immed[gprB_21, 0x158]
1530:	 .678  alu[gprA_20, gprA_0, +, gprB_21]
1538:	 .679  alu[gprB_20, gprA_1, +carry, 0x0]
1540:	 .680  immed[gprA_21, 0x890]
1548:	 .681  ld_field[gprA_21, 1100, gprB_4, <<16]
1550:	 .682  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1558:	 .683  immed[gprA_4, 0x1], gpr_wrboth
1560:	 .684  immed[gprA_5, 0x0], gpr_wrboth
1568:	 .685  immed[gprB_21, 0x15c]
1570:	 .686  alu[gprA_20, gprA_0, +, gprB_21]
1578:	 .687  alu[gprB_20, gprA_1, +carry, 0x0]
1580:	 .688  immed[gprA_21, 0x890]
1588:	 .689  ld_field[gprA_21, 1100, gprB_4, <<16]
1590:	 .690  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1598:	 .691  immed[gprA_4, 0x1], gpr_wrboth
15a0:	 .692  immed[gprA_5, 0x0], gpr_wrboth
15a8:	 .693  immed[gprB_21, 0x160]
15b0:	 .694  alu[gprA_20, gprA_0, +, gprB_21]
15b8:	 .695  alu[gprB_20, gprA_1, +carry, 0x0]
15c0:	 .696  immed[gprA_21, 0x890]
15c8:	 .697  ld_field[gprA_21, 1100, gprB_4, <<16]
15d0:	 .698  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
15d8:	 .699  immed[gprA_4, 0x1], gpr_wrboth
15e0:	 .700  immed[gprA_5, 0x0], gpr_wrboth
15e8:	 .701  immed[gprB_21, 0x164]
15f0:	 .702  alu[gprA_20, gprA_0, +, gprB_21]
15f8:	 .703  alu[gprB_20, gprA_1, +carry, 0x0]
1600:	 .704  immed[gprA_21, 0x890]
1608:	 .705  ld_field[gprA_21, 1100, gprB_4, <<16]
1610:	 .706  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1618:	 .707  immed[gprA_4, 0x1], gpr_wrboth
1620:	 .708  immed[gprA_5, 0x0], gpr_wrboth
1628:	 .709  immed[gprB_21, 0x168]
1630:	 .710  alu[gprA_20, gprA_0, +, gprB_21]
1638:	 .711  alu[gprB_20, gprA_1, +carry, 0x0]
1640:	 .712  immed[gprA_21, 0x890]
1648:	 .713  ld_field[gprA_21, 1100, gprB_4, <<16]
1650:	 .714  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1658:	 .715  immed[gprA_4, 0x1], gpr_wrboth
1660:	 .716  immed[gprA_5, 0x0], gpr_wrboth
1668:	 .717  immed[gprB_21, 0x16c]
1670:	 .718  alu[gprA_20, gprA_0, +, gprB_21]
1678:	 .719  alu[gprB_20, gprA_1, +carry, 0x0]
1680:	 .720  immed[gprA_21, 0x890]
1688:	 .721  ld_field[gprA_21, 1100, gprB_4, <<16]
1690:	 .722  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1698:	 .723  immed[gprA_4, 0x1], gpr_wrboth
16a0:	 .724  immed[gprA_5, 0x0], gpr_wrboth
16a8:	 .725  immed[gprB_21, 0x170]
16b0:	 .726  alu[gprA_20, gprA_0, +, gprB_21]
16b8:	 .727  alu[gprB_20, gprA_1, +carry, 0x0]
16c0:	 .728  immed[gprA_21, 0x890]
16c8:	 .729  ld_field[gprA_21, 1100, gprB_4, <<16]
16d0:	 .730  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
16d8:	 .731  immed[gprA_4, 0x1], gpr_wrboth
16e0:	 .732  immed[gprA_5, 0x0], gpr_wrboth
16e8:	 .733  immed[gprB_21, 0x174]
16f0:	 .734  alu[gprA_20, gprA_0, +, gprB_21]
16f8:	 .735  alu[gprB_20, gprA_1, +carry, 0x0]
1700:	 .736  immed[gprA_21, 0x890]
1708:	 .737  ld_field[gprA_21, 1100, gprB_4, <<16]
1710:	 .738  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1718:	 .739  immed[gprA_4, 0x1], gpr_wrboth
1720:	 .740  immed[gprA_5, 0x0], gpr_wrboth
1728:	 .741  immed[gprB_21, 0x178]
1730:	 .742  alu[gprA_20, gprA_0, +, gprB_21]
1738:	 .743  alu[gprB_20, gprA_1, +carry, 0x0]
1740:	 .744  immed[gprA_21, 0x890]
1748:	 .745  ld_field[gprA_21, 1100, gprB_4, <<16]
1750:	 .746  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1758:	 .747  immed[gprA_4, 0x1], gpr_wrboth
1760:	 .748  immed[gprA_5, 0x0], gpr_wrboth
1768:	 .749  immed[gprB_21, 0x17c]
1770:	 .750  alu[gprA_20, gprA_0, +, gprB_21]
1778:	 .751  alu[gprB_20, gprA_1, +carry, 0x0]
1780:	 .752  immed[gprA_21, 0x890]
1788:	 .753  ld_field[gprA_21, 1100, gprB_4, <<16]
1790:	 .754  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1798:	 .755  immed[gprA_4, 0x1], gpr_wrboth
17a0:	 .756  immed[gprA_5, 0x0], gpr_wrboth
17a8:	 .757  immed[gprB_21, 0x180]
17b0:	 .758  alu[gprA_20, gprA_0, +, gprB_21]
17b8:	 .759  alu[gprB_20, gprA_1, +carry, 0x0]
17c0:	 .760  immed[gprA_21, 0x890]
17c8:	 .761  ld_field[gprA_21, 1100, gprB_4, <<16]
17d0:	 .762  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
17d8:	 .763  immed[gprA_4, 0x1], gpr_wrboth
17e0:	 .764  immed[gprA_5, 0x0], gpr_wrboth
17e8:	 .765  immed[gprB_21, 0x184]
17f0:	 .766  alu[gprA_20, gprA_0, +, gprB_21]
17f8:	 .767  alu[gprB_20, gprA_1, +carry, 0x0]
1800:	 .768  immed[gprA_21, 0x890]
1808:	 .769  ld_field[gprA_21, 1100, gprB_4, <<16]
1810:	 .770  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1818:	 .771  immed[gprA_4, 0x1], gpr_wrboth
1820:	 .772  immed[gprA_5, 0x0], gpr_wrboth
1828:	 .773  immed[gprB_21, 0x188]
1830:	 .774  alu[gprA_20, gprA_0, +, gprB_21]
1838:	 .775  alu[gprB_20, gprA_1, +carry, 0x0]
1840:	 .776  immed[gprA_21, 0x890]
1848:	 .777  ld_field[gprA_21, 1100, gprB_4, <<16]
1850:	 .778  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1858:	 .779  immed[gprA_4, 0x1], gpr_wrboth
1860:	 .780  immed[gprA_5, 0x0], gpr_wrboth
1868:	 .781  immed[gprB_21, 0x18c]
1870:	 .782  alu[gprA_20, gprA_0, +, gprB_21]
1878:	 .783  alu[gprB_20, gprA_1, +carry, 0x0]
1880:	 .784  immed[gprA_21, 0x890]
1888:	 .785  ld_field[gprA_21, 1100, gprB_4, <<16]
1890:	 .786  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1898:	 .787  immed[gprA_4, 0x1], gpr_wrboth
18a0:	 .788  immed[gprA_5, 0x0], gpr_wrboth
18a8:	 .789  immed[gprB_21, 0x190]
18b0:	 .790  alu[gprA_20, gprA_0, +, gprB_21]
18b8:	 .791  alu[gprB_20, gprA_1, +carry, 0x0]
18c0:	 .792  immed[gprA_21, 0x890]
18c8:	 .793  ld_field[gprA_21, 1100, gprB_4, <<16]
18d0:	 .794  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
18d8:	 .795  immed[gprA_4, 0x1], gpr_wrboth
18e0:	 .796  immed[gprA_5, 0x0], gpr_wrboth
18e8:	 .797  immed[gprB_21, 0x194]
18f0:	 .798  alu[gprA_20, gprA_0, +, gprB_21]
18f8:	 .799  alu[gprB_20, gprA_1, +carry, 0x0]
1900:	 .800  immed[gprA_21, 0x890]
1908:	 .801  ld_field[gprA_21, 1100, gprB_4, <<16]
1910:	 .802  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1918:	 .803  immed[gprA_4, 0x1], gpr_wrboth
1920:	 .804  immed[gprA_5, 0x0], gpr_wrboth
1928:	 .805  immed[gprB_21, 0x198]
1930:	 .806  alu[gprA_20, gprA_0, +, gprB_21]
1938:	 .807  alu[gprB_20, gprA_1, +carry, 0x0]
1940:	 .808  immed[gprA_21, 0x890]
1948:	 .809  ld_field[gprA_21, 1100, gprB_4, <<16]
1950:	 .810  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1958:	 .811  immed[gprA_4, 0x1], gpr_wrboth
1960:	 .812  immed[gprA_5, 0x0], gpr_wrboth
1968:	 .813  immed[gprB_21, 0x19c]
1970:	 .814  alu[gprA_20, gprA_0, +, gprB_21]
1978:	 .815  alu[gprB_20, gprA_1, +carry, 0x0]
1980:	 .816  immed[gprA_21, 0x890]
1988:	 .817  ld_field[gprA_21, 1100, gprB_4, <<16]
1990:	 .818  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1998:	 .819  immed[gprA_4, 0x1], gpr_wrboth
19a0:	 .820  immed[gprA_5, 0x0], gpr_wrboth
19a8:	 .821  immed[gprB_21, 0x1a0]
19b0:	 .822  alu[gprA_20, gprA_0, +, gprB_21]
19b8:	 .823  alu[gprB_20, gprA_1, +carry, 0x0]
19c0:	 .824  immed[gprA_21, 0x890]
19c8:	 .825  ld_field[gprA_21, 1100, gprB_4, <<16]
19d0:	 .826  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
19d8:	 .827  immed[gprA_4, 0x1], gpr_wrboth
19e0:	 .828  immed[gprA_5, 0x0], gpr_wrboth
19e8:	 .829  immed[gprB_21, 0x1a4]
19f0:	 .830  alu[gprA_20, gprA_0, +, gprB_21]
19f8:	 .831  alu[gprB_20, gprA_1, +carry, 0x0]
1a00:	 .832  immed[gprA_21, 0x890]
1a08:	 .833  ld_field[gprA_21, 1100, gprB_4, <<16]
1a10:	 .834  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1a18:	 .835  immed[gprA_4, 0x1], gpr_wrboth
1a20:	 .836  immed[gprA_5, 0x0], gpr_wrboth
1a28:	 .837  immed[gprB_21, 0x1a8]
1a30:	 .838  alu[gprA_20, gprA_0, +, gprB_21]
1a38:	 .839  alu[gprB_20, gprA_1, +carry, 0x0]
1a40:	 .840  immed[gprA_21, 0x890]
1a48:	 .841  ld_field[gprA_21, 1100, gprB_4, <<16]
1a50:	 .842  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1a58:	 .843  immed[gprA_4, 0x1], gpr_wrboth
1a60:	 .844  immed[gprA_5, 0x0], gpr_wrboth
1a68:	 .845  immed[gprB_21, 0x1ac]
1a70:	 .846  alu[gprA_20, gprA_0, +, gprB_21]
1a78:	 .847  alu[gprB_20, gprA_1, +carry, 0x0]
1a80:	 .848  immed[gprA_21, 0x890]
1a88:	 .849  ld_field[gprA_21, 1100, gprB_4, <<16]
1a90:	 .850  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1a98:	 .851  immed[gprA_4, 0x1], gpr_wrboth
1aa0:	 .852  immed[gprA_5, 0x0], gpr_wrboth
1aa8:	 .853  immed[gprB_21, 0x1b0]
1ab0:	 .854  alu[gprA_20, gprA_0, +, gprB_21]
1ab8:	 .855  alu[gprB_20, gprA_1, +carry, 0x0]
1ac0:	 .856  immed[gprA_21, 0x890]
1ac8:	 .857  ld_field[gprA_21, 1100, gprB_4, <<16]
1ad0:	 .858  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1ad8:	 .859  immed[gprA_4, 0x1], gpr_wrboth
1ae0:	 .860  immed[gprA_5, 0x0], gpr_wrboth
1ae8:	 .861  immed[gprB_21, 0x1b4]
1af0:	 .862  alu[gprA_20, gprA_0, +, gprB_21]
1af8:	 .863  alu[gprB_20, gprA_1, +carry, 0x0]
1b00:	 .864  immed[gprA_21, 0x890]
1b08:	 .865  ld_field[gprA_21, 1100, gprB_4, <<16]
1b10:	 .866  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1b18:	 .867  immed[gprA_4, 0x1], gpr_wrboth
1b20:	 .868  immed[gprA_5, 0x0], gpr_wrboth
1b28:	 .869  immed[gprB_21, 0x1b8]
1b30:	 .870  alu[gprA_20, gprA_0, +, gprB_21]
1b38:	 .871  alu[gprB_20, gprA_1, +carry, 0x0]
1b40:	 .872  immed[gprA_21, 0x890]
1b48:	 .873  ld_field[gprA_21, 1100, gprB_4, <<16]
1b50:	 .874  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1b58:	 .875  immed[gprA_4, 0x1], gpr_wrboth
1b60:	 .876  immed[gprA_5, 0x0], gpr_wrboth
1b68:	 .877  immed[gprB_21, 0x1bc]
1b70:	 .878  alu[gprA_20, gprA_0, +, gprB_21]
1b78:	 .879  alu[gprB_20, gprA_1, +carry, 0x0]
1b80:	 .880  immed[gprA_21, 0x890]
1b88:	 .881  ld_field[gprA_21, 1100, gprB_4, <<16]
1b90:	 .882  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1b98:	 .883  immed[gprA_4, 0x1], gpr_wrboth
1ba0:	 .884  immed[gprA_5, 0x0], gpr_wrboth
1ba8:	 .885  immed[gprB_21, 0x1c0]
1bb0:	 .886  alu[gprA_20, gprA_0, +, gprB_21]
1bb8:	 .887  alu[gprB_20, gprA_1, +carry, 0x0]
1bc0:	 .888  immed[gprA_21, 0x890]
1bc8:	 .889  ld_field[gprA_21, 1100, gprB_4, <<16]
1bd0:	 .890  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1bd8:	 .891  immed[gprA_4, 0x1], gpr_wrboth
1be0:	 .892  immed[gprA_5, 0x0], gpr_wrboth
1be8:	 .893  immed[gprB_21, 0x1c4]
1bf0:	 .894  alu[gprA_20, gprA_0, +, gprB_21]
1bf8:	 .895  alu[gprB_20, gprA_1, +carry, 0x0]
1c00:	 .896  immed[gprA_21, 0x890]
1c08:	 .897  ld_field[gprA_21, 1100, gprB_4, <<16]
1c10:	 .898  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1c18:	 .899  immed[gprA_4, 0x1], gpr_wrboth
1c20:	 .900  immed[gprA_5, 0x0], gpr_wrboth
1c28:	 .901  immed[gprB_21, 0x1c8]
1c30:	 .902  alu[gprA_20, gprA_0, +, gprB_21]
1c38:	 .903  alu[gprB_20, gprA_1, +carry, 0x0]
1c40:	 .904  immed[gprA_21, 0x890]
1c48:	 .905  ld_field[gprA_21, 1100, gprB_4, <<16]
1c50:	 .906  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1c58:	 .907  immed[gprA_4, 0x1], gpr_wrboth
1c60:	 .908  immed[gprA_5, 0x0], gpr_wrboth
1c68:	 .909  immed[gprB_21, 0x1cc]
1c70:	 .910  alu[gprA_20, gprA_0, +, gprB_21]
1c78:	 .911  alu[gprB_20, gprA_1, +carry, 0x0]
1c80:	 .912  immed[gprA_21, 0x890]
1c88:	 .913  ld_field[gprA_21, 1100, gprB_4, <<16]
1c90:	 .914  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1c98:	 .915  immed[gprA_4, 0x1], gpr_wrboth
1ca0:	 .916  immed[gprA_5, 0x0], gpr_wrboth
1ca8:	 .917  immed[gprB_21, 0x1d0]
1cb0:	 .918  alu[gprA_20, gprA_0, +, gprB_21]
1cb8:	 .919  alu[gprB_20, gprA_1, +carry, 0x0]
1cc0:	 .920  immed[gprA_21, 0x890]
1cc8:	 .921  ld_field[gprA_21, 1100, gprB_4, <<16]
1cd0:	 .922  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1cd8:	 .923  immed[gprA_4, 0x1], gpr_wrboth
1ce0:	 .924  immed[gprA_5, 0x0], gpr_wrboth
1ce8:	 .925  immed[gprB_21, 0x1d4]
1cf0:	 .926  alu[gprA_20, gprA_0, +, gprB_21]
1cf8:	 .927  alu[gprB_20, gprA_1, +carry, 0x0]
1d00:	 .928  immed[gprA_21, 0x890]
1d08:	 .929  ld_field[gprA_21, 1100, gprB_4, <<16]
1d10:	 .930  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1d18:	 .931  immed[gprA_4, 0x1], gpr_wrboth
1d20:	 .932  immed[gprA_5, 0x0], gpr_wrboth
1d28:	 .933  immed[gprB_21, 0x1d8]
1d30:	 .934  alu[gprA_20, gprA_0, +, gprB_21]
1d38:	 .935  alu[gprB_20, gprA_1, +carry, 0x0]
1d40:	 .936  immed[gprA_21, 0x890]
1d48:	 .937  ld_field[gprA_21, 1100, gprB_4, <<16]
1d50:	 .938  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1d58:	 .939  immed[gprA_4, 0x1], gpr_wrboth
1d60:	 .940  immed[gprA_5, 0x0], gpr_wrboth
1d68:	 .941  immed[gprB_21, 0x1dc]
1d70:	 .942  alu[gprA_20, gprA_0, +, gprB_21]
1d78:	 .943  alu[gprB_20, gprA_1, +carry, 0x0]
1d80:	 .944  immed[gprA_21, 0x890]
1d88:	 .945  ld_field[gprA_21, 1100, gprB_4, <<16]
1d90:	 .946  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1d98:	 .947  immed[gprA_4, 0x1], gpr_wrboth
1da0:	 .948  immed[gprA_5, 0x0], gpr_wrboth
1da8:	 .949  immed[gprB_21, 0x1e0]
1db0:	 .950  alu[gprA_20, gprA_0, +, gprB_21]
1db8:	 .951  alu[gprB_20, gprA_1, +carry, 0x0]
1dc0:	 .952  immed[gprA_21, 0x890]
1dc8:	 .953  ld_field[gprA_21, 1100, gprB_4, <<16]
1dd0:	 .954  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1dd8:	 .955  immed[gprA_4, 0x1], gpr_wrboth
1de0:	 .956  immed[gprA_5, 0x0], gpr_wrboth
1de8:	 .957  immed[gprB_21, 0x1e4]
1df0:	 .958  alu[gprA_20, gprA_0, +, gprB_21]
1df8:	 .959  alu[gprB_20, gprA_1, +carry, 0x0]
1e00:	 .960  immed[gprA_21, 0x890]
1e08:	 .961  ld_field[gprA_21, 1100, gprB_4, <<16]
1e10:	 .962  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1e18:	 .963  immed[gprA_4, 0x1], gpr_wrboth
1e20:	 .964  immed[gprA_5, 0x0], gpr_wrboth
1e28:	 .965  immed[gprB_21, 0x1e8]
1e30:	 .966  alu[gprA_20, gprA_0, +, gprB_21]
1e38:	 .967  alu[gprB_20, gprA_1, +carry, 0x0]
1e40:	 .968  immed[gprA_21, 0x890]
1e48:	 .969  ld_field[gprA_21, 1100, gprB_4, <<16]
1e50:	 .970  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1e58:	 .971  immed[gprA_4, 0x1], gpr_wrboth
1e60:	 .972  immed[gprA_5, 0x0], gpr_wrboth
1e68:	 .973  immed[gprB_21, 0x1ec]
1e70:	 .974  alu[gprA_20, gprA_0, +, gprB_21]
1e78:	 .975  alu[gprB_20, gprA_1, +carry, 0x0]
1e80:	 .976  immed[gprA_21, 0x890]
1e88:	 .977  ld_field[gprA_21, 1100, gprB_4, <<16]
1e90:	 .978  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1e98:	 .979  immed[gprA_4, 0x1], gpr_wrboth
1ea0:	 .980  immed[gprA_5, 0x0], gpr_wrboth
1ea8:	 .981  immed[gprB_21, 0x1f0]
1eb0:	 .982  alu[gprA_20, gprA_0, +, gprB_21]
1eb8:	 .983  alu[gprB_20, gprA_1, +carry, 0x0]
1ec0:	 .984  immed[gprA_21, 0x890]
1ec8:	 .985  ld_field[gprA_21, 1100, gprB_4, <<16]
1ed0:	 .986  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1ed8:	 .987  immed[gprA_4, 0x1], gpr_wrboth
1ee0:	 .988  immed[gprA_5, 0x0], gpr_wrboth
1ee8:	 .989  immed[gprB_21, 0x1f4]
1ef0:	 .990  alu[gprA_20, gprA_0, +, gprB_21]
1ef8:	 .991  alu[gprB_20, gprA_1, +carry, 0x0]
1f00:	 .992  immed[gprA_21, 0x890]
1f08:	 .993  ld_field[gprA_21, 1100, gprB_4, <<16]
1f10:	 .994  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1f18:	 .995  immed[gprA_4, 0x1], gpr_wrboth
1f20:	 .996  immed[gprA_5, 0x0], gpr_wrboth
1f28:	 .997  immed[gprB_21, 0x1f8]
1f30:	 .998  alu[gprA_20, gprA_0, +, gprB_21]
1f38:	 .999  alu[gprB_20, gprA_1, +carry, 0x0]
1f40:	.1000  immed[gprA_21, 0x890]
1f48:	.1001  ld_field[gprA_21, 1100, gprB_4, <<16]
1f50:	.1002  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1f58:	.1003  immed[gprB_21, 0x1fc]
1f60:	.1004  alu[gprA_20, gprA_0, +, gprB_21]
1f68:	.1005  alu[gprB_20, gprA_1, +carry, 0x0]
1f70:	.1006  immed[gprA_21, 0x890]
1f78:	.1007  ld_field[gprA_21, 1100, gprB_2, <<16]
1f80:	.1008  mem[add_imm, $xfer_0, gprB_20, <<8, gprA_20, 1], indirect_ref
1f88:	.1009  immed[gprA_2, 0x2], gpr_wrboth
1f90:	.1010  immed[gprA_3, 0x0], gpr_wrboth
1f98:	.1011  alu[gprA_0, --, B, gprB_2], gpr_wrboth
1fa0:	.1012  alu[gprA_1, --, B, gprB_3], gpr_wrboth
1fa8:	.1013  br[.15000]
1fb0:	.1014  br[.15000], defer[2]
1fb8:	.1015  alu[gprA_0, --, B, 0x0]
1fc0:	.1016  ld_field[gprA_0, 1100, 0x82, <<16]
1fc8:	.1017  alu[--, 0x3, -, gprB_0]
1fd0:	.1018  bcc[.1014]
1fd8:	.1019  immed[gprB_2, 0x2282]
1fe0:	.1020  immed_w1[gprB_2, 0x4411]
1fe8:	.1021  alu_shf[gprA_1, --, B, gprB_0, <<3]
1ff0:	.1022  alu[--, gprA_1, OR, 0x0]
1ff8:	.1023  alu_shf[gprB_2, 0xff, AND, gprB_2, >>indirect]
2000:	.1024  br[.15000], defer[2]
2008:	.1025  alu[gprA_0, --, B, 0x0]
2010:	.1026  ld_field[gprA_0, 1100, gprB_2, <<16]
2018:	.1027  nop
2020:	.1028  nop
2028:	.1029  nop
2030:	.1030  nop
2038:	.1031  nop
2040:	.1032  nop
2048:	.1033  nop
2050:	.1034  nop
