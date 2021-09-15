#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "usage: $0 <user@host-rx:nfp-pred-artifacts> <user@switch:nfp-pred-artifacts> <user@host-tx:nfp-pred-artifacts>"
    exit -1
fi

export LOGDIR=data-repeated/measurements-section4/

set -e

# prepeare output dir
mkdir -p $LOGDIR

set -x

./scripts/measure-wpi.sh "$1" "$2" "$3"

