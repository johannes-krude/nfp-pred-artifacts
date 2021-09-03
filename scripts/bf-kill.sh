#!/bin/bash

set -e

while ps ax | egrep -q "[b]f_switchd"; do
	killall bf_switchd
	sleep 0.1
done

