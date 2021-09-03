#ifndef _MAPDEF_H
#define _MAPDEF_H

#include <linux/bpf.h>
#include <stddef.h>
#include <stdint.h>

struct mapdef;
struct mapdef {
	uint64_t num;
	char *name;
	int fd;
	enum bpf_map_type type;
	size_t key_size;
	size_t value_size;
	size_t max_entries;
};

struct mapdef *mapdef_parse(const void *buf, size_t size, size_t *num);

#endif
