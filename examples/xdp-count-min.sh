#!/usr/bin/ruby
# vim: set syntax=c:

$stages = (ARGV[0] || 8).to_i

puts <<C
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <linux/bpf.h>
#include <linux/in.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/udp.h>
#include <linux/tcp.h>

#include "bpf_helpers.h"

#define ntohs(x) ((__uint16_t) ((((x) >> 8) & 0xff) | (((x) & 0xff) << 8)))
#define htons(x) ((__uint16_t) ((((x) >> 8) & 0xff) | (((x) & 0xff) << 8)))
#define htonl(x) \
	((((x) & 0xff000000u) >> 24) | (((x) & 0x00ff0000u) >> 8) \
	 | (((x) & 0x0000ff00u) << 8) | (((x) & 0x000000ffu) << 24))

#define NEXT_POW_OF_TWO(x) (1UL <<(1 +(63 -__builtin_clzl(x -1))))

#define ENTRIES (1<<23)
#define STAGES #{$stages}

struct Entry {
	uint32_t count;
};


struct bpf_map_def SEC("maps") count = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(uint32_t),
	.value_size = sizeof(struct Entry),
	.max_entries = NEXT_POW_OF_TWO(STAGES*ENTRIES),
};

struct Stage {
	uint8_t  stage;
	uint8_t  s1;
	uint32_t m1;
	uint8_t  s2;
	uint32_t m2;
	uint8_t  s3;
};

static uint32_t hash(const struct Stage* s, uint32_t x) {
// https://github.com/skeeto/hash-prospector
	uint32_t volatile v;
	v = x >> s->s1;
	v &= 0xffffffff;
	x = v * s->m1;
	v = x >> s->s2;
	v &= 0xffffffff;
	x = v * s->m2;
	x ^= x >> s->s3;
	return x;
}

static void count_stage(const struct Stage* s, uint32_t key) {
	uint32_t l = s->stage*ENTRIES + hash(s, key) & (ENTRIES-1);
	struct Entry* elem = bpf_map_lookup_elem(&count, &l);
	if (elem)
		__sync_fetch_and_add(&elem->count, 1);
}

int xdp_count_min(struct xdp_md *ctx) {
	void* data_end = (void*)(long)ctx->data_end;
	void* data = (void*)(long)ctx->data;
	struct Stage stages[] = {
// https://github.com/skeeto/hash-prospector
		{ 0,15,0x2c1b3c6d,12,0x297a2d39,15}, // prospector32
		{ 1,16,0x045d9f3b,16,0x045d9f3b,16}, // H2 SQL
		{ 2,15,0x4811acab,15,0x5591acd7,16},
		{ 3,16,0x1ec9b4db,15,0x3224d38d,17},
		{ 4,17,0x179cd515,15,0x4c495d47,15},
		{ 5,17,0x24f4d2cd,15,0x1ba3b969,16},
		{ 6,17,0x5abe3ae5,13,0x65639657,16},
		{ 7,17,0x6e79e54b,14,0x0915b24d,16},
		{ 8,16,0x236f7153,12,0x33cd8663,15},
		{ 9,18,0x4260bb47,13,0x27e8e1ed,15},
		{10,17,0x3f6cde45,12,0x51d608ef,16},
		{11,15,0x5dfa224b,14,0x4bee7e4b,17},
		{12,15,0x42f91d8d,14,0x61355a85,15},
		{13,15,0x4df8395b,15,0x466b428b,16},
		{14,16,0x0ab694cd,14,0x4c139e47,16},
		{15,16,0x45109e55,14,0x3b94759d,16},
		{16,16,0x6cdb9705,14,0x4d58d2ed,14},
		{17,16,0x195565c7,14,0x16064d6f,16},
		{18,16,0x699f272b,14,0x09c01023,16},
		{19,15,0x336536c3,13,0x4f0e38b1,16},
	};

	struct ethhdr *eth = data;
	struct iphdr *ip;
	struct udphdr *udp;
	struct tcphdr *tcp;
	uint32_t key = 0;

	if (data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) > data_end)
		return XDP_PASS;

	key ^= hash(&stages[0], eth->h_proto);

	if (eth->h_proto == htons(ETH_P_IP)) {
		ip = data + sizeof(*eth);

		key ^= hash(&stages[0], ip->saddr);
		key ^= hash(&stages[0], ip->daddr) ;
		key ^= hash(&stages[0], ip->protocol) ;

		if (ip->protocol == IPPROTO_UDP) {
			udp = data + sizeof(*eth) + sizeof(*ip);
			//key ^= hash(&stages[0], (((uint32_t) udp->dest) << 16) + udp->source);
			key ^= hash(&stages[0], udp->source);
			key ^= hash(&stages[0], udp->dest);
		} else if (ip->protocol == IPPROTO_TCP) {
			tcp = data + sizeof(*eth) + sizeof(*ip);
			//key ^= hash(&stages[0], (((uint32_t) tcp->dest) << 16) + tcp->source);
			key ^= hash(&stages[0], tcp->source);
			key ^= hash(&stages[0], tcp->dest);
		}
	}

	#pragma unroll
	for (int stage = 0; stage < STAGES; stage++)
		count_stage(&stages[stage], key);

	return XDP_DROP;
}
C
