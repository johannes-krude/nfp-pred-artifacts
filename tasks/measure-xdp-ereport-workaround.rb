#!./scripts/perform-remote.rb

usage :prog, :dst, :id, :rate, repeat: 30, count: 200, wait: 0.1
prog = args[:prog]
dst = args[:dst].split(",")
count = args[:count].to_i
wait = args[:wait].to_f
rx, bf, tx = connections (3)
id = args[:id]
rate = args[:rate].to_i
repeat = args[:repeat].to_i

ereport = [Pathname.new(prog), logdir / "../predictions/#{prog}.ereport"].select(&:exist?).first
obj = ["", "../programs"].map { |d| ereport.dirname / d / ereport.basename.to_s.sub(/\.[a-z]\.ereport/, ".bpf.o") }.select(&:exist?).first

date
gitstatus
rx.system "uname -srv"
rx.system("./scripts/show-nfp-firmware.rb")

packet = ((local.spawn "./scripts/ereport.rb", "--packets", ereport.to_s).map do |l|
	l.split(" ", 2)
end.select do |i, p|
	i == id
end.first||[]).last
die "no matching packet found" unless packet

gen = nil
begin
	rx.sudo "./build/bpf -cXoe eth1 eth2", in: [obj]

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
		gen = tx.spawn_sudo "./build/gen-packets", "-b", "1", "-w", "500", "-E", "eth1", *dst, in: packet+"\n"

		rx.sudo "./build/bwmeasure -q -t nfp-bpf -s 0 -w #{wait} -c #{count} eth1 eth2", out:
		(collect_data "#{i}", log: true) | (local.spawn "./build/statistics")
	end
ensure
	gen.stop if gen
	rx.sudo "./build/bpf -c eth1 eth2"
	bf.sudo "./scripts/bf-kill.sh"
end

log
date
