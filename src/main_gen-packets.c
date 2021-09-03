#include "input.h"
#include "ktest.h"
#include "ereport.h"
#include "gen.h"

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <math.h>
#include <errno.h>
#include <err.h>
#include <fcntl.h>
#include <signal.h>
#include <sched.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <asm/byteorder.h>
#include <netinet/in.h>
#include <netinet/ether.h>
#include <linux/if_packet.h>
#include <linux/if_ether.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <netdb.h>
#include <poll.h>
#include <pcap/pcap.h>
#include <assert.h>
#include <sys/uio.h>

//LDLIBS=pcap
//LDLIBS=m


static int sock;
size_t num_uniq = 1<<24;
size_t num_msgs;
static struct mmsghdr *msgs;
#define MAX_MSGS (1UL<<42)/8192
#define PAGE_SIZE 4096

struct address_occurences;
struct address_occurences {
	uint64_t num;
	struct address_occurences *next;
};


struct packet_opts {
	enum packet_mode {
		MODE_NONE = 0,
		MODE_GEN,
		MODE_PCAP,
		MODE_KTEST,
		MODE_TAR_KTEST,
		MODE_EREPORT,
		MODE_UDP,
		MODE_ETH,
		MODE_TCP,
		MODE_UDP6,
		MODE_TCP6,
	} packet_mode;
	enum payload_mode {
		MODE_ZERO = 0,
		MODE_RAND,
		MODE_POW,
		MODE_INC,
	} payload_mode;
	int fd;
	struct input_opts *input_opts;
	size_t uniq;
	size_t size;
	size_t num_addrs;
	size_t address_index;
	uint64_t max;
	uint64_t off;
	uint64_t num_occurences;
	uint64_t sum_occurences;
	uint64_t address_counter;
	uint64_t payload_counter;
	double alpha;
	struct addrs {
		struct sockaddr_in  *addrs4;
		struct sockaddr_in6 *addrs6;
		unsigned char       *mac;
	} addrs;
	struct address_occurences *address_occurences;
	char ktest[64];
	char *generator;
};

static void *map_locked(size_t nmemb, size_t size) {
	void *mem;
	size_t mem_size = nmemb * size;

	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS |
	           MAP_SHARED, 0, 0);
	if (mem == (void *) -1)
		err(-1, "mmap(%zu)", mem_size);

	if (mlock(mem, mem_size) && errno != EPERM)
		err(-1, "mlock(%zu)", mem_size);

	return mem;
}

static void *map_noreserve(size_t nmemb, size_t size) {
	void *mem;
	size_t mem_size = nmemb * size;

	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS |
	           MAP_SHARED | MAP_NORESERVE, 0, 0);
	if (mem == (void *) -1)
		err(-1, "mmap(%zu)", mem_size);

	return mem;
}

static unsigned char *parse_macaddrs(size_t num_dsts, char **dsts) {
	unsigned char *as = calloc(num_dsts, ETH_ALEN);
	if (!as)
		err(-1, "calloc");

	for (size_t i = 0; i < num_dsts; i++) {
		unsigned char *a = as + ETH_ALEN*i;
		sscanf(dsts[i], "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", a+0, a+1, a+2, a+3, a+4, a+5);
	}
	return as;
}

static struct sockaddr_in *lookup_addrs4(size_t num_dsts, char **dsts) {
	struct addrinfo hints = {
		.ai_family   = AF_INET,
		.ai_socktype = SOCK_DGRAM,
		.ai_protocol = IPPROTO_UDP,
	};
	struct sockaddr_in *addrs;
	struct addrinfo *addr;
	int rc;

	addrs = calloc(num_dsts, sizeof(*addrs));
	if (!addrs)
		err(-1, "calloc");

	for (size_t i = 0; i < num_dsts; i++) {
		char *ip   = dsts[i];
		char *port = strchr(ip, ':');
		if (port)
			*port++ = 0;
		if (!*ip)
			return NULL;
		rc = getaddrinfo(ip, port, &hints, &addr);
		if (rc)
			errx(-1, "unable to interpret addr: %s", gai_strerror(rc));
		memcpy(&addrs[i], addr->ai_addr, sizeof(*addrs));
		freeaddrinfo(addr);
	}

	return addrs;
}

static struct sockaddr_in6 *lookup_addrs6(size_t num_dsts, char **dsts) {
	struct addrinfo hints = {
		.ai_family   = AF_INET6,
		.ai_socktype = SOCK_DGRAM,
		.ai_protocol = IPPROTO_UDP,
	};
	struct sockaddr_in6 *addrs;
	struct addrinfo *addr;
	int rc;

	addrs = calloc(num_dsts, sizeof(*addrs));
	if (!addrs)
		err(-1, "calloc");

	for (size_t i = 0; i < num_dsts; i++) {
		char *ip   = dsts[i];
		char *port = strchr(ip, ':');
		if (port)
			*port++ = 0;
		if (!*ip)
			return NULL;
		rc = getaddrinfo(ip, port, &hints, &addr);
		if (rc)
			errx(-1, "unable to interpret addr: %s", gai_strerror(rc));
		memcpy(&addrs[i], addr->ai_addr, sizeof(*addrs));
		freeaddrinfo(addr);
	}

	return addrs;
}

static struct addrs lookup_addrs(enum packet_mode packet_mode, size_t num_addrs,
                                char **dsts) {
	static unsigned char mac[ETH_ALEN] =
			{0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
	static struct sockaddr_in addr4 = {
		.sin_family = AF_INET,
		.sin_addr.s_addr = 0xffffffff,
	};
	static struct sockaddr_in6 addr6 = {
		.sin6_family = AF_INET6,
		.sin6_addr.s6_addr = { 0xff, 0x01, 0x00, 0x00,
				       0x00, 0x00, 0x00, 0x00, 
				       0x00, 0x00, 0x00, 0x00, 
				       0x00, 0x00, 0x00, 0x01},
	};
	struct addrs a = {
		.mac    = mac,
		.addrs4 = &addr4,
		.addrs6 = &addr6,
	};

	if (!num_addrs)
		return a;

	switch (packet_mode) {
	case MODE_NONE:
	case MODE_GEN:
	case MODE_PCAP:
	case MODE_KTEST:
	case MODE_TAR_KTEST:
		break;
	case MODE_EREPORT:
	case MODE_ETH:
		a.mac = parse_macaddrs(num_addrs, dsts);
		break;
	case MODE_UDP:
	case MODE_TCP:
		a.addrs4 = lookup_addrs4(num_addrs, dsts);
		break;
	case MODE_UDP6:
	case MODE_TCP6:
		a.addrs6 = lookup_addrs6(num_addrs, dsts);
		break;
	}

	return a;
}

static struct addrs select_addr(struct packet_opts *o) {
	struct addrs a = o->addrs;

	while (o->num_addrs && !o->address_counter) {
		o->address_occurences = o->address_occurences->next;
		o->address_counter = o->address_occurences->num;
		o->address_index += 1;
		o->address_index %= o->num_addrs;
	}
	o->address_counter -= 1;

	switch (o->packet_mode) {
	case MODE_NONE:
	case MODE_GEN:
	case MODE_PCAP:
	case MODE_KTEST:
	case MODE_TAR_KTEST:
		break;
	case MODE_EREPORT:
	case MODE_ETH:
		a.mac = o->addrs.mac + ETH_ALEN * o->address_index;
		break;
	case MODE_UDP:
	case MODE_TCP:
		a.addrs4 = &o->addrs.addrs4[o->address_index];
		break;
	case MODE_UDP6:
	case MODE_TCP6:
		a.addrs6 = &o->addrs.addrs6[o->address_index];
		break;
	}

	return a;
}

static struct address_occurences *parse_address_occurences(const char *s) {
	size_t count = 1;
	struct address_occurences *aos;
	size_t index = 1;

	for (const char *c = s ; *c; c++) {
		if (*c == ',')
			count += 1;
	}
	aos = calloc(count, sizeof(*aos));
	if (!aos)
		err(-1, "calloc");
	aos[0].num = atol(s);
	for (const char *c = s ; *c; c++) {
		if (*c != ',')
			continue;
		aos[index].num = atol(c+1);
		aos[index-1].next = &aos[index];
		index += 1;
	}
	aos[count-1].next = &aos[0];

	return &aos[count-1];
}

static void prepare_gen(struct packet_opts *o) {
	uint8_t *data;
	static struct iovec *iov;
	struct gen g;

	gen_init(&g, o->generator, strlen(o->generator));

	num_uniq = g.num;
	data = map_locked(num_uniq, g.len);
	iov = map_locked(num_uniq, sizeof(*iov));
	num_msgs = UIO_MAXIOV + num_uniq - 1;
	msgs = map_locked(num_msgs, sizeof(*msgs));

	for (size_t i = 0; gen_next(&g); i++) {
		void *b = data + g.len * i;
		memcpy(b, g.buf, g.len);
		iov[i] = (struct iovec) {
			.iov_base = b,
			.iov_len  = g.len,
		};
		msgs[i].msg_hdr = (struct msghdr) {
			.msg_iov = &iov[i],
			.msg_iovlen = 1,
		};
	}
	for (size_t i = num_uniq; i < num_msgs; i++)
		memcpy(&msgs[i], &msgs[i-num_uniq], sizeof(*msgs));
	gen_free(&g);
}

static void prepare_pcap(struct packet_opts *o) {
	FILE *finput;
	pcap_t *p;
	char errbuf[PCAP_ERRBUF_SIZE];
	struct iovec *iov;
	u_char *data;
	size_t data_size;

	data = map_noreserve(MAX_MSGS, 65536);
	msgs = map_noreserve(MAX_MSGS, sizeof(*msgs));
	iov = map_noreserve(MAX_MSGS, sizeof(*iov));

	finput = fdopen(o->fd, "r");
	if (!finput)
		err(-1, "fdopen()");
	p = pcap_fopen_offline(finput, errbuf);
	if (!p)
		errx(-1, "%s", errbuf);
	if (pcap_datalink(p) != DLT_EN10MB)
		errx(-1, "pcap input must be of linktype DLT_EN10MB");

	num_uniq = 0;
	data_size = 0;
	for (;;) {
		struct pcap_pkthdr *phdr;
		const u_char *pdata;
		int rc = pcap_next_ex(p, &phdr, &pdata);
		switch (rc) {
		case -1:
			errx(-1, "%s", pcap_geterr(p));
		default:
			errx(-1, "error reading pcap input");
		case -2:
			goto done;
		case 1:;
		}
		if (phdr->caplen != phdr->len) {
			warnx("ignoring truncated frame");
			continue;
		}
		if (phdr->caplen < 14) {
			warnx("non ethernet frame of size %u", phdr->caplen);
			continue;
		}
		if (!(num_uniq % PAGE_SIZE) &&
		    (mlock(&msgs[num_uniq], sizeof(*msgs) * PAGE_SIZE) ||
		     mlock(&iov[num_uniq], sizeof(*iov) * PAGE_SIZE)))
			err(-1, "mlock");
		if (mlock(&data[data_size], phdr->caplen))
			err(-1, "mlock");
		memcpy(&data[data_size], pdata, phdr->caplen);
		iov[num_uniq] = (struct iovec) {
			.iov_base = &data[data_size],
			.iov_len = phdr->caplen,
		};
		msgs[num_uniq].msg_hdr = (struct msghdr) {
			.msg_iov = &iov[num_uniq],
			.msg_iovlen = 1,
		};
		num_uniq += 1;
		data_size += phdr->caplen;
	}
done:
	pcap_close(p);
	if (!num_uniq)
		errx(-1, "empty pcap");
	num_msgs = UIO_MAXIOV + num_uniq - 1;
	for (size_t i = num_uniq; i < num_msgs; i++) {
		if (mlock(&msgs[i], sizeof(*msgs)))
			err(-1, "mlock");
		memcpy(&msgs[i], &msgs[i-num_uniq], sizeof(*msgs));
	}
	if (mremap(msgs, sizeof(*msgs)*MAX_MSGS, sizeof(*msgs)*num_msgs,
	           0, msgs) == (void *) -1 ||
	    mremap(iov, sizeof(*iov)*MAX_MSGS, sizeof(*iov)*num_uniq,
	           0, iov) == (void *) -1 ||
	    mremap(data, 65536*MAX_MSGS, sizeof(*data)*data_size,
	           0, data) == (void *) -1)
		err(-1, "mremap");
}

static void prepare_ktest(struct packet_opts *o) {
	struct ktest_buf k;
	static struct iovec iov;

	ktest_open(&k, o->fd);
	iov.iov_len = ktest_sk_buff_32(&k, 0);
	if (iov.iov_len < 14)
		errx(2, "non ethernet frame of size %zu", iov.iov_len);
	iov.iov_base = (void *) ktest_get_obj(&k, "data", NULL);
	if (!iov.iov_base)
		errx(-1, "invalid ktest data");

	num_uniq = 1;
	num_msgs = UIO_MAXIOV + num_uniq - 1;
	msgs = map_locked(num_msgs, sizeof(*msgs));

	msgs[0].msg_hdr = (struct msghdr) {
		.msg_iov = &iov,
		.msg_iovlen = 1,
	};
	for (size_t i = num_uniq; i < num_msgs; i++)
		memcpy(&msgs[i], &msgs[i-num_uniq], sizeof(*msgs));
}

static void prepare_tar_ktest(struct packet_opts *o) {
	struct input_tar tar = {0};
	struct input_tar_file file = {0};
	char *buf = NULL;
	size_t buf_size = 65536;
	struct iovec *iov;
	u_char *data;
	size_t data_size;

	data = map_noreserve(MAX_MSGS, sizeof(*data));
	msgs = map_noreserve(MAX_MSGS, sizeof(*msgs));
	iov = map_noreserve(MAX_MSGS, sizeof(*iov));

	input_tar_open(o->input_opts, o->fd, &tar);
	buf = malloc(buf_size);

	num_uniq = 0;
	data_size = 0;
	while (input_tar_next(&tar, o->ktest, &file)) {
		struct ktest_buf k;

		if (file.size > buf_size) {
			buf_size = file.size;
			buf = realloc(buf, buf_size);
			if (!buf)
				err(-1, "realloc");
		}
		input_tar_read(&tar, buf, file.size);

		ktest_init(&k, buf, file.size);
		size_t len = ktest_sk_buff_32(&k, 0);
		if (len < 14) {
			warnx("non ethernet frame of size %zu", len);
			continue;
		}
		const char *obj = ktest_get_obj(&k, "data", NULL);
		if (!obj)
			errx(-1, "invalid ktest data");
		if (!(num_uniq % PAGE_SIZE) &&
		    (mlock(&msgs[num_uniq], sizeof(*msgs) * PAGE_SIZE) ||
		     mlock(&iov[num_uniq], sizeof(*iov) * PAGE_SIZE)))
			err(-1, "mlock");
		if (mlock(&data[data_size], len))
			err(-1, "mlock");
		memcpy(&data[data_size], obj, len);
		iov[num_uniq] = (struct iovec) {
			.iov_base = &data[data_size],
			.iov_len = len,
		};
		msgs[num_uniq].msg_hdr = (struct msghdr) {
			.msg_iov = &iov[num_uniq],
			.msg_iovlen = 1,
		};
		num_uniq += 1;
		data_size += len;
	}
	if (!num_uniq)
		errx(-1, "no usable .ktest in tar");
	num_msgs = UIO_MAXIOV + num_uniq - 1;
	for (size_t i = num_uniq; i < num_msgs; i++) {
		if (mlock(&msgs[i], sizeof(*msgs)))
			err(-1, "mlock");
		memcpy(&msgs[i], &msgs[i-num_uniq], sizeof(*msgs));
	}
	if (mremap(msgs, sizeof(*msgs)*MAX_MSGS, sizeof(*msgs)*num_msgs, 0) == (void *) -1 ||
	    mremap(iov, sizeof(*iov)*MAX_MSGS, sizeof(*iov)*num_uniq, 0) == (void *) -1 ||
	    mremap(data, sizeof(*data)*MAX_MSGS, sizeof(*data)*data_size, 0) == (void *) -1)
		err(-1, "mremap");
}

static void write_eth_header(uint8_t *b, size_t psize, struct addrs a,
                             uint16_t ethtype) {
	// MAC dst
	memcpy(&b[0], a.mac, ETH_ALEN);
	// MAC src
	b[6] = 0x1a;
	b[7] = 0x35;
	b[8] = 0x16;
	b[9] = 0x7a;
	b[10] = 0x5a;
	b[11] = 0xd7;
	// MAC type
	*((uint16_t *) &b[12]) = htons(ethtype);
}

static void prepare_ereport(struct packet_opts *o) {
	uint8_t *data;
	static struct iovec *iov;
	struct ereport_packet p = {0};

	ereport_packet_parse(o->fd, &p);
	if (p.size < 14)
		errx(-1, "non ethernet frame of size %zu", p.size);

	if (o->uniq)
		num_uniq = o->uniq;
	else if (o->num_occurences == o->num_addrs)
		num_uniq = o->sum_occurences;
	else
		num_uniq = o->num_addrs * o->sum_occurences;
	data = map_locked(num_uniq, p.size);
	iov = map_locked(num_uniq, sizeof(*iov));
	num_msgs = UIO_MAXIOV + num_uniq - 1;
	msgs = map_locked(num_msgs, sizeof(*msgs));

	for (size_t i = 0; i < num_uniq; i++) {
		write_eth_header(&data[i*p.size], p.size, select_addr(o), 0x0601);
		ereport_packet_write(&p, &data[i*p.size]);
		iov[i] = (struct iovec) {
			.iov_base = &data[p.size*i],
			.iov_len  = p.size,
		};
		msgs[i].msg_hdr = (struct msghdr) {
			.msg_iov = &iov[i],
			.msg_iovlen = 1,
		};
	}
	for (size_t i = num_uniq; i < num_msgs; i++)
		memcpy(&msgs[i], &msgs[i-num_uniq], sizeof(*msgs));

	ereport_packet_free(&p);
}

static void write_ip_header(uint8_t *b, size_t psize, struct addrs a,
                            uint16_t protocol) {
	write_eth_header(b, psize, a, 0x0800);
	// IP version & IHL
	b[14] = 0x45;
	// IP TOS
	b[15] = 0x00;
	// IP Total Length
	*((uint16_t *) &b[16]) = htons(psize-14);
	// IP Identification
	*((uint16_t *) &b[18]) = lrand48();
	// IP Flags & Fragment Offset
	*((uint16_t *) &b[20]) = 0;
	// IP TTL
	b[22] = 1;
	// IP Protocol
	b[23] = protocol;
	// IP src
	*((uint32_t *) &b[26]) = 0xffffffff;
	// IP dst
	*((uint32_t *) &b[30]) = a.addrs4->sin_addr.s_addr;
	// IP Checksum
	*((uint16_t *) &b[24]) = 0;
	uint32_t chsum = 0;
	for (size_t i = 14; i < 34; i += 2) {
		chsum += ntohs(*((uint16_t *) &b[i]));
	}
	while (chsum >> 16)
		chsum = (chsum & 0xFFFF) + (chsum >> 16);
	*((uint16_t *) &b[24]) = htons(~chsum);
}

static struct ipv6opts {
	uint8_t type;
	uint8_t len;
	uint8_t mul;
} ipv6opts[] = {
	{  0, 16, 8 },
	{ 60, 16, 8 },
	{ 43, 24, 8 },
	{ 44,  8, 0 },
	{ 51, 16, 4 },
	{ 60, 16, 8 },
	{ 43, 24, 8 },
	{ 60, 16, 8 },
	{ 43, 24, 8 },
	{ 60, 16, 8 },
	{0},
};

static size_t write_ip6_header(uint8_t *b, size_t psize, size_t nsize,
                               struct addrs a, uint16_t next_hdr) {
	size_t off = 14 + 40;
	uint8_t nh = next_hdr;
	struct ipv6opts *o = ipv6opts;
	if (psize - off >= o->len + nsize)
		nh = o->type;

	write_eth_header(b, psize, a, 0x86dd);
	// IP6 Version
	b[14] = 0x60;
	// IP6 Traffic Class
	b[15] = 0x00;
	// IP6 Flow Label
	*((uint16_t *) &b[16]) = htons(0);
	// IP6 Payload Length
	*((uint16_t *) &b[18]) = htons(psize-14-40);
	// IP6 Next Header
	b[20] = nh;
	// IP6 Hop Limit
	b[21] = 1;
	// IP6 src
	for (size_t i = 0; i < 16; i++)
		b[22+i] = 0xff;
	// IP6 dst
	for (size_t i = 0; i < 16; i++)
		b[38+i] = a.addrs6->sin6_addr.s6_addr[i];

	// Option Headers
	for (;o->len && psize - off >= o->len + nsize; o++) {
		nh = next_hdr;
		if ((o+1)->len && psize - off >= o->len + (o+1)->len + nsize)
			nh = (o+1)->type;
		// Option Next Header
		b[off] = nh;
		// Option Length
		if (o->mul)
			b[off+1] = (o->len-8)/o->mul;
		else
			b[off+1] = 0;
		// Option content
		for (size_t i = 2; i < o->len; i++)
			b[off+i] = 0;
		off += o->len;
	}

	return off;
}

static void write_udp_header(uint8_t *b, size_t psize, struct addrs a,
                             uint16_t v) {
	write_ip_header(b, psize, a, 17);
	// UDP src
	*((uint16_t *) &b[34]) = htons((lrand48() % 32768) + 32768);
	// UDP dst
	if (a.addrs4->sin_port)
		*((uint16_t *) &b[36]) = a.addrs4->sin_port;
	else
		*((uint16_t *) &b[36]) = htons(lrand48() % 32768);
	// UDP size
	*((uint16_t *) &b[38]) = htons(psize-14-20);
	// UDP Checksum
	*((uint16_t *) &b[40]) = 0;
}

static void write_udp6_header(uint8_t *b, size_t psize, struct addrs a,
                              uint16_t v) {
	size_t off = write_ip6_header(b, psize, 8, a, 17);
	// UDP src
	*((uint16_t *) &b[off]) = htons((lrand48() % 32768) + 32768);
	// UDP dst
	if (a.addrs6->sin6_port)
		*((uint16_t *) &b[off+2]) = a.addrs6->sin6_port;
	else
		*((uint16_t *) &b[off+2]) = htons(lrand48() % 32768);
	// UDP size
	*((uint16_t *) &b[off+4]) = htons(psize-off);
	// UDP Checksum
	*((uint16_t *) &b[off+6]) = 0;
}

static void write_tcp_header(uint8_t *b, size_t psize, struct addrs a,
                             uint16_t v) {
	write_ip_header(b, psize, a, 6);
	// TCP src
	*((uint16_t *) &b[34]) = htons((lrand48() % 32768) + 32768);
	// TCP dst
	if (a.addrs4->sin_port)
		*((uint16_t *) &b[36]) = a.addrs4->sin_port;
	else
		*((uint16_t *) &b[36]) = htons(lrand48() % 32768);
	// TCP sequence
	*((uint32_t *) &b[38]) = htons(lrand48() % 4294967296);
	// TCP ack
	*((uint32_t *) &b[42]) = htons(0);
	// TCP offset
	b[46] = 0x50;
	// TCP flags
	b[47] = 0x02;
	// TCP windows size
	*((uint16_t *) &b[48]) = htons(0);
	// TCP checksum
	*((uint16_t *) &b[50]) = htons(0);
	// TCP urgent pointer
	*((uint16_t *) &b[52]) = htons(0);
}

static void write_tcp6_header(uint8_t *b, size_t psize, struct addrs a,
                              uint16_t v) {
	size_t off = write_ip6_header(b, psize, 8, a, 6);
	// TCP src
	*((uint16_t *) &b[off+0]) = htons((lrand48() % 32768) + 32768);
	// TCP dst
	if (a.addrs6->sin6_port)
		*((uint16_t *) &b[off+2]) = a.addrs6->sin6_port;
	else
		*((uint16_t *) &b[off+2]) = htons(lrand48() % 32768);
	// TCP sequence
	*((uint32_t *) &b[off+4]) = htons(lrand48() % 4294967296);
	// TCP ack
	*((uint32_t *) &b[off+8]) = htons(0);
	// TCP offset
	b[off+12] = 0x50;
	// TCP flags
	b[off+13] = 0x02;
	// TCP windows size
	*((uint16_t *) &b[off+14]) = htons(0);
	// TCP checksum
	*((uint16_t *) &b[off+16]) = htons(0);
	// TCP urgent pointer
	*((uint16_t *) &b[off+18]) = htons(0);
}

static void write_payload(struct packet_opts *o, uint8_t *b, size_t size) {
	uint64_t value = 0;

	switch (o->payload_mode) {
	case MODE_ZERO:
		break;
	case MODE_RAND:
		value = lrand48() % o->max + o->off;
		break;
	case MODE_POW:
  		value = o->off + o->max - pow(pow(o->max, o->alpha+1) * drand48 (), 1 / (o->alpha + 1));
		break;
	case MODE_INC:
		value = o->payload_counter + o->off;
		o->payload_counter += 1;
		o->payload_counter %= o->max;
		break;
	default:
		assert(false);
	}

	uint64_t n = htobe64(value);
	if (size < sizeof(n)) {
		memcpy(b, (uint8_t *) &n + (sizeof(n)-size), size);
	} else {
		memcpy(b, &n, sizeof(n));
		memset(b + sizeof(n), 0, size - sizeof(n));
	}
}

static void prepare_fill(struct packet_opts *o, size_t hsize,
                        void (*w)(uint8_t *b, size_t psize,
                        struct addrs a, uint16_t v), uint16_t v) {
	uint8_t *data;
	static struct iovec *iov;
	size_t psize = hsize + o->size;

	if (o->uniq)
		num_uniq = o->uniq;
	else if (o->num_occurences == o->num_addrs)
		num_uniq = o->sum_occurences;
	else
		num_uniq = o->num_addrs * o->sum_occurences;
	data = map_locked(num_uniq, psize);
	iov = map_locked(num_uniq, sizeof(*iov));
	num_msgs = UIO_MAXIOV + num_uniq - 1;
	msgs = map_locked(num_msgs, sizeof(*msgs));

	for (size_t i = 0; i < num_uniq; i++) {
		write_payload(o, &data[i*psize + hsize], o->size);
		w(&data[i*psize], psize, select_addr(o), v);
		iov[i] = (struct iovec) {
			.iov_base = &data[psize*i],
			.iov_len  = psize,
		};
		msgs[i].msg_hdr = (struct msghdr) {
			.msg_iov = &iov[i],
			.msg_iovlen = 1,
		};
	}
	for (size_t i = num_uniq; i < num_msgs; i++)
		memcpy(&msgs[i], &msgs[i-num_uniq], sizeof(*msgs));
}

static bool prepare(struct packet_opts *o) {
	if (o->size == -1) {
		switch (o->payload_mode) {
		case MODE_ZERO:
			o->size = 0;
			break;
		default:
			o->size = 4;
			break;
		}
	}

	switch (o->packet_mode) {
	case MODE_GEN:
		prepare_gen(o);
		return true;
	case MODE_PCAP:
		prepare_pcap(o);
		return true;
	case MODE_KTEST:
		prepare_ktest(o);
		return true;
	case MODE_TAR_KTEST:
		prepare_tar_ktest(o);
		return true;
	case MODE_EREPORT:
		prepare_ereport(o);
		return true;
	case MODE_ETH:
		prepare_fill(o, 14, &write_eth_header, 0x0601);
		return true;
	case MODE_UDP:
		prepare_fill(o, 14+20+8, &write_udp_header, 0);
		return true;
	case MODE_TCP:
		prepare_fill(o, 14+20+20, &write_tcp_header, 0);
		return true;
	case MODE_UDP6:
		prepare_fill(o, 14+40+8, &write_udp6_header, 0);
		return true;
	case MODE_TCP6:
		prepare_fill(o, 14+40+20, &write_tcp6_header, 0);
		return true;
	default:
		return false;
	}
}

static void write_pcap(void) {
	uint32_t ghdr[6] = {
		0xa1b2c3d4,
		__constant_ntohl((((uint32_t ) __constant_htons(2))<<16) +
		                 __constant_htons(4)),
		0,
		0,
		262144,
		DLT_EN10MB,
	};
	if (write(1, ghdr, sizeof(ghdr)) != sizeof(ghdr))
		err(-1, "write(1)");
	for (size_t i = 0; i < num_uniq; i++) {
		size_t len = msgs[i].msg_hdr.msg_iov->iov_len;
		if (len > UINT32_MAX)
			len = UINT32_MAX;
		uint32_t phdr[4] = {
			0,
			0,
			len,
			len,
		};
		if (write(1, phdr, sizeof(phdr)) != sizeof(phdr))
			err(-1, "write(1)");
		if (write(1, msgs[i].msg_hdr.msg_iov->iov_base, len) != len)
			err(-1, "write(1)");
	}
}

static void open_socket(const char *iface) {
	static struct sockaddr_ll addr = {
		.sll_family = AF_PACKET,
		.sll_halen  = ETH_ALEN,
	};
	struct ifreq if_idx = {.ifr_name = {0}};

	sock = socket(AF_PACKET, SOCK_RAW, 0);
	if (sock == -1)
		err(-1, "unable to open socket");

	strncpy(if_idx.ifr_name, iface, IFNAMSIZ-1);
	if (ioctl(sock, SIOCGIFINDEX, &if_idx) == -1)
		err(-1, "invalid iface '%s'", iface);
	addr.sll_ifindex = if_idx.ifr_ifindex;

	for (size_t i = 0; i < num_msgs; i++) {
		msgs[i].msg_hdr.msg_name = &addr;
		msgs[i].msg_hdr.msg_namelen = sizeof(addr);
	}
}

static void snd(uint64_t count, uint64_t burst, unsigned int wait, bool draw) {
	unsigned int num = num_msgs - num_uniq + 1;
	struct mmsghdr *dmsgs = NULL;
	int rc;

	if (burst < num)
		num = burst;
	if (UIO_MAXIOV < num)
		num = UIO_MAXIOV;

	if (draw) {
		dmsgs = calloc(num, sizeof(*dmsgs));
		for (uint64_t ii = 0; ii < num; ii++)
			memcpy(&dmsgs[ii], &msgs[lrand48() % num_uniq], sizeof(*msgs));
	}

	for (uint64_t i = 0; i < count; i += rc) {
		unsigned int num_round = num;
		struct mmsghdr *m;

		if (count - i  < num_round)
			num_round = count - i;
		if (((count - i - 1) % burst) + 1 < num_round)
			num_round = ((count - i - 1) % burst) + 1;

		if (draw)
			m = dmsgs;
		else
			m = &msgs[i % num_uniq];

		if (wait && i % burst == 0)
			poll(NULL, 0, wait);

		rc = sendmmsg(sock, m, num_round, 0);
		if (rc == -1)
			err(-1, "unable to send on socket");

		if (draw) {
			for (uint64_t ii = 0; ii < rc; ii++)
				memcpy(&dmsgs[ii], &msgs[lrand48() % num_uniq], sizeof(*msgs));
		}
	}
}

static pid_t *pids;
static size_t num_pids;

static void killonexit(void) {
	for (size_t i = 0; i < num_pids; i++) {
		if (pids[i] == -1)
			continue;
		kill(pids[i], SIGTERM);
		waitpid(pids[i], NULL, 0);
	}
}

static void sigaction_exit(int signum, siginfo_t *siginfo, void *context) {
	exit(-1);
}

static void fork_processes(uint16_t processes) {
	struct sigaction act = {
		.sa_flags = SA_SIGINFO,
	};

	if (!processes)
		return;

	pids = calloc(processes, sizeof(*pids));
	for (size_t i = 0; i < processes; i++)
		pids[i] = -1;
	num_pids = processes;

	atexit(&killonexit);
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask, SIGINT);
	sigaddset(&act.sa_mask, SIGTERM);
	act.sa_sigaction = &sigaction_exit;
	if (sigaction(SIGINT, &act, NULL))
		err(-1, "unable to register signal handler");
	if (sigaction(SIGTERM, &act, NULL))
		err(-1, "unable to register signal handler");

	for (size_t i = 0; i < num_pids; i++) {
		cpu_set_t set;
		CPU_ZERO(&set);
		CPU_SET(i, &set);

		pids[i] = fork();
		if (pids[i] == -1)
			err(-1, "fork");
		if (!pids[i]) {
			return;
		}
		if (sched_setaffinity(pids[i], sizeof(set), &set))
			err(-1, "sched_setaffinity");
	}

	wait(NULL);
	exit(0);
}

static void usage(char *argv0) {
	fprintf(stderr, "Usage: %s <packet-mode> [options] <iface> [addr]...\n", argv0);
	fprintf(stderr, "Packet Mode:\n");
	fprintf(stderr, "\t-g <pattern>       generate from pattern\n");
	fprintf(stderr, "\t-p                 generate from PCAP input\n");
	fprintf(stderr, "\t-k                 generate from KTEST input\n");
	fprintf(stderr, "\t-t                 generate from tar input containing .ktest\n");
	fprintf(stderr, "\t-E                 generate from ereport\n");
	fprintf(stderr, "\t-u                 generate UDP packets\n");
	fprintf(stderr, "\t-e                 generate ethernet frames\n");
	fprintf(stderr, "\t-y                 generate TCP SYN segments\n");
	fprintf(stderr, "\t-6                 generate UDP6 packets\n");
	fprintf(stderr, "\t-z                 generate TCP6 SYN segments\n");
	fprintf(stderr, "Payload Mode:\n");
	fprintf(stderr, "\t-0                 generate zero payload [default]\n");
	fprintf(stderr, "\t-i                 increasing payload\n");
	fprintf(stderr, "\t-l <alpha>         generate powerlaw random payload\n");
	fprintf(stderr, "\t-r                 generate uniform random payload\n");
	fprintf(stderr, "Options:\n");
	fprintf(stderr, "\t-b <num=-1>        send bursts of num packets\n");
	fprintf(stderr, "\t-c <num=-1>        send num packets\n");
	fprintf(stderr, "\t-d                 draw random packets for transmission\n");
	fprintf(stderr, "\t-K <test>          select ktest from tar\n");
	fprintf(stderr, "\t-m <num=0>         fork multiple processes\n");
	fprintf(stderr, "\t-n <num>           number of unique packets\n");
	fprintf(stderr, "\t-o <a,b,c,...>     address occurences\n");
	fprintf(stderr, "\t-q                 be quieter\n");
	fprintf(stderr, "\t-s <size>          payload size\n");
	fprintf(stderr, "\t-T                 test whether input is suitable\n");
	fprintf(stderr, "\t-w <timeout=10ms>  wait timeout between bursts\n");
	fprintf(stderr, "\t-X <max=-1:off=0>  maximum and offset value in payload\n");
	input_usage();
	exit(1);
}

static bool quiet = false;

static void print_log(char *fmt, ...) {
	va_list args;

	if (quiet)
		return;
	if (!isatty(fileno(stderr)))
		return;

	va_start(args, fmt);
	vfprintf(stderr, fmt, args);
	va_end(args);
}

int main(int argc, char **argv) {
	struct input_opts input_opts = {0};
	struct packet_opts o = {
		.fd         = -1,
		.input_opts = &input_opts,
		.size       = -1,
		.max        = -1,
		.ktest      = "*/*.ktest",
	};
	const char *address_occurences = "1";
	bool test = false;
	uint64_t count = -1;
	uint64_t burst = -1;
	unsigned int wait = 10;
	uint16_t proceses = 0;
	bool draw = false;
	int opt;

	srand48(0);

	while ((opt = getopt(argc, argv, "g:pktEuey6z0rl:iqb:c:dK:m:n:o:qrs:Tw:X:" INPUT_OPTS)) != -1) {
		switch (opt) {
		case 'g':
			o.packet_mode = MODE_GEN;
			o.generator = optarg;
			continue;
		case 'p':
			o.packet_mode = MODE_PCAP;
			continue;
		case 'k':
			o.packet_mode = MODE_KTEST;
			continue;
		case 't':
			o.packet_mode = MODE_TAR_KTEST;
			input_opts.tar = &input_tar_iterate;
			continue;
		case 'E':
			o.packet_mode = MODE_EREPORT;
			continue;
		case 'u':
			o.packet_mode = MODE_UDP;
			continue;
		case 'e':
			o.packet_mode = MODE_ETH;
			continue;
		case 'y':
			o.packet_mode = MODE_TCP;
			continue;
		case '6':
			o.packet_mode = MODE_UDP6;
			continue;
		case 'z':
			o.packet_mode = MODE_TCP6;
			continue;
		case '0':
			o.payload_mode = MODE_ZERO;
			continue;
		case 'r':
			o.payload_mode = MODE_RAND;
			continue;
		case 'l':
			o.payload_mode = MODE_POW;
			sscanf(optarg, "%lf", &o.alpha);
			continue;
		case 'i':
			o.payload_mode = MODE_INC;
			continue;
		case 'b':
			sscanf(optarg, "%"SCNu64, &burst);
			continue;
		case 'c':
			sscanf(optarg, "%"SCNu64, &count);
			continue;
		case 'd':
			draw = true;
			continue;
		case 'K':
			snprintf(o.ktest, sizeof(o.ktest), "*/%s.ktest", optarg);
			continue;
		case 'm':
			sscanf(optarg, "%"SCNu16, &proceses);
			continue;
		case 'n':
			sscanf(optarg, "%zu", &o.uniq);
			continue;
		case 'o':
			address_occurences = optarg;
			continue;
		case 'q':
			quiet = true;
			continue;
		case 's':
			sscanf(optarg, "%zu", &o.size);
			continue;
		case 'T':
			test = true;
			continue;
		case 'w':
			sscanf(optarg, "%u", &wait);
			continue;
		case 'X':
			sscanf(optarg, "%"SCNu64":%"SCNu64, &o.max, &o.off);
			continue;
		}
		if (input_optparse(opt, &input_opts))
			continue;
		usage(argv[0]);
	}
	if (o.packet_mode == MODE_NONE)
		errx(-1, "a packet mode must be specified");
	if (!burst)
		usage(argv[0]);

	if (argc - optind == 0)
		usage(argv[0]);
	o.num_addrs = argc - optind - 1;
	o.addrs = lookup_addrs(o.packet_mode, o.num_addrs, &argv[optind+1]);
	if (!o.num_addrs)
		o.num_addrs = 1;
	o.address_occurences = parse_address_occurences(address_occurences);
	o.sum_occurences = o.address_occurences->num;
	o.num_occurences = 1;
	for (struct address_occurences *aos = o.address_occurences->next;
	     aos != o.address_occurences;
	     aos = aos->next) {
		o.sum_occurences += aos->num;
		o.num_occurences += 1;
	}
	o.address_index = o.num_addrs - 1;

	if (!strcmp(argv[optind], "-"))
		quiet = true;

	print_log("preparing packets\n");

	o.fd = input_open(&input_opts);

	if (!prepare(&o))
		usage(argv[0]);

	print_log("prepared %"PRIu64" packets\n", num_uniq);

	if (test)
		exit(0);

	if (!strcmp(argv[optind], "-")) {
		write_pcap();
		exit(0);
	}

	open_socket(argv[optind]);

	fork_processes(proceses);

	if (mlockall(MCL_CURRENT | MCL_FUTURE))
		err(-1, "mlockall");

	print_log("sending packets\n");
	snd(count, burst, wait, draw);
	
	exit(0);
}

