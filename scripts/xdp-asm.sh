#!/bin/bash

HOST_RX="$1"
DATADIR="$2"
if [ -z "$DATADIR" ]; then
	DATADIR=data/programs
fi
OUTDIR="./out"

set -e
set -x

function asm {
	BPFO="$OUTDIR/$1.bpf.o"
	make "$BPFO"
	./tasks/xdp-asm.rb -c "$HOST_RX" "$BPFO"
	cp "$OUTDIR/$1.bpf.o" "$DATADIR/"
	cp "$OUTDIR/$1.asm" "$DATADIR/"
}

asm xdp-quic-lb
asm xdp-cloudflare
asm xdp-switch
asm xdp-quic-lb-ipv6-options
asm xdp-alaw2ulaw
asm xdp-alaw2ulaw-opt
asm xdp-dns-cache

asm xdp-count-min.1
asm xdp-count-min.2
asm xdp-count-min.3
asm xdp-count-min.4
asm xdp-count-min.5
asm xdp-count-min.6
asm xdp-count-min.7
asm xdp-count-min.8
asm xdp-count-min.9
asm xdp-count-min.10
asm xdp-count-min.11
asm xdp-count-min.12
asm xdp-count-min.13
asm xdp-count-min.14
asm xdp-count-min.15
asm xdp-count-min.16
asm xdp-count-min.17
asm xdp-count-min.18
asm xdp-count-min.19
asm xdp-count-min.20

asm xdp-path-explosion
