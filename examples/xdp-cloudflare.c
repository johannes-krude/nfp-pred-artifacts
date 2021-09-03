// main structure taken from:
// Gilberto Bertin. XDP in practice: integrating XDP into our DDOS
// mitigation pipeline. NETDEV 2.1, April 2017.

#include <inttypes.h>
#include <arpa/inet.h>
#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>

#define IP_DF 0x4000
#define IP_MF 0x2000

//BPF_TABLE("array", int, long, rule_counters, 256);

static void sample_packet(void *data, void *data_end) {
	// mark the packet to be sampled
}

/*static void update_rule_counters(int rule_id) {
	long *value = rule_counters.lookup(&rule_id);

	if (value)
		*value += 1;
}*/

static int rule_0(void *data, void *data_end) {
	// taken from:
	// Gilberto Bertin. XDP in practice: integrating XDP into our DDOS
	// mitigation pipeline. NETDEV 2.1, April 2017.

	struct ethhdr *eth_hdr;
	struct iphdr  *ip_hdr;
	struct tcphdr *tcp_hdr;
	uint8_t       *tcp_opts;

	eth_hdr = (struct ethhdr *)data;
	if (eth_hdr + 1 > (struct ethhdr *)data_end)
		return XDP_PASS;
	if (!(eth_hdr->h_proto == __constant_htons(ETH_P_IP)))
		return XDP_DROP;

	ip_hdr = (struct iphdr *)(eth_hdr + 1);
	if (ip_hdr + 1 > (struct iphdr *)data_end)
		return XDP_PASS;
	if (!(ip_hdr->daddr == htonl(0x1020304)))
		return XDP_DROP;
	if (!(ip_hdr->version == 4))
		return XDP_DROP;
	if (!(ip_hdr->ttl <= 64))
		return XDP_PASS;
	if (!(ip_hdr->ttl > 29))
		return XDP_PASS;
	if (!(ip_hdr->ihl == 5))
		return XDP_PASS;
/*	if (!((ip_hdr->frag_off & IP_DF) == 0))
		return XDP_PASS;
*/	if (!((ip_hdr->frag_off & IP_MF) == 0))
		return XDP_PASS;

	tcp_hdr = (struct tcphdr*)((uint8_t *)ip_hdr + 5 * 4);
	if (tcp_hdr + 1 > (struct tcphdr *)data_end)
		return XDP_PASS;
	if (!(tcp_hdr->dest == __constant_htons(1234)))
		return XDP_DROP;
	if (!(tcp_hdr->doff == 10))
		return XDP_PASS;
	if (!((__constant_htons(ip_hdr->tot_len) - (ip_hdr->ihl * 4) -
	       (tcp_hdr->doff * 4)) == 0))
		return XDP_PASS;

	tcp_opts = (uint8_t *)(tcp_hdr + 1);
	if (tcp_opts + (tcp_hdr->doff - 5) * 4 > (uint8_t *)data_end)
		return XDP_PASS;
	if (!(*(uint8_t *)(tcp_opts + 19) == 6))
		return XDP_PASS;
	if (!(tcp_opts[0] == 2))
		return XDP_PASS;
	if (!(tcp_opts[4] == 4))
		return XDP_PASS;
	if (!(tcp_opts[6] == 8))
		return XDP_PASS;
	if (!(tcp_opts[16] == 1))
		return XDP_PASS;
	if (!(tcp_opts[17] == 3))
		return XDP_PASS;
	
	//update_rule_counters(0);
	sample_packet(data, data_end);

	return XDP_DROP;
}

static int rule_1(void *data, void *data_end) {
	// translated from `./bpfgen -s -o 14 dns -- -i *.example.com`

	uint32_t a,x;

	// ldx 4*([14]&0xf)
	if (data + 14 + 1 > data_end)
		return XDP_PASS;
	x = 4*(*((uint8_t *) (data + 14))&0xf);
	// ld #34
	a = 34;
	// add x
	a += x;
	// tax
	x = a;
	// ldb [x + 0]
	if (data + x + 0 + 1 > data_end)
		return XDP_PASS;
	a = *((uint8_t *) (data + x + 0));
	// add x
	a += x;
	// add #1
	a += 1;
	// tax
	x = a;
	// ld [x + 0]
	if (data + x + 0 + 4 > data_end)
		return XDP_PASS;
	a = *((uint32_t *) (data + x + 0));
	// or #0x00202020
	a |= 0x00202020;
	// jneq #0x07657861, lb_1
	if (a != 0x07657861)
		return XDP_PASS;
	// ld [x + 4]
	if (data + x + 4 + 4 > data_end)
		return XDP_PASS;
	a = *((uint32_t *) (data + x + 4));
	// or #0x20202020
	a |= 0x20202020;
	// jneq #0x6d706c65, lb_1
	if (a != 0x6d706c65)
		return XDP_PASS;
	// ld [x + 8]
	if (data + x + 8 + 4 > data_end)
		return XDP_PASS;
	a = *((uint32_t *) (data + x + 8));
	// or #0x00202020
	a |= 0x00202020;
	// jneq #0x03636f6d, lb_1
	if (a != 0x0363696d)
		return XDP_PASS;
	// ldb [x + 12]
	if (data + x + 12 + 1 > data_end)
		return XDP_PASS;
	a = *((uint8_t *) (data + x + 12));
	// jneq #0x00, lb_1
	if (a != 0x00)
		return XDP_PASS;
	// ret #65535
	goto drop;
	// lb_1:
	// ret #0
drop:

	//update_rule_counters(1);
	sample_packet(data, data_end);

	return XDP_DROP;
}

static int rule_2(void *data, void *data_end) {
	// translated from `./bpfgen -s -o 14 dns_validate`

	uint32_t a,x;

	// ld #14
	a = 14;
	// ldx 4*([14]&0xf)
	if (data + 14 + 1 > data_end)
		return XDP_PASS;
	x = 4*(*((uint8_t *) (data + 14))&0xf);
	// add x
	a += x;
	// tax
	x = a;
	// check for port 53
	if (data + x + 2 + 2 > data_end)
		return XDP_PASS;
	if (*((uint16_t *) (data + x + 2)) != __constant_htons(53))
		return XDP_PASS;
	// ldh [x + 4]
	if (data + x + 4 + 2 > data_end)
		return XDP_PASS;
	a = *((uint16_t *) (data + x + 4));
	// jlt #29, match
	if (a < 29)
		goto drop;
	// txa
	a = x;
	// add #8
	a += 8;
	// tax
	x = a;
	// ldh [x + 2]
	if (data + x + 2 + 2 > data_end)
		return XDP_PASS;
	a = *((uint16_t *) (data + x + 2));
	// and #0xfc8f
	a &= 0xfc8f;
	// jne #0, match
	if (a != 0)
		goto drop;
	// ldh [x + 4]
	if (data + x + 4 + 2 > data_end)
		return XDP_PASS;
	a = *((uint16_t *) (data + x + 4));
	// jneq #0x1, match
	if (a != 1)
		goto drop;
	// ldh [x + 6]
	if (data + x + 6 + 2 > data_end)
		return XDP_PASS;
	a = *((uint16_t *) (data + x + 6));
	// jneq #0x0, match
	if (a != 0)
		goto drop;
	// ldh [x + 10]
	if (data + x + 4 + 2 > data_end)
		return XDP_PASS;
	a = *((uint16_t *) (data + x + 4));
	// jgt #0x1, match
	if (a > 1)
		goto drop;
	// ret #0
drop:
	// match:
	// ret #65535

	//update_rule_counters(2);
	sample_packet(data, data_end);

	return XDP_DROP;
}

int act_main(struct xdp_md *ctx) {
	void *data = (void *)(long long int) ctx->data;
	void *data_end = (void *)(long long int) ctx->data_end;
	int ret;

	ret = rule_0(data, data_end);
	if (ret != XDP_PASS)
		return ret;

	ret = rule_1(data, data_end);
	if (ret != XDP_PASS)
		return ret;

	ret = rule_2(data, data_end);
	if (ret != XDP_PASS)
		return ret;

	return XDP_PASS;
}

