#!/usr/bin/ruby

require "trollop"
require "pathname"

opts = Trollop::options do
	banner "usage: #{$0}"
	opt :serial, "nic serial", type: String
	opt :iface, "interface", default: "eth1"
	opt :num_ifaces, "how many consecutive interfaces", default: 2
	opt :pci, "pci address", type: String
end

iface = opts[:iface]
ifaces = (opts[:num_ifaces]-1).times.inject([iface]) { |a,i| a + [a.last.succ] }
serial = opts[:serial] || (
	addr = `ethtool -P #{iface}`.split(": ", 2)[1]
	s = addr.gsub(":", "").to_i(16)-1
	("%012x" % s).scan(/../).join("-")
)
pci = opts[:pci] || (
	`ethtool -i #{iface}|fgrep "bus-info: "`.chomp.split(": ", 2).last
)

target = "/lib/firmware/netronome/serial-#{serial}-10-ff.nffw"

target = Pathname.new(target)

ifaces.each do |i|
	system("ip", "link", "set", "down", i)
end
target.unlink if target.symlink?
#system("rmmod nfp")
#system("modprobe nfp")
File.write("/sys/bus/pci/devices/#{pci}/remove", 1)
File.write("/sys/bus/pci/rescan", 1)
