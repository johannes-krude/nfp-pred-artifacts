#include <stddef.h>
#include <stdint.h>
#include <linux/bpf.h>
#include <linux/in.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/ip.h>

#ifndef NUM_CHECKS
#define NUM_CHECKS 8
#endif

// Small helper functions to reduce size of "real" BPF programs
static inline unsigned short checksum(unsigned char *buf, int bufsz) {
	int i;
	unsigned char sum = buf[bufsz - 1];

	#pragma unroll
	for(i = 0; i < bufsz; i++)
		sum ^= buf[i];

	return sum;
}

int xdp_check(struct xdp_md *ctx) {
	struct ethhdr *eth;
	struct iphdr *ip;
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	if (data + sizeof(*eth) + sizeof(*ip) > data_end)
		return XDP_DROP;
	ip = data + sizeof(*eth);

	unsigned char buf[sizeof(struct iphdr)-4];
	#pragma unroll
	for(size_t i = 0; i < sizeof(buf); i++){
		buf[i] = ((char *)ip)[i];
	}

	unsigned char sum = 0;
	#pragma nounroll
	for(unsigned int i = 0; i < NUM_CHECKS; i++) {
		sum^= checksum(buf, sizeof(buf));
	}
	if (!sum)
		return XDP_ABORTED;

	return XDP_DROP;
}
