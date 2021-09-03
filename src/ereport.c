
#include "ereport.h"
#include "input.h"

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <string.h>
#include <err.h>

void ereport_packet_parse(int fd, struct ereport_packet *p) {
	size_t es;
	const char *e = input_map(fd, &es);

	const char *l = e;
	for (;;) {
		if (!*l)
			break;
		const char *le = memchr(l, '\n', es-(l-e));
		if (!le)
			le = e+es;
		size_t o;
		int n = 0;
		if (sscanf(l, "|0x%zx|%n", &o, &n) != 1 || !n)
			goto next;
		l += n;
		for (;;) {
			if (le-l < 5 || l[4] != '|')
				goto next;
			if (o+1 > p->size) {
				p->mask = realloc(p->mask, o+1);
				p->values = realloc(p->values, o+1);
				if (!p->mask || !p->values)
					err(-1, "realloc(%zu)", o+1);
				for (size_t i = p->size; i < o; i++)
					p->mask[i] = 0;
				p->size = o+1;
			}
			if (sscanf(l, " %hhx |", &p->values[o]) == 1)
				p->mask[o] = 1;
			l += 5;
			o += 1;
		}
	next:
		l = le+1;
	}

	input_unmap(e, es);
}

void ereport_packet_free(struct ereport_packet *p) {
	free(p->mask);
	free(p->values);
}

void ereport_packet_write(const struct ereport_packet *p, unsigned char *dst) {
	for (size_t i = 0; i < p->size; i++) {
		if (p->mask[i])
			dst[i] = p->values[i];
	}
}

bool ereport_packet_compare(const struct ereport_packet *p, size_t size, const unsigned char *data) {
	if (p->size != size) {
		fprintf(stderr, "size mismatch, expected %zu, got %zu", p->size, size);
		return false;
	}
	for (size_t i = 0; i < p->size; i++) {
		if (p->mask[i] && data[i] != p->values[i]) {
			fprintf(stderr, "mismatch at %zu, expected 0x%02x, got 0x%02x\n", i, p->values[i], data[i]);
			return false;
		}
	}
	return true;
}

static int compare_ereport_map(const struct ereport_map *a, const struct ereport_map *b) {
	if (a->offset != b->offset) {
		return a->offset - b->offset;
	} else {
		return a->ptr - b->ptr;
	}
}

struct ereport_map *ereport_map_parse(int fd, size_t *num) {
	size_t es;
	struct ereport_map *em = NULL;
	size_t num_ = 0;

	const char *e = (char *) input_map(0, &es);
	if (!e)
		goto out;

	em = calloc((es-8)/3, sizeof(*em));

	const char *l = e;
	for (;;) {
		if (!*l)
			break;
		const char *le = memchr(l, '\n', es-(l-e));
		if (!le)
			le = e+es;
		uint32_t o;
		int n = 0;
		if (sscanf(l, "map[0x%"PRIx32"]=%n", &o, &n) != 1 || !n)
			goto next;
		l += n;
		for (;;) {
			n = 0;
			if (sscanf(l, "; [0x%"PRIx32"]=%n", &o, &n) == 1 && n) {
				l += n;
				continue;
			}
			if ( le-l < 3 || l[0] != ' ')
				goto next;
			em[num_] = (struct ereport_map) {
				.offset = o,
				.ptr = l+1,
			};
			l += 3;
			o += 1;
			num_ += 1;
		}
	next:
		l = le+1;
	}

	if (!num_) {
		free(em);
		goto out;
	}

	qsort(em, num_, sizeof(*em), (int (*)(const void *, const void *)) &compare_ereport_map);
	size_t o = 0;
	for (size_t i = 0; i < num_; i++) {
		if (i && em[i].offset == em[i-o-1].offset)
			o++;
		if (o)
			em[i-o] = em[i];
		char v[3] = {em[i-o].ptr[0], em[i-o].ptr[1], 0};
		sscanf(v, " %hhx", &em[i-o].value);
	}
	num_ -= o;
	input_unmap(e, es);

	em = realloc(em, sizeof(*em)*num_);
	if (!em)
		errx(-1, "realloc()");
out:
	*num = num_;
	return em;
}

void ereport_map_free(struct ereport_map *em) {
	free(em);
}

