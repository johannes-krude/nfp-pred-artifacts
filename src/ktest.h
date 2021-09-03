#ifndef _KTEST_H
#define _KTEST_H

#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>

struct ktest_buf {
	const void *buf;
	size_t len;
	size_t offset;
	size_t rewind_offset;
	const void *sk_buff;
};

void ktest_rewind(struct ktest_buf *k);
bool ktest_read(void *dst, struct ktest_buf *k, uint32_t size);
uint32_t ktest_read_int(struct ktest_buf *k);
const void *ktest_next_obj(struct ktest_buf *k, const char **p_name,
                           size_t *p_name_len, size_t *p_obj_len);
const void *ktest_get_obj(struct ktest_buf *k, const char *name,
                          size_t *p_obj_len);
const void *ktest_find_obj(struct ktest_buf *k, const char *name,
                     size_t *p_obj_len);
uint8_t ktest_sk_buff_8(struct ktest_buf *k, size_t offset);
uint16_t ktest_sk_buff_16(struct ktest_buf *k, size_t offset);
uint32_t ktest_sk_buff_32(struct ktest_buf *k, size_t offset);
void ktest_init(struct ktest_buf *k, const void *buf, size_t len);
void ktest_open(struct ktest_buf *k, int fd);
void ktest_close(struct ktest_buf *k);

#endif
