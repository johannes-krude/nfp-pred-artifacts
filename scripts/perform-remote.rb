#!/usr/bin/ruby

require "trollop"
require "pathname"
require "json"
require "singleton"

class Dispatcher

	include Singleton

	def initialize
		@read_ios  = Hash.new
		@write_ios = Hash.new
		@error_ios = Hash.new
		@children = Hash.new
		@stati = Hash.new
		@waitpid_status = :stopped
	end

	def on_readable(io, &block)
		raise unless io
		@read_ios[io] = block
		@error_ios[io] = block
	end

	def on_writable(io, &block)
		raise unless io
		@write_ios[io] = block
		@error_ios[io] = block
	end

	def on_error(io, &block)
		@error_ios[io] = block
	end

	def on_chld(pid, &block)
		status = @stati[pid]
		if status
			@stati.delete(pid)
			block.call(status)
		else
			@children[pid] = block
			run_waitpid
		end
	end

	def inspect
		exit -1 if caller.size >= 100
		(
			@read_ios.map do |io, block|
				[io.closed? ? :closed : io.to_i, block]
			end.map do |io, block|
				next if block.binding.receiver == self
				"on_readable #{io}: #{block.binding.receiver.inspect}"
			end.compact +
			@write_ios.map do |io, block|
				[io.closed? ? :closed : io.to_i, block]
			end.map do |io, block|
				next if block.binding.receiver == self
				"on_writable #{io}: #{block.binding.receiver.inspect}"
			end +
			@error_ios.map do |io, block|
				[io.closed? ? :closed : io.to_i, block]
			end.map do |io, block|
				next if block.binding.receiver == self
				next if @read_ios.has_key?(io)
				next if @write_ios.has_key?(io)
				"on_error #{io}: #{block.binding.receiver.inspect}"
			end.compact +
			@children.map do |pid, block|
				"on_chld #{pid}: #{block.binding.receiver.inspect}"
			end +
			["waitpid: #{@waitpid_status}"]
		).join("\n")
	end

	def run_waitpid
		if @w2
			@w2.write_nonblock("x")
			return
		end
		status = []
		r, w = IO.pipe
		r2, @w2 = IO.pipe
		Thread.new do
			begin
				loop do
					begin
						@waitpid_status = :waiting
						pid = Process.waitpid
						status << [pid, $?]
						w.write("x")
					rescue Errno::ECHILD
						begin
							r2.read_nonblock(1)
						rescue Errno::EAGAIN
							@waitpid_status = "idle #{status.inspect} #{@stati.inspect}"
							r2.read(1)
						end
					end
				end
			ensure
				@waitpid_status = :exited
				w.close
			end
		end
		on_readable(r) do
			begin
				r.read(1)
				pid, s = status.shift
				if @waitpid_status.to_s.start_with?("idle ")
					@waitpid_status = "idle #{status.inspect} #{@stati.inspect}"
				end
				block = @children[pid]
				if block
					@children.delete(pid)
					block.call(s) if block
				else
					@stati[pid] = status
				end
			rescue EOFError
				raise "waitpid thread died"
			end
		end
	end

	def forget(io)
		@read_ios.delete(io)
		@write_ios.delete(io)
		@error_ios.delete(io)
	end

	def dispatch(timeout=nil)
		readable, writable, error = begin
			IO.select(@read_ios.keys, @write_ios.keys, @error_ios.keys, 0) or
			(
				GC.start
				IO.select(@read_ios.keys, @write_ios.keys, @error_ios.keys, timeout)
			)
		rescue IOError => e
			[@read_ios, @write_ios, @error_ios].map(&:to_a).inject(&:+).each do |io, block|
				raise "closed io(#{io.object_id}): #{block.binding.receiver.inspect}" if io.closed?
			end
			raise e
		rescue Errno::EINTR
			retry
		end
		return :timeout if readable.nil?
		error.each do |io|
			block = @error_ios[io]
			block.call if block
		end
		readable.each do |io|
			block = @read_ios[io]
			block.call if block
		end
		writable.each do |io|
			block = @write_ios[io]
			block.call if block
		end
		nil
	end

	def wait(timeout=nil)
		until yield
			return if dispatch(timeout)
		end
	end

end

class StrVec

	def initialize(v=[])
		raise "invalid encoding" unless v.map(&:last).all? { |s| s.encoding  == Encoding::ASCII_8BIT }
		@v = v
		@size = v.map(&:first).map(&:size).inject(0,&:+)
	end

	attr_reader :size

	def empty?
		@size == 0
	end

	def clear
		@v = []
		@size = 0
	end

	def each(&block)
		@v.each(&block)
	end

	def [](range)
		first = range.first
		last = range.last
		v = []
		@v.each do |r, s|
			if r.size < first
				first -= r.size
				last -= r.size
				next
			end
			if r.size > last
				v << [(r.first..r.first+last), s]
				break
			end
			v << [r, s]
		end
		self.class.new(v)
	end

	def <<(o)
		return self if o.empty?
		case o
		when String
			raise "invalid encoding" unless o.encoding == Encoding::ASCII_8BIT
			@v << [(0..o.size-1), o]
			@size += o.size
		when StrVec
			o.each do |r, s|
				raise "invalid encoding" unless s.encoding == Encoding::ASCII_8BIT
				@v << [r, s]
				@size += r.size
			end
		else
			raise "invalid encoding" unless o[1].encoding == Encoding::ASCII_8BIT
			@v << o
			@size += o[0].size
		end
		self
	end

	def shift(i=nil)
		unless i
			r, s = @v.shift
			@size -= r.size
			return [r, s]
		end
		v = []
		while i > 0
			raise if @v.empty?
			r, s = @v.shift
			if r.size > i
				v << [(r.first..r.first+i-1), s]
				@v.unshift([(r.first+i..r.last), s])
				@size -= i
				break
			end
			v << [r, s]
			i -= r.size
			@size -= r.size
		end
		self.class.new(v)
	end

	def index(str)
		i = 0
		@v.each do |r,s|
			n = s.index(str, r.first)
			return i+n-r.first if n && n <= r.last+1-str.size
			i += r.size
		end
		nil
	end

	def write_to(io)
		until @v.empty?
			r, s = @v[0]
			size = if r.first == 0 && r.last == s.size-1
				io.write(s)
			else
				io.write(s[r])
			end
			shift(size)
		end
		io.flush
	end

	def write_nonblock_to(io)
		until @v.empty?
			r, s = @v[0]
			size = if r.first == 0 && r.last == s.size-1
				io.write_nonblock(s)
			else
				io.write_nonblock(s[r])
			end
			shift(size)
		end
	end

	def to_s
		@v.map { |r, s| s[r] }.join
	end

	def to_i(base=10)
		to_s.to_i(base)
	end

	def inspect
		to_s.inspect
	end

end

class AsyncIO

	def initialize(input, output=input, error=nil)
		@input = input
		@error = error
		@output = output
		@input_eof = false
		@error_eof = false
		@output_eof = false
		@dispatcher = Dispatcher.instance
		@on_free = []
		@ibuf = StrVec.new
		@ebuf = StrVec.new
		@obuf = StrVec.new
		activate_input if input
		activate_error if error
	end

	def debug(level, fmt, *v)
		return if $debug < level
		msgs = fmt % v
		msgs.split("\n").each do |msg|
			STDERR.puts "DEBUG %s" % msg
		end
	end

	def inspect
		input_i, error_i, output_i = [@input, @error, @output].map do |io|
			next unless io
			io.closed? ? :closed : io.to_i
		end

		"input:#{input_i} ibuf:#{@ibuf.size}#{@ibuf[0..31].to_s.inspect} eof:#{eof?} "+
		if @error
			"err:#{error_i} ebuf:#{@ebuf.size}#{@ebuf[0..31].to_s.inspect} erreof:#{erreof?} "
		end.to_s +
		"output:#{output_i} obuf:#{@obuf.size}#{@obuf[0..31].to_s.inspect} closed:#{closed?}"
	end

	def buffer_size
		65536
	end

	def queue_size
		buffer_size * 64
	end

	def eof?
		@input_eof
	end

	def erreof?
		@error_eof
	end

	def eof
	end
	private :eof

	def erreof
	end
	private :erreof

	def closed?
		@output_eof
	end

	def close
		@output_eof = true
		if @obuf.empty? and STDOUT != @output
			begin
				@output.close_write
			rescue IOError
			end
			deactivate_output
		end
	end
	protected :close

	def activate_input
		unless @input.closed? || @input_eof
			@dispatcher.on_readable(@input) { read_input }
		end
		input(@ibuf) if @ibuf.size > 0
		eof if @input_eof && @ibuf.empty?
	end

	def deactivate_input
		@dispatcher.forget(@input)
	end

	def activate_error
		unless @error.closed? || @error_eof
			@dispatcher.on_readable(@error) { read_error }
		end
		error(@ebuf) if @ebuf.size > 0
		erreof if @error_eof && @ebuf.empty?
	end

	def deactivate_error
		@dispatcher.forget(@error)
	end

	def activate_output
		return if @output.closed?
		@dispatcher.on_writable(@output) { write_output }
	end

	def deactivate_output
		@dispatcher.forget(@output)
	end

	def congested?
		@obuf.size > queue_size
	end

	def on_free(&block)
		@on_free << block
	end

	def read_input
		begin
			@ibuf << @input.sysread(buffer_size-@ibuf.size)
		rescue Errno::EINTR
			retry
		rescue EOFError
			deactivate_input
			@input.close_read unless STDIN === @input
			@input_eof = true
			eof if @ibuf.empty?
		end
		input(@ibuf) if @ibuf.size > 0
	end
	private :read_input

	def read_error
		begin
			@ebuf << @error.sysread(buffer_size-@ibuf.size)
		rescue Errno::EINTR
			retry
		rescue EOFError
			deactivate_error
			@error.close_read unless STDERR === @error
			@error_eof = true
			erreof if @ebuf.empty?
		end
		error(@ebuf) if @ebuf.size > 0
	end
	private :read_error

	def write_output
		begin
			@obuf.write_nonblock_to(@output)
		rescue Errno::EINTR
			retry
		rescue IO::WaitWritable
		rescue Errno::EPIPE
			@obuf.clear
			close
		end
		until congested? || @on_free.empty?
			@on_free.shift.call
		end
		deactivate_output if @obuf.empty?
		if @output_eof and @obuf.empty? and STDOUT != @output
			begin
				@output.close_write
			rescue IOError
			end
			deactivate_output
		end
	end
	private :write_output

	def <<(buf)
		@obuf << buf
		activate_output
	end
	protected :<<

end

class ExternalFilter < AsyncIO

	def initialize(cmd, master, opts={})
		@cmd = [cmd].flatten
		@master = master
		case opts[:out]
		when Array
			stdout = [opts[:out][0], opts[:out][1]||"w"]
			out = nil
		else
			@out = opts[:out]
			out, stdout = IO.pipe
		end
		stdin, io = IO.pipe
		err, stderr = IO.pipe
		@pid = Process.spawn(*@cmd,
			:in => stdin,
			:out => stdout,
			:err => stderr,
			:pgroup => true,
		)
		stdin.close
		stderr.close
		stdout.close if IO === stdout
		super(out, io, err)
		@dispatcher.on_chld(@pid) { |s| @status = s }
	end

	attr_reader :pid, :status

	def input(buf)
		@out << buf if buf
		buf.clear
	end
	private :input

	def eof
		@out.close
	end
	private :eof

	def error(buf)
		msgs = buf.to_s.split("\n", -1)
		msgs.pop
		msgs.each do |msg|
			@master.log("ERROR: %s", msg, error: true)
			buf.shift(msg.size+1)
		end
	end
	private :error

	def erreof
		unless @ebuf.empty?
			@master.log("ERROR: %s", @ebuf.to_s, error: true)
			@ebuf.clear
		end
	end
	private :erreof

	public :<<, :close

	def puts(msg)
		self << msg.b
		self << "\n".b
	end

	def wait
		@dispatcher.wait { @status }
		@out.wait if @out
	end

	def inspect
		"#{@cmd.join(" ")} #{super}"
	end

end

class TarWriter

	def initialize(path, master, mode_append=false)
		@master = master
		@output = path.open(mode_append ? "r+" : "w")
		if mode_append
			@output.seek(-1024, :END)
			@master.die "existing tar file not \"\\0\"*1024 padded" unless @output.read(1024) == "\0"*1024
			@output.seek(-1024, :END)
		end
		@master.die "tar output is tty" if @output.tty?
	end

	def tar_header(filename, filesize, type = "0", time = Time.now)
		@master.die "filesize too long for tar" if filesize > 8**11 - 1
		if filename.size > 100
			return "" +
				tar_header("././@LongLink", filename.size, "L", time) +
				filename +
				("\0"*(512-((filename.size-1)%512)-1)) +
				tar_header(filename[0..99], filesize, type, time)
		end
		hdr = 
		[[filename, 100],     # File Name
		 [0444, 8],           # File mode
		 [nil, 8],            # Owner's numeric user ID
		 [nil, 8],            # Group's numeric user ID
		 [filesize, 12],      # File size in bytes
		 [time.to_i, 12],     # Last modification time in numeric Unix time format
		 ["        ", 8],     # Checksum for header record
		 [type, 1],           # Link indicator (file type)
		 [nil, 100],          # Name of linked file
		 #["ustar", 6],       # UStar indicator
		 #["00", 2],          # UStar version
		 #[nil, 32],          # Owner user name
		 #[nil, 32],          # Owner group name
		 #[nil, 8],           # Device major number
		 #[nil, 8],           # Device minor number
		 #[prefix, 155],      # Filename prefix
		].map do |f, s|
			case f
			when nil
				"\0" * s
			when String
				f.ljust(s, "\0")
			when Integer
				f.to_s(8).rjust(s-1, "0").ljust(s, "\0")
			else
				raise
			end
		end.join.ljust(512, "\0")
		csum = hdr.bytes.inject(&:+)
		hdr[148,8] = csum.to_s(8).rjust(7, "0").ljust(8, "\0")
		return hdr
	end

	def write(filename, content)
		size = content.size
		@output.write(tar_header(filename, size))
		content.write_to(@output)
		@output.write("\0"*(512-((size-1)%512)-1))
	end

	def close
		@output.write("\0"*1024)
		@output.close
	end

	def closed?
		@output.closed?
	end

end

class IOLambda

	def initialize(&block)
		@block = block
	end

	def <<(buf)
		@block.call(buf)
	end

	def close
		@block.call(:eof)
	end

	def wait
	end

	def inspect
		"iolambda #{@block.binding.receiver.inspect}"
	end

end

def iolambda(&block)
	IOLambda.new(&block)
end

class EachLine
	def initialize(&block)
		@buf = StrVec.new
		@block = block
		@closed = false
		@running = false
	end

	def invoke
		return if @running
		begin
			@running = true
			while i = @buf.index("\n")
				@block.call(@buf.shift(i+1).to_s)
			end
			if @closed
				@block.call(@buf.to_s) unless @buf.empty?
				@buf = StrVec.new
			end
		ensure
			@running = false
		end
	end

	def <<(buf)
		@buf << buf
		invoke
	end

	def close
		@closed = true
		invoke
	end

	def wait
	end

	def inspect
		"eachline #{@block.binding.receiver.inspect}"
	end
end

def eachline(&block)
	EachLine.new(&block)
end

class Communicator < AsyncIO

	def self.msg_raw_arg(op, argnum)
		define_method(:"msg_raw_arg_#{argnum}_#{op}") { true }
	end

	def input(buf)
		loop do
			return if buf.empty?
			raise "incomplete msg %s" % buf.inspect if buf.size < 4 && eof?
			return if buf.size < 4
			msg_size = buf[0..3].to_i(16)
			raise "invalid msg %s" % buf[0..3].inspect if msg_size < 4
			raise "incomplete msg(%i) %s" % [msg_size, buf.inspect] if buf.size < msg_size && eof?
			return if buf.size < msg_size
			msg = buf.shift(msg_size)
			msg.shift(4)
			raise "invalid msg %s" % msg.inspect if msg.size < 4
			nr_args = msg.shift(4).to_i(16)
			raise "invalid msg %s" % msg.inspect if nr_args < 1
			args = nr_args.times.map do |i|
				raise "invalid msg %s" % msg.inspect if msg.size < 4
				arg_size = msg.shift(4).to_i(16)
				raise "invalid msg %s" % msg.inspect if msg.size < arg_size
				msg.shift(arg_size)
			end
			recv_msg(args.shift.to_s, *args)
		end
	end
	private :input

	def recv_msg(op, *args)
		begin
			handler = method(:"msg_handler_#{op}")
		rescue NameError
			raise "unknown msg op %s" % op.inspect
		end
		unless args.size == handler.arity
			raise "wrong number of msg args %s != %s for %s" % [args.size, handler.arity, op.inspect]
		end
		args = args.each_with_index.map do |a, i|
			if respond_to?(:"msg_raw_arg_#{i+1}_#{op}")
				a
			else
				JSON.load(a.to_s)
			end
		end
		debug(2, "#{@dst} rcv: %s %s", op.inspect, args.inspect)
		handler.call(*args)
	end

	def send_msg(op, *args)
		debug(2, "#{@dst} snd: %s %s", op.inspect, args.inspect)
		msg = StrVec.new
		msg << "%04x".b % (1 + args.size)
		msg << "%04x".b % op.size
		msg << op.to_s.b
		args.each do |a|
			a = a.to_json.b unless StrVec === a
			msg << "%04x".b % a.size
			msg << a
		end
		self << "%04x".b % [msg.size+4]
		self << msg
	end

end

class Master

	def self.perform(task, path, connections, args, name, logdir=nil, postfix=nil, mode_append=false)
		Signal.trap(:SIGINT) do
			STDERR.puts "interrupted"
			raise Interrupt
		end
		Signal.trap(:SIGUSR1) do
			STDERR.puts Dispatcher.instance.inspect
			STDERR.puts caller
		end
		Signal.trap(:SIGHUP, "IGNORE")
		begin
			master = self.new(connections, args, name, logdir, postfix, mode_append)
		rescue Interrupt
			exit -1
		end
		begin
			Signal.trap(:SIGUSR1) do
				master.debug(0, "%s", master.inspect)
				master.connections.each do |c|
					master.debug(0, "%s", c.inspect)
					c.remotes.each do |r|
						master.debug(0, "%s", r.inspect)
					end
				end
				master.debug(0, Dispatcher.instance.inspect)
				caller.each do |c|
					master.debug(0, "%s", c)
				end
			end
			master.run(task, path.to_s)
		rescue Interrupt
			master.cleanup
			master.wait
			master.die
		end
		master.cleanup
		master.wait
		Signal.trap(:SIGUSR1, :DEFAULT)
	end

	def initialize(connections, args, name, logdir=nil, postfix=nil, mode_append=false)
		@args = args
		@name = name
		@status = [:idle]
		@progress = ""
		@mode_append = mode_append
		@dispatcher = Dispatcher.instance
		case logdir
		when nil
		when "-"
			@logdir = "-"
		else
			@logdir = logdir
			@postfix = "-#{postfix}" if postfix
			@logio = ExternalFilter.new("bzip2", self, out: [@logdir+"#{@name}#{@postfix}.log.bz2", @mode_append ? "a" : "w"])
		end
		@connections = connections.map { |d| Connection.new(d, self) }
	end

	def run(task, path)
		@status.push(:running)
		log("Executing #{path} on #{@connections.map(&:dst).inspect} with #{@args.inspect}")
		instance_eval(task, path)
		@status.pop
	end

	def cleanup
		@connections.each do |c|
			c.close
		end
		@cleanup = true
		if $verbose and STDOUT.tty? and not @progress.empty?
			STDOUT.print "\n"
			@progress = ""
		end
	end

	def wait
		@status.push(:waiting)
		@dispatcher.wait { @connections.all?(&:eof?) }
		@connections = []
		@dataio.close if @dataio
		if @logio
			@logio.close
			@logio.wait
		end
		@status.pop
	end

	def inspect
		"master: #{@status.last}"
	end

	def puts(msg)
		print("\r#{" "*@progress.size}\r") if $verbose and STDOUT.tty?
		STDOUT.puts msg
		if $verbose and STDOUT.tty?
			STDOUT.print @progress
			STDOUT.flush
		end
	end

	def log(fmt="", *v)
		opts = Hash === v.last ? v.pop : {}
		msg = (fmt % v).chomp
		print("\r#{" "*@progress.size}\r") if $verbose and STDOUT.tty?
		if opts[:error]
			STDERR.puts msg
		elsif $verbose
			STDOUT.puts msg
		end
		if $verbose and STDOUT.tty?
			STDOUT.print @progress
			STDOUT.flush
		end
		begin
			@logio.puts msg if @logio
		rescue IOError
		end
	end

	def progress(fmt="", *v)
		return unless $verbose and STDOUT.tty?
		return if @cleanup
		opts = Hash === v.last ? v.pop : {}
		msg = fmt % v
		return if msg == @progress
		STDOUT.print("\r#{" "*@progress.size}\r#{msg}")
		STDOUT.flush
		if opts[:permanent]
			STDOUT.puts
			@progress = ""
		else
			@progress = msg
		end
	end

	def die(fmt=nil, *v)
		log("ERROR #{fmt}", *v) if fmt
		exit(-1)
	end

	def debug(level, fmt, *v)
		return if $debug < level
		msgs = fmt % v
		msgs.split("\n").each do |msg|
			log("DEBUG %s", msg, error: true)
		end
	end

	def connections(range=0..1.0/0)
		range = (range..range) if Integer === range
		unless range === @connections.size
			die("invalid number of connections, expected #{range.inspect}")
		end
		case range.last
		when 0
			nil
		when 1
			@connections[0]
		else
			@connections
		end
	end

	def usage(*v)
	end

	def args
		@args || die("no argument syntax specified")
	end

	def local
		@local ||= (
			connection = Connection.new(nil, self)
			@connections << connection
			connection
		)
	end

	class Appendor
	
		def initialize(io)
			@io = io
		end

		def <<(buf)
			@io << buf
		end

		def close
			@io.waiting if @io.respond_to?(:waiting)
		end

		def wait
		end

	end

	class Logger

		def initialize(master)
			@master = master
		end

		def <<(buf)
			@master.log "%s", buf
		end

		def close
		end

		def wait
		end

	end

	class Collector
	
		def initialize(io, master, opts = {})
			@io = io
			@master = master
			@out = nil
			@data_size = 0
			@logging = opts[:log]
			@master.progress("Receiving data: waiting")
		end

		attr_writer :out

		def <<(buf)
			if String === buf && buf.encoding != Encoding::ASCII_8BIT
				buf = buf.encode(Encoding::ASCII_8BIT)
			end
			@data_size += buf.size
			@io << buf
			@out << buf if @out
			@master.log("%s", buf.to_s) if @logging
			if StrVec === buf
				if @data_size < 1024
					@master.progress("Receiving data: %i B", @data_size)
				elsif @data_size < 1024**2
					@master.progress("Receiving data: %i KiB", @data_size/1024.0)
				else
					@master.progress("Receiving data: %i MiB", @data_size/1024.0**2)
				end
			end
		end

		def close
			@master.progress("Receiving data: writing")
			@io.close
			@out.close if @out
		end

		def wait
			@io.wait
			@out.wait if @out
			@master.progress
		end

		def |(out)
			Piper.new(self, out)
		end

	end

	class Piper
	
		def initialize(a, b)
			@a = a
			@b = b
			@a.out = b
		end

		def <<(buf)
			@a << buf
		end

		def close
			@a.close
		end

		def wait
			@a.wait
			@b.wait
		end

		def out=(out)
			@b.out = out
		end

		def |(out)
			Piper.new(self, out)
		end

	end

	def logdir
		unless Pathname === @logdir
			log "no logdir given"
			exit -1
		end
		@logdir
	end

	def append(io)
		Appendor.new(io)
	end

	def collect_data(postfix=nil, opts = {})
		return Collector.new(Logger.new(self), self, opts) if @logdir == "-"
		return Collector.new(iolambda { |b| }, self, opts) unless @logdir
		@dataio ||= TarWriter.new(@logdir+"#{@name}#{@postfix}.dat.tar", self, @mode_append)
		postfix = (postfix || [
			@data_postfix || "",
			@data_postfix ||= 0,
			@data_postfix += 1,
		].first).to_s
		postfix = "-#{postfix}" unless postfix.empty?
		data_size = 0
		bzip2_data = StrVec.new
		bzip2_io = ExternalFilter.new("pbzip2", self, out: iolambda do |buf|
			next if @dataio.closed?
			case buf
			when StrVec
				bzip2_data << buf
			when :eof
				@dataio.write("#{@name}#{@postfix}#{postfix}.bz2", bzip2_data)
			end
		end)
		Collector.new(bzip2_io, self, opts)
	end

	def date
		log("%s", Time.now)
	end

	def gitstatus
		local.gitstatus
		(@connections-[local]).each do |c|
			c.gitstatus
		end
	end

end

class Connection < Communicator

	def initialize(dst, master)
		@dst = dst || "local"
		@dir, @host = dst.split(":", 2).reverse if dst
		@dir = Pathname.new(@dir||".")
		@master = master
		@spawn_id = 0
		@remotes = Hash.new
		stdin, output = IO.pipe
		input, stdout = IO.pipe
		error, stderr = IO.pipe
		cmd = [(@dir+$0).to_s, "--slave", @dir.to_s]
		cmd.unshift "ssh", "-oBatchMode=yes", @host if @host
		cmd.push "--debug", "#{$debug-1}" if $debug > 1
		@pid = Process.spawn(*cmd,
			in: stdin,
			out: stdout,
			err: stderr,
			pgroup: true)
		stdin.close
		stdout.close
		stderr.close
		super(input, output, error)
		@dispatcher.on_chld(@pid) { |status| child_exited(status) }
		ping
	end

	attr_reader :dst, :master

	def remotes
		@remotes.values
	end

	def inspect
		"connection #{dst}: pid:#{@pid} #{super}"
	end

	def debug(level, fmt, *v)
		@master.debug(level, fmt, *v)
	end

	def close
		debug(2, "close: %s", dst.inspect)
		@closing = true
		super
	end

	def log_error(msg)
		if msg.start_with?("DEBUG ")
			@master.log("DEBUG %s: %s", @dst, msg.sub("DEBUG ", ""), error: true)
		else
			@master.log("ERROR slave %s: %s", @dst, msg, error: true)
		end
	end
	private :log_error

	def error(buf)
		msgs = buf.to_s.split("\n", -1)
		msgs.pop
		msgs.each do |msg|
			log_error(msg)
			buf.shift(msg.size+1)
		end
	end
	private :error

	def erreof
		unless @ebuf.empty?
			log_error(@ebuf.to_s)
			@ebuf.clear
		end
	end
	private :erreof

	def child_exited(status)
		@dispatcher.wait(1) { erreof? }
		@master.die("%s closed connection", @dst) unless @closing
	end

	def ping
		@pong_received = false
		send_msg(:ping)
		@dispatcher.wait { @pong_received }
	end

	def msg_handler_pong
		@pong_received = true
	end

	def remove_remote(id)
		@remotes.delete(id)
	end

	def upload(input=nil)
		id = @spawn_id += 1
		remote = @remotes[id] = RemoteUpload.new(id, self)
		remote.input= input if input
		remote
	end

	def remote_msg(id, msg, *args)
		remote = @remotes[id]
		raise "unknown remote endpoint #{id}" unless remote
		raise "invalid remote endpoint #{id}" unless remote.respond_to?(msg)
		remote.send(msg, id, *args)
	end
	private :remote_msg

	def msg_handler_out(id, buf)
		remote_msg(id, :msg_handler_out, buf)
	end
	msg_raw_arg :out, 2

	def msg_handler_err(id, buf)
		remote_msg(id, :msg_handler_err, buf)
	end
	msg_raw_arg :err, 2

	def msg_handler_eof(id)
		remote_msg(id, :msg_handler_eof)
	end

	def msg_handler_erreof(id)
		remote_msg(id, :msg_handler_erreof)
	end

	def msg_handler_CHLD(id, status)
		remote_msg(id, :msg_handler_CHLD, status)
	end

	def spawn(*cmd)
		opts = Hash === cmd.last ? cmd.pop : {}
		cmd = cmd.map(&:to_s)
		id = @spawn_id += 1
		opts[:out] ||= iolambda { |buf| } if opts[:quiet]
		remote = @remotes[id] = RemoteChild.new(id, cmd, opts, self)
		remote.input= opts[:in] if opts[:in]
		if block_given?
			yield(remote)
			remote.stop
		else
			remote
		end
	end

	def system(*cmd)
		opts = Hash === cmd.last ? cmd.pop : {}
		if opts[:capture]
			output = StrVec.new
			opts[:out] = iolambda do |buf|
				next if buf == :eof
				output << buf
			end
		end
		s = spawn(*cmd.map(&:to_s), opts)
		s.close
		s.stop(nil, opts)
		if opts[:capture]
			output.to_s
		else
			s.status
		end
	end

	def spawn_sudo(*cmd, &block)
		opts = Hash === cmd.last ? cmd.pop : {}
		opts[:sudo] = true
		spawn(*cmd, opts, &block)
	end

	def sudo(*cmd)
		opts = Hash === cmd.last ? cmd.pop : {}
		opts[:sudo] = true
		system(*cmd, opts)
	end

	def gitstatus
		system("git show -s --oneline --no-abbrev-commit")
		system("git status -s")
	end

end

class RemoteEndpoint

	def initialize(id, name, opts, connection)
		@id = id
		@name = name
		@connection = connection
		@master = connection.master
		@dispatcher = Dispatcher.instance
		@obuf = StrVec.new
		@ebuf = StrVec.new
		@prefix = opts[:prefix] || "#{connection.dst}: "
		@eof = false
		@erreof = false
		@closed = false
		self.output= opts[:out] if opts[:out]
	end

	attr_writer :out

	def eof?
		@eof
	end

	def erreof?
		@erreof
	end

	def buffer_size
		@connection.buffer_size - 4096
	end

	def input=(input)
		raise "unable to set input on closed remote" if closed?
		case input
		when Array
			self << File.read(*input, encoding: "ASCII-8BIT")
			self.close
		when Pathname
			self << input.read(encoding: "ASCII-8BIT")
			self.close
		when IO
			self << input.read.b
			self.close
		when String
			self << input.b
			self.close
		else
			raise NotImplementedError
		end
	end

	def output=(output)
		@out = case output
		when Array
			File.open(output[0], "w", encoding: "ASCII-8BIT")
		when Pathname
			File.output.open("w", encoding: "ASCII-8BIT")
		else
			output
		end
		@out.close if eof? and @out.respond_to?(:close)
	end

	def |(out)
		p = Master::Piper.new(self, out)
		p
	end

	def each(&block)
		p = Master::Piper.new(self, eachline(&block))
		wait
	end
	include Enumerable

	def <<(buf)
		str = StrVec.new
		str <<  buf
		while str.size > buffer_size
			@connection.send_msg(:in, @id, str.shift(buffer_size))
		end
		unless str.empty?
			@connection.send_msg(:in, @id, str)
		end
	end

	def close
		@closed = true
		@connection.send_msg(:close, @id)
	end

	def closed?
		@closed
	end

	def done?
		eof? && erreof?
	end

	def wait(&block)
		@dispatcher.wait &(block || lambda { done? })
		@out.wait if @out and @out.respond_to?(:wait)
		@status
	end

	def inspect
		"closed:#{closed?} eof:#{eof?} erreof:#{erreof?}"
	end

	def msg_handler_out(id, buf)
		if @out
			@out << buf
		else
			@obuf << buf
			msgs = @obuf.to_s.split("\n", -1)
			msgs.pop
			msgs.each do |msg|
				@master.log("%s%s", @prefix, msg)
				@obuf.shift(msg.size+1)
			end
		end
	end

	def msg_handler_err(id, buf)
		@ebuf << buf
		msgs = @ebuf.to_s.split("\n", -1)
		msgs.pop
		msgs.each do |msg|
			@master.log("ERROR %s: %s", @connection.dst, msg, error: true)
			@ebuf.shift(msg.size+1)
		end
	end

	def msg_handler_eof(id)
		@eof = true
		if @out
			@out.close if @out.respond_to?(:close)
		else
			unless @obuf.empty?
				@master.log("%s%s", @prefix, @obuf.to_s)
			end
			@obuf.clear
		end
		@connection.remove_remote(@id) if done?
	end

	def msg_handler_erreof(id)
		@erreof = true
		unless @ebuf.empty?
			@master.log("ERROR %s: %s", @connection.dst, @ebuf.to_s, error: true)
		end
		@ebuf.clear
		@connection.remove_remote(@id) if done?
	end

end

class RemoteUpload < RemoteEndpoint

	def initialize(id, connection)
		@filename = ""
		opts = {}
		opts[:out] = iolambda do |buf|
			next if buf == :eof
			@filename += buf.to_s
		end
		super(id, "upload", opts, connection)
		@connection.send_msg(:upload, id)
	end

	def wait
		@dispatcher.wait { eof? }
		nil
	end

	def filename
		wait
		@filename
	end

	alias to_s filename

	def remove
		@filename = nil
		@connection.send_msg(:remove, @id)
	end

	def inspect
		"upload: filename:#{@filename} #{super}"
	end

end

class RemoteChild < RemoteEndpoint

	def initialize(id, cmd, opts, connection)
		@sudo = opts[:sudo]
		@quiet = opts[:quiet]
		super(id, cmd.join(" "), opts, connection)
		@master.debug(1, "spawning %s %s", @connection.dst, cmd.inspect, @pid)
		@connection.send_msg(@sudo ? :spawn_sudo : :spawn, id, cmd)
	end

	attr_reader :status

	def msg_handler_CHLD(id, status)
		@status = status
		@connection.remove_remote(@id) if done?
	end

	def kill(signal="TERM")
		@connection.send_msg(:kill, @id, signal)
	end

	def done?
		 @status && eof? && erreof?
	end

	def stop(signal="TERM", opts={})
		signal, opts = "TERM", signal if Hash === signal
		close
		kill(signal) if signal
		status = wait { @quiet ? @status : done? }
		if opts[:nofail]
			status
		else
			unless [signal, 0].include?(status)
				@master.die("%s %s exited with %s", @connection.dst, @name, status)
			end
		end
	end

	def inspect
		"child #{@name}: #{super}"
	end

end

class Slave < Communicator

	def self.perform(input, output)
		slave = self.new(input, output)
		begin
			Signal.trap(:SIGUSR1) do
				slave.debug(0, "%s", slave.inspect)
				slave.endpoints.map(&:inspect).each do |e|
					slave.debug(0, "%s", e)
				end
				slave.debug(0, "%s", Dispatcher.instance.inspect)
			end
			slave.run
		rescue Interrupt
		ensure
			slave.cleanup
		end
		slave.wait
		Signal.trap(:SIGUSR1, :DEFAULT)
	end

	def initialize(input, output)
		@endpoints = Hash.new
		@status = [:idle]
		super
	end

	def endpoints
		@endpoints.values
	end

	def run
		@status.push :running
		@dispatcher.wait { eof? }
		@status.pop
		close
	end

	def cleanup
		@endpoints.each do |id, endpoint|
			endpoint.cleanup
		end
	end

	def wait
		@status.push :waiting
		@dispatcher.wait { @endpoints.empty? && @obuf.empty? }
		@status.pop
	end

	def inspect
		"slave: #{@status.last} #{super}"
	end

	def msg_handler_ping
		send_msg(:pong)
	end

	def msg_handler_spawn(id, cmd)
		@endpoints[id] = Child.new(id, cmd, {}, self)
	end

	def msg_handler_spawn_sudo(id, cmd)
		@endpoints[id] = Child.new(id, cmd, {sudo: true}, self)
	end

	def msg_handler_upload(id)
		@endpoints[id] = Upload.new(id, self)
	end

	def remove_endpoint(id)
		@endpoints.delete(id)
	end

	def msg_handler_in(id, buf)
		endpoint = @endpoints[id]
		endpoint << buf if endpoint
	end
	msg_raw_arg(:in, 2)

	def msg_handler_close(id)
		endpoint = @endpoints[id]
		endpoint.close if endpoint
	end

	def msg_handler_kill(id, signal)
		endpoint = @endpoints[id]
		endpoint.kill(signal) if endpoint
	end

	def msg_handler_remove(id)
		endpoint = @endpoints[id]
		endpoint.remove if endpoint
	end

end

class Upload

	def initialize(id, slave)
		@id = id
		@slave = slave
		begin
			@path = Pathname.new("/tmp/upload.#{rand(16**8).to_s(16)}")
			@file = @path.open(File::WRONLY|File::CREAT|File::EXCL)
		rescue Errno::EEXIST
			retry
		end
	end

	attr_reader :id

	def <<(buf)
		buf.write_to(@file)
	end

	def close
		@file.close
		msg = StrVec.new
		msg << @path.to_s.b
		@slave.send_msg(:out, id, msg)
		@slave.send_msg(:eof, @id)
	end

	def remove
		@path.unlink
		@slave.remove_endpoint(@id)
	end

	def cleanup
		@file.close unless @file.closed?
		remove
	end

	def wait
	end

end

class Child < AsyncIO

	def initialize(id, cmd, opts, slave)
		@id = id
		@slave = slave
		cmd = [cmd] unless Array === cmd
		@dispatcher = Dispatcher.instance
		@cmd = cmd
		@sudo = opts[:sudo]
		if @sudo
			cmd = if cmd.size == 1
				["sudo " + cmd[0]]
			else
				["sudo"] + cmd
			end
		end
		stdin, input = IO.pipe
		output, stdout = IO.pipe
		error, stderr = IO.pipe
		@pid = Process.spawn(*cmd,
			in: stdin,
			out: stdout,
			err: stderr,
			pgroup: true)
		stdin.close
		stdout.close
		stderr.close
		debug(1, "spawned %s (%s)", cmd.inspect, @pid)
		super(output, input, error)
		@dispatcher.on_chld(@pid) { |status| child_exited(status) }
	end

	attr_reader :id, :pid, :cmd, :status

	def inspect
		"child #{id}: pid:#{pid} cmd:#{cmd.inspect} status:#{status||"nil"} #{super}"
	end

	def buffer_size
		@slave.buffer_size - 4096
	end

	def input(buf)
		until buf.empty? || @slave.congested?
			size = [buffer_size, buf.size].min
			@slave.send_msg(:out, @id, buf.shift(size))
		end
		if @slave.congested? && !buf.empty?
			deactivate_input
			@slave.on_free do
				activate_input
			end
		end
	end
	private :input

	def eof
		@slave.send_msg(:eof, @id)
		@slave.remove_endpoint(@id) if status and erreof?
	end
	private :eof

	def error(buf)
		until buf.empty? || @slave.congested?
			size = [buffer_size, buf.size].min
			@slave.send_msg(:err, @id, buf.shift(size))
		end
		if @slave.congested? && !buf.empty?
			deactivate_error
			@slave.on_free do
				activate_error
			end
		end
	end

	private :error
	def erreof
		@slave.send_msg(:erreof, @id)
		@slave.remove_endpoint(@id) if status and eof?
	end
	private :eof

	def child_exited(status)
		@status = case
		when status.exited?
			status.exitstatus
		when status.signaled?
			Signal.signame(status.termsig)
		else
			true
		end
		@pid = nil
		@slave.send_msg(:CHLD, @id, @status)
		@slave.remove_endpoint(@id) if eof? and erreof?
	end
	private :child_exited

	def cleanup
		close
		kill("TERM") if @pid
	end

	public :<<
	public :close

	def kill(signaln)
		signal = Signal.list[signaln]
		raise "unknown signal #{signaln.inspect}" unless signal
		begin
			if @sudo
				pid = Process.spawn("sudo kill -s #{signal} -#{@pid}")
				@dispatcher.on_chld(pid) {}
				Process.detach(pid)
			else
				Process.kill(signal, @pid) if @pid
			end
		rescue Errno::ESRCH
		end
	end

end

class ArgumentParser

	def self.parse(task, path, args)
		parser = self.new(args)
		catch(self) do
			parser.instance_eval(task, path.to_s)
		end
	end

	def initialize(args)
		@args = args
	end

	def usage(*m)
		o = Hash === m.last ? m.pop : {}
		usage = (m.map { |n| "<#{n}>" } + o.map { |n,v| "<#{n}=#{v}>" }).join(" ")
		range = (m.size..m.size+o.size)
		throw(self.class, usage) unless range === @args.size
		throw(self.class, [usage, range.last.times.inject({}) do |h,i|
			n, v = m.shift || o.shift
			h[n.to_sym] = @args[i] || ENV["ARG_#{n}"] || v
			h
		end])
	end

	def method_missing(name, *args)
		throw(self.class)
	end

end

opts = Trollop::options do
	banner "usage: #{$0} [options] [task] [args]"
	banner "options:"
	opt(:connect, "connect to remote", type: String, multi: true)
	opt(:logdir, "log into this directory", type: String)
	opt(:slave, "execute commands on behalf of master", type: String)
	opt(:args, "list possible task arguments")
	opt(:postfix, "add to output filenames", type: String)
	opt(:append, "append to instead of overwriting output files")
	opt(:quiet)
	opt(:debug, "enable debug output", type: Integer, default: 0)
end

$verbose = ! opts[:quiet]
$debug = opts[:debug]

if opts[:slave]
	Dir.chdir opts[:slave]
	Slave.perform(STDIN, STDOUT)
	exit
end

Trollop::die("no task given") if ARGV.size < 1
path = Pathname.new(ARGV.shift)
name = ([path.basename.to_s.split(".")[0]]+ARGV).join("-")
begin
	task = path.read
rescue Errno::ENOENT
	Trollop::die("no such task file")
end

usage, args = ArgumentParser.parse(task, path, ARGV)
unless usage
	STDERR.puts "ERROR: task must start with usage definition"
	exit -1
end
if opts[:args] || ! args
	STDERR.puts "usage: #{path} [options] #{usage}"
	exit -1
end

logdir = case opts[:logdir]
when nil
	nil
when "-"
	"-"
else
	Pathname.new(opts[:logdir])
end
Master.perform(task, path, opts[:connect], args, name, logdir, opts[:postfix], opts[:append])


