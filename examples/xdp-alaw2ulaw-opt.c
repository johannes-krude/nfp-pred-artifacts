
#include <stddef.h>
#include <stdint.h>
//#include <netinet/in.h>
#define KBUILD_MODNAME ""
#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/udp.h>

#define ntohs(x) ((__uint16_t) ((((x) >> 8) & 0xff) | (((x) & 0xff) << 8)))

struct rtphdr {
	uint8_t vpxcc;
	uint8_t mpt;
	uint8_t seq1;
	uint8_t seq2;
	uint8_t ts1;
	uint8_t ts2;
	uint8_t ts3;
	uint8_t ts4;
	uint8_t ssrc1;
	uint8_t ssrc2;
	uint8_t ssrc3;
	uint8_t ssrc4;
};

// from http://www.speech.kth.se/cost250/refsys/v1.0/src/g711.c
//unsigned char _a2u[128] = {			/* A- to u-law conversions */
//	1,	3,	5,	7,	9,	11,	13,	15,
//	16,	17,	18,	19,	20,	21,	22,	23,
//	24,	25,	26,	27,	28,	29,	30,	31,
//	32,	32,	33,	33,	34,	34,	35,	35,
//	36,	37,	38,	39,	40,	41,	42,	43,
//	44,	45,	46,	47,	48,	48,	49,	49,
//	50,	51,	52,	53,	54,	55,	56,	57,
//	58,	59,	60,	61,	62,	63,	64,	64,
//	65,	66,	67,	68,	69,	70,	71,	72,
//	73,	74,	75,	76,	77,	78,	79,	80,
//	80,	81,	82,	83,	84,	85,	86,	87,
//	88,	89,	90,	91,	92,	93,	94,	95,
//	96,	97,	98,	99,	100,	101,	102,	103,
//	104,	105,	106,	107,	108,	109,	110,	111,
//	112,	113,	114,	115,	116,	117,	118,	119,
//	120,	121,	122,	123,	124,	125,	126,	127,
//};
inline uint8_t a2u(uint8_t x) {
	if (x < 8)
		x += x+1;
	else if (x < 23)
		x += 8;
	else if (x < 31)
		x += (32-x)/2 + 4;
	else if (x < 45)
		x += 4;
	else if (x < 47)
		x += 3;
	else if (x < 63)
		x += 2;
	else if (x < 80)
		x += 1;
	return x;
}

int act_main(struct xdp_md *ctx) {
	struct ethhdr *eth;
	struct iphdr *ip;
	struct udphdr *udp;
	struct rtphdr *rtp;
	uint8_t *law;

	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	size_t len = data_end-data;

	if (data + sizeof(*eth) > data_end)
		return XDP_PASS;
	eth = data;

	if (ntohs(eth->h_proto) != 0x0800)
		return XDP_PASS;

	if (data + sizeof(*eth) + sizeof(*ip) > data_end)
		return XDP_PASS;
	ip = data + sizeof(*eth);

	if (ip->protocol != 17)
		return XDP_PASS;

	if (data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) > data_end)
		return XDP_PASS;
	udp = data + sizeof(*eth) + sizeof(*ip);

	if (ntohs(udp->dest) != 1026)
		return XDP_PASS;

	if (data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*rtp) > data_end)
		return XDP_PASS;
	rtp = data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp);

	if ((rtp->mpt & 0x7f) != 8)
		return XDP_PASS;

	law = data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*rtp);
	//len -= sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*rtp);

	rtp->mpt = rtp->mpt & 0x80;

	for (size_t i = 0; i < 160; i++) {
		//if (i > len)
		if (data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*rtp) + i + 1 > data_end)
			return XDP_PASS;
		uint32_t val = law[i] ^ 0x55;
		uint32_t s = val & 0x80;
		val &= 0x7f;
		val = a2u(val);
		val ^= 0x7f;
		val |= s;
		law[i] = val;
		// from http://www.speech.kth.se/cost250/refsys/v1.0/src/g711.c
		//law[i] = (aval & 0x80) ? (0xFF ^ _a2u[aval ^ 0xD5]) : (0x7F ^ _a2u[aval ^ 0x55]);
	}
	return XDP_PASS;
}

