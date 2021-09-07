#!./scripts/perform-remote.rb

usage :variant
r = connections 1

variant = args[:variant]

r.sudo "./scripts/load-nfp-firmware.rb", "-v", variant
