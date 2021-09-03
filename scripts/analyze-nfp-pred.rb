#!/usr/bin/ruby -e require "pathname"; exec((Pathname.new(ARGV[0]).dirname/"analyze-data.rb").to_s, *ARGV)

rule :list_dat_tar, // do
	popen(basefile("build/read"), "-ljf", datafile("#{name}.dat.tar")).split("\n").map do |l|
		l[Pathname.new(name).basename.to_s.size+1..-1]
	end
end

rule :dat_tar, // do
	popen(basefile("build/read"), "-jf", datafile("#{name}.dat.tar"), "-a").split("\n").map do |l|
		l.split(" ").map(&:to_f)
	end
end

rule :dat_tar, // do |extract|
	extract = "#{Pathname.new(name).basename.sub(/\.dat\.tar\z/, "")}-#{extract}"
	popen(basefile("build/read"), "-jf", datafile("#{name}.dat.tar"), "-x", extract).split("\n").map do |l|
		l.split(" ").map(&:to_f)
	end
end

rule :dat_tar_filter_min, // do |min|
	(rule :dat_tar).select do |f|
		f.first >= min
	end
end

rule :gnuplot_out, // do
	(rule :gnuplot_data).map do |d|
		d.flatten.map do |n|
			case n
			when nil
				"     NaN"
			when String
				"%8s" % n
			when Float
				"%8f" % n
			when Integer
				"%8i" % n
			end
		end.join(" ")+"\n"
	end.join
end

rule :tex_units, // do
	result = []

	texname = name.gsub(/[-_%.=]/, ".")
	(rule :units).each do |u, dat|
		unit, h = u
		h ||= {}
		dat.to_a.product((
			h[:post] || {"":1}
		).to_a,(
			h[:precision] || 10.times
		).to_a).each do |(n,d) , (p,m), i|
			value = case d
			when String
				d
			when Integer
				("%.#{i}f" % (d.to_f/m)).gsub(/\B(?=(\d\d\d)+#{i == 0 ? "\\z" : "\\."})/, "\\,")
			when Float
				("%.#{i}f" % (d/m)).gsub(/\B(?=(\d\d\d)+#{i == 0 ? "\\z" : "\\."})/, "\\,")
			when Array
				d.map { |x| "%.#{i}f" % (x/m) }.join("]{}& -- &\\unit[")
			when true
				texvalue = "\\checkmark"
			else
				raise NotImplementedError
			end
			if h[:sign] && Numeric === d && !d.negative?
				value = "+#{value}"
			end
			texvalue ||= "#{h[:pre]||""}#{value}#{p.to_s.gsub("%", "\\%")}"
			texvalue = "\\unit[#{texvalue}]{#{unit}}" unless unit.empty?
			result << "\\expandafter\\def\\csname #{texname}X#{n.to_s.gsub(/[-_%.]/, ".")}X#{p.to_s.gsub(/[-_%.]/, ".")}#{i}\\endcsname{#{texvalue}}\n"
		end
	end

	result.join
end

rule :confidence_intervalls, // do
	Hash[(rule :key_values).map do |k, v|
		next if v.empty?
		[k, Statistics.confidence_interval_99(v.map(&:first))]
	end]
end

rule :linear_fit, // do
	Statistics.linefit(rule :pairs)
end

rule :proportional_fit, // do
	Statistics.proportionalfit(rule :pairs)
end

rule :proportional_determination, // do
	Statistics.proportionaldetermination(rule :pairs)
end

rule :fitted_line, // do
	a, b = rule :linear_fit
	"#{a}+x*#{b}"
end



rule :key_values, "wpi-" do
	(data[:range] || (1..10)).map do |i|
		[i*5, if data[:workaround] && data[:workaround][i]
			s, f = data[:workaround][i]
			rule :dat_tar_filter_min, "measurements-section4/#{s}", f
		else
			rule :dat_tar, "measurements-section4/#{data[:src]}", i
		end]
	end
end

rule :pairs, "wpi-" do
	if data[:proportional_range]
		(rule :key_values).select do |k, vs|
			data[:proportional_range].include?(k/5)
		end
	else
		rule :key_values
	end.map do |k, vs|
		vs.map do |v|
			[k, v[0]]
		end
	end.flatten(1)
end

rule :gnuplot_data, "wpi-" do
	rule :confidence_intervalls
end

rule :linear_fit, "wpi-" do
	rule :proportional_fit
end

rule :mulrange, "wpi-" do
	mulrange = (rule :confidence_intervalls).reject do |k, (mu, l, r)|
		data[:proportional_range].include?(k/5)
	end.map(&:last).flatten.map do |v|
		v * data[:opspp]
	end
	{
		mulc01min: mulrange.min,
		mulc99max: mulrange.max,
	}
end

rule :units, "wpi-" do
	{
		["pkts/s", post: { "": 1, k: 10.0**3, M: 10.0**6, G: 10.0**9 }] => {b: (rule :proportional_fit)[1]},
		"": {Rsquared: (rule :proportional_determination)},
	}.merge(
	if data[:opspp] ;{
		["ops/s", post: { "": 1, k: 10.0**3, M: 10.0**6, G: 10.0**9 }] => (rule :mulrange),
	}; end || {})
end

export ".dat", "wpi-" do
	rule :gnuplot_out
end

export ".lines", "wpi-" do
	(rule :fitted_line) + "\n"
end

export ".tex", /^wpi(\.all|\.series)?-/ do
	rule :tex_units
end

rule :mulrange, "wpi.all-" do
	n = Hash.new { |h,k| h[k] = [] }

	data[:variants].each do |v|
		(rule :mulrange, v).each do |k,m|
			n[k] << m
		end
	end

	r = {}
	r[:mulc01min] = n[:mulc01min].min if n.has_key?(:mulc01min)
	r[:mulc99max] = n[:mulc99max].max if n.has_key?(:mulc99max)
	r
end

rule :key_values, "wpi.series-" do
	(rule :list_dat_tar, "measurements-section4/#{data[:src]}").map do |n|
		[n.to_i, (rule :dat_tar, "measurements-section4/#{data[:src]}", n)]
	end
end

rule :mulrange, "wpi.series-" do
	mulrange = (rule :confidence_intervalls).map do |n, (mu, l, r)|
		[mu*n, l*n, r*n]
	end.flatten

	{
		mulc01min: mulrange.min,
		mulc99max: mulrange.max,
	}
end

rule :units, /\Awpi.(all|series)-/ do
	{
		["ops/s", post: { "": 1, k: 10.0**3, M: 10.0**6, G: 10.0**9 }] => (rule :mulrange),
	}
end

gather /^wpi-[a-z]+[0-9]+$/ do
	names.map do |n|
		next unless n =~ /^wpi-([a-z]+)[0-9]+$/
		[$1, n]
	end.compact.group_by(&:first).map do |s,v|
		["wpi.all-#{s}", {
			variants: v.map(&:last),
		}]
	end
end

data "wpi-drop", {
	src: "measure-xdp-wpi-drop-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	proportional_range: (1..5),
	workaround: {
		4 => ["measure-xdp-wpi-workaround-drop-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4-38600000", 38300000],
		5 => ["measure-xdp-wpi-workaround-drop-00:15:4d:13:12:9a,00:15:4d:13:12:9b-5-48300000", 47300000],
		6 => ["measure-xdp-wpi-workaround-drop-00:15:4d:13:12:9a,00:15:4d:13:12:9b-6", 53000000],
	}
}
data "wpi-slow", {
	src:"measure-xdp-wpi-slow-00:15:4d:13:12:9a,00:15:4d:13:12:9b"
}
data "wpi-lookup4", {
	src: "measure-xdp-wpi-lookup4-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	opspp: 4,
	proportional_range: (1..4),
	workaround: {
		4 => ["measure-xdp-wpi-workaround-lookup4-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4-46500000", 46000000],
		5 => ["measure-xdp-wpi-workaround-lookup4-00:15:4d:13:12:9a,00:15:4d:13:12:9b-5-51000000", 48900000],
		6 => ["measure-xdp-wpi-workaround-lookup4-00:15:4d:13:12:9a,00:15:4d:13:12:9b-6-51000000", 48900000],
		7 => ["measure-xdp-wpi-workaround-lookup4-00:15:4d:13:12:9a,00:15:4d:13:12:9b-7-49400000", 48900000],
		8 => ["measure-xdp-wpi-workaround-lookup4-00:15:4d:13:12:9a,00:15:4d:13:12:9b-8-51000000", 48900000],
		9 => ["measure-xdp-wpi-workaround-lookup4-00:15:4d:13:12:9a,00:15:4d:13:12:9b-9-51000000", 48900000],
		10 => ["measure-xdp-wpi-workaround-lookup4-00:15:4d:13:12:9a,00:15:4d:13:12:9b-10-51000000", 48900000],
	}
}
data "wpi-lookup8", {
	src: "measure-xdp-wpi-lookup8-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	opspp: 8,
	proportional_range: (1..2)
}
data "wpi-lookup12", {
	src: "measure-xdp-wpi-lookup12-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	opspp: 12,
	proportional_range: (1..2)
}
data "wpi.series-inc", {
	src: "measure-xdp-wpi-series-inc-00:15:4d:13:12:9a,00:15:4d:13:12:9b-9-20",
}

rule :"ereport.rb", "*.ereport" do |mode|
	popen(basefile("scripts/ereport.rb"), "--#{mode}", datafile)
end

rule :is_bitrate, "*.ereport" do
	(rule :"ereport.rb", name, "is-bitrate").chomp == "true"
end

rule :workers, "*.ereport" do
	[(rule :"ereport.rb", name, "workers").chomp, "5"].reject(&:empty?).first.to_i
end

rule :proc_predictions, "*.ereport" do
	Hash[(rule :"ereport.rb", name, "cycles").split("\n").map { |l| l.split(" ", 3) }.map do |id,c,s|
		[id, [c.to_i, s.to_i]]
	end]
end

rule :dram_predictions, "*.ereport" do
	Hash[(rule :"ereport.rb", name, "dram-cycles").split("\n").map { |l| l.split(" ", 3) }.map do |id,c,s|
		[id, [c.to_f, s.to_i]]
	end]
end

rule :progress, "*.ereport" do
	scale_workers = 50
	workers = (rule :workers)
	(rule :"ereport.rb", name, "progress").split("\n").map do |l|
		d = l.split("\t")
		d[0..1].map(&:to_f) + d[2..-1].map(&:to_i)
	end.reverse.inject([]) do |a,e|
		a +
		[e + [(a[-1] || e)[-1]]]
	end.reverse.inject([]) do |a, e|
		a + [[
			e[0],
			!a[-1] || a[-1][2] == 0 ? 800000000.0/e[1] * 8 * scale_workers : a[-1][1],
			e[3],
			e[2],
		]]
	end
end

rule :numbers, "*.ereport" do
	m = {}
	(rule :"ereport.rb", name, "numbers").split("\n").map do |l|
		l.split("\t")
	end.each do |n,*x|
		m[n.to_sym] = x
	end
	m
end


rule :gnuplot_data, "progress-xdp-"  do
	[[0,0.0,0,0]]+
	(rule :progress, data[:src])
end

export ".dat", /\Aprogress-xdp-.*\.k\z/ do
	rule :gnuplot_out
end

gen "xdp-" do
	data[:ereports].map do |k, n|
		["progress-#{name}.#{k}", {src: "predictions/#{name}.#{k}.ereport"}]
	end
end


rule :num_intermediates, "*.ereport" do
	last_time = 0
	count = 0
	result = nil

	(rule :progress).each do |time, cycles, num_max, num|
		if num != 0
			result = count
			break
		end
		next unless time > last_time
		last_time = time
		count += 1
	end

	result
end

rule :numbers, "numbers-xdp-" do
	convert, f, s = (rule :is_bitrate, data[:srcs].first) ? [:to_f, 8, 1] : [:to_i, 1, 60*8]

	numbers = Hash.new { |h,k| h[k] = []}

	data[:srcs].each do |ereport|
		m = (rule :numbers, ereport)
		numbers[:early_time] << m[:early][0].to_f
		er = 800000000.0/m[:early][1].send(convert)*f
		numbers[:early_rate] << er
		numbers[:early_bitrate] << er*s
		numbers[:early_z3cputime] << m[:early][3].to_f
		numbers[:early_cfgcputime] << m[:early][4].to_f
		if m[:first]
			numbers[:first_time] << m[:first][0].to_f
			fr = 800000000.0/m[:first][1].send(convert)*f
			numbers[:first_rate] << fr
			numbers[:first_bitrate] << fr*s
			numbers[:improve_rate] << 100.0/er*fr-100 unless er.infinite?

			numbers[:first_unsatisfiable] << m[:first][2].to_i
			numbers[:first_z3cputime] << m[:first][3].to_f
			numbers[:first_cfgcputime] << m[:first][4].to_f
		end
		if m[:last]
			numbers[:total_time] << m[:last][0].to_f
			numbers[:num] << m[:last][1].to_i
			numbers[:num_unsatisfiable] << m[:last][2].to_i
			numbers[:total_z3cputime] << m[:last][3].to_f
			numbers[:total_cfgcputime] << m[:last][4].to_f
		else
			numbers[:min_time] << m[:end][0].to_f
			numbers[:min_num] << m[:end][1].to_i
			numbers[:min_unsatisfiable] << m[:end][2].to_i
			numbers[:min_z3cputime] << m[:end][3].to_f
			numbers[:min_cfgcputime] << m[:end][4].to_f
		end
	end

	intermediates = data[:srcs].each do |ereport|
		m = (rule :num_intermediates, ereport)
		numbers[:num_intermediates] << m if m
	end

	aggregated = {
		early_time: Statistics.confidence_interval_99(numbers[:early_time]),
		early_rate: numbers[:early_rate].first,
		early_bitrate: numbers[:early_bitrate].first,
	}
	[:first_time,
	 :total_time,
	 :num_intermediates
	].each do |k|
		next unless numbers.has_key?(k)
		aggregated[k] = Statistics.confidence_interval_99(numbers[k])
	end
	[:first_rate,
	 :first_bitrate,
	 :improve_rate
	].each do |k|
		next unless numbers.has_key?(k)
		aggregated[k] = numbers[k].first
	end
	[:num,
	 :min_time,
	 :min_num,
	 :first_unsatisfiable,
	 :num_unsatisfiable,
	 :min_unsatisfiable,
	].each do |k|
		next unless numbers.has_key?(k)
		aggregated[k] = numbers[k].max
	end

	z3ratios = []
	data[:srcs].size.times.each do |i|
		[#:early,
		 :first,
		 #:total,
		 #:min,
		].each do |k|
			z3 = numbers[:"#{k}_z3cputime"][i]
			next unless z3
			sum = z3 + numbers[:"#{k}_cfgcputime"][i]
			z3ratios << 100.0/sum*z3
		end
	end

	aggregated[:z3ratios] = [z3ratios.min, z3ratios.max]

	aggregated
end

rule :units, "numbers-xdp-" do
	numbers = rule :numbers

	{
		["#{(rule :is_bitrate, data[:srcs].first) ? "Bit" : "pkt"}/s/c", post: {"": 1, k: 10.0**3, M: 10.0**6, G: 10.0**9 }] => {
			"early_rate": numbers[:early_rate],
		}.merge(if numbers.has_key?(:first_rate);{
			"first_rate": numbers[:first_rate],
		};end||{}),
	}.merge(if numbers[:num_intermediates];{
		["", post: {"": 1, k: 10.0**3, M: 10.0**6, G: 10.0**9 }] => {
			num_intermediates_mean: numbers[:num_intermediates][0],
			num_intermediates_c0199: numbers[:num_intermediates][1..2],
		},
	};end||{}
	).merge(if numbers.has_key?(:improve_rate);{
		["", post: {"%":1}, sign: true] => {"improve_rate": numbers[:improve_rate], },
	};end||{}
	).merge( if numbers.has_key?(:min_time);{
		["path", pre: "$\\geq{}$", post: {"": 1, k: 10.0**3, M: 10.0**6, G: 10.0**9 }] => {"min_num": numbers[:min_num], "min_unsatisfiable": numbers[:min_unsatisfiable]},
	}.merge(Hash[{"ms": 1.0/1000, "s": 1, "m": 60, "h": 60*60}.map do |u, d|
		[[u, pre: "$\\geq{}$"], {
			"min_time_#{u}": numbers[:min_time]/d
		}.merge(unless numbers.has_key?(:first_time);{
			"min_first_time_#{u}": numbers[:min_time]/d
		};end||{})]
	end]);else;{
		["path", post: {"": 1, k: 10.0**3, M: 10.0**6, G: 10.0**9 }] => {"num": numbers[:num], "num_unsatisfiable": numbers[:num_unsatisfiable]},
	};end
	).merge(Hash[{"ms": 1.0/1000, "s": 1, "m": 60, "h": 60*60}.map do |u, d|
	[u, (
		["early_time_mean", "early_time_c0199", "early_time_c99diff", "early_time_c99max"] +
		(numbers.has_key?(:first_time) ?  ["first_time_mean", "first_time_c0199", "first_time_c99diff", "first_time_c99max"] : []) +
		(numbers.has_key?(:total_time) ? ["total_time_mean", "total_time_c0199", "total_time_c99diff", "total_time_c99max"] : [])
	).map { |x| "#{x}_#{u}" }.zip((
		[numbers[:early_time]].map { |m,a,b| [m/d, [a/d,b/d], (b-m)/d, b/d] } +
		(numbers.has_key?(:first_time) ?  [numbers[:first_time]].map { |m,a,b| [m/d,[a/d,b/d], (b-m)/d, b/d] } : [])+

		(numbers.has_key?(:total_time) ? [numbers[:total_time]].map { |m,a,b| [m/d,[a/d,b/d], (b-m)/d, b/d] } : [])
		).flatten(1))]
	end])
end

export ".tex", /\Anumbers-(xdp-.*\.k|all)\z/ do
	rule :tex_units
end

rule :units, "numbers-all" do
	numbers = Hash[data[:examples].map { |e| [e, (rule :numbers, "numbers-#{e}")] }]

	percent_all = {}
	[:improve_rate,
	].each do |i|
		max = numbers.map { |k,n| [k, n[i]] }.select(&:last).max_by(&:last)
		percent_all[i] = max if max
	end

	time_all = {}
	[:early,
	 :first,
	].each do |i|
		max = numbers.map { |k,n| [k, n[:"#{i}_time"]] }.select(&:last).max_by { |k, (m,a,b)| b }
		next unless max
		time_all[:"#{i}_c99max"] = [max[0], max[1][2]]
	end

	percent_all[:z3ratio_min] = numbers.map { |k,n| [k, n[:z3ratios].min] }.select(&:last).min_by(&:last)
	percent_all[:z3ratio_max] = numbers.map { |k,n| [k, n[:z3ratios].max] }.select(&:last).max_by(&:last)

	{
		["", precision: [""]] => (percent_all.to_a+time_all.to_a).map { |k,v| [k, v.first] },
		["", post: {"%":1}] => percent_all.map { |k,v| [k, v.last] },
	}.merge(Hash[{"ms": 1.0/1000, "s": 1, "m": 60, "h": 60*60}.map do |u, d|
		[u, time_all.map do |k,v|
			["#{k}_#{u}", v.last/d]
		end]
	end])
end

gather /\Anumbers-xdp-.*\.k\z/ do
	[["numbers-all", {
		examples: names.map { |n| n.sub(/\Anumbers-/, "") },
	}]]
end

gen "xdp-" do
	data[:ereports].map do |k, n|
		["numbers-#{name}.#{k}", {srcs: ["predictions/#{name}.#{k}.ereport"] + (n-1).times.map { |i| "predictions/#{name}.#{k}-#{i+1}.ereport" } }]
	end
end

rule :numbers, "compare-xdp-" do
	nA, nB = data[:ereports].map do |k, v|
		(rule :numbers, "numbers-#{data[:ereport_names] ? data[:ereport_names][k] : "#{data[:example]}.#{k}"}")
	end

	result = {
		improve_early_bitrate: 100.0/nA[:early_bitrate]*nB[:early_bitrate]-100,
		no_first: nA[:first_time] && !nB[:first_time],
	}
	if nA[:num_intermediates] && nB[:num_intermediates]
		result[:improve_num_intermediates] = 100.0/nA[:num_intermediates][2]*nB[:num_intermediates][1]-100
		result[:improve_num_intermediates_abs] = nB[:num_intermediates][2]-nA[:num_intermediates][1]
	end
	if nA[:first_bitrate] && nB[:first_bitrate]
		result[:improve_first_bitrate] = 100.0/nA[:first_bitrate]*nB[:first_bitrate]-100
	end
	if nA[:first_time]
		nAft = nA[:first_time][2]
		nBft = (nB[:first_time] || [nil,nB[:min_time]])[1]
		rel = nBft/nAft
		result[:improve_first_time] = 100-100*rel
		result[:factor_first_time]   = rel
		result[:worse_first_time]   = 100*rel-100
		result[:worse_first_time_abs] = nBft-nAft
	end
	if !nB[:first_time]
		result[:b_first_min_time] = nB[:min_time]
	end

	result
end

rule :units, "compare-xdp-" do
	{
		["", post: {"%":1}] => (rule :numbers).select { |k,v| Float === v }
	}
end

#export ".tex", "compare-xdp-" do
#	rule :tex_units
#end

gen "xdp-" do
	(
	[[:i, :k],[:k, :i]] +
	data[:ereports].keys.product(data[:ereports].keys).select do |a, b|
		a != b && a.to_s.size == 1 && b.to_s.start_with?(a.to_s)
	end
	).compact.map do |a, b|
		next unless data[:ereports][a] && data[:ereports][b]
		["compare-#{name}.#{a}.#{b}", {
			example: name,
			ereports: {
				a => data[:ereports][a],
				b => data[:ereports][b],
			},
		}]
	end.compact
end

rule :numbers, /\Anumbers-.+\.add\./ do
	nA, nB = data[:ereports].map do |k, v|
		(rule :numbers, "numbers-#{data[:example]}.#{k}")
	end

	result = {
		early_bitrate: [nA[:early_bitrate], nB[:early_bitrate]].min,
		num_intermediates: 0,
	}
	if nA[:first_bitrate] && nB[:first_bitrate]
		result[:first_bitrate] = [nA[:first_bitrate], nB[:first_bitrate]].min
	end
	if nA[:first_time] && nB[:first_time]
		result[:first_time] = (nA[:first_time].zip(nB[:first_time])).map(&:sum)
	end

	result
end

gen "xdp-" do
	[
		[:k, [:m, :q]]
	].map do |a, (b, c)|
		next unless data[:ereports][a] && data[:ereports][b] && data[:ereports][c]
		[["numbers-#{name}.add.#{b}.#{c}", {
			example: name,
			ereports: {
				b => data[:ereports][b],
				c => data[:ereports][c],
			},
		}],
		["compare-#{name}.#{a}.add.#{b}.#{c}", {
			example: name,
			ereports: {
				a => data[:ereports][a],
				:"add.#{b}.#{c}" => [data[:ereports][b], data[:ereports][c]],
			},
		}]]
	end.compact.flatten(1)
end

gather /^xdp-alaw2ulaw/ do
	next [] if names.size != 2
	prefix = names[0][0, names[0].size.downto(0).find { |i| names.all? { |n| n[0,i] == names[0][0,i] } }]
	ereports =  Hash[
		names.map do |n|
			[
			 :"#{"#{n[prefix.size..-1]}.k".sub(/^[\.-]/, "")}",
			 (data n)[:ereports][:k]
			]
		end
	]
	ereport_names =  Hash[
		names.map do |n|
			[
			 :"#{"#{n[prefix.size..-1]}.k".sub(/^[\.-]/, "")}",
			 "#{n}.k"
			]
		end
	]
	[["compare-#{prefix}.#{ereports.keys.join(".")}", {
		ereports: ereports,
		ereport_names: ereport_names,
	}]]
end

export ".tex", "compare-xdp-alaw2ulaw.k.opt.k" do
	rule :tex_units
end


rule :units, "compare-all." do
	numbers = Hash[data[:comparisons].map { |e| [e, (rule :numbers, e)] }]

	rel_all = {}
	[:improve_early_bitrate,
	 :improve_first_bitrate,
	 :improve_first_time,
	 :worse_first_time,
	 :improve_num_intermediates,
	].each do |i|
		min = numbers.map { |k,n| [k, n[i]] }.select(&:last).min_by(&:last)
		max = numbers.map { |k,n| [k, n[i]] }.select(&:last).max_by(&:last)
		rel_all[:"#{i}_min"] = min if min
		rel_all[:"#{i}_max"] = max if max
	end

	factor_all = {}
	time_lower_bound_all = {}
	begin
		i = :factor_first_time
		min = numbers.map { |k,n| [k, n[i]] }.select(&:last).min_by(&:last)
		max = numbers.map { |k,n| [k, n[i]] }.select(&:last).max_by(&:last)
		b_first_min_time = numbers.map { |k,n| [k,n[:b_first_min_time]] }.select(&:last).max_by(&:last)
		factor_all[:"#{i}_min"] = min if min
		if b_first_min_time
			time_lower_bound_all[:"#{i}_max"] = b_first_min_time
		else
			factor_all[:"#{i}_max"] = max if max 
		end
	end

	time_abs_all = {}
	[:worse_first_time_abs,
	].each do |i|
		min = numbers.map { |k,n| [k, n[i]] }.select(&:last).min_by(&:last)
		max = numbers.map { |k,n| [k, n[i]] }.select(&:last).max_by(&:last)
		time_abs_all[:"#{i}_min"] = min if min
		time_abs_all[:"#{i}_max"] = max if max
	end

	abs_all = {}
	[:improve_num_intermediates_abs,
	].each do |i|
		min = numbers.map { |k,n| [k, n[i]] }.select(&:last).min_by(&:last)
		max = numbers.map { |k,n| [k, n[i]] }.select(&:last).max_by(&:last)
		abs_all[:"#{i}_min"] = min if min
		abs_all[:"#{i}_max"] = max if max
	end

	[:no_first
	].each do |i|
		s = numbers.map { |k,n| [k,n[i]] }.select(&:last)
		abs_all[i] = [s.map(&:first).join(","), s.size]
	end

	{
		["", precision: [""], sign: true] => (rel_all.to_a+factor_all.to_a+time_lower_bound_all.to_a+time_abs_all.to_a+abs_all.to_a).map { |k,v| [k, v.first] },
		["", post: {"%":1}, sign: true] => rel_all.map { |k,v| [k, v.last] },
		["", pre: "$\\times{}$"] => factor_all.map { |k,v| [k, v.last] },
		["h", pre: "$\\geq{}$"] => time_lower_bound_all.map { |k,v| [k, v.last/60/60] },
		["s", sign: true] => time_abs_all.map { |k,v| [k, v.last] },
		["", sign: true]  => abs_all.map { |k,v| [k, v.last] },
	}
end

export ".tex", "compare-all." do
	rule :tex_units
end

gather "compare-xdp-" do
	names.map do |name|
		data name
	end.select do |data|
		data[:example]
	end.group_by do |data|
		data[:ereports].keys
	end.map do |(a, b), datas|
		["compare-all.#{a}.#{b}", {
			comparisons: datas.map(&:name)
		}]
	end
end

rule :key_values, "rate-xdp-" do
	list = rule :list_dat_tar, "measured-throughput/#{data[:measurement]}"
	list += data[:workaround].keys if data[:workaround]
	list.uniq
	Hash[list.map do |id|
		[id, if data[:workaround] && data[:workaround][id]
			s, f = data[:workaround][id]
			rule :dat_tar_filter_min, "measured-throughput/#{s}", f
		else
			rule :dat_tar, "measured-throughput/#{data[:measurement]}", id
		end]
	end]
end

rule :rates, "rate-xdp-" do
	throughput = rule :is_bitrate, data[:ereport]
	proc_frequency = 800000000.0 * (rule :workers, data[:ereport])
	dram_frequency = 800000000.0

	proc_pred = rule :proc_predictions, data[:ereport]
	dram_pred = rule :dram_predictions, data[:ereport]
	measured = rule :confidence_intervalls

	(proc_pred.keys + dram_pred.keys + measured.keys).uniq.map do |id|
		size = (proc_pred[id] || dram_pred[id] || [])[1]
		f = throughput ? (size ? size*8 : nil) : 1
		proc_rate = proc_frequency / proc_pred[id][0] if proc_pred[id]
		dram_rate = dram_frequency / dram_pred[id][0] if dram_pred[id]
		mac_rate = data[:workaround] && data[:workaround][id] ? 54400000 : 30000000
		bottleneck= [
			[:proc, proc_rate],
			[:dram, dram_rate],
			[:mac,  mac_rate ],
		].select(&:last).min_by(&:last).first

		[
			id,
			if proc_rate && f
				proc_rate * f
			end,
			if dram_rate && f
				dram_rate * f
			end,
			if measured[id] && f
				measured[id].map { |p| p*f }
			end,
			bottleneck,
		]
	end
end

rule :gnuplot_data, "rate-xdp-" do
	(rule :rates).map { |r| r[0..3] }
end

#export ".dat", "rate-xdp-" do
#	rule :gnuplot_out
#end
export ".dat", /\Arate-xdp-count-min\.[0-9]+\.i\z/ do
	rule :gnuplot_out
end

rule :path_errors, "rate-xdp-" do
	rate = rule :rates

	numbers = {}
	next numbers if rate.empty?

	if rate[0][3] && (rate[0][1] || rate[0][2]) && rate[0][4] != :mac
		numbers[:abs_first_error]= rate[0][3][1..2].map { |x| x-rate[0][1..2].compact.min }.max_by(&:abs)
		numbers[:rel_first_error]= rate[0][3][1..2].map { |x| 100.0/x*(x-rate[0][1..2].compact.min) }.map(&:abs).max
	end

	[nil, :proc, :dram].each do |t|
		label = t ? "_#{t}" : ""

		r = rate.map do |id, p, r, m, b|
			[[p, r].compact.min, m, b]
		end.select do |a, m, b|
			a && m && b != :mac && (t.nil? || b == t)
		end

		r_n = r.select { |a, m, b| m[2] < a}
		r_p = r.select { |a, m, b| m[1] > a}

		numbers[:"num_measured#{label}"] = r.size
		numbers[:"num_error_n#{label}"] = r_n.size
		numbers[:"num_error_p#{label}"] = r_p.size
		numbers[:"num_correct#{label}"] = r.size-r_n.size-r_p.size

		n_abs_max = r_n.map { |a, m, b| a - m[2] }.max
		p_abs_max = r_p.map { |a, m, b| m[1] - a }.max
		n_rel_max = r_n.map { |a, m, b| 100.0/m[2]*(a - m[2]) }.max
		p_rel_max = r_p.map { |a, m, b| 100.0/m[1]*(m[1] - a) }.max

		abs_max = [n_abs_max, p_abs_max].compact.map(&:abs).max
		rel_max = [n_rel_max, p_rel_max].compact.map(&:abs).max

		numbers[:"abs_max_error#{label}_n"] = n_abs_max if n_abs_max
		numbers[:"rel_max_error#{label}_n"] = n_rel_max if n_rel_max
		numbers[:"abs_max_error#{label}_p"] = p_abs_max if p_abs_max
		numbers[:"rel_max_error#{label}_p"] = p_rel_max if p_rel_max
	end

	numbers
end

rule :worst_cases, "rate-xdp-" do
	rates = rule :rates
	ereport_numbers = rule :numbers, "numbers-#{name[5..-1]}"
	scale_workers = 50
	workers = rule :workers, data[:ereport]
	early_rate = ereport_numbers[:early_rate] * scale_workers

	first = rates[0]
	if first 
		first_rate = ereport_numbers[:first_rate] * scale_workers
	end

	worst_measured = rates.each_with_index.select do |x,i|
		x[3] && x[4] != :mac
	end.map do |(id, p, r, m ,b), i|
		[id,
		 p/workers*scale_workers,
		 r/workers*scale_workers,
		 m.map { |i| i/workers*scale_workers },
		 b,
		 i,
		]
	end. min_by { |id, p, r, m ,b, i| m[2] }

	numbers = {}
	numbers[:abs_early_rate] = early_rate

	next numbers if
		!first ||
		first[4] == :mac ||
		!worst_measured ||
		worst_measured[4] == :mac

	if first[3] && worst_measured[3][2] < first[3][1]
		diff = first[3][1] - worst_measured[3][2]
		numbers[:abs_reorder_error] = diff
		numbers[:rel_reorder_error] = 100.0/worst_measured[3][2]*diff
	end

	numbers[:num_reorder] = rates[0..worst_measured[5]].select do |x|
		x[3] &&
		worst_measured[3][2] < x[3][1]
	end.size

	numbers[:bottleneck] = worst_measured[4]
	numbers[:abs_first_rate] = first_rate
	numbers[:measured_worst_rate] = worst_measured[3]
	case
	when first_rate < worst_measured[3][1]
		numbers[:abs_prediction_error] = worst_measured[3][1]-first_rate
		numbers[:rel_prediction_error] = 100.0/worst_measured[3][1]*(worst_measured[3][1]-first_rate)
		numbers[:relp_prediction_error_p] = 100.0/worst_measured[3][1]*(worst_measured[3][1]-first_rate)
	when first_rate > worst_measured[3][2]
		numbers[:abs_prediction_error] = worst_measured[3][2]-first_rate
		numbers[:rel_prediction_error] = 100.0/worst_measured[3][2]*(worst_measured[3][2]-first_rate)
	else
		numbers[:abs_prediction_error] = true
		numbers[:rel_prediction_error] = true
	end

	numbers
end

rule :numbers, "rate-xdp-" do
	n = {}
	n.merge!(rule :path_errors)
	n.merge!(rule :worst_cases)
	n
end

rule :is_bitrate, "rate-xdp-" do
	rule :is_bitrate, data[:ereport]
end

rule :units, "rate-xdp-" do
	throughput= rule :is_bitrate, data[:ereport]
	rate_unit = "#{throughput ? "Bit" : "pkt"}/s"
	numbers = rule :numbers

	Hash[[
		["abs_", [rate_unit, post: {"": 1, k: 10**3, M: 10**6, G: 10**9 }]],
		["rel_", ["", post: {"%":1}, sign: true]],
		["relp_", ["", post: {"%":1}]],
		["num_", ["path", precision: [0]]],
	].map do |p, u|
		[u, Hash[numbers.select do |k,v|
			k.start_with?(p)
		end.map do |k,v|
			[k[p.size..-1], v]
		end]]
	end].merge(if numbers[:bottleneck];{
		["", precision: [""]] => {
			:bottleneck => {
				:mac  => "MAC",
				:dram => "DRAM",
				:proc => "processing cores",
			}[numbers[:bottleneck]],
		}
	};end || {}
	).merge(if numbers[:measured_worst_rate];{
		[rate_unit, post: {"": 1, k: 10**3, M: 10**6, G: 10**9 }, x: :measured_worst_rate] =>  {
			measured_worst_rate_mean: numbers[:measured_worst_rate][0],
			measured_worst_rate_c0199: numbers[:measured_worst_rate][1..2],
			measured_worst_rate_c99diff: numbers[:measured_worst_rate][2]-numbers[:measured_worst_rate][0],
		},
	};end || {}
	)
end

rule :units, "rate-all" do
	numbers = Hash[data[:examples].map { |e| [e, (rule :numbers, "rate-#{e}")] }]

	minmax_all = {}
	[:rel_first_error,
	 :rel_max_error_p,
	 :rel_max_error_n,
	 :rel_max_error_proc_p,
	 :rel_max_error_proc_n,
	 :rel_max_error_dram_p,
	 :rel_max_error_dram_n,
	 :rel_reorder_error,
	].each do |i|
		max = numbers.map { |k,n| [k, n[i]] }.select(&:last).max_by(&:last)
		minmax_all[i] = max if max
	end
	[:rel_prediction_error,
	].each do |i|
		min = numbers.map { |k,n| [k, n[i]] }.select { |k,n| Numeric === n }.min_by(&:last)
		max = numbers.map { |k,n| [k, n[i]] }.select { |k,n| Numeric === n }.max_by(&:last)
		minmax_all[:"#{i}_min"] = min if min
		minmax_all[:"#{i}_min.p"] = [min[0],min[1].abs] if min && min[1] < 0
		minmax_all[:"#{i}_max"] = max if max
	end

	nums = {}
	max_all= {}
	count_all= {}
	sum_all = {}
	rel_all = {}
	[:num_measured,
	 :num_reorder,
	 :num_error_n,
	 :num_error_p,
	 :num_correct,
	].each do |i|
		mapped = numbers.map { |k,n| [k, n[i]] }.select(&:last)
		sum =   mapped.map(&:last).inject(&:+)
		max =   mapped.max_by(&:last)
		count = mapped.select { |k,v| v > 0 }.size

		nums[i] = sum

		max_all  [:"#{i.to_s.sub(/\A[a-z]+_/, "max_"  )}"] = max
		count_all[:"#{i.to_s.sub(/\A[a-z]+_/, "count_")}"] = count
		sum_all  [:"#{i.to_s.sub(/\A[a-z]+_/, "sum_"  )}"] = sum
		rel_all  [:"#{i.to_s.sub(/\A[a-z]+_/, "rel_"  )}"] = 100.0/nums[:num_measured]*sum if i != :num_measured
		rel_all  [:"#{i.to_s.sub(/\A[a-z]+_/, "notrel_"  )}"] = 100-100.0/nums[:num_measured]*sum if i != :num_measured
	end

	{
		["", precision: [""]] => (minmax_all.to_a+max_all.to_a).map { |k,v| [k, v.first] },
		["", post: {"%":1}] => (minmax_all.map { |k,v| [k, v.last] }+rel_all.to_a),
		["path", precision: [0]] => max_all.map { |k,v| [k, v.last] },
		["program", precision: [0]] => count_all.map { |k,v| [k, v] },
		["path", post: {"": 1, k: 10.0**3, M: 10.0**6, G: 10.0**9 }] => sum_all,
	}
end

export ".tex", /\Arate-(xdp-|all\z)/ do
	rule :tex_units
end

gather "rate-xdp-" do
	[["rate-all", {
		examples: names.map { |n| n.sub(/\Arate-/, "") },
	}]]
end

gen "xdp-" do
	((data[:measurements]||{}).keys & (data[:ereports]||{}).keys) .map do |k|
		["rate-#{name}.#{k}", {
			ereport: "predictions/#{name}.#{k}.ereport",
			measurement: data[:measurements][k],
		}.merge(
		if data[:workarounds] && data[:workarounds][k] ;{
			workaround: data[:workarounds][k]
		}; end || {})]
	end
end

run do
	$num_ereports = 20
end

data "xdp-quic-lb", {
	ereports: {
		k: $num_ereports,
		i: $num_ereports,
		m: $num_ereports,
		q: $num_ereports,
		kL0: $num_ereports,
		"kFcheck-each-branch": $num_ereports,
		"kFcheck-unlikely-edges": $num_ereports,
		"kFno-impossible-prefixes": $num_ereports,
		"kFno-impossible-path-merging": $num_ereports,
		"kFno-keep-impossible-paths": $num_ereports,
		"kFsat-strategy=incremental": $num_ereports,
	},
	measurements: {
		k: "measure-xdp-ereport-xdp-quic-lb.l-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	}
}
data "xdp-quic-lb-ipv6-options", {
	ereports: {
		k: $num_ereports,
		i: $num_ereports,
		m: $num_ereports,
		q: $num_ereports,
		kL0: $num_ereports,
		"kFcheck-each-branch": $num_ereports,
		"kFcheck-unlikely-edges": $num_ereports,
		"kFno-impossible-prefixes": $num_ereports,
		"kFno-impossible-path-merging": $num_ereports,
		"kFno-keep-impossible-paths": $num_ereports,
		"kFsat-strategy=incremental": $num_ereports,
	},
	measurements: {
		k: "measure-xdp-ereport-xdp-quic-lb-ipv6-options.m-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	}
}
data "xdp-cloudflare", {
	ereports: {
		k: $num_ereports,
		i: $num_ereports,
		m: $num_ereports,
		q: $num_ereports,
		kL0: $num_ereports,
		"kFcheck-each-branch": $num_ereports,
		"kFcheck-unlikely-edges": $num_ereports,
		"kFno-impossible-prefixes": $num_ereports,
		"kFno-impossible-path-merging": $num_ereports,
		"kFno-keep-impossible-paths": $num_ereports,
		"kFsat-strategy=incremental": $num_ereports,
	},
	measurements: {
		k: "measure-xdp-ereport-xdp-cloudflare.l-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	}
}
data "xdp-switch", {
	ereports: {
		k: $num_ereports,
		i: $num_ereports,
		m: $num_ereports,
		q: $num_ereports,
		kL0: $num_ereports,
		"kFcheck-each-branch": $num_ereports,
		"kFcheck-unlikely-edges": $num_ereports,
		"kFno-impossible-prefixes": $num_ereports,
		"kFno-impossible-path-merging": $num_ereports,
		"kFno-keep-impossible-paths": $num_ereports,
		"kFsat-strategy=incremental": $num_ereports,
	},
	measurements: {
		k: "measure-xdp-ereport-xdp-switch.l-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	}
}
data "xdp-alaw2ulaw", {
	ereports: {
		k: $num_ereports,
		i: $num_ereports,
		m: $num_ereports,
		q: $num_ereports,
		kL0: $num_ereports,
		"kFcheck-each-branch": $num_ereports,
		"kFcheck-unlikely-edges": $num_ereports,
		"kFno-impossible-prefixes": $num_ereports,
		"kFno-impossible-path-merging": $num_ereports,
		"kFno-keep-impossible-paths": $num_ereports,
		"kFsat-strategy=incremental": $num_ereports,
	},
	measurements: {
		k: "measure-xdp-ereport-xdp-alaw2ulaw.m-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	}
}
data "xdp-alaw2ulaw-opt", {
	ereports: {
		k: $num_ereports,
		i: $num_ereports,
		m: $num_ereports,
		q: $num_ereports,
		kL0: $num_ereports,
		"kFcheck-each-branch": $num_ereports,
		"kFcheck-unlikely-edges": $num_ereports,
		"kFno-impossible-prefixes": $num_ereports,
		"kFno-impossible-path-merging": $num_ereports,
		"kFno-keep-impossible-paths": $num_ereports,
		"kFsat-strategy=incremental": $num_ereports,
	},
	measurements: {
		k: "measure-xdp-ereport-xdp-alaw2ulaw-opt.m-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	}
}
data "xdp-dns-cache", {
	ereports: {
		k: $num_ereports,
		i: $num_ereports,
		m: $num_ereports,
		q: $num_ereports,
		kL0: $num_ereports,
		"kFcheck-each-branch": $num_ereports,
		"kFcheck-unlikely-edges": $num_ereports,
		"kFno-impossible-prefixes": $num_ereports,
		"kFno-impossible-path-merging": $num_ereports,
		"kFno-keep-impossible-paths": $num_ereports,
		"kFsat-strategy=incremental": $num_ereports,
	},
	measurements: {
		k: "measure-xdp-ereport-slow-1333-xdp-dns-cache.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
	}
}
data "xdp-path-explosion", {
	ereports: {
		k: $num_ereports,
	},
	measurements: {
		k: "empty",
	}
}
run do
	workarounds = {
		1 => {
			i: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.1.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-54400000", 53300000]},
			k: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.1.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-54400000", 53300000]},
		},
		2 => {
			i: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.2.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-54400000", 53300000]},
			k: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.2.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-54400000", 53300000]},
		},
		3 => {
			i: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.3.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-54000000", 53800000]},
			k: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.3.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-54000000", 53800000]},
		},
		4 => {
			i: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.4.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-50100000", 49800000]},
			k: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.4.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-50100000", 49800000]},
		},
		5 => {
			i: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.5.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-46200000", 45900000]},
			k: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.5.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-46200000", 45900000]},
		},
		6 => {
			i: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.6.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-41500000", 40900000]},
			k: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.6.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-41500000", 40900000]},
		},
		7 => {
			i: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.7.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-35500000", 34900000]},
			k: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.7.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-35500000", 34900000]},
		},
		8 => {
			i: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.8.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-31100000", 30000000]},
			k: { "4f50d2bf86593c0f" => ["measure-xdp-ereport-workaround-xdp-count-min.8.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b-4f50d2bf86593c0f-31100000", 30000000]},
		},
	}
	(1..20).each do |i|
		data "xdp-count-min.#{i}", **({
			ereports: {
				k: $num_ereports,
				i: $num_ereports,
				m: $num_ereports,
				q: $num_ereports,
				kL0: $num_ereports,
				"kFcheck-each-branch": $num_ereports,
				"kFcheck-unlikely-edges": $num_ereports,
				"kFno-impossible-prefixes": $num_ereports,
				"kFno-impossible-path-merging": $num_ereports,
				"kFno-keep-impossible-paths": $num_ereports,
				"kFsat-strategy=incremental": $num_ereports,
			},
			measurements: {
				i: "measure-xdp-ereport-xdp-count-min.#{i}.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
				k: "measure-xdp-ereport-xdp-count-min.#{i}.i-00:15:4d:13:12:9a,00:15:4d:13:12:9b",
			}
		}.merge(
		if workarounds[i] ;{
			workarounds: workarounds[i]
		}; end || {}))
	end
end

