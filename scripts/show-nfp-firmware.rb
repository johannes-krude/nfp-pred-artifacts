#!/usr/bin/ruby

require "trollop"

opts = Trollop::options do
	banner "usage: #{$0}"
	opt :iface, "interface", default: "eth1"
end

iface = opts[:iface]
puts `ethtool -i #{iface} | fgrep firmware-version`.split(": ", 2)[1]
