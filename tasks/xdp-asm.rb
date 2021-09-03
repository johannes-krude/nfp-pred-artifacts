#!./scripts/perform-remote.rb

usage :bpf
r = (connections 0..1) || local

bpf = args[:bpf]

a, out = case bpf
when /\/?([^\/]+)\.bpf\.o$/
	[["-e"], "out/#{$1}.asm"]
when /\/?([^\/]+)\.bpf$/
	[[], "out/#{$1}.asm"]
when /\/?([^\/]+)\.c/
	[["-i", "act_main"], "out/#{$1}.asm"]
else
	die("unexpected file suffix")
end

r.sudo "./build/bpf", "-cXop", *a, "eth1", in: [bpf], out: [out]
