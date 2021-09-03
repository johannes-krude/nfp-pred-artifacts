
#include <stdbool.h>
#include <stdint.h>
#include <inttypes.h>
#include <string.h>
#include <stdio.h>
#include <err.h>

#include "convert.h"

static const char *prefixes = "pnum kMGT";

static char buf[16] = { 0 };


int8_t convert_prefix(const char *format) {
	double factor;
	char prefix[2] = {0};
	int unit_off = 0;
	int8_t shift = -12;

	if (sscanf(format, "%lf%c%n", &factor, &prefix[0], &unit_off) != 2 || !unit_off)
		errx(-1, "invalid format '%s'", format);
	if (!strchr(prefixes, prefix[0]))
		errx(-1, "invalid prefix in format '%s'", format);

	for (const char *p = prefixes; *p; p++) {
		if (*p == prefix[0])
			break;
		shift += 3;
	}

	return shift;
}

const char *convert_(double value, const char *format, bool shift_prefix,
                     const char *space) {
	double factor;
	char prefix[2] = {0};
	int unit_off = 0;
	int precision;

	if (!format || *format == 0) {
		snprintf(buf, sizeof(buf), "%.3f", value);
		return buf;
	}

	if (sscanf(format, "%lf%c%n", &factor, &prefix[0], &unit_off) != 2 || !unit_off)
		errx(-1, "invalid format '%s'", format);
	if (!strchr(prefixes, prefix[0]))
		errx(-1, "invalid prefix in format '%s'", format);

	value *= factor;

	if (factor == 1) {
		precision = 0;
	} else {
		precision = 1;
		if (shift_prefix && value) {
			const char *p = prefixes;
			for (; p[1]; p++) {
				if (*p == prefix[0] && value >= 999.5) {
					prefix[0] = p[1];
					value /= 1000;
				}
			}
			for (; p[-1]; p--) {
				if (*p == prefix[0] && value <= 0.0015) {
					prefix[0] = p[-1];
					value *= 1000;
				}
			}
		}
	}

	if (prefix[0] == ' ')
		prefix[0] = 0;
	if (!format[unit_off])
		space = "";

	snprintf(buf, sizeof(buf), "%.*f%s%s%s", precision, value, space, prefix, format+unit_off);
	return buf;
}

unsigned int convert_len(double max, const char *format, bool shift_prefix, const char *space) {
	double factor;
	char prefix[2] = {0};
	int unit_off = 0;
	int precision;

	if (!format || *format == 0) {
		snprintf(buf, sizeof(buf), "%.1f", max);
		return strlen(buf);
	}

	if (sscanf(format, "%lf%c%n", &factor, &prefix[0], &unit_off) != 2 || !unit_off)
		errx(-1, "invalid format '%s'", format);

	if (factor == 1) {
		precision = 0;
	} else {
		precision = 1;
	}

	if (prefix[0] == ' ')
		prefix[0] = 0;
	if (!format[unit_off])
		space = "";

	if (shift_prefix)
		snprintf(buf, sizeof(buf), "%.*f%s%s%s", precision, 500.5, space, prefix, format+unit_off);
	else
		snprintf(buf, sizeof(buf), "%.*f%s%s%s", precision, max, space, prefix, format+unit_off);
	return strlen(buf);
}

const char *convert_u32(uint32_t value, const char *format, bool shift_prefix) {
	if (!format || *format == 0) {
		snprintf(buf, sizeof(buf), "%"PRIu32, value);
		return buf;
	}

	return convert_(value, format, shift_prefix, " ");
}

const char *convert_d(double value, const char *format, bool shift_prefix) {
	return convert_(value, format, shift_prefix, " ");
}

const char *convertl_u32(uint32_t value, const char *format, bool shift_prefix) {
	if (!format || *format == 0) {
		snprintf(buf, sizeof(buf), "%"PRIu32, value);
		return buf;
	}

	return convert_(value, format, shift_prefix, "~");
}

const char *convertl_d(double value, const char *format, bool shift_prefix) {
	return convert_(value, format, shift_prefix, "~");
}

unsigned int convert_u32_len(uint32_t max, const char *format, bool shift_prefix) {
	return convert_len(max, format, shift_prefix, " ");
}
