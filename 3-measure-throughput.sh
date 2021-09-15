#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "usage: $0 <programs-dir> <predictions-dir> <user@host-rx:nfp-pred-artifacts> <user@switch:nfp-pred-artifacts> <user@host-tx:nfp-pred-artifacts>"
    exit -1
fi

set -e

# prepeare output dir
mkdir -p data-repeated/measured-throughput

# output dir as seen by the called scripts
export LOGDIR=data-tmp/measured-throughput

mkdir -p data-tmp
rm -f data-tmp/programs
rm -f data-tmp/predictions
rm -f $LOGDIR
-ln -srf "$1" data-tmp/programs
-ln -srf "$2" data-tmp/predictions
-ln -srf data-repeated/measured-throughput $LOGDIR

set -x

./scripts/measure-ereports.sh "$3" "$4" "$5"

