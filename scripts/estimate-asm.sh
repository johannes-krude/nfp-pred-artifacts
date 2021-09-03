#!/bin/bash

PROGDIR="${PROGDIR:-"data/programs/"}"
EREPORTDIR="${EREPORTDIR:-"data/predictions/"}"

NUM=${1}
if [ -z "$NUM" ]; then
	NUM=20
fi
INDEX=${2}
if [ -z "$INDEX" ]; then
	INDEX=0
fi

function estimate {
	if [ "$INDEX" -ne "0" ]; then
		P="-$INDEX"
	fi
	echo ./build/nfp-estimator -S -T 3600 -$1 -f "$PROGDIR/$2.asm" -o "$EREPORTDIR/$2.$1$P.ereport" $3 $4 $5 $6 $7 $8 $9
	./build/nfp-estimator -S -T 3600 -$1 -f "$PROGDIR/$2.asm" -o "$EREPORTDIR/$2.$1$P.ereport" $3 $4 $5 $6 $7 $8 $9
	if [[ $? -eq 130 ]]; then
		exit 130
	fi
}

BASE=k
VARIANTS="i m q kL0 kFcheck-each-branch kFcheck-unlikely-edges kFno-impossible-prefixes kFno-impossible-path-merging kFno-keep-impossible-paths kFsat-strategy=incremental"

function example {
	estimate $BASE $1 $2 $3 $4 $5 $6
	for V in $VARIANTS; do
		estimate $V $1 -c 1 $2 $3 $4 $5 $6
	done
}

while [ "$INDEX" -lt "$NUM" ]; do

example xdp-quic-lb -w 5
example xdp-cloudflare -w 5
example xdp-switch -w 5
example xdp-quic-lb-ipv6-options -U 10 -w 5
example xdp-alaw2ulaw -U 160 -w 5
example xdp-alaw2ulaw-opt -U 160 -w 5
example xdp-dns-cache

for i in {1..20}; do
	example xdp-count-min.$i
done

if [ "$INDEX" -eq "0" ]; then
	estimate $BASE xdp-path-explosion
else
	estimate $BASE xdp-path-explosion -c 0
fi

INDEX=$(( $INDEX + 1 ))
done
