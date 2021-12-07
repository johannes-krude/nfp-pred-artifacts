set terminal pdfcairo size 8.47415cm,3.2cm enhanced color fontscale 0.75 font 'Linux Libertine,9pt'

set xlabel "NIC Processing Cores [#]" enhanced
set ylabel "Packet Rate [pkts/s]       " enhanced
set xrange[0:52]
set yrange[0:68000000]

#set ytics 5000000
set xtics 5
set mxtics 1
set mytics 5

set tmargin 0

set key samplen 1 top left at 1,67000000 width 1

da = system("cat plot/wpi-drop.lines | cut -d '+' -f 1")
db = system("cat plot/wpi-drop.lines | cut -d '*' -f 2")
sa = system("cat plot/wpi-slow.lines | cut -d '+' -f 1")
sb = system("cat plot/wpi-slow.lines | cut -d '*' -f 2")

plot \
da+x*db ls 24 dt 1 notitle, \
sa+x*sb ls 24 dt 1 notitle, \
'plot/wpi-drop.dat' using 1:2 with linespoints ls 21 dt 2 title "Fast Program", \
'plot/wpi-drop.dat' using 1:2:3:4 with errorbars ls 90 notitle, \
'plot/wpi-slow.dat' using 1:2 with linespoints ls 22 dt 2 title "Slow Program", \
'plot/wpi-slow.dat' using 1:2:3:4 with errorbars ls 90 notitle
