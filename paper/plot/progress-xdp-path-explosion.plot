set terminal pdfcairo size 4.237075cm,2.5cm enhanced color fontscale 0.75 font 'Linux Libertine,9pt'

x2 = system('tail -n 1 plot/progress-xdp-path-explosion.k.dat | cut -d " " -f 1')
bm  = 0.375
gap = 0.05

set ylabel "Guarantee [Bit/s]         " enhanced offset -0.5,0
set format y "%0.0f G"
#set yrange [5.5:9.5]
set yrange [0:1.5]
set ytics 1
set mytics 10
set xrange [0:x2]
set xlabel "Analysis Time [s]" enhanced
set xtics 1200
set format x "%0.0f"

set lmargin 9.1
set rmargin 1
set bmargin 2.3

set key top left samplen 1 width -3
set nokey

plot \
'plot/progress-xdp-path-explosion.k.dat' using 1:($2/1000000000) axis x1y1 with steps ls 21 notitle

set mytics 1
set xlabel " " enhanced
set ylabel " " enhanced
set format x " "
set format y " "

plot \
'plot/progress-xdp-path-explosion.k.dat' using 1:($2/1000000000) axis x1y1 with steps ls 21 notitle
