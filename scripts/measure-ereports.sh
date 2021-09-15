#!/bin/bash

RX=${1}
BF=${2}
TX=${3}
LOGDIR="${LOGDIR:-"data/measured-throughput/"}"

if [ -z "$RX" ] || [ -z "$BF" ] || [ -z "$TX" ]; then
	echo "usage: <rx> <bf> <tx> [logdir]" >&2
	exit -1
fi

set -x
set -e

function measure {
	./tasks/measure-$1.rb -c "$RX" -c "$BF" -c "$TX" -l "$LOGDIR" $2 $3 $4 $5 $6 $7 $8 $9
}


# loading the firmware may cause the kernel to crash
./tasks/load-nfp-firmware.rb -c "$RX" wpi1

measure xdp-ereport xdp-quic-lb.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-cloudflare.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-alaw2ulaw-opt.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-quic-lb-ipv6-options.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-alaw2ulaw.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-switch.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b


# loading the firmware may cause the kernel to crash
./tasks/load-nfp-firmware.rb -c "$RX" wpi10

measure xdp-ereport-slow 1333 xdp-dns-cache.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b

measure xdp-ereport xdp-count-min.1.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.2.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.3.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.4.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.5.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.6.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.7.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.8.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.9.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.10.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.11.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.12.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.13.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.14.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.15.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.16.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.17.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.18.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.19.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport xdp-count-min.20.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b
measure xdp-ereport-workaround xdp-count-min.1.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4f50d2bf86593c0f 54400000
measure xdp-ereport-workaround xdp-count-min.2.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4f50d2bf86593c0f 54400000
measure xdp-ereport-workaround xdp-count-min.3.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4f50d2bf86593c0f 54000000
measure xdp-ereport-workaround xdp-count-min.4.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4f50d2bf86593c0f 50100000
measure xdp-ereport-workaround xdp-count-min.5.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4f50d2bf86593c0f 46200000
measure xdp-ereport-workaround xdp-count-min.6.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4f50d2bf86593c0f 41500000
measure xdp-ereport-workaround xdp-count-min.7.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4f50d2bf86593c0f 35500000
measure xdp-ereport-workaround xdp-count-min.8.k 00:15:4d:13:12:9a,00:15:4d:13:12:9b 4f50d2bf86593c0f 31100000

