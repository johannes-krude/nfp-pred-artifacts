#!./scripts/perform-remote.rb

usage :prog, :dst, :wpi, :rate, repeat: 30, count: 200, wait: 0.1
prog = args[:prog]
dst = args[:dst]
count = args[:count].to_i
wait = args[:wait].to_f
wpi = args[:wpi].to_i
rate = args[:rate].to_i
rx, bf, tx = connections(3)
repeat = args[:repeat].to_i

date
gitstatus
rx.system "uname -srv"

local.system "make", "out/xdp-#{prog}.bpf.o"

rx.sudo "./build/bpf -c eth1 eth2"

begin

	tx.sudo "modprobe pktgen"
	rx.sudo "./scripts/load-nfp-firmware.rb", "-v", "wpi#{wpi}"
	rx.system("./scripts/show-nfp-firmware.rb")
	rx.sudo "./build/bpf -cXoe eth1 eth2", in: ["out/xdp-#{prog}.bpf.o"]
	gen = nil

	repeat.times do |i|
		log
		log "Measuring repetition #{i}"

		gen.stop if gen
		bf.sudo "./scripts/accelerator.sh", quiet: true
		sleep 2
		bf.sudo "./scripts/swappctl.rb set 144 rate #{rate/2}"
		bf.sudo "./scripts/swappctl.rb set 152 rate #{rate/2}"
		rx.sudo "/opt/netronome/bin/nfp -m mac -e set port txflush 0 0 enable"
		rx.sudo "/opt/netronome/bin/nfp -m mac -e set port txflush 0 4 enable"
		gen = tx.spawn_sudo "./scripts/pktgen", "-i", "eth1,eth2", "--dst-macs", dst, "--threads", "2", "--ratep", "2"

		rx.sudo "./build/bwmeasure -q -t nfp-bpf -s 0 -w #{wait} -c #{count} eth1 eth2", out:
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
