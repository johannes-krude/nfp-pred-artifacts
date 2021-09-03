#!./scripts/perform-remote.rb

usage :filter_short, :prog, :dst, count: 30, wait: 0.1
prog = args[:prog]
dst = args[:dst].split(",")
filter_short = args[:filter_short]
count = args[:count].to_i
wait = args[:wait].to_f
rx, bf, tx = connections (3)

ereport = [Pathname.new(prog), logdir+"#{prog}.ereport"].select(&:exist?).first
obj = [/\.ereport/, /\.[a-z]\.ereport/].map { |p| ereport.dirname + ereport.basename.to_s.sub(p, ".bpf.o") }.select(&:exist?).first
rx_obj = rx.upload([obj])

date
gitstatus
rx.system "uname -srv"
rx.system("./scripts/show-nfp-firmware.rb")

workers = local.system("./scripts/ereport.rb", "--workers", ereport.to_s, capture: true).to_i
rx.sudo "./build/bpf -c eth1 eth2"

begin

	bf.sudo "./scripts/accelerator.sh", quiet: true
	sleep 2

	(local.spawn "./scripts/ereport.rb", "--input", "--filter-short", filter_short, ereport.to_s).each do |l|
		id, packet = l.split(" ", 2)
		packet, map = packet.split(" map[", 2)
		map = "map[" + map if map
		log
		log "Measuring #{id}"

		begin
			gen = tx.spawn_sudo "./build/gen-packets", "-E", "eth1", *dst, in: packet
			bf.sudo "./scripts/swappctl.rb", "dst", dst[0],  "accelerate", "144"
			bf.sudo "./scripts/swappctl.rb", "dst", dst[-1], "accelerate", "152"
			status0 = rx.sudo "./build/check-rx -E -w 3 eth1", in: packet, nofail: true
			status1 = rx.sudo "./build/check-rx -E -w 3 eth2", in: packet, nofail: true
			if status0 == 1 or status1 == 1
				log "not receiving correct packets, skipping"
				next
			end
			rx.sudo "./build/bpf", "-cXoeEf", rx_obj, "eth1", "eth2", in: map
			rx.sudo "./build/bwmeasure -q -t nfp-bpf -w #{wait} -s #{(1.0/wait).ceil} -c #{count} eth1 eth2", out:
			(collect_data "#{id}") | (local.spawn "./build/statistics -i #{800000000*workers}")
		ensure
			gen.stop
			bf.sudo "./scripts/swappctl.rb", "dst", dst[0],  "forward", "144"
			bf.sudo "./scripts/swappctl.rb", "dst", dst[-1], "forward", "152"
			rx.sudo "./build/bpf -c eth1 eth2"
		end
	end
ensure
	bf.sudo "./scripts/bf-kill.sh"
end

log
date
