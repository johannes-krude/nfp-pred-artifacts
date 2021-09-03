
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <asm/byteorder.h>
#include <time.h>
#include <poll.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <errno.h>
#include <err.h>

#include "input.h"
#include "ktest.h"
#include "ereport.h"

#define MOD(a,b) (((a%b)+b)%b)
#define NS 1000000000

enum mode {
	MODE_NONE,
	MODE_ANY,
	MODE_KTEST,
	MODE_EREPORT,
};

typedef bool (*comparator)(size_t size, const unsigned char *data);

static bool compare_any(size_t size, const unsigned char *data) {
	return true;
}

size_t compare_size;
unsigned char *compare_data;

static bool compare_fixed(size_t size, const unsigned char *data) {
	if (size != compare_size || memcmp(data, compare_data, size)) {
		fprintf(stderr, "packet missmatch\n");
		fprintf(stderr, "expected: (%zu)0x", compare_size);
		fprint_buffer2(stderr, compare_data, compare_size);
		fprintf(stderr, "\nreceived: (%zu)0x", size);
		fprint_buffer2(stderr, data, size);
		fprintf(stderr, "\n");
		return false;
	}
	return true;
}

struct ereport_packet ereport;

static bool compare_ereport(size_t size, const unsigned char *data) {
	return ereport_packet_compare(&ereport, size, data);
}

static comparator prepare_compare(enum mode mode, int fd, size_t *size) {
	switch (mode) {
	case MODE_ANY:
		*size = 0;
		return &compare_any;
	case MODE_KTEST:;
		struct ktest_buf k;
		ktest_open(&k, fd);
		compare_size = ktest_sk_buff_32(&k, 0);
		compare_data = (void *) ktest_get_obj(&k, "data", NULL);
		if (!compare_data)
			errx(-1, "invalid ktest data");
		*size = compare_size;
		return &compare_fixed;
	case MODE_EREPORT:
		ereport_packet_parse(fd, &ereport);
		*size = ereport.size;
		return &compare_ereport;
	default:
		return NULL;
	}
}

static int sock;

static void prepare_rcv(char *iface) {
	struct ifreq if_idx = {.ifr_name = {0}};
	struct sockaddr_ll addr = {
		.sll_family   = AF_PACKET,
		.sll_protocol = __constant_htons(ETH_P_ALL),
	};
	struct packet_mreq mreq = {
		.mr_type = PACKET_MR_PROMISC,
	};

	sock = socket(AF_PACKET, SOCK_RAW, __constant_htons(ETH_P_ALL));
	if (sock == -1)
		err(-1, "unable to open raw socket");
	strncpy(if_idx.ifr_name, iface, IFNAMSIZ-1);
	if (ioctl(sock, SIOCGIFINDEX, &if_idx) == -1)
		err(-1, "invalid iface '%s'", iface);
	addr.sll_ifindex = if_idx.ifr_ifindex;
	if (bind(sock, (void *) &addr, sizeof(addr)) == -1)
		err(-1, "bind");
	mreq.mr_ifindex = if_idx.ifr_ifindex;
	if (setsockopt(sock, SOL_PACKET, PACKET_ADD_MEMBERSHIP, &mreq, sizeof(mreq)) == -1)
		err(-1, "setsockopt(SOL_PACKET, PACKET_ADD_MEMBERSHIP, PACKET_MR_PROMISC)");
}

static bool check_rcv(int count, float timeout, size_t size, comparator compare) {
	struct timespec end, cur, t;
	struct pollfd pfd = {
		.fd     = sock,
		.events = POLLIN,
	};
	if (size < 14)
		size = 14;
	unsigned char buf[size+10];

	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end))
		err(-1, "clock_gettime(CLOCK_MONOTONIC_RAW)");
	end.tv_nsec += MOD((long) (timeout*NS), NS);
	end.tv_sec += (int) timeout;
	end.tv_sec += end.tv_nsec/NS;
	end.tv_nsec = MOD(end.tv_nsec, NS);

	for (; count > 0; count--) {
		if (clock_gettime(CLOCK_MONOTONIC_RAW, &cur))
			err(-1, "clock_gettime(CLOCK_MONOTONIC_RAW)");
		t = (struct timespec) {
			.tv_nsec = MOD(end.tv_nsec - cur.tv_nsec, NS),
			.tv_sec  = (end.tv_sec - cur.tv_sec) +
			           (NS + end.tv_nsec - cur.tv_nsec) / NS - 1,
		};
		switch (ppoll(&pfd, 1, &t, NULL)) {
		case -1:
			err(-1, "ppoll");
		case 0:
			fprintf(stderr, "timeout\n");
			return false;
		}
		ssize_t s = recv(sock, buf, size+10, MSG_DONTWAIT);
		if (s == -1)
			err(-1, "recv");
		if (!compare(s, buf))
			return false;
	}
	return true;
}

static void usage(char *argv0) {
	fprintf(stderr, "Usage: %s <mode> [options] <iface>\n", argv0);
	fprintf(stderr, "Mode:\n");
	fprintf(stderr, "\t-k                 compare to KTEST input\n");
	fprintf(stderr, "\t-E                 compare to ereport input\n");
	fprintf(stderr, "\t-n                 do not compare\n");
	fprintf(stderr, "Options:\n");
	fprintf(stderr, "\t-c <num=1000>      terminate on num received packets\n");
	fprintf(stderr, "\t-t <test>          select ktest from tar\n");
	fprintf(stderr, "\t-w <timeout=1.0s>  terminate after timeout\n");
	input_usage();
	exit(1);
}

int main(int argc, char **argv) {
	enum mode mode = MODE_NONE;
	struct input_opts input_opts = {0};
	int fd;
	const char *test = NULL;
	size_t count = 1000;
	float timeout = 1.0;
	size_t size = 0;
	char *iface;
	int opt;

	while ((opt = getopt(argc, argv, "kEnc:t:w:" INPUT_OPTS)) != -1) {
		switch (opt) {
		case 'k':
			mode = MODE_KTEST;
			continue;
		case 'E':
			mode = MODE_EREPORT;
			continue;
		case 'n':
			mode = MODE_ANY;
			continue;
		case 'c':
			sscanf(optarg, "%zu", &count);
			continue;
		case 't':
			test = optarg;
			input_opts.tar = &input_tar_iterate;
			continue;
		case 'w':
			sscanf(optarg, "%f", &timeout);
			continue;
		}
		if (input_optparse(opt, &input_opts))
			continue;
		usage(argv[0]);
	}
	if (argc != optind+1)
		usage(argv[0]);
	iface = argv[optind];

	fd = input_open(&input_opts);

	if (test) {
		struct input_tar t = {0};
		struct input_tar_file f = {0};
		char pattern[] = "*/test000000.ktest";
		char *p = pattern;
		snprintf(pattern, sizeof(pattern), "*/%s.ktest", test);

		input_tar_open(&input_opts, fd, &t);
		if (input_tar_next(&t, p, &f)) {
			fd = input_tar_fd(&t);
		} else {
			errx(-1, "ktest not found");
		}
	}

	comparator compare = prepare_compare(mode, fd, &size);
	if (!compare)
		usage(argv[0]);

	prepare_rcv(iface);
	if (!check_rcv(count, timeout, size, compare))
		exit(1);

	exit(0);
}

