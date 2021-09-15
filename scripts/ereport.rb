#!/usr/bin/ruby

require "digest"

require "trollop"
opts = Trollop::options do
	banner "usage: #{$0} <mode>"
	opt :mode, "output ereport mode"
	opt :is_bitrate, "whether mode is a bitrate mode"
	opt :workers, "output ereport number of bpf-workers"
	opt :input, "output one path input per line"
	opt :packets, "output one packet per line"
	opt :map, "output one map assignment per line"
	opt :cycles, "output proc cycles"
	opt :dram_cycles, "output DRAM cycles"
	opt :check_monotonicity, "check whether cycles are monotonously decreasing"
	opt :overestimation, "output overestimation"
	opt :progress, "analyze estimation progress"
	opt :numbers, "analyze estimation"
	opt :filter_short, "ignore paths shorter than the given number of cycles", type: Integer, default: nil
end

input = if ARGV.size > 0
	file = File.open(ARGV[0])
	file_magic = file.read(3)
	file.seek(0)
	if file_magic == "BZh"
		r, w = IO.pipe
		Process.spawn("pbzip2", "-d", 0 => file, 1 => w)
		w.close
		r
	else
		file
	end
else
	STDIN
end

$mode = (opts.to_a.select(&:last).map(&:first) + [:ids]).first
$mode_opt = opts[$mode]
$filter_short = opts[:filter_short]

class Ereport
	def initialize
		reset
	end

	attr_reader :mode
	attr_reader :workers
	attr_reader :name
	attr_reader :num
	attr_reader :time
	attr_reader :cfg_cputime
	attr_reader :cfg_threads_cputime
	attr_reader :z3_cputime
	attr_reader :cycles
	attr_reader :dram_cycles
	attr_reader :maxcycles
	attr_reader :cycleratio
	attr_reader :maxcycleratio
	attr_reader :size

	def reset
		@name = nil
		@num = nil
		@time = nil
		@cfg_cputime = nil
		@cfg_threads_cputime = nil
		@z3_cputime = nil
		@size = 0
		@size_max_cycles = nil
		@size_dram_cycles = nil
		@bytes = nil
		@map = nil
		@cycles = nil
		@maxcycles = nil
		@dram_cycles = nil
	end
	
	def parse(l)
		case l
		when /\Amode:/
			@mode ||= $'.strip
		when /\Abpf-workers:/
			@workers ||= $'.to_i
		when /\A#### /
			@name = $'.strip
		when /(-?[0-9]+): ([0-9]+.[0-9]+) s/
			@num = $1.to_i
			@time = $2.to_f
		when /\Acfg\.cputime:/
			@cfg_cputime = $'.to_f
		when /\Acfg\.threads\.cputime:/
			@cfg_threads_cputime = $'.to_f
		when /\Az3\.cputime:/
			@z3_cputime = $'.to_f
		when /\Acycles:/
			@cycles = $'.to_i
		when /\Amax cycles:/
			@maxcycles = $'.to_i
		when /\ADRAM cycles:/
			@dram_cycles = $'.to_f
		when /\Amin packet size:/
			@size = $'.to_i
		when /\Amin packet size\(max cycles\):/
			@size_max_cycles = $'.to_i
		when /\Amin packet size\(DRAM cycles\):/
			@size_dram_cycles = $'.to_i
		when /\A\|0x([0-9a-fA-F]+)\|/
			@bytes ||= {}
			l = $'
			addr = $1.to_i(16)
			while l=~ / (..) \|/
				l = $'
				b = $1
				if b =~ /[0-9a-fA-F]{2}/
					@bytes[addr] = b.to_i(16)
				end
				addr += 1
				@size= [@size, addr].max
			end
		when /\Amap\[0x([0-9a-fA-F]+)\]=/
			@map ||= {}
			l = $'
			offset = $1.to_i(16)
			while l=~ /([ ;]..)/
				l = $'
				b = $1
				if b == "; [" && l =~ /0x([0-9a-fA-F]+)\]=/
					offset = $1.to_i(16)
					l = $'
					next
				end
				break unless b[0] == " "
				@map[offset] = b[1..2].to_i(16)
				offset += 1
			end
		end
	end

	def bitrate?
		return !!(@mode =~ /bitrate/) ||
		       !!(@mode =~ /(\A| )minimal (.* )?throughput\z/)
	end

	def interleaved?
		return !!(@mode =~ /\A(packet|bit)rate/) ||
		       !!(@mode =~ /\Ainterleaved /)
	end

	def proc?
		return !!(@mode =~ /\Aproc /) ||
		       !!(@mode =~ /\A(longest path|minimal throughput)\z/)
	end

	def dram?
		return !!(@mode =~ /\ADRAM /) ||
		       !!(@mode =~ / dram /)
	end

	def size_max_cycles
		@size_max_cycles || @size
	end

	def size_dram_cycles
		@size_dram_cycles || @size
	end

	def packet
		return nil unless @bytes
		"|0x0000|" + @size.times.map do |i|
			if @bytes[i]
				" %02x |" % @bytes[i]
			else
				" -- |"
			end
		end.join
	end

	def packet?
		!!@bytes
	end

	def map
		return nil unless @map
		"map"+@map.to_a.sort.inject([]) do |m, (o,v)|
			if m.last && m.last.first+m.last.last.size == o
				m[0..-2] + [[m[-1][0], m[-1][1] + [v]]]
			else
				m + [[o,[v]]]
			end
		end.map do |o, vs|
			"[0x%08x]=" % o +
			vs.map do |v|
				" %02x" % v
			end.join
		end.join("; ")
	end

	def map?
		!!@map
	end

	def id
		Digest::SHA256.hexdigest((packet||"")+(map||""))[0..15]
	end

	def filtered?
		$filter_short && (
			(cycles && cycles <= $filter_short) ||
			(dram_cycles && dram_cycles*workers <= $filter_short)
		)
	end

end

def output(e,ends=false)
	return if e.filtered?
	case $mode
	when :mode
		return unless e.mode
		puts e.mode
		exit
	when :is_bitrate
		puts e.bitrate?.to_s
		exit
	when :workers
		return unless e.workers
		puts e.workers
		exit
	when :ids
		puts e.id if e.packet?
	when :cycles
		puts "#{e.id} #{e.cycles} #{e.size}" if e.cycles
	when :dram_cycles
		puts "#{e.id} #{e.dram_cycles} #{e.size}" if e.dram_cycles && e.packet
	when :input
		puts "#{e.id} #{e.packet} #{e.map}" if e.packet?
	when :packets
		puts "#{e.id} #{e.packet}" if e.packet?
	when :map
		puts "#{e.id} #{e.map}" if e.packet? || e.map?
	when :check_monotonicity
		return unless e.time
		c = e.maxcycles
		w = e.cycles
		d = e.dram_cycles
		if e.bitrate?
			c /= 1.0*e.size_max_cycles if c
			w /= 1.0*e.size if w
			d /= 1.0*e.size_dram_cycles if d
			d = nil if d && d.nan?
		end
		x,y = case
		when e.proc?
			[c,w]
		when e.dram?
			[d*e.workers,w ? d*e.workers : nil]
		when e.interleaved?
			[[c,d*e.workers].max,w ? [w,d*e.workers].max : nil]
		else
			raise
		end
		if x and $max and x > $max
			puts "monotonicity-error #{e.name} #{x} > #{$max}"
		end
		if x and y and y > x
			puts "overestimation-error #{e.name} #{y} > #{x}"
		end
		$max = x
	when :overestimation
		puts "#{e.maxcycles - e.cycles}" if e.maxcycles and e.cycles
	when :progress
		$count ||= 0
		$y ||= []
		return unless e.time
		c = e.maxcycles
		w = e.cycles
		d = e.dram_cycles
		unless c or w or d
			puts "#{"%.6f" % e.time}\t#{$lastline}" if ends
			return
		end
		if e.bitrate?
			c /= 1.0*e.size_max_cycles if c
			w /= 1.0*e.size if w
			d /= 1.0*e.size_dram_cycles if d
			d = nil if d && d.nan?
		end
		x,y = case
		when e.proc?
			[c,w]
		when e.dram?
			[d*e.workers,w ? d*e.workers : nil]
		when e.interleaved?
			[[c,d*e.workers].max,w ? [w,d*e.workers].max : nil]
		else
			raise
		end
		$max = x if x
		$y << y if y
		if $max
			$count += $y.select { |c| c >= $max }.size
			$y.delete_if { |c| c >= $max }
		end
		line = "#{x}\t#{$count}\t#{$count+$y.size}"
		puts "#{"%.6f" % e.time}\t#{line}" if line != $lastline or ends
		$lastline = line
	when :numbers
		$early ||= false
		$first ||= false
		$maxnum ||= 0
		$maxtime ||= 0.0
		$unsatisfiable ||= 0

		if e.name =~ /\A\(([1-9][0-9]*)\)\z/
			$unsatisfiable += $1.to_i
		end

		c = e.maxcycles
		w = e.cycles
		d = e.dram_cycles
		if e.bitrate?
			c /= 1.0*e.size_max_cycles if c
			w /= 1.0*e.size if w
			d /= 1.0*e.size_dram_cycles if d
			d = nil if d && d.nan?
		end

		if e.num
			n = e.num
			n += 1  if e.cycles
			$maxnum = [$maxnum,n].max
		end
		if e.time
			$maxtime = [$maxtime,e.time].max
		end

		x,y = case
		when e.proc?
			[c,w]
		when e.dram?
			[d*e.workers,w ? d*e.workers : nil]
		when e.interleaved?
			[[c,d*e.workers].max, w ? [w,d*e.workers].max : nil]
		else
			raise
		end if c || d || w
		if !$early && x
			puts "early\t#{"%.6f" % e.time}\t#{x}\t#{$unsatisfiable}\t#{e.z3_cputime}\t#{e.cfg_cputime+e.cfg_threads_cputime}"
			$early = true
		end
		if !$first && y
			puts "first\t#{"%.6f" % e.time}\t#{y}\t#{$unsatisfiable}\t#{e.z3_cputime}\t#{e.cfg_cputime+e.cfg_threads_cputime}"
			$first = true
		end

		$max_cfg_cputime = e.cfg_cputime if e.cfg_cputime
		$max_cfg_threads_cputime = e.cfg_threads_cputime if e.cfg_threads_cputime
		$max_z3_cputime = e.z3_cputime if e.z3_cputime
		if ends
			puts "#{e.name == "N" ? "last" : "end"}\t#{"%.6f" % $maxtime}\t#{$maxnum}\t#{$unsatisfiable}\t#{$max_z3_cputime}\t#{$max_cfg_cputime+$max_cfg_threads_cputime}"
			return
		end
	end
end

e = Ereport.new

input.each do |l|
	if l =~ /\A####/
		output(e)
		e.reset
		e.parse(l)
	else
		e.parse(l)
	end
end
output(e, true)
