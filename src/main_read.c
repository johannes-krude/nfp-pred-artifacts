
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <assert.h>
#include <err.h>

#include "input.h"

static void usage(char *argv0) {
	fprintf(stderr, "Usage: %s [options]\n", argv0);
	fprintf(stderr, "Options:\n");
	fprintf(stderr, "\t-l                 list tar content\n");
	input_usage();
	exit(1);
}

int main(int argc, char **argv) {
	struct input_opts input_opts = {0};
	int opt;
	int fd;

	while ((opt = getopt(argc, argv, "l" INPUT_OPTS)) != -1) {
		switch (opt) {
		case 'l':
			input_opts.tar = &input_tar_list;
			continue;
		}
		if (input_optparse(opt, &input_opts))
			continue;
		usage(argv[0]);
	}

	if (argc-optind)
		usage(argv[0]);

	fd = input_open(&input_opts);

	while (input_splice(fd, 1, 2147483648) == 2147483648);

	exit(0);
}

