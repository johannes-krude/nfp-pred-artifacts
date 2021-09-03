
#include <stddef.h>
#include <stdint.h>
#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ipv6.h>
#include <linux/udp.h>

#define ntohs(x) ((__uint16_t) ((((x) >> 8) & 0xff) | (((x) & 0xff) << 8)))
#define htonl(x) \
	((((x) & 0xff000000u) >> 24) | (((x) & 0x00ff0000u) >> 8) \
	 | (((x) & 0x0000ff00u) << 8) | (((x) & 0x000000ffu) << 24))


static inline uint32_t div(uint32_t n, uint8_t p, uint32_t m) {
	uint32_t q = (m * (uint64_t) n)>>32;
	uint32_t t = ((n-q) >> 1) + q;
	return t >> (p-1);
}


int act_main(struct xdp_md *ctx) {
	struct ethhdr *eth;
	struct ipv6hdr *ip6;
	void *next;
	struct ipv6_opt_hdr *opt;
	uint8_t nexthdr;
	struct udphdr *udp;

	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;

	if (data + sizeof(*eth) > data_end)
		return XDP_DROP;
	eth = data;

	if (ntohs(eth->h_proto) != 0x86dd)
		return XDP_DROP;

	if (data + sizeof(*eth) + sizeof(*ip6) > data_end)
		return XDP_DROP;
	ip6 = data + sizeof(*eth);
	next = data + sizeof(*eth) + sizeof(*ip6);
	nexthdr = ip6->nexthdr;

	#pragma nounroll
	for (size_t i = 0; i < 10; i++) {
		switch (nexthdr) {
		case 0: // Hop-by-Hop Options
		case 60: // Destination Options
		case 43: // Routing
			if (next + 8 > data_end)
				return XDP_DROP;
			opt = next;
			nexthdr = opt->nexthdr;
			next = next + 8 * (1+opt->hdrlen);
			continue;
		}
		break;
	}

	if (nexthdr != 17)
		return XDP_PASS;
	if (next + sizeof(*udp) > data_end)
		return XDP_DROP;
	udp = next;

	if (ntohs(udp->dest) != 80 && ntohs(udp->dest) != 443)
		return XDP_PASS;

	uint8_t first_byte;
	uint16_t dcid_off;
	uint16_t dcid_len;
	char *dcid;
	uint8_t first_octet;
	uint8_t rotation;
	uint8_t len;
	uint32_t routing;

	if (next + sizeof(*udp) + 1 > data_end)
		return XDP_DROP;
	first_byte = ((char *) (next + sizeof(*udp)))[0];

	if (!(first_byte & 0x40))
		return XDP_DROP;

	dcid_off = 1;
	dcid_len = INT16_MAX;
	if (first_byte & 0x80) {
		dcid_off = 6;
		if (next + sizeof(*udp) + 6 > data_end)
			return XDP_DROP;
		dcid_len = ((char *) (next + sizeof(*udp) + 5))[0];
		if (!dcid_len)
			return XDP_PASS;
		if (next + sizeof(*udp) + 6 + dcid_len > data_end)
			return XDP_DROP;
	}

	if (next + sizeof(*udp) + dcid_off + 1 > data_end)
		return XDP_DROP;
	dcid = next + sizeof(*udp) + dcid_off;
	first_octet = dcid[0];
	rotation = first_octet >> 6;
	len = first_octet & 0x3f;
	if (dcid_len != INT16_MAX && len != dcid_len - 1)
		return XDP_PASS;

	if (len < 8)
		return XDP_PASS;
	if (next + sizeof(*udp) + dcid_off + 9 > data_end)
		return XDP_DROP;
	routing = 0;
	#define EXTRACT(t,s) routing |= ((dcid[1+s/8]>>(s%8))&0x01)<<t;
	EXTRACT(0,0);
	EXTRACT(1,2);
	EXTRACT(2,4);
	EXTRACT(3,6);
	EXTRACT(4,8);
	EXTRACT(5,10);
	EXTRACT(6,12);
	EXTRACT(7,14);
	EXTRACT(8,16);
	EXTRACT(9,18);
	EXTRACT(10,20);
	EXTRACT(11,22);
	EXTRACT(12,24);
	EXTRACT(13,26);
	EXTRACT(14,28);
	EXTRACT(15,30);
	EXTRACT(16,32);
	EXTRACT(17,34);
	EXTRACT(18,36);
	EXTRACT(19,38);
	EXTRACT(20,40);
	EXTRACT(21,42);
	EXTRACT(22,44);
	EXTRACT(23,46);
	EXTRACT(24,48);
	EXTRACT(25,50);
	EXTRACT(26,52);
	EXTRACT(27,54);
	EXTRACT(28,56);
	EXTRACT(29,58);
	EXTRACT(30,60);
	EXTRACT(31,62);
	//routing /= 65521;
	routing = div(routing, 16, 983266);
	if (!routing)
		return XDP_DROP;
	ip6->daddr.in6_u.u6_addr32[0] = htonl(routing);
	ip6->daddr.in6_u.u6_addr32[1] = (void *) udp - (void *) eth;
	ip6->version = -1;
	return XDP_PASS;
}

