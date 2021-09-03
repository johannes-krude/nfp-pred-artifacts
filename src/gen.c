
#include "prandom_u32.h"
#include "gen.h"

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <err.h>

void gen_parse_args(const char **restrict buf, size_t *restrict size,
                    const char **restrict name, size_t *restrict name_size,
                    uint32_t *restrict args, size_t num) {
	const char *colon = memchr(*buf, ':', *size);
	const char *bracket = memchr(*buf, '(', *size);
	if (!colon || ! bracket || colon < bracket || colon[-1] != ')')
		errx(-1, "malformed generator args '%.*s'", (int) *size, *buf);
	*name = *buf;
	*name_size = bracket-*buf;

	*size -= (bracket + 1) - *buf;
	*buf = bracket + 1;
	if (colon - 1 == *buf)
		goto out;

	for (;;) {
		if (!num)
			errx(-1, "too many generator args");
		sscanf(*buf, "%"SCNu32, args);
		args += 1;
		num -= 1;

		const char *comma = memchr(*buf, ',', colon - *buf);
		if (!comma)
			break;
		*size -= (comma + 1 ) - *buf;
		*buf = comma + 1;
	}
out:
	*size -= (colon + 1 ) - *buf;
	*buf = colon + 1;
}

static void write_be32(void *b, uint32_t val) {
	((char *) b)[0] = val >> 24;
	((char *) b)[1] = val >> 16;
	((char *) b)[2] = val >> 8;
	((char *) b)[3] = val >> 0;
}

static void write_le32(void *b, uint32_t val) {
	((char *) b)[3] = val >> 24;
	((char *) b)[2] = val >> 16;
	((char *) b)[1] = val >> 8;
	((char *) b)[0] = val >> 0;
}

static void write_be16(void *b, uint32_t val) {
	((char *) b)[0] = val >> 8;
	((char *) b)[1] = val >> 0;
}

static void write_le16(void *b, uint32_t val) {
	((char *) b)[1] = val >> 8;
	((char *) b)[0] = val >> 0;
}

static void write_8(void *b, uint32_t val) {
	((char *) b)[0] = val;
}

const struct writer {
	const char *spec;
	size_t size;
	gen_writer writer;
} writers[] = {
	{">L", 4, &write_be32},
	{"<L", 4, &write_le32},
	{">S", 2, &write_be16},
	{"<S", 2, &write_le16},
	{"<C", 1, &write_8},
	{">C", 1, &write_8},
	{0},
};

static void iter_counter(uint32_t *values, uint32_t num, uint32_t seek,
		uint32_t skip) {
	for (uint64_t i = 0; i < num; i++)
		values[i] = seek + i * (skip+1);
}

static void iter_prandom_u32(uint32_t *values, uint32_t num, uint32_t seek,
		uint32_t skip) {
	struct rnd_state state;

	prandom_seed_full_state_fixed(&state);
	for (uint64_t i = 0; i < seek; i++)
		prandom_u32_state(&state);

	for (uint64_t i = 0; i < num; i++) {
		for (uint32_t ii = skip; ii; ii--)
			prandom_u32_state(&state);
		values[i] = prandom_u32_state(&state);
	}
}

const struct iter {
	const char *name;
	void (*iter)(uint32_t *, uint32_t, uint32_t, uint32_t);
} iters[] = {
	{"counter",          &iter_counter},
	{"prandom_u32",      &iter_prandom_u32},
	{0},
};

static size_t pattern_size(const char *pattern, size_t size) {
	size_t psize = 0;

	while (size) {
		if (size >= 3 && *pattern == '%') {
			const struct writer *w;
			for (w = writers; w->spec; w++) {
				if (!memcmp(pattern+1, w->spec, 2))
					break;
			}
			if (!w->spec)
				errx(-1, "invalid generator spec '%.3s'", pattern);
			psize += w->size;
			pattern += 3;
			size -= 3;
			continue;
		}
		if (size >= 2 &&
		    (('0' <= pattern[0] && pattern[0] <= '9') ||
		     ('a' <= pattern[0] && pattern[0] <= 'f') ||
		     ('A' <= pattern[0] && pattern[0] <= 'F')) &&
		    (('0' <= pattern[1] && pattern[1] <= '9') ||
		     ('a' <= pattern[1] && pattern[1] <= 'f') ||
		     ('A' <= pattern[1] && pattern[1] <= 'F'))) {
			psize += 1;
			pattern += 2;
			size -= 2;
			continue;
		}
		errx(-1, "invalid generator pattern '%.*s'", (int) size, pattern);
	}

	return psize;
}

static void pattern_parse(const char *pattern, size_t size,
                          char *buf, gen_writer *writer, size_t *off) {
	size_t o = 0;
	*writer = NULL;

	while (size) {
		if (*pattern == '%') {
			if (*writer)
				errx(-1, "multiple writes into generator output not supported");
			const struct writer *w;
			for (w = writers; w->spec; w++) {
				if (!memcmp(pattern+1, w->spec, 2))
					break;
			}
			pattern += 3;
			size -= 3;
			*writer = w->writer;
			*off = o;
			memset(buf, 23, w->size);
			o += w->size;
			buf += w->size;
			continue;
		} else {
			if        ('0' <= pattern[0] && pattern[0] <= '9') {
				*buf = (pattern[0] - '0') << 4;
			} else if ('a' <= pattern[0] && pattern[0] <= 'f') {
				*buf = (pattern[0] - 'a' + 10) << 4;
			} else if ('A' <= pattern[0] && pattern[0] <= 'F') {
				*buf = (pattern[0] - 'A' + 10) << 4;
			}
			if        ('0' <= pattern[1] && pattern[1] <= '9') {
				*buf |= pattern[1] - '0';
			} else if ('a' <= pattern[1] && pattern[1] <= 'f') {
				*buf |= pattern[1] - 'a' + 10;
			} else if ('A' <= pattern[1] && pattern[1] <= 'F') {
				*buf |= pattern[1] - 'A' + 10;
			}
			pattern += 2;
			size -= 2;
			o += 1;
			buf += 1;
		}
	}
}

#define MAX_ARGS 3

void gen_init(struct gen *g, const char *pattern, size_t size) {
	const char *iter_name;
	size_t iter_size;
	const struct iter *iter = iters;
	uint32_t args[MAX_ARGS] = {0};

	*g = (struct gen) {0};
	if (!size)
		return;

	gen_parse_args(&pattern, &size, &iter_name, &iter_size, args, MAX_ARGS);
	while (iter->name &&
			(strlen(iter->name) != iter_size ||
			memcmp(iter_name, iter->name, iter_size)))
		iter++;
	if (!iter->name)
		errx(-1, "unknown generator type '%.*s'", (int) iter_size, iter_name);

	g->len = pattern_size(pattern, size);
	g->buf = malloc(g->len);
	pattern_parse(pattern, size, g->buf, &g->writer, &g->off);

	g->num = args[0];
	g->values = calloc(g->num, sizeof(*g->values));
	if (args[0] && !g->values)
		errx(-1, "calloc");
	iter->iter(g->values, g->num, args[1], args[2]);
}

bool gen_next(struct gen *g) {
	if (!g->num)
		return false;
	
	size_t index = lrand48() % g->num;
	uint32_t value = g->values[index];
	g->values[index] = g->values[g->num-1];
	g->num -= 1;

	if (g->writer)
		g->writer(((char *) g->buf) + g->off, value);

	return true;
}

void gen_free(struct gen *g) {
	free(g->buf);
	free(g->values);
	*g = (struct gen) {0};
}

