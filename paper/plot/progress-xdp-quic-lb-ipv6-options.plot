set terminal pdfcairo size 4.237075cm,2.5cm enhanced color fontscale 0.75 font 'Linux Libertine,9pt'

x2 = system('egrep -v " 0$" plot/progress-xdp-quic-lb-ipv6-options.k.dat -m 1 | cut -d " " -f 1')
x2 = ceil(x2/10)*10
bm  = 0.375
gap = 0.05

set ylabel "Guarantee [Bit/s]         " enhanced offset -0.5,0
set format y "%0.0f G"
#set yrange [20.5:28]
set yrange [0:29]
set ytics 5
set mytics 5
set xlabel "Analysis Time [s]" enhanced
set xrange [0:x2]
set xtics 10

set lmargin 8.1
set rmargin 2
set bmargin 2.3

set key top left samplen 1 width -3
set nokey

#set multiplot
#unset xlabel
#set bmargin at screen bm+gap
#set border 2+4+8
#set format x ""
#set xtics scale 0

plot \
'< egrep " 0$" plot/progress-xdp-quic-lb-ipv6-options.k.dat; egrep -v " 0$" plot/progress-xdp-quic-lb-ipv6-options.k.dat -m 1' using 1:($2/1000000000) axis x1y1 with steps ls 21 notitle, \
'< egrep -v " 0$" plot/progress-xdp-quic-lb-ipv6-options.k.dat -m 1' using 1:($2/1000000000) axis x1y1 with points ls 21 pt 7 pointsize 0.25 notitle

#set bmargin 2.3
#set xlabel "Analysis Time [s]" enhanced
#set xlabel offset 0,0.75
#
#
#set tmargin at screen bm
#set yrange [0:0.09]
#unset ylabel
#set format x "%0.0f"
#set xtics scale default
#set border 1+2+8
#
#set arrow from first x2/-20, screen bm+gap/2 to first x2/20, screen bm+gap+gap/2 ls 90 nohead
#set arrow from first x2+x2/-20, screen bm+gap/2 to first x2+x2/20, screen bm+gap+gap/2 ls 90 nohead
#set arrow from first x2/-20, screen bm-gap/2 to first x2/20, screen bm+gap/2 ls 90 nohead
#set arrow from first x2+x2/-20, screen bm-gap/2 to first x2+x2/20, screen bm+gap/2 ls 90 nohead
#
#plot \
#'plot/progress-xdp-quic-lb-ipv6-options.k.dat' using 1:($2/1000000000) axis x1y1 with steps ls 21 notitle
#
#unset multiplot
