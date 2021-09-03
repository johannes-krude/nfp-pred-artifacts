
#include "mapreads.h"

#include "ktest.h"
#include "jsmn.h"
#include "gen.h"

#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>

void mapreads_json_init(struct mapreads_json *ms, const void *buf, size_t size,
                   size_t max_key_size, size_t max_value_size) {
	int rc;

	ms->buf = buf;
	ms->max_key_size = max_key_size;
	ms->max_value_size = max_value_size;

	jsmn_init(&ms->p);
	rc = jsmn_parse(&ms->p, ms->buf, size, NULL, 0);
	if (rc < 0)
		errx(-1, "invalid mapreads json");
	ms->num_tokens = rc;
	if (!ms->num_tokens)
		errx(-1, "invalid mapreads json");
	ms->tokens = calloc(ms->num_tokens, sizeof(*ms->tokens));
	if (!ms->tokens)
		err(-1, "calloc");
	jsmn_init(&ms->p);
	rc = jsmn_parse(&ms->p, ms->buf, size, ms->tokens, ms->num_tokens);
	if (rc < 0)
		errx(-1, "jsmn_parse error");
	if (ms->tokens[0].type != JSMN_ARRAY ||
	    ms->tokens[0].size*4 != ms->num_tokens-1)
		errx(-1, "invalid mapreads json structure");
	ms->i = 1;
}

static void parse_hex(void *dst, const char *src, size_t size) {
	char *d = dst;

	for (size_t i = 0; i < size; i++) {
		const char *s = src + 2*i;
		if        ('0' <= s[0] && s[0] <= '9') {
			d[i] = (s[0] - '0') << 4;
		} else if ('a' <= s[0] && s[0] <= 'f') {
			d[i] = (s[0] + 10 - 'a') << 4;
		} else if ('A' <= s[0] && s[0] <= 'F') {
			d[i] = (s[0] + 10 - 'A') << 4;
		} else {
			err(-1, "invalid hex encoding '%.*s'", (int) size*2, src);
		}

		if        ('0' <= s[1] && s[1] <= '9') {
			d[i] |= s[1] - '0';
		} else if ('a' <= s[1] && s[1] <= 'f') {
			d[i] |= s[1] + 10 - 'a';
		} else if ('A' <= s[1] && s[1] <= 'F') {
			d[i] |= s[1] + 10 - 'A';
		} else {
			err(-1, "invalid hex encoding '%.*s'", (int) size*2, src);
		}
	}
}

bool mapreads_json_next(struct mapreads_json *ms, struct mapread_json *m) {
	jsmntok_t *tok = ms->tokens + ms->i;

	if (ms->i >= ms->num_tokens)
		return false;

	if (tok[0].type != JSMN_ARRAY ||
	    tok[0].size != 3 ||
	    tok[1].type != JSMN_STRING ||
	    tok[2].type != JSMN_STRING ||
	    (tok[2].end - tok[2].start) % 2 ||
	    tok[3].type != JSMN_STRING ||
	    (tok[3].end - tok[3].start) % 2)
		errx(-1, "invalid mapreads json structure");
	if ((tok[2].end - tok[2].start) / 2 > ms->max_key_size)
		errx(-1, "mapreads key too long, %u > %zu",
		     (tok[2].end - tok[2].start) / 2, ms->max_key_size);
	if ((tok[3].end - tok[3].start) / 2 > ms->max_value_size)
		errx(-1, "mapreads value too long, %u > %zu",
		     (tok[3].end - tok[3].start) / 2, ms->max_value_size);

	m->name_len = tok[1].end - tok[1].start;
	m->name = ms->buf + tok[1].start;
	m->key_len = (tok[2].end - tok[2].start) / 2;
	parse_hex(m->key, ms->buf + tok[2].start, m->key_len);
	m->value_len = (tok[3].end - tok[3].start) / 2;
	parse_hex(m->value, ms->buf + tok[3].start, m->value_len);

	ms->i += 4;
	return true;
}

void mapreads_json_free(struct mapreads_json *ms) {
	free(ms->tokens);
	*ms = (struct mapreads_json) {0};
}

bool mapreads_ktest_next(struct ktest_buf *k, struct mapread_ktest *m,
                         bool skip) {
	const char *name;
	size_t name_len;
	size_t read_res_len;

restart:

	m->key = ktest_next_obj(k, &name, &name_len, &m->key_len);
	if (!m->key) {
		if (!skip)
			errx(-1, "unexpected ktest end");
		return false;
	}
	if (name_len < 4 || memcmp(name, "key_", 4)) {
		if (!skip ||
		    (name_len >= 6 && !memcmp(name, "value_", 6)) ||
		    (name_len >= 9 && !memcmp(name, "read_res_", 9)))
			errx(-1, "unexpected %.*s in ktest", (int) name_len, name);
		goto restart;
	}
	m->name = name + 4;
	m->name_len = name_len - 4;
	m->value = ktest_next_obj(k, &name, &name_len, &m->value_len);

	if (!m->value)
		errx(-1, "unexpected ktest end, expected value_%.*s or read_res_%.*s",
		     (int) m->name_len, m->name, (int) m->name_len, m->name);
	if (name_len == 9 + m->name_len &&
	    !memcmp(name, "read_res_", 9) &&
	    !memcmp(name+9, m->name, m->name_len))
	{
		m->read_res = m->value;
		read_res_len = m->value_len;
		m->value = NULL;
		m->value_len = 0;
		goto read_res;
	}
	if (name_len != 6 + m->name_len ||
	    memcmp(name, "value_", 6) ||
	    memcmp(name+6, m->name, m->name_len)) {
		errx(-1, "unexpected %.*s in ktest, expected value_%.*s",
		     (int) name_len, name, (int) m->name_len, m->name);
	}

	m->read_res = ktest_next_obj(k, &name, &name_len, &read_res_len);
	if (!m->read_res) {
		errx(-1, "unexpected ktest end, expected read_res_%.*s",
		     (int) m->name_len, m->name);
		return false;
	}
	if (name_len != 9 + m->name_len ||
	    memcmp(name, "read_res_", 9) ||
	    memcmp(name+9, m->name, m->name_len)) {
		errx(-1, "unexpected %.*s in ktest, expected read_res_%.*s",
		     (int) name_len, name, (int) m->name_len, m->name);
	}
read_res:
	if (read_res_len != 8)
		errx(-1, "unexpected size %zu of read_res_%.*s, expected 8",
		     read_res_len, (int) m->name_len, m->name);

	return true;
}

static void next_gen_pattern(struct mapreads_gen *mg) {
	const char *plus = memchr(mg->buf, '+', mg->size);
	const char *b = mg->buf;
	size_t size = mg->size;

	if (!mg->size) {
		return;
	}

	if (plus) {
		size = plus - b;
		mg->buf = plus + 1;
		mg->size -= size + 1;
	} else {
		mg->buf = NULL;
		mg->size = 0;
	}

	uint32_t s[2] = {0};
	gen_parse_args(&b, &size, &mg->name, &mg->name_len, s, 2);
	mg->key_len = s[0];
	mg->value_len = s[1];

	gen_init(&mg->gen, b, size); 
	if (mg->gen.len != mg->key_len + mg->value_len)
		errx(-1, "contradicting sizes in mapreads generator, %zu != %zu + %zu",
			 mg->gen.len, mg->key_len, mg->value_len);
}

void mapreads_gen_init(struct mapreads_gen *mg, const char *buf, size_t size) {
	*mg = (struct mapreads_gen) {
		.buf = buf,
		.size = size,
	};
	next_gen_pattern(mg);
}

bool mapreads_gen_next(struct mapreads_gen *mg, struct mapread_gen *m) {
	while (!gen_next(&mg->gen)) {
		if (!mg->size)
			return false;
		gen_free(&mg->gen);
		next_gen_pattern(mg);
	}
	m->name = mg->name;
	m->name_len = mg->name_len;
	m->key = mg->gen.buf;
	m->key_len = mg->key_len;
	m->value = mg->gen.buf + mg->key_len;
	m->value_len = mg->value_len;
	return true;
}

void mapreads_gen_free(struct mapreads_gen *mg) {
	gen_free(&mg->gen);
}

