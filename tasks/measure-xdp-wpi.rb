#!./scripts/perform-remote.rb

usage :prog, :dst, count: 300, wait: 0.1, wpi: nil
prog = args[:prog]
dst = args[:dst]
count = args[:count].to_i
wait = args[:wait].to_f
wpi = args[:wpi]
rx, bf, tx = connections (3)

date
gitstatus
rx.system "uname -srv"

local.system "make", "out/xdp-#{prog}.bpf.o"

rx.sudo "./build/bpf -c eth1 eth2"

begin

	tx.sudo "modprobe pktgen"
	gen = nil
	bf.sudo "./scripts/accelerator.sh", quiet: true
	gen = tx.spawn_sudo "./scripts/pktgen", "-i", "eth1,eth2", "--dst-macs", dst, "--ratep", "1000"
	sleep 2
	rx.sudo("./build/check-rx -n eth1 -w 10")
	rx.sudo("./build/check-rx -n eth2 -w 10")

	if wpi
		[wpi.to_i]
	else
		1.upto(10).to_a
	end.each do |i|
		log
		log "Measuring #{i}"

		gen.stop if gen
		rx.sudo "./scripts/load-nfp-firmware.rb", "-v", "wpi#{i}"
		rx.system("./scripts/show-nfp-firmware.rb")
		rx.sudo("./build/check-rx -n eth1 -w 10")
		rx.sudo("./build/check-rx -n eth2 -w 10")

		rx.sudo "./build/bpf -cXoe eth1 eth2", in: ["out/xdp-#{prog}.bpf.o"]

		rx.sudo "./build/bwmeasure -q -t nfp-bpf -w #{wait} -s #{(1.0/wait).ceil} -c #{count} eth1 eth2", out:
		(collect_data "#{i}", log: true) | (local.spawn "./build/statistics")
	end
ensure
	gen.stop(nofail: true) if gen
	tx.sudo "modprobe -r pktgen"
	bf.sudo "./scripts/bf-kill.sh"
	rx.sudo "./scripts/clear-nfp-firmware.rb"
end

log
date
