#include "measure.h"

#include <stdint.h>
#include <inttypes.h>
#include <time.h>
#include <poll.h>
#include <err.h>

#include <stdio.h>

void sleep_dbl(double time) {
	if (poll(NULL, 0, (unsigned int) (time*1000)) == -1)
		err(-1, "poll");
}

uint64_t calculate_rate(struct timespec ta, struct timespec tb, uint64_t ca, uint64_t cb) {
	uint64_t t = tb.tv_nsec-ta.tv_nsec+1000000000L*(tb.tv_sec-ta.tv_sec);
	uint64_t c = cb - ca;

	if (c > UINT64_MAX/1000000000L)
		errx(-1, "counter diff bigger than %"PRIu64, UINT64_MAX/1000000000L);

	return c*1000000000L/t;
}

double calculate_inverse_rate(struct timespec ta, struct timespec tb, uint64_t ca, uint64_t cb, double numerator) {
	uint64_t t = tb.tv_nsec-ta.tv_nsec+1000000000L*(tb.tv_sec-ta.tv_sec);
	uint64_t c = cb - ca;

	return numerator/(c*1000000000.0/t);
}

uint64_t calculate_rate2(uint64_t ta, uint64_t tb, uint64_t tf, uint64_t ca, uint64_t cb) {
	uint64_t t = tb - ta;
	uint64_t c = cb - ca;

	if (c > UINT64_MAX/tf)
		errx(-1, "counter diff bigger than %"PRIu64, UINT64_MAX/tf);

	return c*tf/t;
}

double calculate_inverse_rate2(uint64_t ta, uint64_t tb, uint64_t tf, uint64_t ca, uint64_t cb, double numerator) {
	uint64_t t = tb - ta;
	uint64_t c = cb - ca;

	fprintf(stderr, "%lu %lu\n", c, t);

	return numerator/(c*tf/t);
}

