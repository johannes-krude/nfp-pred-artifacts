#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "usage: $0 <programs-dir>"
    exit -1
fi

export PROGDIR=$1
export EREPORTDIR=data-repeated/predictions

# prepeare output dir
mkdir -p "$EREPORTDIR"

# run predictions, arguments are: <number-of-runs> <start-with-run-number>
./scripts/estimate-asm.sh 20 0
