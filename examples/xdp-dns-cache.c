/*
 * Originally created by Rudi Floren 2016.
 * Modified by many others since then.
 */
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/udp.h>
#include <arpa/inet.h>
#include "bpf_helpers.h"

#define KEYLENGTH 24
#define LEAFLENGTH 16
#define MAPSIZE 65536

struct dns_hdr
{
	uint16_t id;
	uint16_t flags;
	/* number of entries in the question section */
	uint16_t qdcount;
	/* number of resource records in the answer section */
	uint16_t ancount;
	/* number of name server resource records in the authority records section*/
	uint16_t nscount;
	/* number of resource records in the additional records section */
	uint16_t arcount;
};


struct dns_query_flags_t
{
	uint16_t qtype;
	uint16_t qclass;
};


struct dns_char_t
{
	char c;
};

struct Key {
	unsigned char p[KEYLENGTH];
};

struct Leaf {
	struct Key k;
	unsigned char p[LEAFLENGTH];
	uint32_t next;
	uint32_t reqCount;
};
struct Counters {
	uint64_t count;
};


struct bpf_map_def SEC("maps") table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(uint32_t),
	.value_size = sizeof(struct Leaf),
	.max_entries = MAPSIZE,
};

static uint32_t hash(uint32_t x) {
// https://github.com/skeeto/hash-prospector
	uint32_t volatile v;
	v = x ^ (x >> 15);
	v &= 0xffffffff;
	x = v * 0x2c1b3c6d;
	v = x ^ (x >> 12);
	v &= 0xffffffff;
	x = v * 0x297a2d39;
	x ^= x >> 15;
	return x;
}

static __attribute__((always_inline)) bool compare_key(const struct Key *k, const struct Leaf *l) {
	#pragma clang loop unroll(full)
	for (size_t i = 0; i < KEYLENGTH/4; i++) {
		struct quad {
			uint8_t a;
			uint8_t b;
			uint8_t c;
			uint8_t d;
		};
		uint32_t xk = ((uint32_t *)k->p)[i];
		uint32_t xl = ((uint32_t *)l->k.p)[i];
		struct quad kq = *((struct quad*) &xk);
		struct quad lq = *((struct quad*) &xl);
		if (kq.a != lq.a)
			return false;
		if (!kq.a)
			return true;
		if (kq.b != lq.b)
			return false;
		if (!kq.b)
			return true;
		if (kq.c != lq.c)
			return false;
		if (!kq.c)
			return true;
		if (kq.d != lq.d)
			return false;
		if (!kq.d)
			return true;
	}
	return true;
}

static __attribute__((always_inline)) struct Leaf* lookup(const struct Key *k) {
	uint32_t h = 0;
	for (size_t i = 0; i < KEYLENGTH/4; i++) {
		h = hash(h^((uint32_t *) k->p)[i]);
		if (!k->p[i*4+3])
			break;
	}
	struct Leaf* l = bpf_map_lookup_elem(&table, &h);
	if (!l)
		return NULL;
	if (!compare_key(k, l))
		goto retry;
	return l;

retry:
	h = hash(h^l->next);
	l = bpf_map_lookup_elem(&table, &h);
	if (!l)
		return NULL;
	if (!compare_key(k, l))
		return NULL;
	return l;
}

int dns_cache(struct xdp_md *ctx) {

	struct Key key = {0};

	struct ethhdr *eth;
	struct iphdr *ip;
	struct udphdr *udp;
	struct dns_hdr *dns;

	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;

	if (data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*dns) > data_end)
		return XDP_PASS;
	
	eth = data;
	if (ntohs(eth->h_proto) != 0x0800)
		return XDP_PASS;
	ip = data + sizeof(*eth);
	if (ip->protocol != 17)
		return XDP_PASS;
	udp = data + sizeof(*eth) + sizeof(*ip);
	if (ntohs(udp->dest) != 53)
		return XDP_PASS;

	dns = data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp);

	// Exit if this packet is not a request.
	if ((ntohs(dns->flags) >>15) != 0)
		return XDP_DROP;

	if (ntohs(dns->qdcount) != 1)
		goto error;

	struct dns_char_t *c = data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*dns);
	size_t qs = 0;
	#pragma clang loop unroll(full)
	for (qs = 0; qs < KEYLENGTH; qs++) {
		if (((void *)  c) + qs + 1 > data_end)
			goto error;
		if (c[qs].c == 0)
			break;
		key.p[qs] = c[qs].c;
	}
	if (qs == KEYLENGTH)
		goto error;

	// Check if the question wants A record
	struct dns_query_flags_t *flags = ((void *)  c) + qs + 1;
	if (((void *)flags) + sizeof(*flags) > data_end)
		goto error;
	if(ntohs(flags->qtype) != 1) // A Question
		goto no_name;
	if(ntohs(flags->qclass) != 1) // Internet
		goto no_name;
	
	struct Leaf *lookup_leaf;
	lookup_leaf= lookup(&key);
	if(!lookup_leaf)
		goto no_name;

	__sync_fetch_and_add(&lookup_leaf->reqCount, 1);

	unsigned char *answer = ((void *) flags) + sizeof(*flags);
	if ((void *) answer + LEAFLENGTH > data_end)
		goto error;

	dns->ancount = htons(1);
	dns->nscount = 0;
	#pragma clang loop unroll(full)
	for (size_t i = 0; i < LEAFLENGTH/4; i++)
		((uint32_t *) answer)[i] = ((uint32_t *) lookup_leaf->p)[i];
	ip->tot_len = ((void *) answer) + LEAFLENGTH - (void *) ip;
	udp->len = ((void *) answer) + LEAFLENGTH - (void *) udp;
	goto out;

error:
	dns->flags = htons(ntohs(dns->flags) | 4);
	goto out;

no_name:
	dns->flags = htons(ntohs(dns->flags) | 3);
	goto out;

out:;
	dns->flags = htons(ntohs(dns->flags) | 1<<15);
	unsigned char tmp_mac_src[6];
	#pragma clang loop unroll(full)
	for (size_t i = 0; i < 6; i++)
		tmp_mac_src[i] = eth->h_source[i];
	unsigned char tmp_mac_dst[6];
	#pragma clang loop unroll(full)
	for (size_t i = 0; i < 6; i++)
		tmp_mac_dst[i] = eth->h_dest[i];
	#pragma clang loop unroll(full)
	for (size_t i = 0; i < 6; i++)
		eth->h_source[i] = tmp_mac_dst[i];
	#pragma clang loop unroll(full)
	for (size_t i = 0; i < 6; i++)
		eth->h_dest[i] = tmp_mac_src[i];
	uint32_t tmp_ip_src = ip->saddr;
	uint32_t tmp_ip_dst = ip->daddr;
	ip->saddr = tmp_ip_dst;
	ip->daddr = tmp_ip_src;
	uint16_t tmp_udp_src = udp->source;
	uint16_t tmp_udp_dst = udp->dest;
	udp->source = tmp_udp_dst;
	udp->dest = tmp_udp_src;
	udp->check = 0;

	return XDP_TX;
}

