
#include <stddef.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <err.h>
#include <stdio.h>
#include <errno.h>

#include "hwinfo.h"

static struct hwinfo infos[] = {
	{
		.name        = "Q9650",
		.description = "Intel(R) Core(TM)2 Quad CPU    Q9650  @ 3.00GHz",
		.clock       = "0.334170ns",
	},
	{
		.name        = "i7-870",
		.description = "Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz",
		.clock       = "0.341763ns",
	},
	{
		.name        = "i7-4790",
		.description = "Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz",
		.clock       = "0.278419ns",
	},
	{
		.name        = "i7-6500U",
		.description = "Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz",
		.clock       = "0.385795ns",
	},
	{
		.name        = "i7-7700",
		.description = "Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz",
		.clock       = "0.256415ns",
	},
	{
		.name        = "rpi-3b",
		.description = "Raspberry Pi 3 Model B Rev 1.2",
		.clock       = "0.83333ns",
	},
	{
		.name        = "rpi-3b-plus",
		.description = "Raspberry Pi 3 Model B Plus Rev 1.3",
		.clock       = "0.71428ns",
	},
	{ 0 }
};

static char counter_name[512] = {0};
static struct hwinfo counter_info = {
	.name = counter_name,
};

const struct hwinfo *hwinfo_find_description(const char *description,
                                             size_t len) {
	const struct hwinfo *info;

	for (info = infos; info->name; info++) {
		if (strlen(info->description) == len &&
		    !strncmp(info->description , description, len))
			return info;
	}
	return NULL;
}

static const struct hwinfo *hwinfo_cpuinfo(void) {
	int fd;
	char buf[4096];
	size_t len = 0;

	fd = open("/proc/cpuinfo", O_RDONLY);
	if (fd == -1 && errno == ENOENT)
		return NULL;
	if (fd == -1)
		err(-1, "open(/proc/cpuinfo)");


	char *next = buf;
	for (;;) {
		memmove(buf, next, len-(next-buf));
		len -= next-buf;
		int size = read(fd, buf+len, sizeof(buf)-len-1);
		if (size == -1)
			err(-1, "read(/proc/cpuinfo)");
		len += size;
		buf[len] = 0;
		if (!len)
			break;

		char *colon = strchr(buf, ':');
		char *line = strchr(buf, '\n');
		next = buf;
		if (!line)
			continue;
		next = line+1;
		if (!colon || colon > line)
			continue;
		while (colon[1] == ' ')
			colon += 1;
		colon += 1;
		if (colon == line)
			continue;
		const struct hwinfo *info;
		info = hwinfo_find_description(colon, line-colon);
		if (info)
			return info;
	}
	return NULL;
}

static const struct hwinfo *hwinfo_devicetree_model(void) {
	int fd;
	char buf[256];
	int size;

	fd = open("/proc/device-tree/model", O_RDONLY);
	if (fd == -1 && errno == ENOENT)
		return NULL;
	if (fd == -1)
		err(-1, "open(/proc/device-tree/model)");
	size = read(fd, buf, sizeof(buf));
	if (size == -1)
		err(-1, "read");
	close(fd);
	if (!size)
		return NULL;
	return hwinfo_find_description(buf, size-1);
}

#define COUNTER_PATH "/sys/module/bpf_perf/parameters/count"
static const char *read_counter(void) {
	static char counter[256] = {0};
	int size;
	int fd;

	counter[0] = 0;

	fd = open(COUNTER_PATH, O_RDONLY);
	if (fd == -1 && errno == ENOENT)
		return NULL;
	if (fd == -1)
		err(-1, "open(%s)", COUNTER_PATH);
	size = read(fd, counter, sizeof(counter)-1);
	if (size == -1)
		err(-1, "read(%s)", COUNTER_PATH);
	counter[size-1] = 0;
	return counter;
}

static const struct hwinfo *return_counter_info(const struct hwinfo *info,
                                                const char *counter) {
	if (!counter || !counter[0])
		return info;
	snprintf(counter_name, sizeof(counter_name), "%s+%s", info->name, counter);
	counter_info.description = info->description;
	counter_info.clock = info->clock;
	return &counter_info;
}

const struct hwinfo *hwinfo_native(void) {
	const char *counter;
	const struct hwinfo *info;

	info = hwinfo_devicetree_model();
	if (info)
		goto found;
	info = hwinfo_cpuinfo();
	if (info)
		goto found;
	return NULL;

found:
	counter = read_counter();
	return return_counter_info(info, counter);
}

const struct hwinfo *hwinfo_find(const char *name) {
	const struct hwinfo *info;
	const char *colon;
	const char *counter;
	size_t size;

	colon = strchr(name, '+');
	if (colon) {
		size = colon-name;
		counter = colon + 1;
	} else {
		size = strlen(name);
		counter = NULL;
	}

	for (info = infos; info->name; info++) {
		if (strlen(info->name) != size || strncmp(info->name , name, size))
			continue;
		return return_counter_info(info, counter);
	}
	return NULL;
}

