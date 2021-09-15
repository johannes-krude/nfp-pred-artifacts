#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "usage: $0 <predictions-dir> <measured-throughput-dir> <measurements-section4-dir>"
    exit -1
fi

set -e

mkdir -p data-tmp
rm -f data-tmp/predictions
rm -f data-tmp/measured-throughput
rm -f data-tmp/measurements-section4
ln -srf "$1" data-tmp/predictions
ln -srf "$2" data-tmp/measured-throughput
ln -srf "$3" data-tmp/measurements-section4

set -x

./scripts/analyze-nfp-pred.rb --outdir=paper/plot --datadir=data-tmp

make paper-plots
make paper
cp paper/paper-nfp-pred.pdf paper-repeated.pdf

