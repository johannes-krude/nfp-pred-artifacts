#!/bin/bash

RX=${1}
BF=${2}
TX=${3}

if [ -z "$RX" ] || [ -z "$BF" ] || [ -z "$TX" ]; then
	echo "usage: <rx> <bf> <tx>" >&2
	exit -1
fi

LOGDIR="data/"

set -x
set -e

function measure {
	./tasks/measure-$1.rb -c "$RX" -c "$BF" -c "$TX" -l "$LOGDIR" $2 $3 $4 $5 $6 $7 $8 $9
}


# The kernel sometimes crashes on firmware loading, so don't expect any of
# these to run through in a single run


# The drop/slow measurements were performed with a mostly unmodified firmware
# variant, with all our modifications the throughput numbers are higher
measure xdp-wpi drop 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-wpi-workaround drop 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4 38600000
measure xdp-wpi-workaround drop 00:15:4d:13:12:9a,00:15:4d:13:12:9b 5 48300000
measure xdp-wpi-workaround drop 00:15:4d:13:12:9a,00:15:4d:13:12:9b 6
measure xdp-wpi slow 00:15:4d:13:12:9a,00:15:4d:13:12:9b


measure xdp-wpi lookup4 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-wpi-workaround lookup4 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4 46500000
measure xdp-wpi-workaround lookup4 00:15:4d:13:12:9a,00:15:4d:13:12:9b 5 51000000
measure xdp-wpi-workaround lookup4 00:15:4d:13:12:9a,00:15:4d:13:12:9b 6 51000000
measure xdp-wpi-workaround lookup4 00:15:4d:13:12:9a,00:15:4d:13:12:9b 7 49400000
measure xdp-wpi-workaround lookup4 00:15:4d:13:12:9a,00:15:4d:13:12:9b 8 51000000
measure xdp-wpi-workaround lookup4 00:15:4d:13:12:9a,00:15:4d:13:12:9b 9 51000000
measure xdp-wpi-workaround lookup4 00:15:4d:13:12:9a,00:15:4d:13:12:9b 10 51000000
measure xdp-wpi lookup8 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-wpi lookup12 00:15:4d:13:12:9a,00:15:4d:13:12:9b

#./tasks/nfp-load-firmware.rb -c inp5:nf-tools wpi10
measure xdp-wpi-series inc 00:15:4d:13:12:9a,00:15:4d:13:12:9b 9 20
