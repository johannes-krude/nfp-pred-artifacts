#!./scripts/perform-remote.rb

usage :prog, :dst, :min, :max, count: 300, wait: 0.1
prog = args[:prog]
dst = args[:dst]
min = args[:min]
max = args[:max]
count = args[:count].to_i
wait = args[:wait].to_f
rx, bf, tx = connections (3)

date
gitstatus
rx.system "uname -srv"

rx.sudo "./build/bpf -c eth1 eth2"
rx.system("./scripts/show-nfp-firmware.rb")

begin

	tx.sudo "modprobe pktgen"
	gen = nil
	bf.sudo "./scripts/accelerator.sh", quiet: true
	gen = tx.spawn_sudo "./scripts/pktgen", "-i", "eth1,eth2", "--dst-macs", dst, "--ratep", "1000"
	sleep 2
	rx.sudo("./build/check-rx -n eth1 -w 10")
	rx.sudo("./build/check-rx -n eth2 -w 10")

	(min..max).each do |i|
		log
		log "Measuring #{i}"

		local.system "make", "out/xdp-#{prog}.#{i}.bpf.o"
		rx.sudo "./build/bpf -cXoe eth1 eth2", in: ["out/xdp-#{prog}.#{i}.bpf.o"]

		rx.sudo "./build/bwmeasure -q -t nfp-bpf -w #{wait} -s #{(1.0/wait).ceil} -c #{count} eth1 eth2", out:
		(collect_data "#{i}", log: true) | (local.spawn "./build/statistics")
	end
ensure
	gen.stop(nofail: true) if gen
	tx.sudo "modprobe -r pktgen"
	bf.sudo "./scripts/bf-kill.sh"
end

log
date
