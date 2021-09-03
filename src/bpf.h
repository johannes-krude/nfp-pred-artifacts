
#include <linux/bpf.h>
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#define _BPF_PROG_TYPE_XDP ((enum bpf_prog_type) 6)
#define _XDP_FLAGS_SKB_MODE 2
#define _XDP_FLAGS_DRV_MODE 4
#define _XDP_FLAGS_HW_MODE 8
#define _XDP_DROP 1
#define _XDP_PASS 2
#define _XDP_TX   3
#define _BPF_FUNC_redirect_map 51
#define _BPF_MAP_TYPE_PERCPU_HASH 5
#define _BPF_MAP_TYPE_XSKMAP 17

struct _bpf_prog_info {
	uint32_t type;
	uint32_t id;
	uint8_t tag[BPF_TAG_SIZE];
	uint32_t jited_prog_len;
	uint32_t xlated_prog_len;
	uint64_t jited_prog_insns;
	uint64_t xlated_prog_insns;
	uint64_t load_time;
	uint32_t created_by_uid;
	uint32_t nr_map_ids;
	uint64_t map_ids;
	char name[BPF_OBJ_NAME_LEN];
	uint32_t ifindex;
	uint32_t gpl_compatible:1;
	uint64_t netns_dev;
	uint64_t netns_ino;
};

int bpf_load(enum bpf_prog_type type, const struct bpf_insn *instr, size_t num,
		uint32_t ifindex);
void bpf_info(int fd, struct _bpf_prog_info *info);
int bpf_map_create(enum bpf_map_type type, size_t key_size, size_t value_size,
		size_t max_entries, int ifindex, const char *ifname,
		const char* mapname);
void bpf_map_delete(int fd, const char* ifname, const char *mapname);
int bpf_map_open(const char *ifname, const char *mapname);
void bpf_map_insert(int fd, const void *key, const void *value, uint64_t flags);
void bpf_map_lookup(int fd, const void *key, void *value, uint64_t flags);
void bpf_attach_act(unsigned int iface, int bpf_fd);
void bpf_clear_act(unsigned int iface);
void bpf_attach_xdp(unsigned int iface, uint32_t mode, int bpf_fd);
void bpf_clear_xdp(unsigned int iface, const char* ifname);
void bpf_clear_maps(const char *ifname);

