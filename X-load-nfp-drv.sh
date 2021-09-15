#!/bin/sh

set -e
set -x

# Build the Kernel module
make build/nfp-drv-kmods/src/nfp.ko

# Remove the currently loaded module
sudo rmmod nfp || true

# Load our module
sudo modprobe tls
sudo insmod build/nfp-drv-kmods/src/nfp.ko nfp_dev_cpp

