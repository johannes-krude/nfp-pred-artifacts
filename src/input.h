#ifndef _INPUT_H
#define _INPUT_H

#include <stddef.h>
#include <stdbool.h>
#include <stdio.h>
#include <sys/types.h>

struct input_opts {
	enum input_type {
		INPUT_PLAIN,
		INPUT_XZ,
		INPUT_BZIP2,
		INPUT_OUTER_BZIP2,
	} type;
	const char *path;
	const char *tar;
	bool to_file : 1;
};

extern char input_tar_list;
extern char input_tar_concatenate_all;
extern char input_tar_iterate;

struct input_tar {
	const struct input_opts *opts;
	int tar_fd;
	int file_fd;
	pid_t child_pid;
	size_t file_size;
	size_t file_skip;
};

struct input_tar_file {
	char *raw_header;
	size_t size;
	char name[101];
};

#define INPUT_OPTS "f:jJx:a"
void input_usage(void);
bool input_optparse(char opt, struct input_opts *opts);

int input_file(const char *path);
int input_open(const struct input_opts *opts);
int input_filter_exec(int fd, const char **argv);
size_t input_splice(int infd, int outfd, size_t size);
const void *input_map(int fd, size_t *size);
const void *input_map_file(const char *path, size_t *size);
void input_unmap(const void *buf, size_t size);

void input_tar_open(const struct input_opts *opts, int fd,
                    struct input_tar *tar);
bool input_tar_next(struct input_tar *tar, const char *pattern,
                    struct input_tar_file *file);
const void *input_tar_map(struct input_tar *tar, size_t *size);
size_t input_tar_read(struct input_tar *tar, char *buf, size_t size);
int input_tar_fd(struct input_tar *tar);
void input_tar_close(struct input_tar *tar);

void print_buffer(const void *buf, size_t size);
void print_buffer2(const void *buf, size_t size);
void fprint_buffer2(FILE *f, const void *buf, size_t size);

#endif
