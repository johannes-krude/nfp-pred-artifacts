#!/bin/bash

set -e

heading() {
	echo ""
	echo "####################"
	echo $1
	echo "####################"
	echo ""
}


heading "Compiling accelerator"

p4_build.sh -p scripts/accelerator.p4


heading "Killing old bf_switchd"

while ps ax | egrep "[b]f_switchd"; do
	killall bf_switchd
	sleep 0.1
done


heading "Starting bf_switchd"

$SDE/run_switchd.sh -p accelerator &
while ! netstat -tl | fgrep -q "*:9999"; do
	sleep 0.1
done


heading "Setting up ports"

run_pd_rpc.py scripts/accelerator_setup.py

heading "Starting controller"

unbuffer $SDE/run_bfshell.sh -p 9999 -b $PWD/scripts/accelerator_control.py&

