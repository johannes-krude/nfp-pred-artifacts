
#include "bpf.h"

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <net/if.h>
#include <sys/syscall.h>
#include <sys/resource.h>
#include <arpa/inet.h>
#include <linux/bpf.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if_ether.h>
#include <linux/tc_act/tc_bpf.h>
#include <errno.h>
#include <err.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/sysinfo.h>
#include <poll.h>
#include <ftw.h>

#define _IFLA_XDP 43
#define _IFLA_XDP_FD 1
#define _IFLA_XDP_FLAGS 3
#define _XDP_FLAGS_UPDATE_IF_NOEXIST 1
#define _BPF_OBJ_NAME_LEN 16U

#define LOG_BUF_SIZE 10485760*16

#define SYS_PROG_PATH "/sys/fs/bpf/progs"
#define SYS_MAP_PATH "/sys/fs/bpf/maps"

static void mk_bpf_dirs(const char *ifname) {
	char path[strlen(SYS_MAP_PATH) + strlen(ifname) + 3];

	if (mkdir(SYS_PROG_PATH, 0777) && errno != EEXIST)
		err(-1, "mkdir(%s)", SYS_PROG_PATH);

	if (mkdir(SYS_MAP_PATH, 0777) && errno != EEXIST)
		err(-1, "mkdir(%s)", SYS_MAP_PATH);

	snprintf(path, 40, SYS_MAP_PATH"/%s/", ifname);
	if (mkdir(path, 0777) && errno != EEXIST)
		err(-1, "mkdir(%s)", path);
}

int bpf_load(enum bpf_prog_type type, const struct bpf_insn *instr, size_t num,
		uint32_t ifindex) {
	char *log_buf;
	struct {
		uint32_t prog_type;
		uint32_t insn_cnt;
		uint64_t __attribute__((aligned(8))) insns;
		uint64_t __attribute__((aligned(8))) license;
		uint32_t log_level;
		uint32_t log_size;
		uint64_t __attribute__((aligned(8))) log_buf;
		uint32_t kern_version;
		uint32_t prog_flags;
		char     prog_name[16];
		uint32_t prog_ifindex;
	} attr = {
		.prog_type = type,
		.insn_cnt  = num,
		.insns     = (uint64_t) instr,
		//.license   = (uint64_t) "GPL v2",
		.license   = (uint64_t) "",
		.log_level = 1,
		.log_size  = LOG_BUF_SIZE,
		.prog_ifindex = ifindex,
	};
	int fd;

	log_buf = malloc(LOG_BUF_SIZE);
	if (!log_buf)
		err(-1, "malloc");
	attr.log_buf = (uint64_t) log_buf,

	fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
	if (fd == -1) {
		warn("bpf(BPF_PROG_LOAD)");
		if (errno != ENOSPC)
			fprintf(stderr, "%s", log_buf);
		exit(-1);
	}

	free(log_buf);
	return fd;
}

void bpf_info(int fd, struct _bpf_prog_info *info) {
	struct _bpf_prog_info info2 = {0};
	struct {
		uint32_t bpf_fd;
		uint32_t info_len;
		uint64_t info;
	} attr = {
		.bpf_fd   = fd,
		.info_len = sizeof(info2),
		.info     = (uint64_t) &info2,
	};

	memset(info, 0, sizeof(*info));
	if (syscall(__NR_bpf, BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr)))
		err(-1, "bpf(BPF_OBJ_GET_INFO_BY_FD)");

	info->jited_prog_insns = (uint64_t) malloc(info2.jited_prog_len);
	if (!info->jited_prog_insns)
		err(-1, "malloc");
	info->jited_prog_len = info2.jited_prog_len;
	attr.info = (uint64_t) info;
	attr.info_len = sizeof(*info);

	if (syscall(__NR_bpf, BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr)))
		err(-1, "bpf(BPF_OBJ_GET_INFO_BY_FD)");
}

#define MEMLIMIT_BUFFER (256*1024*1024)

static void limit_mem(void) {
	struct sysinfo si;
	struct rlimit rlimit = {
		.rlim_cur = RLIM64_INFINITY,
		.rlim_max = RLIM64_INFINITY,
	};
	static bool done = false;

	if (done)
		return;

	if (sysinfo(&si) == -1)
		err(-1, "sysinfo()");
	rlimit.rlim_cur = si.freeram - MEMLIMIT_BUFFER;
	rlimit.rlim_max = si.freeram - MEMLIMIT_BUFFER;

	if (setrlimit(RLIMIT_MEMLOCK, &rlimit))
		err(-1, "setrlimit(RLIMIT_MEMLOCK, %lu)", si.freeram);

	done = true;
}

int bpf_map_create(enum bpf_map_type type, size_t key_size, size_t value_size,
		size_t max_entries, int ifindex, const char* ifname,
		const char *mapname) {
	struct {
		uint32_t map_type;
		uint32_t key_size;
		uint32_t value_size;
		uint32_t max_entries;
		uint32_t map_flags;
		uint32_t inner_map_fd;
		uint32_t numa_node;
		char map_name[_BPF_OBJ_NAME_LEN];
		uint32_t map_ifindex;
	} attr = {
		.map_type     = type,
		.key_size     = key_size,
		.value_size   = value_size,
		.max_entries  = max_entries,
		.map_ifindex  = ifindex,
	};
	int fd;

	limit_mem();

	fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
	if (fd == -1 && errno == EPERM)
		return -1;
	if (fd == -1)
		err(-1, "bpf(BPF_MAP_CREATE, %s)", mapname);

	if (mapname) {
		char path[strlen(SYS_MAP_PATH) + strlen(ifname) + strlen(mapname) + 3];
		mk_bpf_dirs(ifname);
		snprintf(path, 40, SYS_MAP_PATH"/%s/%s", ifname, mapname);
		bpf_map_delete(-1, ifname, mapname);

		union bpf_attr attr_pin = {
			.pathname = (uint64_t) path,
			.bpf_fd   = fd,
		};
		int res = syscall(__NR_bpf, BPF_OBJ_PIN, &attr_pin, sizeof(attr_pin));
		if (res == -1)
			err(-1, "bpf(BPF_OBJ_PIN, %s", path);
	}

	return fd;
}

void bpf_map_delete(int fd, const char* ifname, const char *mapname) {
	char path[strlen(SYS_MAP_PATH) + strlen(ifname) + strlen(mapname) + 3];
	int rc;

	snprintf(path, sizeof(path), SYS_MAP_PATH"/%s/%s", ifname, mapname);
	rc= unlink(path);
	if (rc == -1 && errno != ENOENT)
		err(-1, "unlink(%s)", path);
	if (fd != -1 && close(fd) == -1)
		err(-1, "close(%i)", fd);
	if (!rc || fd != -1)
		if (poll(NULL, 0, 100) == -1)
			err(-1, "poll(NULL, 0, 100)");
}

int bpf_map_open(const char *ifname, const char *mapname) {
	char path[strlen(SYS_MAP_PATH) + strlen(ifname) + strlen(mapname) + 3];
	snprintf(path, sizeof(path), SYS_MAP_PATH"/%s/%s", ifname, mapname);
	struct {
		uint64_t pathname;
		uint32_t bpf_fd;
		uint32_t file_flags;
	} attr = {
		.pathname = (uint64_t) path,
	};
	int fd;

	fd = syscall(__NR_bpf, BPF_OBJ_GET, &attr, sizeof(attr));
	if (fd == -1)
		err(-1, "bpf(BPF_OBJ_GET)");

	return fd;
}

void bpf_map_insert(int fd, const void *key, const void *value, uint64_t flags) {
	static uint64_t xflags = 1L<<63;
	int r;

	union bpf_attr bpf_attr = {
		.map_fd = fd,
		.key    = (uint64_t) key,
		.value  = (uint64_t) value,
		.flags  = flags | xflags,
	};
	r = syscall(__NR_bpf, BPF_MAP_UPDATE_ELEM, &bpf_attr, sizeof(bpf_attr));
	if (xflags && r && errno == EINVAL) {
		bpf_attr.flags &= ~xflags;
		xflags = 0;
		r = syscall(__NR_bpf, BPF_MAP_UPDATE_ELEM, &bpf_attr, sizeof(bpf_attr));
	}
	if (r)
		err(2, "bpf(BPF_MAP_UPDATE_ELEM)");
}

void bpf_map_lookup(int fd, const void *key, void *value, uint64_t flags) {
	int r;

	union bpf_attr bpf_attr = {
		.map_fd = fd,
		.key    = (uint64_t) key,
		.value  = (uint64_t) value,
		.flags  = flags,
	};
	r = syscall(__NR_bpf, BPF_MAP_LOOKUP_ELEM, &bpf_attr, sizeof(bpf_attr));
	if (r)
		err(2, "bpf(BPF_MAP_LOOKUP_ELEM)");
}

static int netlink_do(void *nlmsg, size_t size, size_t num) {
	int sock;
	char buf[4096];
	struct sockaddr_nl addr = {
		.nl_family = AF_NETLINK,
	};
	size_t seq = 1;
	//int one = 1;
	int r = 0;

	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (sock == -1)
		err(-1, "socket(AF_NETLINK)");
	//if (setsockopt(sock, SOL_NETLINK, NETLINK_EXT_ACK, &one, sizeof(one)))
	//	err(-1, "setsockopt(NETLINK_EXT_ACK, 1)");
	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)))
		err(-1, "bind(AF_NETLINK)");
	if (send(sock, nlmsg, size, 0) == -1)
		err(-1, "send(AF_NETLINK)");
	while (seq <= num) {
		ssize_t len = recv(sock, &buf, sizeof(buf), 0);
		if (len == -1)
			err(-1, "recv(AF_NETLINK)");
		for (struct nlmsghdr *nh = (struct nlmsghdr *) buf;
		     NLMSG_OK(nh, len);
		     nh = NLMSG_NEXT(nh, len)) {
			switch (nh->nlmsg_type) {
				case NLMSG_NOOP:
					break;
				case NLMSG_OVERRUN:
					errx(-1, "NLMSG_OVERRUN");
				case NLMSG_ERROR:;
					r = -((struct nlmsgerr *) NLMSG_DATA(nh))->error;
					if (r)
						goto out;
				case NLMSG_DONE:
					if (nh->nlmsg_seq !=  seq)
						errx(-1, "unexpected netlink seq %"PRIu32" != %lu",
						    nh->nlmsg_seq, seq);
					seq += 1;
					break;
				default:
					errx(-1, "unexpected netlink message");
			}
		}
	}

out:
	if (close(sock))
		err(-1, "close");
	return r;
}

void bpf_clear_act(unsigned int iface) {
	struct {
		struct nlmsghdr nh;
		struct tcmsg    tcm;
		struct nlattr   nla;
		char            kind[7];
		char            pad1[NLA_ALIGN(7) - 7];
	} __attribute__((packed)) req = {
		.nh.nlmsg_len    = NLMSG_LENGTH(sizeof(struct tcmsg) +
		                   NLA_HDRLEN + NLA_ALIGN(7)),
		.nh.nlmsg_type   = RTM_DELQDISC,
		.nh.nlmsg_flags  = NLM_F_REQUEST | NLM_F_ACK,
		.nh.nlmsg_seq    = 1,
		.tcm.tcm_ifindex = iface,
		.tcm.tcm_handle  = 0xffff0000,
		.tcm.tcm_parent  = TC_H_INGRESS,
		.nla.nla_len     = NLA_HDRLEN + 7,
		.nla.nla_type    = TCA_KIND,
		.kind            = "clsact",
	};

	int r = netlink_do(&req, sizeof(req), 1);
	if (r && r != EINVAL && r != ENOENT)
		errx(-1, "error clearing clsact: %s", strerror(r));
}

void bpf_attach_act(unsigned int iface, int bpf_fd) {
	struct {
		struct {
			struct nlmsghdr nh;
			struct tcmsg    tcm;
			struct nlattr   nla;
			char            kind[7];
			char            pad1[NLA_ALIGN(7) - 7];
		} __attribute__((packed)) r1;
		struct {
			struct nlmsghdr   nh;
			struct tcmsg      tcm;
			struct nlattr     nla_kind;
			char              kind[4];
			char              pad1[NLA_ALIGN(4) - 4];
			struct nlattr     nla_opt;
			struct nlattr     nla_act;
			struct nlattr     nla_1;
			struct nlattr     nla_ak;
			char              act_kind[4];
			char              pad2[NLA_ALIGN(4) - 4];
			struct nlattr     nla_ao;
			struct nlattr     nla_fd;
			uint32_t          bpf_fd;
			char              pad3[NLA_ALIGN(sizeof(uint32_t)) -
			                       sizeof(uint32_t)];
			struct nlattr     nla_name;
			char              name[9];
			char              pad4[NLA_ALIGN(9) - 9];
			struct nlattr     nla_aop;
			struct tc_act_bpf act_bpf;
			char              pad5[NLA_ALIGN(sizeof(struct tc_act_bpf)) -
			                       sizeof(struct tc_act_bpf)];
			struct nlattr     nla_sel;
			struct tc_u32_sel u32_sel;
			struct tc_u32_key u32_key;
			char              pad6[NLA_ALIGN(sizeof(struct tc_u32_sel) +
			                                 sizeof(struct tc_u32_key)) -
			                       (sizeof(struct tc_u32_sel) +
			                        sizeof(struct tc_u32_key))];
		} __attribute__((packed)) r2;
	} req = {
		.r1 = {
			.nh.nlmsg_len    = NLMSG_LENGTH(sizeof(struct tcmsg) +
		                   	   NLA_HDRLEN + NLA_ALIGN(6)),
			.nh.nlmsg_type   = RTM_NEWQDISC,
			.nh.nlmsg_flags  = NLM_F_REQUEST | NLM_F_ACK |
			                   NLM_F_CREATE | NLM_F_REPLACE,
			.nh.nlmsg_seq    = 1,
			.tcm.tcm_ifindex = iface,
			.tcm.tcm_handle  = 0xffff0000,
			.tcm.tcm_parent  = TC_H_INGRESS,
			.nla.nla_len     = NLA_HDRLEN + 7,
			.nla.nla_type    = TCA_KIND,
			.kind            = "clsact",
		},
		.r2 = {
			.nh.nlmsg_len      = NLMSG_LENGTH(sizeof(struct tcmsg) +
			                     10 * NLA_HDRLEN +
			                     NLA_ALIGN(4) +
			                     NLA_ALIGN(4) +
			                     NLA_ALIGN(sizeof(uint32_t)) +
			                     NLA_ALIGN(9) +
			                     NLA_ALIGN(sizeof(struct tc_act_bpf)) +
			                     sizeof(struct tc_u32_sel) +
			                     sizeof(struct tc_u32_key)),
			.nh.nlmsg_type     = RTM_NEWTFILTER,
			.nh.nlmsg_flags    = NLM_F_REQUEST | NLM_F_ACK |
			                     NLM_F_CREATE | NLM_F_EXCL,
			.nh.nlmsg_seq      = 2,
			.tcm.tcm_ifindex   = iface,
			.tcm.tcm_handle    = 1,
			.tcm.tcm_parent    = 0xfffffff2,
			.tcm.tcm_info      = htons(ETH_P_ALL),
			.nla_kind.nla_len  = NLA_HDRLEN + 4,
			.nla_kind.nla_type = TCA_KIND,
			.kind              = "u32",
			.nla_opt.nla_len   = 9 * NLA_HDRLEN +
			                     NLA_ALIGN(4) +
			                     NLA_ALIGN(sizeof(uint32_t)) +
			                     NLA_ALIGN(9) +
			                     NLA_ALIGN(sizeof(struct tc_act_bpf)) +
			                     sizeof(struct tc_u32_sel) +
			                     sizeof(struct tc_u32_key),
			.nla_opt.nla_type  = TCA_OPTIONS,
			.nla_act.nla_len   = 7 * NLA_HDRLEN +
			                     NLA_ALIGN(4) +
			                     NLA_ALIGN(sizeof(uint32_t)) +
			                     NLA_ALIGN(9) +
			                     NLA_ALIGN(sizeof(struct tc_act_bpf)),
			.nla_act.nla_type  = TCA_U32_ACT,
			.nla_1.nla_len     = 6 * NLA_HDRLEN +
			                     NLA_ALIGN(4) +
			                     NLA_ALIGN(sizeof(uint32_t)) +
			                     NLA_ALIGN(9) +
			                     NLA_ALIGN(sizeof(struct tc_act_bpf)),
			.nla_1.nla_type    = 1,
			.nla_ak.nla_len    = NLA_HDRLEN + 4,
			.nla_ak.nla_type   = TCA_ACT_KIND,
			.act_kind          = "bpf",
			.nla_ao.nla_len    = 4 * NLA_HDRLEN +
			                     NLA_ALIGN(sizeof(uint32_t)) +
			                     NLA_ALIGN(9) +
			                     NLA_ALIGN(sizeof(struct tc_act_bpf)),
			.nla_ao.nla_type   = TCA_ACT_OPTIONS,
			.nla_fd.nla_len    = NLA_HDRLEN + sizeof(uint32_t),
			.nla_fd.nla_type   = TCA_ACT_BPF_FD,
			.bpf_fd            = bpf_fd,
			.nla_name.nla_len  = NLA_HDRLEN + 9,
			.nla_name.nla_type = TCA_ACT_BPF_NAME,
			.name              = "bytecode",
			.nla_aop.nla_len   = NLA_HDRLEN + sizeof(struct tc_act_bpf),
			.nla_aop.nla_type  = TCA_ACT_OPTIONS,
			.act_bpf           = {0},
			.nla_sel.nla_len   = NLA_HDRLEN + sizeof(struct tc_u32_sel) +
			                     sizeof(struct tc_u32_key),
			.nla_sel.nla_type  = TCA_U32_SEL,
			.u32_sel.flags     = TC_U32_TERMINAL,
			.u32_sel.nkeys     = 1,
			.u32_key           = {0},
		},
	};

	int r = netlink_do(&req, sizeof(req), 2);
	if (r)
		errx(-1, "error attaching bpf prog to clsact: %s", strerror(r));
}

static int bpf_do_xdp(unsigned int iface, uint32_t flags, int bpf_fd) {
	struct {
		struct nlmsghdr  nh;
		struct ifinfomsg ifinfo;
		struct nlattr    nla;
		char             pad1[NLA_HDRLEN - sizeof(struct nlattr)];
		struct nlattr    nla_fd;
		char             pad2[NLA_HDRLEN - sizeof(struct nlattr)];
		int32_t          bpf_fd;
		char             pad3[NLA_ALIGN(sizeof(int32_t)) - sizeof(int32_t)];
		struct nlattr    nla_flags;
		char             pad4[NLA_HDRLEN - sizeof(struct nlattr)];
		uint32_t         flags;
		char             pad5[NLA_ALIGN(sizeof(uint32_t)) - sizeof(uint32_t)];
	} req = {
		.nh.nlmsg_len       = NLMSG_LENGTH(sizeof(struct ifinfomsg) +
		                      NLA_HDRLEN + 2*NLA_HDRLEN +
		                      NLA_ALIGN(sizeof(int32_t)) +
		                      NLA_ALIGN(sizeof(uint32_t))),
		.nh.nlmsg_type      = RTM_SETLINK,
		.nh.nlmsg_flags     = NLM_F_REQUEST | NLM_F_ACK,
		.nh.nlmsg_seq       = 1,
		.ifinfo.ifi_family  = AF_UNSPEC,
		.ifinfo.ifi_index   = iface,
		.nla.nla_len        = NLA_HDRLEN + 2*NLA_HDRLEN +
		                      NLA_ALIGN(sizeof(int32_t)) +
		                      NLA_ALIGN(sizeof(uint32_t)),
		.nla.nla_type       = NLA_F_NESTED | _IFLA_XDP,
		.nla_fd.nla_len     = NLA_HDRLEN + sizeof(int32_t),
		.nla_fd.nla_type    = _IFLA_XDP_FD,
		.bpf_fd             = bpf_fd,
		.nla_flags.nla_len  = NLA_HDRLEN + sizeof(uint32_t),
		.nla_flags.nla_type = _IFLA_XDP_FLAGS,
		.flags              = flags,
	};

	return netlink_do(&req, sizeof(req), 1);
}

void bpf_attach_xdp(unsigned int iface, uint32_t mode, int bpf_fd) {
	uint32_t flags = _XDP_FLAGS_UPDATE_IF_NOEXIST | mode;

	if (!mode || mode & ~(_XDP_FLAGS_SKB_MODE | _XDP_FLAGS_DRV_MODE |
			_XDP_FLAGS_HW_MODE))
		errx(-1, "invalid mode 0x%x for attaching bpf", mode);

	int r = bpf_do_xdp(iface, flags, bpf_fd);
	if (r)
		errx(-1, "error attaching xdp prog: %s", strerror(r));
}

static int unlink_cb(const char *fpath, const struct stat *sb, int typeflag, struct FTW *ftwbuf)
{
	switch (typeflag) {
	case FTW_DP:
		if (rmdir(fpath) == -1)
			err(-1, "rmdir(%s)", fpath);
		return 0;
	default:
		if (unlink(fpath))
			err(-1, "unlink(%s)", fpath);
		if (poll(NULL, 0, 100) == -1)
			err(-1, "poll(NULL, 0, 100)");
		return 0;
	}
}

void bpf_clear_xdp(unsigned int iface, const char *ifname) {
	int r;

	r = bpf_do_xdp(iface, _XDP_FLAGS_SKB_MODE, -1);
	if (r && r != EOPNOTSUPP && r != EBUSY && r != EINVAL)
		errx(-1, "error clearing xdp prog: %s", strerror(r));
	r = bpf_do_xdp(iface, _XDP_FLAGS_DRV_MODE, -1);
	if (r && r != EOPNOTSUPP && r != EBUSY)
		errx(-1, "error clearing xdp prog: %s", strerror(r));
	r = bpf_do_xdp(iface, _XDP_FLAGS_HW_MODE, -1);
	if (r && r != EOPNOTSUPP && r != EBUSY && r != EINVAL)
		errx(-1, "error clearing xdp prog: %s", strerror(r));
}

void bpf_clear_maps(const char *ifname) {
	char path[strlen(SYS_MAP_PATH)+strlen(ifname)+2];
	snprintf(path, sizeof(path), SYS_MAP_PATH"/%s", ifname);
	nftw(path, unlink_cb, 64, FTW_DEPTH | FTW_PHYS);
}

