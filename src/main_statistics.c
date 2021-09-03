#include "statistics.h"
#include "input.h"
#include "convert.h"

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <math.h>
#include <errno.h>
#include <err.h>
#include <sys/mman.h>

//LDLIBS=m


#define MAX_DATA (1UL<<47)/8
#define PAGE_SIZE 4096

static void usage(char *argv0) {
	fprintf(stderr, "Usage: %s [options]\n", argv0);
	fprintf(stderr, "Options:\n");
	fprintf(stderr, "\t-D                 calculate difference between values\n");
	fprintf(stderr, "\t-i <numerator>     calculate the inverse with the given numerator\n");
	fprintf(stderr, "\t-k <key=1>         select data column\n");
	fprintf(stderr, "\t-S <unit>          shift input value (implies -u)\n");
	statistics_usage();
	input_usage();
	exit(1);
}

static void store_value(uint64_t value, uint32_t *data, size_t *data_count) {
	if (*data_count == MAX_DATA)
		err(-1, "too much data");
	if (!((*data_count * sizeof(*data)) % PAGE_SIZE))
		mlock(&data[*data_count], PAGE_SIZE);
	if (value > UINT32_MAX)
		errx(-1, "value > UINT32_MAX: %"PRIu64, value);
	data[(*data_count)++] = value;
	//printf("%"PRIu32"\n", value);
}

static void store_diff_value(uint64_t value, uint32_t *data, size_t *data_count) {
	static uint64_t last;
	static bool first = true;

	if (first)
		goto done;
	if (value < last)
		errx(-1, "negative difference: %"PRIu64" - %"PRIu64, value, last);
	store_value(value-last, data, data_count);

done:
	first = false;
	last = value;
}

static bool refill(int fd, char *buf, size_t size, size_t *o, size_t *fill) {
	memmove(buf, buf+*o, *fill-*o);
	*fill -= *o;
	*o = 0;
	int r = read(fd, buf+*fill, size-1-*fill);
	if (r == -1)
		err(-1, "read");
	*fill += r;
	buf[*fill] = 0;
	return r > 0;
}

static bool find_key(const char *buf, size_t o, size_t *c, size_t key) {
	for (size_t k = 1; k < key; k++) {
		while (buf[o+*c] &&
		       buf[o+*c] != '\n' &&
		       buf[o+*c] != ' ')
			(*c)++;
		if (buf[o+(*c)++] != ' ')
			return false;
	}
	return true;
}

static bool skip_line(const char *buf, size_t o, size_t *c) {
	if (buf[o+*c] == ' ') {
		while (buf[o+*c] && buf[o+*c] != '\n')
			(*c)++;
	}
	if (buf[o+(*c)++] != '\n')
		return false;
	return true;
}

static bool read_value(const char *buf, size_t o, size_t *c, int8_t shift, uint64_t *value) {
	if (buf[o+*c] < '0' || buf[o+*c] > '9') {
		(*c)++;
		return false;
	}
	if (buf[o+*c] == '0' && buf[o+*c+1] != ' ' && buf[o+*c+1] != '\n' &&  buf[o+*c+1] != '.') {
		(*c) += 2;
		return false;
	}
	for (; buf[o+*c] >= '0' && buf[o+*c] <= '9'; (*c)++) {
		if (*value*10 < *value)
			errx(-1, "value too big");
		*value = *value * 10 + (buf[o+*c] - '0');
	}
	if (buf[o+*c] == ' ' || buf[o+*c] == '\n')
		goto done;
	if (buf[o+(*c)++] != '.')
		return false;
	if (buf[o+*c] < '0' || buf[o+*c] > '9') {
		(*c)++;
		return false;
	}
	for (; buf[o+*c] >= '0' && buf[o+*c] <= '9'; (*c)++) {
		shift++;
		if (*value*10 < *value)
			errx(-1, "value too big");
		*value = *value * 10 + (buf[o+*c] - '0');
	}
done:
	for (; shift < 0; shift++)
		*value = *value * 10;
	for (; shift > 0; shift--) {
		if (*value % 10 > 5)
			*value += 10;
		*value = *value / 10;
	}
	return true;
}

static size_t read_data(int fd, uint32_t *data, size_t key, size_t shift, void (*store)(uint64_t, uint32_t *, size_t *)) {
	size_t data_count = 0;
	char buf[4096+1] = {0};
	size_t fill = 0;
	size_t line = 0;
	size_t c = 0;

	for (;;) {
		uint64_t value = 0;

		if (line + c >= fill) {
			if (!refill(fd, buf, sizeof(buf), &line, &fill) && c)
				errx(-1, "unexpected eof");
		}
		if (!fill)
			break;
		c = 0;
		if (!find_key(buf, line, &c, key))
			goto retry;
		if (!read_value(buf, line, &c, shift, &value))
			goto retry;
		if (!skip_line(buf, line, &c))
			goto retry;
		line += c;
		c = 0;
		store(value, data, &data_count);
		continue;
	retry:
		//printf("%u %u %u\n", line, c, fill);
		if (line + c < fill) {
			errx(-1, "invalid input: %.*s", (int) c, buf+line);
		}
	}

	return data_count;
}

int main(int argc, char **argv) {
	struct input_opts input_opts = {0};
	int fd = 0;
	struct statistics_params p = {0};
	uint32_t *data = NULL;
	size_t data_count = 0;
	size_t key = 1;
	int8_t shift = 0;
	void (*store)(uint64_t, uint32_t *, size_t *) = &store_value;
	double inverse = NAN;
	int opt;

	while ((opt = getopt(argc, argv, "Di:k:S:" STATISTICS_OPTS INPUT_OPTS)) != -1) {
		switch (opt) {
		case 'D':
			store = &store_diff_value;
			continue;
		case 'i':
			sscanf(optarg, "%lf", &inverse);
			continue;
		case 'k':
			sscanf(optarg, "%zu", &key);
			continue;
		case 'S':
			shift = convert_prefix(optarg);
			p.unit = optarg;
			continue;
		}
		if (statistics_optparse(opt, &p))
			continue;
		if (input_optparse(opt, &input_opts))
			continue;
		usage(argv[0]);
	}
	if (argc != optind)
		usage(argv[0]);

	fd = input_open(&input_opts);
	data = mmap(NULL, sizeof(*data) * MAX_DATA, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, 0, 0);
	if (data == (void *) -1)
		err(-1, "mmap");

	data_count = read_data(fd, data, key, shift, store);
	if (!isnan(inverse))
		for (size_t i = 0; i < data_count; i++)
			data[i] = round(inverse / data[i]);

	close(fd);

	statistics_print(data, data_count, &p);

	exit(0);
}

