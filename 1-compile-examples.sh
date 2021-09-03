#!/bin/bash

set -e
set -x

# Build the P4 to XDP compiler
make build/p4c/build/p4c-xdp

# Prepeare the output directory
mkdir -p data-repeated/programs

# Compile the example programs
./scripts/xdp-asm.sh "" data-repeated/programs

