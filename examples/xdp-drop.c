//#include <bcc/proto.h>
#include <linux/bpf.h>

int act_main(struct xdp_md *ctx) {
	return XDP_DROP;
}
