#include "statistics.h"
#include "measure.h"

#include <stddef.h>
#include <stdint.h>
#include <inttypes.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/netlink.h>
#include <linux/if.h>
#include <linux/sockios.h>
#include <linux/ethtool.h>
#include <time.h>
#include <sched.h>
#include <err.h>

//LDLIBS=m


struct iface_data {
	int                  r;
	struct ifreq         ifr;
	struct ethtool_stats stats;
};

struct iface_list {
	int               fd;
	size_t            num_ifaces;
	size_t            num_counters;
	size_t            dsize;
	size_t           *ctrs;
	struct iface_data d[0];
};

struct counter_list {
	size_t size;
	char **names;
};

void counter_add(struct counter_list *cl, const char *name) {
	cl->size += 1;
	cl->names = realloc(cl->names, sizeof(*cl->names) * cl->size);
	if (!cl->names)
		err(-1, "realloc()");
	cl->names[cl->size-1] = strdup(name);
	if (!cl->names[cl->size-1])
		err(-1, "strdup()");
}

struct template {
	const char *name;
	const char *const *counters;
} templates[] = {
	{
		.name     = "ixgbe",
		.counters = (const char *[]) {"rx_pkts_nic", NULL},
	},
	{
		.name     = "nfp",
		.counters = (const char *[]) {"dev_rx_pkts", NULL},
	},
	{
		.name     = "nfp-mac",
		.counters = (const char *[]) {"mac.rx_pkts", NULL},
	},
	{
		.name     = "nfp-bpf",
		.counters = (const char *[]) {"bpf_pass_pkts", "bpf_app1_pkts", "bpf_app2_pkts", "bpf_app3_pkts", NULL},
	},
	{
		.name     = "nfp-bpf-drop",
		.counters = (const char *[]) {"bpf_app1_pkts", NULL},
	},
	{
		.name     = "nfp-pause",
		.counters = (const char *[]) {"mac.tx_pause_mac_ctrl_frames", NULL},
	},
	{0}
};

void template_add(struct counter_list *cl, const char *name) {
	for (struct template *t = &templates[0]; t->name; t++) {
		if (!strcmp(name, t->name)) {
			for (const char *const *c = t->counters; *c; c++)
				counter_add(cl, *c);
			return;
		}
	}
	errx(-1, "not template '%s' found", name);
}

struct iface_list *prepare_iface_list(char **ifaces, size_t count, struct counter_list *cl) {
	int fd;
	struct {
		struct ethtool_sset_info s;
		uint32_t set_size;
	} sset = { .s = {
		.cmd       = ETHTOOL_GSSET_INFO,
		.sset_mask = 1 << ETH_SS_STATS,
	}};
	struct ifreq ifr = {
			.ifr_data = &sset,
	};
	strncpy(ifr.ifr_name, ifaces[0], IFNAMSIZ-1);
	size_t ssize;
	size_t dsize;
	struct ethtool_gstrings *gstrings;
	struct iface_list *l;

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	if (fd == -1)
		err(-1, "socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC)");
	if (ioctl(fd, SIOCETHTOOL, &ifr))
		err(-1, "ioctl(fd, SIOCETHTOOL, ETHTOOL_GSSET_INFO)");
	if (sset.s.sset_mask != 1 << ETH_SS_STATS)
		errx(-1, "ETHTOOL_GSTATS unsupported for %s", ifaces[0]);
	ssize = sset.s.data[0];
	dsize = sizeof(struct iface_data) + 8*ssize;

	l = malloc(sizeof(*l) + count * dsize + cl->size * sizeof(l->ctrs[0]));
	if (!l)
		err(-1, "malloc");
	*l = (struct iface_list) {
		.fd           = fd,
		.num_ifaces   = count,
		.num_counters = cl->size,
		.dsize        = dsize,
		.ctrs         = ((void *)(l->d)) + count * dsize,
	};
	for (size_t i = 0; i < count; i++) {
		struct iface_data *d = ((void *) &l->d) + i*l->dsize;
		d->stats = (struct ethtool_stats) {
			.cmd     = ETHTOOL_GSTATS,
			.n_stats = ssize,
		};
		d->ifr = (struct ifreq) {
			.ifr_data = &d->stats,
		};
		strncpy(d->ifr.ifr_name, ifaces[i], IFNAMSIZ-1);
	}

	gstrings = malloc(sizeof(*gstrings) + ssize * ETH_GSTRING_LEN);
	if (!gstrings)
		err(-1, "malloc");
	*gstrings = (struct ethtool_gstrings) {
		.cmd        = ETHTOOL_GSTRINGS,
		.string_set = ETH_SS_STATS,
		.len        = ssize,
	};
	ifr.ifr_data = gstrings;
	if (ioctl(fd, SIOCETHTOOL, &ifr))
		err(-1, "ioctl(fd, SIOCETHTOOL, ETHTOOL_GSTRINGS)");
	for (size_t i = 0; i < cl->size; i++) {
		l->ctrs[i] = -1;
		for (size_t ii = 0; ii < gstrings->len; ii++) {
			if (!strncmp(cl->names[i], (char *) gstrings->data + ii*ETH_GSTRING_LEN, ETH_GSTRING_LEN)) {
				l->ctrs[i] = ii;
				break;
			}
		}
		if (l->ctrs[i] == -1)
			errx(-1, "no counter '%s' for %s", cl->names[i], ifaces[0]);
	}

	return l;
}

static uint64_t extract_counters(struct iface_list *l) {
	uint64_t c = 0;

	for (size_t i = 0; i < l->num_ifaces; i++) {
		struct iface_data *d = ((void *) &l->d) + i*l->dsize;
		if (d->r)
			errx(-1, "ioctl(SIOCETHTOOL, ETHTOOL_GSTATS)");
		for (size_t ii = 0; ii < l->num_counters; ii++)
			c += d->stats.data[l->ctrs[ii]];
	}

	return c;
}

static void get_point(struct timespec *t, uint64_t *c, struct iface_list *l) {
	if (clock_gettime(CLOCK_MONOTONIC_RAW, t))
		err(-1, "clock_gettime(CLOCK_MONOTONIC_RAW)");
	for (size_t i = 0; i < l->num_ifaces; i++) {
		struct iface_data *d = ((void *) &l->d) + i*l->dsize;
			d->r = ioctl(l->fd, SIOCETHTOOL, &d->ifr);
	}
	*c = extract_counters(l);
}

static void measure(size_t skip, double wait, size_t count, uint32_t *data, struct iface_list *l) {
	struct timespec ta, tb;
	uint64_t ca, cb;
	uint64_t rate;

	if (SIZE_MAX-skip > count) {
		count += skip;
		data -= skip;
	}

	get_point(&tb, &cb, l);

	for (size_t i = 0; i < count; i++) {
		ta = tb;
		ca = cb;
		sleep_dbl(wait);
		get_point(&tb, &cb, l);
		rate = calculate_rate(ta, tb, ca, cb);
		if (skip) {
			skip -= 1;
			continue;
		}
		printf("%"PRIu64"\n", rate);
		fflush(stdout);
		if (!data)
			continue;
		if (rate > UINT32_MAX)
			errx(-1, "rate > UINT32_MAX");
		data[i] = rate;
	}
}

static void measure_inverse(double wait, double numerator, struct iface_list *l) {
	struct timespec ta, tb;
	uint64_t ca, cb;
	double inverse = NAN;

	get_point(&tb, &cb, l);

	for (;;) {
		ta = tb;
		ca = cb;
		sleep_dbl(wait);
		get_point(&tb, &cb, l);
		inverse = calculate_inverse_rate(ta, tb, ca, cb, numerator);
		printf("%f\n", inverse);
		fflush(stdout);
	}
}

static void activate_realtime(void) {
	struct sched_param param = {0};

	if (mlockall(MCL_CURRENT|MCL_FUTURE))
		err(-1, "mlockall");

	param.sched_priority = sched_get_priority_max(SCHED_FIFO);
	if (param.sched_priority == -1)
		err(-1, "sched_get_priority_max(SCHED_FIFO)");
	if (sched_setscheduler(0, SCHED_FIFO | SCHED_RESET_ON_FORK, &param))
		err(-1, "sched_setscheduler(SCHED_FIFO)");
}

static void usage(char *argv0) {
	fprintf(stderr, "Usage: %s [counters] [options] <iface...>\n", argv0);
	fprintf(stderr, "Counters:\n");
	fprintf(stderr, "\t-E <names...>      use ethtool -S counters\n");
	fprintf(stderr, "\t-t <template...>   use counter template\n");
	fprintf(stderr, "Options:\n");
	fprintf(stderr, "\t-c <count=-1>      number of measurements\n");
	fprintf(stderr, "\t-i <numerator>     calculate the inverse with the given numerator\n");
	fprintf(stderr, "\t-s <skip=1>        skip number of data points\n");
	fprintf(stderr, "\t-w <time=1.0s>     wait time for each measurement\n");
	statistics_usage();
	exit(1);
}

int main(int argc, char** argv)
{
	struct statistics_params p = {0};
	size_t count = -1;
	size_t skip = 1;
	double wait = 1.0;
	struct counter_list cl = {0};
	struct iface_list *l;
	uint32_t *data = NULL;
	double inverse = NAN;
	int opt;

	while ((opt = getopt(argc, argv, "E:t:c:i:s:w:" STATISTICS_OPTS)) != -1) {
		switch (opt) {
		case 'E':
			counter_add(&cl, optarg);
			continue;
		case 't':
			template_add(&cl, optarg);
			continue;
		case 'c':
			sscanf(optarg, "%zu", &count);
			continue;
		case 'i':
			sscanf(optarg, "%lf", &inverse);
			continue;
		case 's':
			sscanf(optarg, "%zu", &skip);
			continue;
		case 'w':
			sscanf(optarg, "%lf", &wait);
			continue;
		}
		if (statistics_optparse(opt, &p))
			continue;
		usage(argv[0]);
	}

	if (!cl.size)
		usage(argv[0]);
	if (argc-optind < 1)
		usage(argv[0]);
	l = prepare_iface_list(argv+optind, argc-optind, &cl);

	activate_realtime();

	if (count != -1 && isnan(inverse)) {
		data = calloc(count, sizeof(*data));
		if (!data)
			err(-1, "calloc(%zu, %zu)", count, sizeof(*data));
	}

	if (isnan(inverse)) {
		measure(skip, wait, count, data, l);
	} else {
		measure_inverse(wait, inverse, l);
	}

	if (count != -1)
		statistics_print(data, count, &p);

	return 0;
}

