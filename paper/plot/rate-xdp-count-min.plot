set terminal pdfcairo size 8.47415cm,3.6cm enhanced color fontscale 0.75 font 'Linux Libertine,9pt'

set xlabel "Count-Min Program Variant [# hash functions]" enhanced
set ylabel "Packet Rate [pkt/s]" enhanced
set xrange[0:20.4]
set yrange[0:65000000]

set ytics 10000000
set xtics 1
set mxtics 1
set mytics 2

set key samplen 0  bottom left at 0.25,65000000 nobox
#set rmargin 30
set tmargin 2.6

set label "NIC MAC Limit" at 20,54400000 font 'Linux Libertine,9pt' right offset 0,-0.3

plot \
54400000 with lines ls 92 notitle, \
'< ls plot/rate-xdp-count-min.*.i.dat | sort -t . -k 2 -n | xargs -n 1 fgrep 4f50d2bf86593c0f' using ($0+1):2 with linespoints ls 23 dt 1 title "Estimated Processing Cores Limit", \
'< ls plot/rate-xdp-count-min.*.i.dat | sort -t . -k 2 -n | xargs -n 1 fgrep 4f50d2bf86593c0f' using ($0+1):3 with linespoints ls 24 dt 1  title "Estimated DRAM Limit", \
'< ls plot/rate-xdp-count-min.*.i.dat | sort -t . -k 2 -n | xargs -n 1 fgrep 4f50d2bf86593c0f' using ($0+1):4:5:6 with errorbars ls 90 lc rgb '#cc071e' title "Measured Throughput (99% Confidence Intervals)"

#'< ls plot/rate-xdp-count-min.*.i.dat | sort -t . -k 2 -n | xargs -n 1 fgrep 4f50d2bf86593c0f' using ($0+1):4 with linespoints ls 24 title "Measured Throughput", \
