#ifndef _CONVERT_H
#define _CONVERT_H

#include <stdbool.h>
#include <stdint.h>

int8_t convert_prefix(const char *format);
const char *convert_u32(uint32_t value, const char *format, bool shift_prefix);
const char *convert_d(double value, const char *format, bool shift_prefix);
const char *convertl_u32(uint32_t value, const char *format, bool shift_prefix);
const char *convertl_d(double value, const char *format, bool shift_prefix);
unsigned int convert_u32_len(uint32_t max, const char *format, bool shift_prefix);

#endif
