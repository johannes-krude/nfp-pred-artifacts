#!/usr/bin/ruby
# vim: set syntax=c:

$num = (ARGV[0] || 10).to_i

puts <<C
#include <stddef.h>
#include <stdint.h>
#define KBUILD_MODNAME ""
#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/udp.h>

#include "bpf_helpers.h"

#define ntohs(x) ((__uint16_t) ((((x) >> 8) & 0xff) | (((x) & 0xff) << 8)))
#define htonl(x) \
	((((x) & 0xff000000u) >> 24) | (((x) & 0x00ff0000u) >> 8) \
	 | (((x) & 0x0000ff00u) << 8) | (((x) & 0x000000ffu) << 24))


struct bpf_map_def SEC("maps") table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(uint32_t),
	.value_size = 1<<22,
	.max_entries = 1,
};


int act_main(struct xdp_md *ctx) {
	uint32_t key = 0;
	uint32_t *value;

	value = bpf_map_lookup_elem(&table, &key);
	if (!value)
		return XDP_PASS;
	#{$num.times.map { "__sync_fetch_and_add(&value[0], 5);" }.join("\n\t")}
	return XDP_PASS;
}
C
