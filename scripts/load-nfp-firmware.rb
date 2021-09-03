#!/usr/bin/ruby

require "trollop"
require "pathname"

opts = Trollop::options do
	banner "usage: #{$0} [file]"
	opt :variant, "firmware variant", default: ""
	opt :serial, "nic serial", type: String
	opt :iface, "interface", default: "eth1"
	opt :num_ifaces, "how many consecutive interfaces", default: 2
	opt :pci, "pci address", type: String
	opt :board, "board.id", type: String
	opt :ports, "port configuration", type: String
end

iface = opts[:iface]
ifaces = (opts[:num_ifaces]-1).times.inject([iface]) { |a,i| a + [a.last.succ] }
serial = opts[:serial] || (
	addr = `ethtool -P #{iface}`.split(": ", 2)[1]
	s = addr.gsub(":", "").to_i(16)-1
	("%012x" % s).scan(/../).join("-")
)
target = "/lib/firmware/netronome/serial-#{serial}-10-ff.nffw"
pci = opts[:pci] || (
	`ethtool -i #{iface}|fgrep "bus-info: "`.chomp.split(": ", 2).last
)
board = opts[:board] || (
	`devlink dev info pci/#{pci} | fgrep board.id`.strip.split(" ", 2).last
)
ports = opts[:ports] || (
	case board
	when "AMDA0096-0001"
		"2x10"
	when "AMDA0099-0001"
		"2x25"
	when "AMDA0097-0001"
		"2x40"
	end
)
file = ARGV[0] || (
	variant = opts[:variant] ? "-#{opts[:variant]}" : ""
	"nfp-firmware/nic_#{board}_#{ports}#{variant}.nffw"
)

file = Pathname.new(file)
target = Pathname.new(target)
Trollop::die("no firmware #{file.inspect}") unless file.file?

ifaces.each do |i|
	system("ip", "link", "set", "down", i)
end
target.unlink if target.symlink?
puts "loading #{file}"
target.make_symlink(file.expand_path)
#system("rmmod nfp")
#system("modprobe nfp")
File.write("/sys/bus/pci/devices/#{pci}/remove", 1)
File.write("/sys/bus/pci/rescan", 1)
target.unlink
