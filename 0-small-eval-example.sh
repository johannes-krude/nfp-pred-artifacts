#!/bin/bash

set -e
set -x

DIR="data-small-eval-example"
PROG="data-paper/programs/xdp-quic-lb.asm"

mkdir -p "$DIR/predictions"
ln -srf data-paper/measured-throughput data-small-eval-example/

# 20 runs of predicting the throughput of the QUIC LB (IPv4) example
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-1.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-2.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-3.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-4.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-5.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-6.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-7.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-8.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-9.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-10.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-11.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-12.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-13.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-14.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-15.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-16.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-17.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-18.ereport"
./build/nfp-estimator -k -w 5 -S -f "$PROG" -o "$DIR/predictions/xdp-quic-lb.k-19.ereport"

# Extract the resulting throughput bounds
./scripts/analyze-nfp-pred.rb --datadir="$DIR" --outdir=paper/plot paper/plot/rate-xdp-quic-lb.k.tex
# Analyze the prediction runtime
./scripts/analyze-nfp-pred.rb --datadir="$DIR" --outdir=paper/plot paper/plot/numbers-xdp-quic-lb.k.tex

# Update the plots
make paper-plots
# Update the paper
make paper
cp paper/paper-nfp-pred.pdf paper-small-eval-example.pdf

