#!/usr/bin/ruby

require "pathname"

build = Pathname.new("nfp-firmware-build")
if build.exist?
	system("cd #{build}; git pull")
else
	system("git clone git@laboratory.comsys.rwth-aachen.de:smartnic-measurements/nic-firmware.git #{build}")
end

out = Pathname.new("nfp-firmware")
system("mkdir -p #{out}")

1.upto(10) do |i|
	system("cd #{build}; git checkout firmware/apps/nic/Makefile")
	system("sed \"s/WORKERS_PER_ISLAND=[0-9]\\+/WORKERS_PER_ISLAND=#{i}/\" #{build}/firmware/apps/nic/Makefile -i")
	system("cd #{build}; make bpf/nic_AMDA0096-0001_2x10.nffw")
	system("cd #{build}; make bpf/nic_AMDA0099-0001_2x10.nffw")
	system("cd #{build}; make bpf/nic_AMDA0099-0001_2x25.nffw")
	system("cd #{build}; make bpf/nic_AMDA0097-0001_2x40.nffw")
	system("cp #{build}/firmware/nffw/bpf/nic_AMDA0096-0001_2x10.nffw #{out}/nic_AMDA0096-0001_2x10-wpi#{i}.nffw")
	system("cp #{build}/firmware/nffw/bpf/nic_AMDA0099-0001_2x10.nffw #{out}/nic_AMDA0099-0001_2x10-wpi#{i}.nffw")
	system("cp #{build}/firmware/nffw/bpf/nic_AMDA0099-0001_2x25.nffw #{out}/nic_AMDA0099-0001_2x25-wpi#{i}.nffw")
	system("cp #{build}/firmware/nffw/bpf/nic_AMDA0097-0001_2x40.nffw #{out}/nic_AMDA0097-0001_2x40-wpi#{i}.nffw")
end
