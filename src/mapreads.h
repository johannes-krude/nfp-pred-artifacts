#ifndef _MAPREADS_H
#define _MAPREADS_H

#include "jsmn.h"
#include "ktest.h"
#include "gen.h"

#include <stddef.h>
#include <stdbool.h>

struct mapreads_json {
	size_t max_key_size;
	size_t max_value_size;
	const char *buf;
	size_t i;
	jsmn_parser p;
	size_t num_tokens;
	jsmntok_t *tokens;
};

struct mapread_json {
	const char *name;
	void *key;
	void *value;
	size_t name_len;
	size_t key_len;
	size_t value_len;
};

void mapreads_json_init(struct mapreads_json *ms, const void *buf, size_t size,
                        size_t max_key_size, size_t max_value_size);
bool mapreads_json_next(struct mapreads_json *ms, struct mapread_json *m);
void mapreads_json_free(struct mapreads_json *ms);

struct mapread_ktest {
	const char *name;
	const void *key;
	const void *value;
	const void *read_res;
	size_t name_len;
	size_t key_len;
	size_t value_len;
};

bool mapreads_ktest_next(struct ktest_buf *k, struct mapread_ktest *m,
                         bool skip);

struct mapreads_gen {
	const char *buf;
	size_t size;
	const char *name;
	size_t name_len;
	size_t key_len;
	size_t value_len;
	struct gen gen;
};

struct mapread_gen {
	const char *name;
	const void *key;
	const void *value;
	size_t name_len;
	size_t key_len;
	size_t value_len;
};

void mapreads_gen_init(struct mapreads_gen *mg, const char *buf, size_t size);
bool mapreads_gen_next(struct mapreads_gen *mg, struct mapread_gen *m);
void mapreads_gen_free(struct mapreads_gen *mg);

#endif
