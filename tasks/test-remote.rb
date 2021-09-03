#!./scripts/perform-remote.rb

usage
c = connections 1

c.sudo("hostname")
log "SUCCESS"

