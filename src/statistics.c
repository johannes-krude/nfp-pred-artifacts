#include "statistics.h"
#include "convert.h"
#include "hwinfo.h"

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <sys/ioctl.h>
#include <math.h>
#include <err.h>

//LDLIBS=m


void statistics_usage(void) {
	fprintf(stderr, "Statistics Options:\n");
	fprintf(stderr, "\t-1                 normalize share to 1.0\n");
	fprintf(stderr, "\t-C                 CDF mode\n");
	fprintf(stderr, "\t-b <size>          bin size for histogram\n");
	fprintf(stderr, "\t-d <device>        hardware info for device\n");
	fprintf(stderr, "\t-g <name>          print gnuplot summary\n");
	fprintf(stderr, "\t-h                 print human readable numbers\n");
	fprintf(stderr, "\t-l <prefix>        print latex summary\n");
	fprintf(stderr, "\t-n                 use native hardware info\n");
	fprintf(stderr, "\t-q                 print only requested output\n");
	fprintf(stderr, "\t-u <unit>          multiply input by unit\n");
}

bool statistics_optparse(char opt, struct statistics_params *p) {
	const struct hwinfo *hw;

	switch (opt) {
	case '1':
		p->normalize = true;
		return true;
	case 'C':
		p->cdf = true;
		return true;
	case 'b':
		sscanf(optarg, "%"SCNu32, &p->bin_size);
		return true;
	case 'd':
		hw = hwinfo_find(optarg);
		if (!hw)
			errx(-1, "unknown device '%s'", optarg);
		return true;
	case 'g':
		p->gnuplot = optarg;
		return true;
	case 'h':
		p->human = true;
		if (!p->bin_size)
			p->bin_size = 1;
		return true;
	case 'l':
		p->latex = optarg;
		return true;
	case 'n':
		hw = hwinfo_native();
		if (!hw)
			errx(-1, "unknown device");
		return true;
	case 'q':
		p->quiet = true;
		return true;
	case 'u':
		p->unit = optarg;
		return true;
	default:
		return false;
	}
}

static void radix_sort16(uint32_t *array, size_t offset, size_t end) {
	size_t frequency[65536] = {0};
	uint32_t base = array[offset] & 0xFFFF0000;

	for (size_t i = offset; i < end; i++)
		frequency[array[i] & 0xFFFF] += 1;

	size_t ptr = offset;
	for (size_t x = 0; x < 65536; x++) {
		for (size_t i = frequency[x]; i; i--)
			array[ptr++] = base + x;
	}
}

static void radix_sort(uint32_t *array, size_t size) {
	size_t x, y;
	uint32_t value, temp;
	size_t last[65536] = {0};
	size_t pointer[65536];

	for (x=0; x<size; ++x) {
		++last[(array[x] >> 16) & 0xFFFF];
	}

	pointer[0] = 0;
	for (x=1; x<65536; ++x) {
		pointer[x] = last[x-1];
		last[x] += last[x-1];
	}

	for (x=0; x<65536; ++x) {
		while (pointer[x] != last[x]) {
			value = array[pointer[x]];
			y = (value >> 16) & 0xFFFF;
			while (x != y) {
				temp = array[pointer[y]];
				array[pointer[y]++] = value;
				value = temp;
				y = (value >> 16) & 0xFFFF;
			}
			array[pointer[x]++] = value;
		}
	}

	if (pointer[0])
		radix_sort16(array, 0, pointer[0]);
	for (x=1; x<65536; ++x) {
		if (pointer[x] - pointer[x-1]) {
			radix_sort16(array, pointer[x-1], pointer[x]);
		}
	}
}

static const char *sconvert_u32(uint32_t value, const struct statistics_params *p) {
	return convert_u32(value, p->unit, p->human);
}

static const char *sconvert_d(double value, const struct statistics_params *p) {
	return convert_d(value, p->unit, p->human);
}

static const char *sconvertl_u32(uint32_t value, const struct statistics_params *p) {
	return convertl_u32(value, p->unit, p->human);
}

static const char *sconvertl_d(double value, const struct statistics_params *p) {
	return convertl_d(value, p->unit, p->human);
}

static unsigned int sconvert_u32_len(uint32_t max, const struct statistics_params *p) {
	return convert_u32_len(max, p->unit, p->human);
}

struct bar_info {
	unsigned int ws_col;
	unsigned int value_width;
	unsigned int count_width;
	unsigned int numbers_width;
	unsigned int bar_width;
	uint8_t      ltics;
	uint8_t      stics;
	size_t num;
};

static void get_bar_info(struct bar_info *b, const struct statistics_params *p,
                         uint32_t max, size_t num) {
	struct winsize w = { .ws_col = 80, .ws_row = 20 };
	char buf[32];

	ioctl(1, TIOCGWINSZ, &w);
	b->ws_col = w.ws_col;
	b->value_width = sconvert_u32_len(max, p);
	snprintf(buf, sizeof(buf), "%zu", num);
	if (p->human && p->normalize) {
		b->count_width = 4;
	} else {
		b->count_width = strlen(buf);
		if (p->normalize)
			b->count_width += 2;
	}
	b->numbers_width = b->value_width + 1 + b->count_width;
	b->bar_width = b->ws_col - b->numbers_width;
	b->ltics = 10;
	b->stics = 10;
	if ((b->bar_width-3)/b->ltics < 6)
		b->ltics = 2;
	if ((b->bar_width-1)/b->stics < 2)
		b->stics = 2;
	b->num = num;
}

static char line[USHRT_MAX*3+2*11];

static const char *bar_tips[] = {"","▏","▎","▍","▌","▋","▊","▉","█"};
static const char *line_elements[] = {"▌", "▐"};

static void print_bar(uint32_t point, size_t count,
                      const struct bar_info *b,
                      const struct statistics_params *p) {
	char count_s[21];
	if (p->human) {
		uint8_t stics = b->stics;
		unsigned short width = b->bar_width;
		size_t offset = 0;
		for (size_t i = 0; i < width*3 + 11; i++)
			line[i] = ' ';

		if (p->cdf) {
			ssize_t size2 = (width * 4 + 2) * ((uint64_t) count) / b->num  / 2 - 1;
			ssize_t size1  = size2 / 2;
			if (size1 > 0) {
				strncpy(line + offset, "\033[30;1m", 8);
				offset += 7;
				strncpy(line + offset, "▏", 4);
				offset += 2;
				for (uint8_t i = 1; i < stics; i++) {
					if (width*i/stics < size1) {
						strncpy(line + width*i/stics + offset, "┆", 4);
						offset += 2;
					}
				}
				if (size1 >= width) {
					strncpy(line + width - 1 + offset, "\033[0m", 5);
				} else {
					strncpy(line + size1 + offset, "\033[0m", 5);
				}
				offset += 4;
			}
			if (size2 < 0) {
				strncpy(line + offset, "▏", 4);
			} else if (size1 >= width) {
				strncpy(line + width - 1 + offset, "▕", 4);
			} else {
				strncpy(line + size1 + offset, line_elements[size2 % 2], 3);
			}
			offset += 2;
			if (size1 + 1 < width) {
				strncpy(line + size1 + 1 + offset, "\033[30;1m", 8);
				offset += 7;
				for (uint8_t i = 1; i < stics; i++) {
					if (width*i/stics > size1) {
						strncpy(line + width*i/stics + offset, "┆", 4);
						offset += 2;
					}
				}
				strncpy(line + width - 1 + offset, "▕", 4);
				offset += 2;
				strncpy(line + width + offset, "\033[0m", 5);
				offset += 4;
			}
		} else {
			size_t size8 = width * 8 * ((uint64_t) count) / b->num;
			size_t size1  = size8 / 8;
			for (unsigned int i = 0; i < size1; i++) {
				strncpy(line + i + offset, bar_tips[8], 4);
				offset += 2;
			}
			if (size8 % 8) {
				strncpy(line + size1 + offset, bar_tips[size8 % 8], 3);
				offset += 2;
			}
			strncpy(line + size1*3 + ((size8%8)+7)/8*3, "\033[30;1m", 8);
			offset += 7;
			for (uint8_t i = 1; i < stics; i++) {
				if (width*i/stics >= size1 + ((size8%8)+7)/8) {
					strncpy(line + width*i/stics + offset, "┆", 4);
					offset += 2;
				}
			}
			if (width > size1 + ((size8%8)+7)/8) {
				strncpy(line + width - 1 + offset, "▕", 4);
				offset += 2;
			}
			strncpy(line + width + offset, "\033[0m", 5);
			offset += 4;
		}
		line[width + offset] = 0;

		if (p->normalize) {
			snprintf(count_s, sizeof(count_s), "%1.2f", 1.0 * count / b->num);
		} else {
			snprintf(count_s, sizeof(count_s), "%*zu", b->count_width, count);
		}
		printf("%*s %s%s\n", b->value_width, sconvert_u32(point, p), count_s,
		       line);
	} else {
		if (p->normalize) {
			snprintf(count_s, sizeof(count_s), "%1.*f", b->count_width - 3,
			         1.0 * count / b->num);
		} else {
			snprintf(count_s, sizeof(count_s), "%zu", count);
		}
		printf("%*s %s\n", b->value_width, sconvert_u32(point, p), count_s);
	}
}

static void print_dots(const struct bar_info *b) {
	uint8_t stics = b->stics;
	unsigned short width = b->bar_width;
	for (size_t i = 0; i < width + (stics+1)*2; i++)
		line[i] = ' ';
	strncpy(line, "▏", 4);
	for (uint8_t i = 1; i < stics; i++)
		strncpy(line + width*i/stics + i*2, "┆", 4);
	strncpy(line + width - 1 + stics*2, "▕", 4);
	line[width + stics*2 + 2] = 0;
	printf("%*s %*s\033[30;1m%s\033[0m\n", b->value_width, "...",
	       b->count_width, "", line);
}

static const char *const scale_legend[] = { "0.0", "0.1", "0.2", "0.3", "0.4", "0.5",
                                "0.6", "0.7", "0.8", "0.9", "1.0" };

static void print_scale(const struct bar_info *b,
                        const struct statistics_params *p) {
	uint8_t ltics = b->ltics;
	uint8_t stics = b->stics;
	unsigned short width = b->bar_width;

	for (size_t i = 0; i < width; i++)
		line[i] = ' ';
	line[width] = 0;
	strncpy(line, scale_legend[0], 4);
	for (uint8_t i = 1; i < ltics; i++)
		strncpy(line + width*i/ltics - 1, scale_legend[i*10/ltics], 3);
	strncpy(line+width - 3, scale_legend[10], 4);
	line[width] = 0;
	printf("%*s\033[30;1m%s\033[0m\n", b->numbers_width, "", line);

	for (size_t i = 0; i < width; i++)
		strncpy(line + i*3, "─", 4);
	strncpy(line, "▏", 4);
	for (uint8_t i = 1; i < stics; i++) {
		if (!(i % (stics/ltics)))
			strncpy(line + width*i/stics*3, "┼", 4);
		else
			strncpy(line + width*i/stics*3, "┬", 4);
	}
	strncpy(line + width*3 - 3, "▕", 4);
	line[width*3] = 0;
	printf("%*s\033[30;1m%s\033[0m\n", b->numbers_width, "", line);
}

bool statistics_isnoop(const struct statistics_params *p) {
	return !p->bin_size && p->quiet && !p->latex && !p->gnuplot;
}

void statistics_print(uint32_t *data, size_t data_count,
                      const struct statistics_params *p) {
	struct bar_info b;
	double sum = 0;
	double mean;
	double sumsd = 0;
	double stdev;
	double c01, c05, c95, c99;
	int64_t num;
	uint32_t min = -1;
	uint32_t max = 0;
	uint64_t median_a, median_b;
	uint64_t q1_a, q1_b, q3_a, q3_b;
	uint64_t p05_a, p05_b, p95_a, p95_b;
	uint64_t p01_a, p01_b , p99_a, p99_b;
	uint32_t median, q1, q3, p01, p99;
	uint32_t p05, p95;

	if (statistics_isnoop(p))
		return;

	num = data_count;
	if (!num)
		return;

	radix_sort(data, data_count);
	median_a = data[num/2 + num%2 - 1];
	median_b = data[num/2];
	if (num  < 4)
		q1_a = data[0];
	else
		q1_a = data[num/4 + num%2 - 1];
	q1_b = data[num/4];
	q3_a = data[num*3/4 + num%2 - 1];
	q3_b = data[num*3/4];
	if (num < 100)
		p01_a = data[0];
	else
		p01_a = data[num/100 + num%2 - 1];
	p01_b = data[num/100];
	if (num < 20)
		p05_a = data[0];
	else
		p05_a = data[num/20 + num%2 - 1];
	p05_b = data[num/20];
	p95_a = data[num*19/20 + num%2 - 1];
	p95_b = data[num*19/20];
	p99_a = data[num*99/100 + num%2 - 1];
	p99_b = data[num*99/100];
	min = data[0];
	max = data[num-1];
	for (size_t i = 0; i < num; i++)
		sum += data[i];
	mean = sum/num;
	for (size_t i = 0; i < num; i++)
		sumsd += pow(mean-data[i], 2);
	stdev = sqrt(sumsd/num);
	c01 = mean - 2.58*stdev/sqrt(num);
	c99 = mean + 2.58*stdev/sqrt(num);
	c05 = mean - 1.96*stdev/sqrt(num);
	c95 = mean + 1.96*stdev/sqrt(num);
	median = (median_a + median_b) / 2;
	q1 = (q1_a + q1_b) / 2;
	q3 = (q3_a + q3_b) / 2;
	p01 = (p01_a + p01_b) / 2;
	p05 = (p05_a + p05_b) / 2;
	p95 = (p95_a + p95_b) / 2;
	p99 = (p99_a + p99_b) / 2;

	if (p->bin_size) {
		uint32_t threshold = data[0]/p->bin_size*p->bin_size;
		size_t count = 1;
		get_bar_info(&b, p, data[num-1], num);
		if (p->human)
			print_scale(&b, p);
		if (p->human && min+p->bin_size <= p01)
			print_dots(&b);
		for (size_t i = 1; i < num; i++) {
			if (data[i] > threshold) {
				uint32_t next_threshold = (((data[i]-1)/p->bin_size)+1)*p->bin_size;
				if (!p->human || (threshold + p->bin_size > p01 && threshold <= p99))
					print_bar(threshold, count, &b, p);
				if (!p->cdf)
					count = 0;
				if (!p->human && next_threshold > threshold + p->bin_size)
					print_bar(threshold+p->bin_size, count, &b, p);
				if (!p->human && next_threshold > threshold + 2 * p->bin_size)
					print_bar(next_threshold-p->bin_size, count, &b, p);
				threshold = next_threshold;
			}
			count += 1;
		}
		if (!p->human || (threshold + p->bin_size > p01 && threshold <= p99))
			print_bar(threshold, count, &b, p);
		if (p->human && max > p99)
			print_dots(&b);
	}

	if (!p->quiet) {
		printf("num:    %zu\n", num);
		printf("min:    %s\n", sconvert_u32(min, p));
		printf("p01     %s\n", sconvert_u32(p01, p));
		//printf("p05     %s\n", sconvert_u32(p05, p));
		//printf("q1:     %s\n", sconvert_u32(q1, p));
		printf("median: %s\n", sconvert_u32(median, p));
		//printf("q3:     %s\n", sconvert_u32(q3, p));
		//printf("p95     %s\n", sconvert_u32(p95, p));
		printf("p99     %s\n", sconvert_u32(p99, p));
		printf("max:    %s\n", sconvert_u32(max, p));
		printf("c01:    %s\n", sconvert_d(c01, p));
		//printf("c05:    %s\n", sconvert_d(c05, p));
		printf("mean:   %s\n", sconvert_d(mean, p));
		//printf("c95:    %s\n", sconvert_d(c95, p));
		printf("c99:    %s\n", sconvert_d(c99, p));
	}

	if (p->latex) {
		printf("\\newcommand{\\%s_num}{$%zu$}\n", p->latex, num);
		printf("\\newcommand{\\%s_min}{%s}\n", p->latex, sconvertl_u32(min, p));
		printf("\\newcommand{\\%s_p01}{%s}\n", p->latex, sconvertl_u32(p01, p));
		printf("\\newcommand{\\%s_p05}{%s}\n", p->latex, sconvertl_u32(p05, p));
		printf("\\newcommand{\\%s_q1}{%s}\n", p->latex, sconvertl_u32(q1, p));
		printf("\\newcommand{\\%s_median}{%s}\n", p->latex, sconvertl_u32(median, p));
		printf("\\newcommand{\\%s_q3}{%s}\n", p->latex, sconvertl_u32(q3, p));
		printf("\\newcommand{\\%s_p95}{%s}\n", p->latex, sconvertl_u32(p95, p));
		printf("\\newcommand{\\%s_p99}{%s}\n", p->latex, sconvertl_u32(p99, p));
		printf("\\newcommand{\\%s_max}{%s}\n", p->latex, sconvertl_u32(max, p));
		printf("\\newcommand{\\%s_c01}{%s}\n", p->latex, sconvertl_d(c01, p));
		printf("\\newcommand{\\%s_c05}{%s}\n", p->latex, sconvertl_d(c05, p));
		printf("\\newcommand{\\%s_mean}{%s}\n", p->latex, sconvertl_d(mean, p));
		printf("\\newcommand{\\%s_c95}{%s}\n", p->latex, sconvertl_d(c95, p));
		printf("\\newcommand{\\%s_c99}{%s}\n", p->latex, sconvertl_d(c99, p));
	}
	if (p->gnuplot)
		printf("%12s %7"PRIu32" %7"PRIu32" %7"PRIu32"  %7"PRIu32" %7"PRIu32
		       " %7"PRIu32" %7"PRIu32" %10.2f\n", p->gnuplot, min, p01, q1,
		       median, q3, p99, max, mean);
}

