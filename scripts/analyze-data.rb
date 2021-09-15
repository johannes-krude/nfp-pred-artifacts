#!/usr/bin/ruby

require "pathname"
require "digest"
require "etc"
require "io/console"

module Statistics

	def self.sum(data)
		data.inject(0.0) { |s, val| s + val }
	end

	def self.mean(data)
		sum(data) / data.size
	end

	def self.median(data)
		(data[data.size/2]+data[(data.size-1)/2])/2
	end

	def self.variance(data)
		mu = mean data
		squared_diff = data.map { |val| (mu - val) ** 2 }
		mean squared_diff
	end

	def self.stdev(data)
		Math.sqrt variance(data)
	end

	def self.confidence_interval_95(data)
		mu = mean data
		delta = 1.96 * stdev(data) / Math.sqrt(data.size)
		[mu, mu - delta, mu + delta]
	end

	def self.confidence_interval_99(data)
		mu = mean data
		delta = 2.58 * stdev(data) / Math.sqrt(data.size)
		[mu, mu - delta, mu + delta]
	end

	def self.pearson(data)
		meanx = mean data.map(&:first)
		meany = mean data.map(&:last)
		sum(data.map { |x,y| (x-meanx)*(y-meany) }) /
		(
			Math::sqrt(sum(data.map(&:first).map { |x| (x-meanx)**2 })) *
			Math::sqrt(sum(data.map(&:last).map { |y| (y-meany)**2 }))
		)
	end

	def self.linefit(data)
		meanx = mean data.map(&:first)
		meany = mean data.map(&:last)
		stdevx = stdev data.map(&:first)
		stdevy = stdev data.map(&:last)
		b = pearson(data) * stdevy / stdevx
		a = meany - b * meanx
		[a, b]
	end

	def self.proportionalfit(data)
		[0,
			sum(data.map { |x,y| x*y }) /
			sum(data.map { |x,y| x**2 })
		]
	end

	def self.proportionaldetermination(data)
		a, b = proportionalfit(data)
		1 - (
			sum(data.map { |x,y| (y-b*x)**2 }) /
			sum(data.map { |x,y| y**2})
		)
	end

end

class Analyzer

	attr_accessor :basedir
	attr_accessor :outdir
	attr_accessor :datadir
	attr_accessor :time

	def initialize
		runner = nil
		@ruledefs = RuleDefs.new(self) do |rule, name, args|
			runner.run_rule(rule, name, args).first
		end
		@cache = Cache.new(self, @ruledefs)
		runner = Runner.new(self, @ruledefs, @cache)
		@queue = Queue.new
		@threads = nil
		@progresslock = Mutex.new
		@progresses = {}
	end

	def threads=(n)
		@threads.each(&:kill) if @threads
		Thread.abort_on_exception = true
		@threads = n.times.map do
			Thread.new do
				runner = Runner.new(self, @ruledefs, @cache)
				while job = @queue.pop
					job.call(runner)
				end
			end
		end
	end

	def wait
		return if @threads.nil?
		@queue.close
		@threads.each(&:join)
		@threads = nil
	end

	def schedule(&block)
		if @threads
			@queue << block
		else
			block.call(Runner.new(self, @ruledefs, @cache)
)
		end
	end
	private :schedule

	def die(msg)
		print("\n#{msg}\n\n")
		exit -1
	end

	def load(rulesfile)
		@ruledefs.load(rulesfile)
	end

	def export(target)
		file = target.relative_path_from(@outdir).to_s
		exprule = @ruledefs.exports(file).first
		schedule do |runner|
			die "no export rule for #{file.inspect} found" unless exprule
			runner.run_exprule(exprule, exprule.name(file), target)
		end
	end

	def export_matches(match)
		@ruledefs.targets(match).each do |file, exprule|
			schedule do |runner|
				runner.run_exprule(exprule, exprule.name(file), @outdir/file)
			end
		end
	end

	def export_all
		@ruledefs.targets.each do |file, exprule|
			schedule do |runner|
				runner.run_exprule(exprule, exprule.name(file), @outdir/file)
			end
		end
	end

	def rule(type, name)
		Runner.new(self, @ruledefs, @cache).get_rule_result(type, name, [])
	end

	def show_matches(match)
		@ruledefs.targets(match).map do |file, exprule|
			file
		end
	end

	def print(str)
		@progresslock.synchronize do
			yield if block_given?
			if STDOUT.tty?
				@winsize ||= IO.console.winsize
			end
			str.sub!(/^/, "\e[K") if STDOUT.tty?

			out = str
			if STDOUT.tty?
				num = [@progresses.size,@winsize[0]/2].min
				out += @progresses.to_a[0,num].map do |k, l|
					"\e[K         %s\r" % l
				end.join("\n")
				out += "\n...\r" if @progresses.size > @winsize[0]/2
				out += "\e[#{num-1}A" if num > 1
			end
			STDOUT.print out
			STDOUT.flush
		end
	end

	def report_progress(what)
		label = if RuleDefs::Rule === what
			return yield if !@time
			what.inspect
		else
			what.to_s
		end

		if STDOUT.tty?
			@winsize ||= IO.console.winsize
			label = label[0,@winsize[1]-9]
		end

		x = [label]

		@progresslock.synchronize do
			if @progresses.size <= @winsize[0]/2
				out  = "\n"*@progresses.size
				out += "         %s\r" % x
				out += "\e[#{@progresses.size}A" if @progresses.size > 0
				STDOUT.print out
				STDOUT.flush
			elsif @progresses.size == (@winsize[0]/2)+1
				n = @winsize[0]/2
				STDOUT.print "\e[#{n}B...\r\e[#{n}A"
				STDOUT.flush
			end
			@progresses[x.object_id] = x
		end if STDOUT.tty?

		r = nil
		msg = catch(:skip) do
			starttime = Time.now
			r = yield
			endtime = Time.now
			"%.2fs" % (endtime-starttime)
		end || "skip "

		print("%8s %s\n" % [msg, label]) do
			@progresses.delete(x.object_id)
		end

		r
	end

	class RuleDefs

		def initialize(analyzer, &run_rule)
			@analyzer = analyzer
			@run_rule = run_rule
			@ruledefs = Hash.new { |h,k| h[k] = [] }
			@data = {}
			@exports = []
			@gens = []
			@gathers = []
		end

		def load(rulesfile)
			src = ""
			block = nil

			begin
				rulesfile.read
			rescue Errno::ENOENT
				@analyzer.die "ruleset #{rulesfile.to_s.inspect} not found"
			end.split("\n").each_with_index do |line, i|
				next if !block && line.strip.empty?
				next if !block && line.start_with?("#") && !block

				keyword = line.split(/[ \t\n]/, 2)[0]
				src += line
				src += "\n"

				if !block
					if ["run", "data", "rule", "export", "gen", "gather"].include?(keyword)
						block = i
					else
						@analyzer.die("#{rulesfile.to_s}:#{i} unexpected keywoard #{keyword.inspect}")
					end
				end
				if block && ["end", "}"].include?(keyword)
					begin
						RuleDefEnv.new(self, src).instance_eval(src, rulesfile.to_s, block+1)
					rescue SyntaxError => e
						@analyzer.die e.message
					end
					src = ""
					block = nil
				end
			end

			@analyzer.die "#{rulesfile.to_s}: unfinished block  at end of file" if block
		end

		def gen(genrule, data)
			(@run_rule.call(genrule, data.name, []) ||[]).each do |newname, dsc|
				unless String === newname
					@analyzer.die(
						"#{genrule.inspect}:\n" +
						"data name must be String: #{newname.inspect}")
				end
				self << RuleDefs::DatRule.new(newname, dsc, [data] + data.gensrc)
			end
		end

		def gather(genrule, datas)
			(@run_rule.call(genrule, datas.map(&:name), []) ||[]).each do |newname, dsc|
				unless String === newname
					@analyzer.die(
						"#{genrule.inspect}:\n" +
						"data name must be String: #{newname.inspect}")
				end
				self << RuleDefs::DatGatherRule.new(newname, dsc, datas.map(&:gensrc).flatten.uniq)
			end
		end

		def <<(rule)
			case rule
			when IntRule
				@ruledefs[rule.type] << rule
			when DatRule
				return if @data[rule.name] == rule
				@data.delete(rule.name)
				@data[rule.name] = rule
				@gens.each do |genrule|
					next unless genrule.match(rule.name)
					gen(genrule, rule)
				end
				@gathers.each do |gatherrule|
					next unless gatherrule.match(rule.name)
					datas = []
					@data.values.each do |data|
						next unless gatherrule.match(data.name)
						datas << data
					end
					gather(gatherrule, datas) unless datas.empty?
				end
			when ExpRule
				@exports << rule
			when GenRule
				@gens << rule
				@data.values.each do |data|
					next unless rule.match(data.name)
					gen(rule, data)
				end
			when GatherRule
				@gathers << rule
				names = []
				@data.values.each do |data|
					next unless rule.match(data.name)
					names << data.name
				end
				gather(rule, names) unless names.empty?
			end
		end

		def rules(type, name, args)
			rules = Hash.new { |h,k| h[k] = [] }

			@ruledefs[type].each do |rule|
				score = rule.match(name, args)
				next unless score
				rules[score] << rule
			end

			rules.to_a.sort_by(&:first).map(&:last).flatten
		end

		def data(name)
			@data[name]
		end

		def exports(file=nil)
			exprules = Hash.new { |h,k| h[k] = [] }

			@exports.each do |exprule|
				score = exprule.match(file)
				next unless score
				exprules[score] << exprule
			end

			exprules.to_a.sort_by(&:first).map(&:last).flatten
		end

		def targets(match=nil)
			targets = Hash.new { |h,k| h[k] = [] }

			@data.values.each do |data|
				next if match && !data.matches(match)
				@exports.each do |exprule|
					file = data.name + exprule.ext
					score = exprule.match(file)
					next unless score
					targets[file] << [exprule, score]
				end
			end

			targets.map { |file, rules| [file, rules.min_by(&:last).first ] }
		end

		class Rule

			def self.match(match, name)
				case match
				when String
					(
					match == name ||
					(match.end_with?("-") && name.start_with?(match)) ||
					(match.end_with?(".") && name.start_with?(match)) ||
					(match.start_with?("*") && name.end_with?(match[1..-1])) ||
					false) && match.size
				when Regexp
					name =~ match && $~.to_s.size
				end
			end

			def csum
				return @csum[0] if @csum

				dumped = begin
					Marshal.dump(csum_data)
				rescue TypeError
				end
				@csum = [if dumped
					Digest::SHA256.hexdigest(dumped)
				end]

				return @csum[0]
			end

		end

		class IntRule < Rule

			attr_reader :type
			attr_reader :block

			def initialize(type, match, src, block)
				@type = type
				@match = match.first
				@src = src
				@block = block
			end

			def cacheable?
				true
			end

			def inspect
				"(rule #{@type.inspect}, #{@match.inspect}, #{block.source_location.join(":")})"
			end

			def csum_data
				[@type, @match, @src]
			end

			def match(name, args)
				size = self.class.match(@match, name)
				return unless size
				params = Hash.new { |h,k| h[k] = 0 }.merge @block.parameters.map(&:first).tally
				return if params[:req] > args.size
				return if params[:rest]==0 && params[:req] + params[:opt] < args.size
				[-size, -params[:req], params[:opt]]
			end

		end

		class DatRule < Rule

			attr_reader :name
			attr_reader :gensrc

			def initialize(name, dsc, gensrc=[])
				@name = name
				@dsc = dsc
				@gensrc = gensrc.sort.uniq
			end

			def inspect
				"(data #{name}, {..})"
			end

			def csum_data
				[@name, @dsc]
			end

			def ==(o)
				self.class  == o.class &&
				self.name   == o.name  &&
				self.gensrc == o.gensrc &&
				@dsc.keys.all? { |k| self[k] == o[k] }
			end

			def <=>(o)
				self.name <=> o.name
			end

			def [](key)
				@dsc[key.to_sym]
			end

			def matches(match)
				self.class.match(match, @name) or
				gensrc.any? { |g| g.matches(match) }
			end

		end

		class DatGatherRule < DatRule

			def inspect
				"(gather #{name}, {..})"
			end

			def matches(match)
				self.class.match(match, @name) or
				gensrc.all? { |g| g.matches(match) }
			end

		end

		class ExpRule < Rule

			attr_reader :block
			attr_reader :ext

			def initialize(ext, match, src, block)
				@ext = ext
				@match = match
				@src = src
				@block = block
			end

			def cacheable?
				true
			end

			def inspect
				"(export #{@match.inspect}, #{@block.source_location.join(":")})"
			end

			def csum_data
				[@ext, @match, @src]
			end

			def match(file)
				return unless file.end_with?(@ext)
				size = self.class.match(@match, file[0..-@ext.size-1])
				return unless size
				[-@ext.size, -size]
			end

			def name(file)
				file[0..(-1-@ext.size)]
			end

		end

		class GenGather < Rule

			attr_reader :block

			def initialize(match, block)
				@match = match
				@block = block
			end

			def cacheable?
				false
			end

			def match(name)
				self.class.match(@match, name)
			end

		end

		class GenRule < GenGather
			def inspect
				"(gen #{@match.inspect}, #{@block.source_location.join(":")})"
			end
		end

		class GatherRule < GenGather
			def inspect
				"(gather #{@match.inspect}, #{@block.source_location.join(":")})"
			end
		end

		class RuleDefEnv

			def initialize(defs, src)
				@defs = defs
				@src = src
			end

			def run
				yield
			end

			def rule(type, *match, &block)
				@defs << IntRule.new(type, match, @src, block)
			end

			def data(name, dsc={})
				@defs << DatRule.new(name, dsc)
			end

			def export(ext, match, &block)
				@defs << ExpRule.new(ext, match, @src, block)
			end

			def gen(match, &block)
				@defs << GenRule.new(match, block)
			end

			def gather(match, &block)
				@defs << GatherRule.new(match, block)
			end

		end
	end

	class Cache

		def initialize(analyzer, ruledefs)
			@analyzer = analyzer
			@ruledefs = ruledefs
			@files = {}
			@cache = Hash.new { |h,k| h[k] = [] }
			@lock = Mutex.new
			@locks = Hash.new { |h,k| h[k] = Mutex.new }
		end

		def filename(rule, name, args)
			m = begin
				Marshal.dump(describe_rule(rule, name, args))
			rescue TypeError
				m
			end
			return unless m
			s = Digest::SHA256.hexdigest(m)
			@analyzer.outdir / ".adcache" / s[0..1] / s[2..-15]
		end
		private :filename

		def mtime(file)
			mtime = @files[file]
			return mtime if mtime
			update_mtime(file)
		end

		def update_mtime(file)
			mtime = begin
				file.mtime
			rescue Errno::ENOENT
				return nil
			end
			@files[file] = mtime
			mtime
		end

		def describe_rule(rule, name, args)
			case rule
			when RuleDefs::IntRule
				[:intrule, rule.type, name, args, rule.csum]
			when RuleDefs::ExpRule
				[:exprule, rule.ext, name, rule.csum]
			else
				raise NotImplementedError
			end
		end
		private :describe_rule

		def check_rule(desc)
			return false unless
				Array === desc &&
				desc.size >= 3
			ruletype = desc.shift
			result_csum = desc.pop
			rule_csum = desc.pop

			rule = case ruletype
			when :intrule
				return false unless
					desc.size == 3 &&
					Symbol === desc[0] &&
					String === desc[1] &&
					Array === desc[2]
				type, name, args = desc
				@ruledefs.rules(type, name, args).first
			when :exprule
				return false unless
					desc.size == 2 &&
					String === desc[0] &&
					String === desc[1]
				ext, name = desc
				@ruledefs.exprule(ext, name).first
			else
				return false
			end

			return false unless
				rule &&
				rule_csum == rule.csum
			!!get(rule, name, args, result_csum)
		end
		private :check_rule

		def describe_data(data)
			[data.name, data.csum]
		end
		private :describe_data

		def check_data(desc)
			return false unless
				Array === desc &&
				desc.size == 2 &&
				String === desc[0]
			data = @ruledefs.data(desc[0])
			return false unless data
			desc[1] == data.csum
		end
		private :check_data

		def load(rule, name, args)
			return unless rule.cacheable?
			filename = filename(rule, name, args)
			return unless filename
			raw = begin
				filename.read
			rescue Errno::ENOENT
			end
			return unless raw
			loaded = begin
				Marshal.load(raw)
			rescue TypeError, ArgumentError
			end
			return unless loaded
			return unless loaded[:rule] == describe_rule(rule, name, args)
			return unless Array === loaded[:files]
			return unless loaded[:files].all? do |f,mtime|
				String === f && mtime
				mtime(Pathname.new(f)) == mtime
			end
			return unless Array === loaded[:datas]
			return unless loaded[:datas].all? do |desc|
				check_data(desc)
			end
			return unless Array === loaded[:rules]
			return unless loaded[:rules].all? do |desc|
				check_rule(desc)
			end
			return unless loaded.has_key?(:result)

			[loaded[:result], filename.mtime]
		end
		private :load

		def store(rule, name, args, result, entry)
			return unless rule.cacheable?
			filename = filename(rule, name, args)
			return unless filename
			dump = {
				rule:   describe_rule(rule, name, args),
				files:  entry.files.map { |f| [f.to_s, mtime(f)] },
				rules:  entry.rules.map { |r, rcsum| describe_rule(*r)+[rcsum] },
				datas:  entry.datas.map { |d| describe_data(d) },
				result: result,
			}
			raw = begin
				Marshal.dump(dump)
			rescue TypeError
			end
			return unless raw 
			begin
				filename.write(raw)
			rescue Errno::ENOENT
				filename.dirname.mkpath
				filename.write(raw)
			end
			filename.mtime
		end
		private :store

		def locked(rule, name, args, &block)
			container, lock = @lock.synchronize do
				[
					@cache[[rule, name, args]],
					@locks[[rule, name, args]]
				]
			end

			lock.synchronize do
				yield(container)
			end
		end
		private :locked

		def get(rule, name, args, rcsum)
			locked(rule, name, args) do |container|
				if container.size > 0
					if container[1] && container[1] == rcsum
						break [container[0], container[1]]
					else
						break
					end
				end

				result, loaded_rcsum = load(rule, name, args)
				break unless loaded_rcsum

				container.push(result, loaded_rcsum)
				break if loaded_rcsum != rcsum

				[container[0], container[1]]
			end
		end

		def get_or_update(rule, name, args, &block)
			locked(rule, name, args) do |container|
				break [container[0], container[1]] if container.size > 0

				result, rcsum = load(rule, name, args)

				unless rcsum
					result, entry = yield
					rcsum = store(rule, name, args, result, entry)
				end
				container.push(result, rcsum)

				[container[0], container[1]]
			end
		end

	end

	class Runner

		class Stack

			class Entry

				def initialize(name, rule)
					@name = name
					@files = {}
					@rules = {}
					@datas = {}
				end

				attr_reader :name

				def files
					@files.keys
				end

				def add_file(file)
					@files[file] = true
				end

				def rules
					@rules.to_a
				end

				def add_rule(rule, name, args, rcsum)
					@rules[[rule, name, args]] =  rcsum
				end

				def add_data(data)
					@datas[data] = true
				end

				def datas
					@datas.keys
				end

			end

			def initialize
				@stack = []
			end

			def push(name, rule)
				@stack << Entry.new(name, rule)
				nil
			end

			def pop
				@stack.pop
			end

			def name
				@stack[-1].name
			end

			def files
				@stack[-1].files
			end

			def add_file(file)
				return unless @stack.size > 0
				@stack[-1].add_file(file)
			end

			def add_rule(rule, name, args, rcsum)
				return unless @stack.size > 0
				@stack[-1].add_rule(rule, name, args, rcsum)
			end

			def add_data(data)
				return unless @stack.size > 0
				@stack[-1].add_data(data)
			end

		end

		def initialize(analyzer, ruledefs, cache)
			@analyzer = analyzer
			@ruledefs = ruledefs
			@stack = Stack.new
			@cache = cache
		end

		def run_rule(rule, name, args)
			@cache.get_or_update(rule, name, args) do 
				@stack.push(name, rule)
				result = @analyzer.report_progress(rule) do
					RunEnv.run(self, rule, args)
				end
				[result, @stack.pop]
			end
		end

		def get_rule_result(type, name, args)
			rules = @ruledefs.rules(type, name, args)
			@analyzer.die "no rules for #{type.inspect}, #{name.inspect}, #{args.inspect}" if rules.empty?
			rule = rules.first
			result, rcsum = run_rule(rule, name, args)
			@stack.add_rule(rule, name, args, rcsum)
			result
		end

		def get_data(name)
			data = @ruledefs.data(name)
			raise "no data for #{name.inspect}" unless data
			@stack.add_data(data)
			data
		end

		def run_exprule(exprule, name, target)
			@analyzer.report_progress(target) do
				run = false
				@cache.get_or_update(exprule, name, []) do
					run = true
					@stack.push(name, exprule)
					result = RunEnv.run(self, exprule, [])
					target.write(result)
					@cache.update_mtime(target)
					@stack.add_file(target)
					[result, @stack.pop]
				end
				throw :skip unless run
			end
		end

		def current_name
			@stack.name
		end

		def get_basefilename(file)
			get_filename(@analyzer.basedir / file)
		end

		def get_datafilename(file)
			get_filename(@analyzer.datadir / file)
		end

		def get_filename(file)
			@stack.add_file(file)
			file.to_s
		end

		def die(msg)
			@analyzer.die(msg)
		end

		def debug(msg)
			@analyzer.print(msg)
		end

		class RunEnv

			def self.run(runner, rule, args)
				begin
					env = RunEnv.new(runner)
					env.instance_exec(*args, &rule.block)
				rescue SystemExit
					raise

				rescue Interrupt
					runner.die("interrupted in #{rule.inspect} for #{runner.current_name}, #{args.inspect}")
					exit -1
				rescue Exception => e
					runner.die(
						"Exception in #{rule.inspect} for #{runner.current_name}, #{args.inspect}\n" +
					e.backtrace[0..-caller.size-2].each_with_index.to_a.reverse.map do |l, i|
						"\t#{i} from #{l}\n"
					end.join +
					"#{e.message} (#{e.class})")
				end
			end

			def initialize(runner)
				@runner = runner 
			end

			def name
				name = @runner.current_name
				raise "no single name available" unless String === name
				name
			end

			def names
				name = @runner.current_name
				raise "no multiple names available" unless Array === name
				name
			end

			def rule(rule, name=nil, *args)
				name ||= @runner.current_name
				name = name.to_s
				rule = rule.to_sym
				@runner.get_rule_result(rule, name, args)
			end

			def data(name=nil)
				name ||= @runner.current_name
				name = name.to_s
				@runner.get_data(name)
			end

			def datafile(name=nil)
				name ||= @runner.current_name
				@runner.get_datafilename(name)
			end

			def basefile(name)
				@runner.get_basefilename(name)
			end

			def popen(*cmd)
				rio, wio = IO.pipe
				pid = Process.spawn({}, *cmd, {
					0 => "/dev/null",
					1 => wio,
					close_others: true})
				wio.close
				result = rio.read
				rio.close
				Process.wait(pid)
				raise "popen failed" unless $?.success?
				result
			end

			def debug(fmt, *args)
				str = case
				when String === fmt && args.size > 0
					fmt % args
				when String === fmt
					fmt
				else
					fmt.inspect
				end
				@runner.debug("DEBUG(#{caller_locations(1,1)[0].lineno}): #{str}\n")
			end

		end

	end

end

require "trollop"

opts = Trollop::options do
	banner "usage: #{$0} <ruleset> [target...]"
	opt :datadir, "read data from directory", default: ""
	opt :outdir, "write output to directory", default: ""
	opt :ruleset, "additional ruleset file", type: :string, multi: true
	opt :time
	opt :rule, "show rule result", type: :strings, short: :r
	opt :matches, "show matches", type: :strings, short: :m
	opt :threads, "number of parallel threads", default: Etc.nprocessors
end

Trollop::die("no ruleset given") unless ARGV.size >= 1

base = Pathname.new($0).dirname.dirname
rulesfile = Pathname.new(ARGV.shift)
targets = ARGV.to_a

begin
	analyzer = Analyzer.new
	analyzer.basedir = Pathname.new(base)
	analyzer.outdir = Pathname.new(opts[:outdir])
	analyzer.datadir = Pathname.new(opts[:datadir])
	analyzer.time = opts[:time]
	analyzer.load(rulesfile)
	opts[:ruleset].each do |r|
		analyzer.load(Pathname.new(r))
	end
	analyzer.threads = opts[:threads] if opts[:threads] > 0

	done = false

	(opts[:rule] || []).each do |r|
		type, name = r.split(":", 2)
		puts analyzer.rule(type.to_sym, name).inspect
		done = true
	end

	(opts[:matches] || []).each do |m|
		puts analyzer.show_matches(m)
		done = true
	end

	targets.each do |target|
		path = Pathname.new(target)
		if analyzer.outdir.each_filename.to_a == path.each_filename.to_a[0,analyzer.outdir.each_filename.to_a.size]
			analyzer.export(path)
		else
			analyzer.export_matches(target)
		end
		done = true
	end

	analyzer.export_all() unless done

	analyzer.wait
rescue Interrupt
	STDERR.puts "interrupted"
	exit -1
end
