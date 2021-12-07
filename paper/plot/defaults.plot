set terminal pdfcairo size 8.47415cm,3.5cm enhanced color fontscale 0.75 font 'Linux Libertine,9pt'
set encoding utf8
set pointintervalbox 1.6
set style line 97 lc rgb '#aaaaaa' lt 1 dt 3
set style line 98 lc rgb '#000000' lt 1
set border 15 ls 98
set tics nomirror
set style line 99 lc rgb '#000000' lt 0 lw 1


set style line 1 lc rgb '#d7b5d8' pt 1  ps 0.5
set style line 2 lc rgb '#78c679' pt 2  ps 0.5
set style line 3 lc rgb '#2c7fb8' pt 12 ps 0.5

#set style line 10 lc rgb '#000000' pt 12 lw 1.5
#set style line 11 lc rgb '#000000' pt 12 lw 1

# neutral black color
set style line 90 lc rgb '#000000' pt 0 lw 1.5
# neutral white color
set style line 91 lc rgb '#ffffff' pt 0 lw 1.5
# neutral gray color
set style line 92 lc rgb '#808080' pt 0 lw 0.5

# stacked bar plot with up to 2 bars
set style line 12 lc rgb '#00549f' ps 0.5
set style line 11 lc rgb '#57ab27' ps 0.5

# linespoints with up to 5 colors
set style line 21 lc rgb '#e30066' pt  4 dt 1 ps 0.8
set style line 22 lc rgb '#006165' pt  8 dt 2 ps 0.8
set style line 23 lc rgb '#57ab27' pt 10 dt 4 ps 0.8
set style line 24 lc rgb '#f6a800' pt  6 dt 5 ps 0.8
set style line 25 lc rgb '#ffed00' pt  2 dt 3 ps 0.8
set style line 26 lc rgb '#7a6fac' pt 12 dt 3 ps 0.8
set style line 27 lc rgb '#612158' pt  2 dt 4 ps 0.8


set grid ytics back ls 97
set grid xtics back ls 97

set tmargin 0.2
set rmargin 0
set lmargin 8.6
set bmargin 2.25

set key samplen 5 box opaque width 0 height 0.3 spacing 0.9 reverse Left font 'Linux Libertine,9pt'
set nokey

set xlabel offset 0,0.75
set xtics offset 0,0.25

set format x "%3.0s %c"
set format y "%3.0s %c"

set title offset 0,-1
#set notitle
