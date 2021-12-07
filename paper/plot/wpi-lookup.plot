set terminal pdfcairo size 8.47415cm,3.2cm enhanced color fontscale 0.75 font 'Linux Libertine,9pt'

set xlabel "NIC Processing Cores [#]" enhanced
set ylabel "Packet Rate [pkts/s]       " enhanced
set xrange[0:52]
set yrange[0:52000000]

#set ytics 5000000
set xtics 5
set mxtics 1
set mytics 5

set tmargin 0

#set key samplen 1 top left at 1,61000000 width -3
set key samplen 1 bottom right at 51,28500000 width 1 horizontal title "Reads per Packet"

plot \
'plot/wpi-lookup4.dat' using 1:2 with linespoints ls 21 dt 1 title "4", \
'plot/wpi-lookup4.dat' using 1:2:3:4 with errorbars ls 90 notitle, \
'plot/wpi-lookup8.dat' using 1:2 with linespoints ls 22 dt 1 title "8", \
'plot/wpi-lookup8.dat' using 1:2:3:4 with errorbars ls 90 notitle, \
'plot/wpi-lookup12.dat' using 1:2 with linespoints ls 23 dt 1 title "12", \
'plot/wpi-lookup12.dat' using 1:2:3:4 with errorbars ls 90 notitle,
