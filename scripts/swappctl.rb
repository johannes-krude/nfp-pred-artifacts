#!/usr/bin/ruby

require "socket"

UNIXSocket.open("/run/swappctl.sock") do |fd|
	fd.write(
		if ARGV.empty?
			STDIN.read
		else
			ARGV.join(" ")
		end.gsub(/([ \n])[ \n]+/, "\\1").strip
	)
	fd.close_write
	r = fd.read
	unless r.empty?
		puts r
		exit -1
	end
end

