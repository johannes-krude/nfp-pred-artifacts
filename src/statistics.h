#ifndef _STATISTICS_H
#define _STATISTICS_H

#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>

struct statistics_params {
	bool        human;
	bool        quiet;
	bool        cdf;
	bool        normalize;
	const char *latex;
	const char *gnuplot;
	const char *unit;
	uint32_t    bin_size;
};

#define STATISTICS_OPTS "1Cb:d:g:hl:nqu:"
void statistics_usage(void);
bool statistics_optparse(char opt, struct statistics_params *p);

bool statistics_isnoop(const struct statistics_params *p);
void statistics_print(uint32_t *data, size_t data_count,
                      const struct statistics_params *p);

#endif
