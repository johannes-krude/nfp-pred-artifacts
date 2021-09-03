#ifndef _MEASURE_H
#define _MEASURE_H

#include <stdint.h>
#include <time.h>


void sleep_dbl(double time);

uint64_t calculate_rate(struct timespec ta, struct timespec tb, uint64_t ca, uint64_t cb);
double calculate_inverse_rate(struct timespec ta, struct timespec tb, uint64_t ca, uint64_t cb, double numerator);
uint64_t calculate_rate2(uint64_t ta, uint64_t tb, uint64_t tf, uint64_t ca, uint64_t cb);
double calculate_inverse_rate2(uint64_t ta, uint64_t tb, uint64_t tf, uint64_t ca, uint64_t cb, double numerator);

#endif
