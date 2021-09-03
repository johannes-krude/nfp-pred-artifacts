#ifndef _EREPORT_H
#define _EREPORT_H

#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>

struct ereport_packet {
	size_t size;
	unsigned char *mask;
	unsigned char *values;
};

void ereport_packet_parse(int fd, struct ereport_packet *p);
void ereport_packet_write(const struct ereport_packet *p, unsigned char *dst);
bool ereport_packet_compare(const struct ereport_packet *p, size_t size, const unsigned char *data);
void ereport_packet_free(struct ereport_packet *p);

struct ereport_map {
	uint32_t offset;
	union {
		const char *ptr;
		uint8_t value;
	};
};
struct ereport_map * ereport_map_parse(int fd, size_t *num);
void ereport_map_free(struct ereport_map *em);

#endif
