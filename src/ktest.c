
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <arpa/inet.h>
#include <err.h>

#include "input.h"

#include "ktest.h"

void ktest_rewind(struct ktest_buf *k) {
	k->offset = k->rewind_offset;
}

bool ktest_read(void *dst, struct ktest_buf *k, uint32_t size) {
	if (k->len-k->offset < size)
		return false;
	if (dst)
		memcpy(dst, k->buf + k->offset, size);
	k->offset += size;
	return true;
}

uint32_t ktest_read_int(struct ktest_buf *k) {
	uint32_t i;

	if (!ktest_read(&i, k, 4))
		return -1;
	return ntohl(i);
}

const void *ktest_next_obj(struct ktest_buf *k, const char **p_name,
                           size_t *p_name_len, size_t *p_obj_len) {
	char *name;
	uint32_t name_len;
	uint32_t obj_len;
	const void *obj;

retry:
	name_len = ktest_read_int(k);
	if (name_len == -1)
		return NULL;
	name = (char *) k->buf + k->offset;
	if (!ktest_read(NULL, k, name_len))
		return NULL;
	obj_len = ktest_read_int(k);
	if (obj_len == -1)
		return NULL;
	obj = k->buf + k->offset;
	if (!ktest_read(NULL, k, obj_len))
		return NULL;
	if ((name_len == 5 && !memcmp(name, "stack", 5)) ||
	    (name_len == 7 && !memcmp(name, "sym_reg", 7)))
		goto retry;
	if (p_name)
		*p_name = name;
	if (p_name_len)
		*p_name_len = name_len;
	if (p_obj_len)
		*p_obj_len = obj_len;
	return obj;
}

const void *ktest_get_obj(struct ktest_buf *k, const char *name,
                          size_t *p_obj_len) {
	const char *name2;
	size_t name_len;
	const void *obj;
	size_t off = k->offset;

	for (;;) {
		obj = ktest_next_obj(k, &name2, &name_len, p_obj_len);
		if (!obj)
			goto err;
		if (name_len != strlen(name) ||
		    memcmp(name, name2, name_len))
			goto err;
		return obj;
	}

err:
	k->offset = off;
	return NULL;
}

const void *ktest_find_obj(struct ktest_buf *k, const char *name,
                           size_t *p_obj_len) {
	const char *name2;
	size_t name_len;
	const void *obj;

	for (;;) {
		obj = ktest_next_obj(k, &name2, &name_len, p_obj_len);
		if (!obj)
			return NULL;
		if (name_len == strlen(name) &&
			!memcmp(name, name2, name_len))
			return obj;
	}
	return NULL;
}

uint8_t ktest_sk_buff_8(struct ktest_buf *k, size_t offset) {
	return *((uint8_t *) (k->sk_buff + offset));
}

uint16_t ktest_sk_buff_16(struct ktest_buf *k, size_t offset) {
	return *((uint16_t *) (k->sk_buff + offset));
}

uint32_t ktest_sk_buff_32(struct ktest_buf *k, size_t offset) {
	return *((uint32_t *) (k->sk_buff + offset));
}

void ktest_init(struct ktest_buf *k, const void *buf, size_t len) {
	uint32_t num_args;

	k->buf = buf;
	k->len = len;

	if (k->len < 5 || memcmp(k->buf, "KTEST", 5))
		errx(-1, "invalid ktest magic");
	k->offset = 5;
	if (ktest_read_int(k) != 3)
		errx(-1, "invalid ktest version");
	num_args = ktest_read_int(k);
	for (uint32_t i = 0; i < num_args; i++) {
		uint32_t size = ktest_read_int(k);
		if (!ktest_read(NULL, k, size))
			errx(-1, "invalid ktest args");
	}
	if (!ktest_read(NULL, k, 8))
		errx(-1, "invalid ktest symArgs");
	if (!ktest_read(NULL, k, 4))
		errx(-1, "invalid ktest numObjects");
	k->sk_buff = ktest_get_obj(k, "real_sk_buff", NULL);
	if (!k->sk_buff)
		errx(-1, "invalid ktest real_sk_buff");
	k->rewind_offset = k->offset;
}

void ktest_open(struct ktest_buf *k, int fd) {
	const void *buf;
	size_t len;

	buf = input_map(fd, &len);
	ktest_init(k, buf, len);
}

void ktest_close(struct ktest_buf *k) {
	input_unmap(k->buf, k->len);
	k->buf = NULL;
	k->len = 0;
}

