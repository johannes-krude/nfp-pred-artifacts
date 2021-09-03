#ifndef _GEN_H
#define _GEN_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

typedef void (*gen_writer)(void *b, uint32_t val);

struct gen {
	void *buf;
	size_t len;
	gen_writer writer;
	size_t off;
	uint32_t *values;
	size_t num;
};

void gen_parse_args(const char **buf, size_t *size,
                    const char **name, size_t *name_size,
                    uint32_t *args, size_t num);

void gen_init(struct gen *g, const char *pattern, size_t size);
bool gen_next(struct gen *g);
void gen_free(struct gen *g);

#endif
