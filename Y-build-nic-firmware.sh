#!/bin/bash

NIC_FW=build/nic-firmware

set -x
set -e

function firmware {
	(
		cd $NIC_FW
		sed "s/WORKERS_PER_ISLAND=[0-9]\+/WORKERS_PER_ISLAND=$2/" firmware/apps/nic/Makefile -i
		make bpf/nic_$1.nffw
		git checkout firmware/apps/nic/Makefile
	)
	cp $NIC_FW/firmware/nffw/bpf/nic_$1.nffw nfp-firmware/nic_$1-wpi$2.nffw
}

make $NIC_FW

for wpi in {1..10}; do

firmware AMDA0096-0001_2x10 $wpi
firmware AMDA0099-0001_2x10 $wpi
firmware AMDA0099-0001_2x25 $wpi
firmware AMDA0097-0001_2x40 $wpi

done

