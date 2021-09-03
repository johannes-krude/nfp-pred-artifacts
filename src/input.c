#include "input.h"

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <fnmatch.h>
#include <err.h>
#include <assert.h>
#include <errno.h>

void input_usage(void) {
	fprintf(stderr, "Input Options:\n");
	fprintf(stderr, "\t-f <file>          read input from file\n");
	fprintf(stderr, "\t-j                 treat input as bzip2 compressed\n");
	fprintf(stderr, "\t-J                 treat input as xz compressed\n");
	fprintf(stderr, "\t-x <path>          extract path from tar archive\n");
	fprintf(stderr, "\t-a                 extract and concatenate all content from tar archive\n");
}

char input_tar_list;
char input_tar_concatenate_all;
char input_tar_iterate;

bool input_optparse(char opt, struct input_opts *opts) {
	switch (opt) {
	case 'f':
		opts->path = optarg;
		return true;
	case 'j':
		opts->type = INPUT_BZIP2;
		return true;
	case 'J':
		opts->type = INPUT_XZ;
		return true;
	case 'x':
		opts->tar = optarg;
		return true;
	case 'a':
		opts->tar = &input_tar_concatenate_all;
		return true;
	default:
		return false;
	}
}

static size_t input_read(int fd, void *buf, size_t size) {
	size_t s = 0;
	ssize_t r;

	while (s < size) {
		r = read(fd, buf+s, size-s);
		if (r == -1)
			err(-1, "read");
		if (!r)
			return s;
		s += r;
	}
	return s;
}

static size_t input_seek(int fd, off_t offset) {
	static char buf[65536];
	ssize_t r;

	r = lseek(fd, offset, SEEK_CUR);
	if (r == -1 && errno != ESPIPE)
		err(-1, "lseek");
	if (r > 0)
		return r;

	size_t size = 0;
	while (offset - size) {
		size_t s = offset - size > sizeof(buf) ? sizeof(buf) : offset - size;
		r = read(fd, buf, s);
		if (r == -1)
			err(-1, "read");
		if (!r)
			break;
		size += r;
	}
	return size;
}

size_t input_splice(int infd, int outfd, size_t size) {
	size_t s = 0;

	while (s < size) {
		int r = splice(infd, NULL, outfd, NULL, size-s, 0);
		if (r == -1 && errno == EINVAL)
			goto no_splice;
		if (r == -1)
			err(-1, "splice");
		if (r == 0)
			break;
		s += r;
	}
	return s;

no_splice:;
	char buf[65536];
	size_t bsize = 0;
	while (s < size) {
		size_t rsize = sizeof(buf)-bsize > size-s ? size-s : sizeof(buf)-bsize;
		if (rsize) {
			ssize_t r = read(infd, buf+bsize, rsize);
			if (r == -1)
				err(-1, "read");
			bsize += r;
		}
		if (!bsize)
			break;
		ssize_t r = write(outfd, buf, bsize);
		if (r == -1)
			err(-1, "write");
		bsize -= r;
		if (bsize)
			memmove(buf, buf+bsize, bsize);
	}
	return s;
}

static int input_filter(int fd, void (*f)(void *), void *a, pid_t *pid_p) {
	pid_t pid = 0;
	pid_t pidm = 0;
	int p[2];

	if (pipe(p) == -1)
		err(-1, "pipe()");
	
	if (!pid_p)
		pid = pidm = fork();
	if (!pid)
		pid = fork();
	switch (pid) {
	case -1:
		err(-1, "fork()");
	case 0:
		if (close(p[0]))
			err(-1, "close");
		if (close(0))
			err(-1, "close");
		if (close(1))
			err(-1, "close");
		if (dup2(fd, 0) == -1 ||
		    dup2(p[1], 1) == -1)
			err(-1, "dup2()");
		if (close(fd))
			err(-1, "close");
		if (close(p[1]))
			err(-1, "close");

		f(a);
		exit(0);
	}
	if (!pid_p && !pidm) {
		if (close(p[0]))
			err(-1, "close");
		if (close(p[1]))
			err(-1, "close");
		if (close(0))
			err(-1, "close");
		if (close(1))
			err(-1, "close");
		if (waitpid(pid, NULL, 0) == -1)
			err(-1, "waitpid(%u)", pid);
		exit(0);
	}
	if (close(p[1]))
		err(-1, "close");
	fd = p[0];
	if (pid_p)
		*pid_p = pid;

	return fd;
}

static void do_exec(void *a) {
	char **argv = a;
	char path[128];

	if (argv[0][0] == '.' && argv[0][1] == '/') {
		execv(argv[0], argv);
		if (errno != ENOENT)
			err(-1, "execv(%s)", path);
	}
	snprintf(path, sizeof(path), "/bin/%s", argv[0]);
	execv(path, argv);
	if (errno != ENOENT)
		err(-1, "execv(%s)", path);
	snprintf(path, sizeof(path), "/usr/bin/%s", argv[0]);
	execv(path, argv);
	if (errno != ENOENT)
		err(-1, "execv(%s)", path);
	errx(-1, "%s not found", argv[0]);
}

int input_filter_exec(int fd, const char **argv) {
	return input_filter(fd, &do_exec, argv, NULL);
}

static void do_tar_list(void *a) {
	const struct input_opts *input_opts = a;
	char buf[65536];
	size_t buf_size = 0;

	for (;;) {
		char *cursor = buf;
		int size = read(0, buf+buf_size, sizeof(buf)-1-buf_size);
		if (size == -1)
			err(-1, "read");
		if (!size && buf_size)
			errx(-1, "invalid input");
		if (!size)
			break;
		buf_size += size;
		buf[buf_size] = 0;
		for (;;) {
			char *newline = strchr(cursor, '\n');
			if (!newline)
				break;
			newline[0] = 0;
			switch (input_opts->type) {
			case INPUT_PLAIN:
				break;
			case INPUT_BZIP2:
				if (newline-cursor < 4 || strncmp(newline-4, ".bz2", 4))
					errx(-1, "non bz2 filename '%s'", cursor);
				newline[-4] = 0;
				break;
			case INPUT_XZ:
				if (newline-cursor < 3 || strncmp(newline-3, ".xz", 3))
					errx(-1, "non xz filename '%s'", cursor);
				newline[-3] = 0;
				break;
			default:
				assert(false);
			}
			printf("%s\n", cursor);
			cursor = newline + 1;
		}
		memmove(buf, cursor, buf_size-(cursor-buf));
		buf_size -= cursor-buf;
	}
}

static void do_tar_concatenate_all(void *a) {
	char buf[512];
	char empty[sizeof(buf)] = {0};

	for (;;) {
		size_t size = input_read(0, buf, sizeof(buf));
		if (size != sizeof(buf))
			errx(-1, "premature end of tar archive");
		if (!memcmp(buf, empty, sizeof(buf)))
			break;

		uint64_t filesize;
		char sbuf[13] = {0};
		memcpy(sbuf, &buf[124], 12);
		sscanf(sbuf, "%"PRIo64, &filesize);
		char type = buf[156];

		if (type != '0') {
			input_seek(0, (filesize+sizeof(buf)-1)/sizeof(buf)*sizeof(buf));
			continue;
		}

		size = input_splice(0, 1, filesize / sizeof(buf) * sizeof(buf));
		if (size != filesize / sizeof(buf) * sizeof(buf))
			errx(-1, "premature end of tar archive");
		if (filesize % sizeof(buf)) {
			int size = read(0, buf, sizeof(buf));
			if (size == -1)
				err(-1, "read");
			if (size != sizeof(buf))
				errx(-1, "premature end of tar archive");
			size = write(1, buf, filesize % sizeof(buf));
			if (size == -1)
				err(-1, "write");
			if (size != filesize % sizeof(buf))
				errx(-1, "write did not accept all data");
		}
	}
}

int input_file(const char *path) {
	int fd;

	if (!path || !strcmp(path, "-")) {
		fd = dup(0);
		if (fd == -1)
			err(-1, "dup()");
	} else {
		fd = open(path, O_RDONLY);
		if (fd == -1)
			err(-1, "opening '%s'", path);
	}

	return fd;
}

int input_buffer(int fd) {
	struct stat stat;
	int fd2;
	char filename[] = "/tmp/bufXXXXXX";
	char buf[16384];

	if (fstat(fd, &stat) == -1)
		err(-1, "fstat");
	switch (stat.st_mode & S_IFMT) {
	case S_IFREG:
		return fd;
	case S_IFCHR:
	case S_IFIFO:
		fd2 = mkostemp(filename, O_CLOEXEC);
		if (fd2 == -1)
			err(-1, "mkstemp(%s)", filename);
		if (unlink(filename))
			err(-1, "unlink(%s)", filename);
		for (;;) {
			ssize_t r = read(fd, buf, sizeof(buf));
			if (r == -1)
				err(-1, "read");
			if (r == 0)
				break;
			if (write(fd2, buf, r) != r)
				err(-1, "write");
		}
		if (close(fd))
			err(-1, "close");
		return fd2;
	default:
		errx(-1, "invalid fd");
	}
}

int input_open(const struct input_opts *opts) {
	int fd;
	char buf[128];
	const char *tar_list_argv[]    = {"tar", "-t", NULL};
	const char *tar_extract_argv[] = {"tar", "-xO", buf, NULL};
	const char *bzip2_argv[]       = {"pbzip2", "-d", NULL};
	const char *   xz_argv[]       = {"xz",    "-d", NULL};

	fd = input_file(opts->path);

	if (opts->type == INPUT_OUTER_BZIP2) {
		fd = input_filter_exec(fd, bzip2_argv);
	}

	if (opts->tar == &input_tar_iterate) {
		return fd;
	} else if (opts->tar == &input_tar_list) {
		fd = input_filter_exec(fd, tar_list_argv);
		fd = input_filter(fd, &do_tar_list, (void *) opts, NULL);
		return fd;
	} else if (opts->tar == &input_tar_concatenate_all) {
		fd = input_filter(fd, &do_tar_concatenate_all, NULL, NULL);
	} else if (opts->tar) {
		switch (opts->type) {
		case INPUT_PLAIN:
		case INPUT_OUTER_BZIP2:
			snprintf(buf, sizeof(buf), "%s", opts->tar);
			break;
		case INPUT_BZIP2:
			snprintf(buf, sizeof(buf), "%s.bz2", opts->tar);
			break;
		case INPUT_XZ:
			snprintf(buf, sizeof(buf), "%s.xz", opts->tar);
			break;
		default:
			assert(false);
		}
		fd = input_filter_exec(fd, tar_extract_argv);
	}

	switch (opts->type) {
	case INPUT_PLAIN:
	case INPUT_OUTER_BZIP2:
		break;
	case INPUT_BZIP2:
		fd = input_filter_exec(fd, bzip2_argv);
		break;
	case INPUT_XZ:
		fd = input_filter_exec(fd, xz_argv);
		break;
	default:
		assert(false);
	}

	if (opts->to_file)
		fd = input_buffer(fd);

	return fd;
}

const void *input_map(int fd, size_t *size) {
	struct stat stat;
	void *buf;
	size_t alloc_size = 4096*2;
	size_t s = 0;

	if (fstat(fd, &stat) == -1)
		err(-1, "fstat");
	switch (stat.st_mode & S_IFMT) {
	case S_IFREG:
		s = stat.st_size;
		buf = mmap(NULL, s, PROT_READ, MAP_PRIVATE, fd, 0);
		if (buf == (void *) -1)
			err(-1, "mmap");
		break;
	case S_IFCHR:
	case S_IFIFO:
		buf = mmap(NULL, alloc_size, PROT_READ | PROT_WRITE,
		              MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
		if (buf == (void *) -1)
			err(-1, "mmap");
		for (;;) {
			ssize_t r = read(fd, buf + s, alloc_size - s);
			if (r == -1)
				err(-1, "read");
			if (r == 0)
				break;
			s += r;
			if (s == alloc_size) {
				alloc_size = alloc_size + alloc_size/2;
				if (buf == (void *) -1)
					err(-1, "mremap");
			}
		}
		if (!s) {
			if (munmap((void *) buf, alloc_size)) 
				err(-1, "munmap");
			buf = NULL;
			break;
		}
		buf = mremap(buf, alloc_size, s, MREMAP_MAYMOVE);
		if (buf == (void *) -1)
			err(-1, "mremap");
		break;
	default:
		errx(-1, "invalid fd");
	}

	if (size)
		*size = s;
	return buf;
}

const void *input_map_file(const char *path, size_t *size) {
	int fd;
	const char *buf;
	
	fd = input_file(path);
	buf = input_map(fd, size);
	if (close(fd))
		err(-1, "close");
	return buf;
}

void input_unmap(const void *buf, size_t size) {
	if (!buf)
		return;
	if (munmap((void *) buf, size))
		err(-1, "munmap");
}

void input_tar_open(const struct input_opts *opts, int fd,
                    struct input_tar *tar) {

	tar->opts = opts;
	tar->tar_fd = fd;
	tar->child_pid = 0;
	tar->file_fd = -1;
	tar->file_size = 0;
	tar->file_skip = 0;
}

bool input_tar_next(struct input_tar *tar, const char *pattern,
                    struct input_tar_file *file) {
	char buf[512];
	char empty[sizeof(buf)] = {0};

	if (tar->tar_fd == -1)
		return false;

	if (tar->file_size || tar->file_skip) {
		input_seek(tar->tar_fd, tar->file_size + tar->file_skip);
	} else if (tar->child_pid) {
		if (close(tar->file_fd))
			err(-1, "close");
		int status;
		if (waitpid(tar->child_pid, &status, 0) == -1)
			err(-1, "waitpid");
		if (!WIFEXITED(status) || WEXITSTATUS(status))
			exit(-1);
	}
	tar->child_pid = 0;
	tar->file_fd = -1;
	tar->file_size = 0;
	tar->file_skip = 0;

	for (;;) {
		size_t size = input_read(tar->tar_fd, buf, sizeof(buf));
		if (size != sizeof(buf))
			errx(-1, "premature end of tar archive");
		if (!memcmp(buf, empty, sizeof(buf))) {
			tar->tar_fd = -1;
			return false;
		}

		char sbuf[13] = {0};
		memcpy(sbuf, &buf[124], 12);
		sscanf(sbuf, "%"PRIo64, &file->size);

		buf[99] = 0;
		memcpy(file->name, buf, 100);
		size_t len = strlen(file->name);
		switch (tar->opts->type) {
		case INPUT_PLAIN:
			break;
		case INPUT_BZIP2:
			if (len < 4 || strncmp(file->name+len-4, ".bz2", 4))
				errx(-1, "non bz2 filename '%s'", file->name);
			file->name[len-4] = 0;
			break;
		case INPUT_XZ:
			if (len < 3 || strncmp(file->name+len-3, ".xz", 3))
				errx(-1, "non xz filename '%s'", file->name);
			file->name[len-3] = 0;
			break;
		default:
			assert(false);
		}

		if (pattern) {
			switch (fnmatch(pattern, file->name, FNM_PATHNAME)) {
			default:
				err(-1, "fnmatch");
			case FNM_NOMATCH:
				input_seek(tar->tar_fd, (file->size + 511) / 512 * 512);
				continue;
			case 0:;
			}
		}

		if (file->raw_header)
			memcpy(file->raw_header, buf, 512);

		tar->file_size = file->size;
		tar->file_skip = 511 - (file->size - 1) % 512;
		return true;
	}
}

const void *input_tar_map(struct input_tar *tar, size_t *size) {
	const void *buf = NULL;
	size_t s = 0;

	if (tar->file_size) {
		buf = mmap(NULL, tar->file_size, PROT_READ | PROT_WRITE,
		              MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
		if (buf == (void *) -1)
			err(-1, "mmap");
		while (tar->file_size) {
			size_t r = input_read(tar->tar_fd, (void *) buf+s, tar->file_size);
			if (!r)
				errx(-1, "premature end of tar archive");
			s += r;
			tar->file_size -= r;
		}
	} else {
		int fd = input_tar_fd(tar);
		buf = input_map(fd, &s);
	}

	if (size)
		*size = s;
	return buf;
}

size_t input_tar_read(struct input_tar *tar, char *buf, size_t size) {
	int fd;

	if (tar->file_fd != -1) {
		fd = tar->file_fd;
		goto read;
	}

	switch (tar->opts->type) {
	case INPUT_PLAIN:
		fd = tar->tar_fd;
		if (size > tar->file_size)
			size = tar->file_size;
		break;
	case INPUT_BZIP2:
	case INPUT_XZ:
		input_tar_fd(tar);
		fd = tar->file_fd;
		break;
	default:
		assert(false);
	}

read:;
	size_t r = input_read(fd, buf, size);
	if (tar->opts->type == INPUT_PLAIN) {
		tar->file_size -= r;
	} else if (r < size) {
		if (close(tar->tar_fd))
			err(-1, "close");
		tar->tar_fd = -1;
	}
	return r;
}

struct do_read_size_args {
	size_t size;
	size_t skip;
};

static void do_read_size(void *a) {
	struct do_read_size_args *sa = a;
	size_t size = sa->size;
	char buf[65536];
	ssize_t r;

	while (size) {
		size_t s = size > sizeof(buf) ? sizeof(buf) : size;
		r = read(0, buf, s);
		if (r == -1)
			err(-1, "read");
		if (!r)
			err(-1, "eof");
		size -= r;
		r = write(1, buf, r);
		if (r == -1 && errno == EPIPE) {
			input_seek(0, size);
			break;
		}
		if (r == -1)
			err(-1, "write");
	}
	input_seek(0, sa->skip);
}

int input_tar_fd(struct input_tar *tar) {
	const char *bzip2_argv[] = {"pbzip2", "-d", NULL};
	const char *   xz_argv[] = {"xz",    "-d", NULL};
	int fd = tar->tar_fd;
	struct do_read_size_args sa = {
		.size = tar->file_size,
		.skip = tar->file_skip,
	};

	if (tar->file_fd != -1)
		return tar->file_fd;

	fd = input_filter(fd, &do_read_size, &sa, &tar->child_pid);

	if (tar->file_size == 0) {
		tar->file_fd = fd;
		return fd;
	}
	switch (tar->opts->type) {
	case INPUT_PLAIN:
		break;
	case INPUT_BZIP2:
		fd = input_filter_exec(fd, bzip2_argv);
		break;
	case INPUT_XZ:
		fd = input_filter_exec(fd, xz_argv);
		break;
	default:
		assert(false);
	}

	tar->file_fd = fd;
	tar->file_size = 0;
	tar->file_skip = 0;

	return fd;
}

void input_tar_close(struct input_tar *tar) {
	if (tar->tar_fd != -1 && close(tar->tar_fd))
		err(-1, "close");
	tar->tar_fd = -1;
	if (tar->child_pid && waitpid(tar->child_pid, NULL, 0) == -1)
		err(-1, "waitpid");
	tar->child_pid = 0;
	if (tar->file_fd != -1 && close(tar->file_fd))
		err(-1, "close");
	tar->file_fd = -1;
}

void print_buffer(const void *buf, size_t size) {
	printf("0x");
	print_buffer2(buf, size);
}

void print_buffer2(const void *buf, size_t size) {
	fprint_buffer2(stdout, buf, size);
}

void fprint_buffer2(FILE *f, const void *buf, size_t size) {
	const unsigned char *b  = buf;

	for (size_t i = 0; i < size; i++)
		fprintf(f, "%02x", b[i]);
}

