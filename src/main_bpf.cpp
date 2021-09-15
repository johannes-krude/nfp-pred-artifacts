
extern "C" {
#include "input.h"
#include "mapreads.h"
#include "ktest.h"
#include "bpf.h"
#include "mapdef.h"
#include "ereport.h"
}

#include <vector>
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <net/if.h>
#include <sys/mman.h>
#include <linux/bpf.h>
#include <poll.h>
#include <fnmatch.h>
#include <assert.h>
#include <libelf.h>
#include <gelf.h>
#include <errno.h>
#include <limits.h>
#include <err.h>

#ifdef PACKAGE
#include <dis-asm.h>
#else
#define PACKAGE
#include <dis-asm.h>
#undef PACKAGE
#endif

//LDLIBS=elf bfd opcodes z iberty dl


#define NEXT_POW_OF_TWO(x) (1UL <<(1 +(63 -__builtin_clzl(x -1))))

static bool verbose = false;

enum program_mode {
	PMODE_NONE = 0,
	PMODE_BINARY,
	PMODE_SOURCE,
	PMODE_TAR,
	PMODE_ELF,
};

enum bpf_task {
	BPF_TASK_ATTACH = 0,
	BPF_TASK_PRINT_JITTED,
	BPF_TASK_MAP_LOOKUP,
};

static struct mapdef *mapdefs = NULL;
size_t num_mapdefs = 0;

static bool shrink_applicable(const struct mapdef *m, size_t divisor) {
	if (!m->max_entries/divisor)
		return false;
	switch (m->type) {
	case BPF_MAP_TYPE_HASH:
	case _BPF_MAP_TYPE_PERCPU_HASH:
		return true;
	default:
		return false;
	}
}

static void maps_open(const char *ifname) {
	for (size_t i = 0; i < num_mapdefs; i++)
		mapdefs[i].fd = bpf_map_open(ifname, mapdefs[i].name);
}

static bool shrink_maps(size_t divisor, uint32_t ifindex, const char *ifname) {
	int fd;
	bool shrinked = false;

	for (size_t i = 0; i < num_mapdefs; i++) {
		struct mapdef *m = &mapdefs[i];
		if (m->fd == -1)
			continue;
		if (!shrink_applicable(m, divisor))
			continue;

		bpf_map_delete(m->fd, ifname, m->name);
	retry:
		fd = bpf_map_create(m->type, m->key_size, m->value_size,
				m->max_entries/divisor, ifindex, ifname, m->name);
		if (fd == -1 && errno == EPERM) {
			if (poll(NULL, 0, 100) == -1)
				err(-1, "poll(NULL, 0, 100)");
			goto retry;
		}
		if (fd != m->fd)
			errx(-1, "map shrinkage changed fd %i -> %i", m->fd, fd);
		shrinked = true;
	}

	return shrinked;
}

static int get_map_fd(struct mapdef *m, uint32_t ifindex, const char *ifname, bool divide_maps) {
	size_t divisor = 1;

	if (m->fd != -1)
		return m->fd;

	while (m->fd == -1) {
		m->fd = bpf_map_create(m->type, m->key_size, m->value_size,
				m->max_entries/(shrink_applicable(m, divisor) ? divisor : 1),
				ifindex, ifname, m->name);
		if (m->fd != -1)
			break;
		if (!divide_maps)
			errx(-1, "not enough memory available to create bpf map");
		divisor *= 2;
		if (!shrink_maps(divisor, ifindex, ifname) && !shrink_applicable(m, divisor))
			err(-1, "maps can not be shrinked any further");
	}
	return m->fd;
}

static void prog_link(struct bpf_insn *instr, size_t num, uint32_t ifindex,
		const char* ifname, bool divide_maps) {
	for (size_t i = 0; i < num-1; i++) {
		if (instr[i].code != (BPF_LD | BPF_DW | BPF_IMM) ||
		    instr[i].src_reg != BPF_PSEUDO_MAP_FD ||
		    instr[i].off ||
		    instr[i+1].code ||
		    instr[i+1].dst_reg ||
		    instr[i+1].src_reg ||
		    instr[i+1].off)
			continue;
		uint64_t num = instr[i].imm + (((uint64_t) instr[i+1].imm) << 32);
		struct mapdef *m = NULL;
		for (size_t ii = 0; ii < num_mapdefs; ii++) {
			if (mapdefs[ii].num != num)
				continue;
			m = &mapdefs[ii];
			break;
		}
		if (!m)
			errx(-1, "missing mapdef for map number %" PRIu64, num);
		if (m->fd == -1 && verbose)
			printf("map %" PRIu64 ": type %u %s[%zu] [%zu]->[%zu]\n", m->num,
				   m->type, m->name, m->max_entries, m->key_size,
				   m->value_size);
		instr[i].imm = get_map_fd(m, ifindex, ifname, divide_maps);
		instr[i+1].imm = ((uint64_t) m->fd)<<32;
	}
}

#define LOG_BUF_SIZE 1048576

static int prog_load(enum bpf_prog_type type, const void *buf, size_t size,
		uint32_t ifindex, const char* ifname, bool divide_maps) {
	size_t num = size / sizeof(struct bpf_insn);
	struct bpf_insn *instr;
	int fd;

	if (num * sizeof(struct bpf_insn) != size)
		errx(-1, "invalid binary bpf size");

	instr = new bpf_insn[num];
	if (!instr)
		err(-1, "calloc");
	memcpy(instr, buf, num * sizeof(*instr));

	prog_link(instr, num, ifindex, ifname, divide_maps);
	fd = bpf_load(type, instr, num, ifindex);

	delete[] instr;
	return fd;
}

static void prog_disassemble(unsigned char *buf, size_t size, const char *arch) {
	char tpath[PATH_MAX+1] = {};
	bfd *bfdf;
	struct disassemble_info info = {};
	disassembler_ftype disassemble;
	size_t pc = 0;
	int count = 0;

	if (readlink("/proc/self/exe", tpath, sizeof(tpath)-1) == -1)
		err(-1, "readlink(/proc/self/exe)");
	bfdf = bfd_openr(tpath, NULL);
	if (!bfdf || ! bfd_check_format(bfdf, bfd_object))
		errx(-1, "bfd_openr()");
	init_disassemble_info(&info, stdout, (fprintf_ftype) fprintf);
	if (arch) {
		bfdf->arch_info = bfd_scan_arch(arch);
		if (!bfdf->arch_info)
			errx(-1, "No libbfd support for %s", arch);
	}
	info.arch = bfd_get_arch(bfdf);
	info.mach = bfd_get_mach(bfdf);
	disassemble_init_for_target(&info);
	disassemble = disassembler(info.arch, bfd_big_endian(bfdf), info.mach,
					bfdf);
	if (!disassemble)
		errx(-1, "no suitable disassembler available");
	info.buffer = buf;
	info.buffer_length = size;
	info.buffer_vma = 0;
	info.disassembler_options = "ctx4";
	do {
		printf("%4lx:\t", pc);
		count = disassemble(pc, &info);
		printf("\n");

		pc += count;
	} while(count > 0 && pc < size);

	bfd_close(bfdf);
}

static void prog_dump(int fd, uint32_t ifindex) {
	struct _bpf_prog_info info;

	bpf_info(fd, &info);
	prog_disassemble((unsigned char *) info.jited_prog_insns, info.jited_prog_len, ifindex ? "NFP-6xxx" : NULL);
}

static void map_lookup(const char *ifname, const char *mapname,
			unsigned long index) {
	struct mapdef *m = NULL;
	if (num_mapdefs)
		m = &mapdefs[0];
	if (mapname) {
		for (size_t i = 0; i < num_mapdefs; i++) {
			if (strcmp(mapname, mapdefs[i].name))
				continue;
			m = &mapdefs[i];
			break;
		}
	}
	if (!m)
		errx(-1, "map not found");

	char key[m->key_size] = {0};
	char value[m->value_size] = {0};
	*((uint32_t *) key) = index;
	bpf_map_lookup(m->fd, key, value, 0);
	print_buffer(value, m->value_size);
	printf("\n");
}

static void map_insert(const char *map, size_t map_size,
                       const void *key, size_t key_size,
                       const void *value, size_t value_size) {
	struct mapdef *m = NULL;
	static uint64_t flags = 0;

	for (size_t i = 0; i < num_mapdefs; i++) {
		if (strncmp(map, mapdefs[i].name, map_size) ||
			mapdefs[i].name[map_size])
			continue;
		m = &mapdefs[i];
		break;
	}
	if (!m) {
		warnx("unknown map in mapreads '%.*s'", (int) map_size, map);
		return;
	}
	if (m->fd == -1) {
		warnx("unused map with mapreads '%.*s'", (int) map_size, map);
		return;
	}
	if (key_size != m->key_size)
		errx(-1, "invalid map key size %zu for map '%s'", key_size,
			 m->name);
	if (value_size != -1U && value_size != m->value_size)
		errx(-1, "invalid map value size %zu for map '%s'", value_size,
			 m->name);

	if (verbose) {
		printf("insert %s ", m->name);
		print_buffer(key, key_size);
		printf(" -> ");
		print_buffer(value, value_size);
		printf("\n");
	}
	if (m->type == BPF_MAP_TYPE_HASH)
		flags |= BPF_NOEXIST;
	bpf_map_insert(m->fd, key, value, flags);
}

static void gen_insert(const char *gen, size_t gen_size) {
	struct mapreads_gen mg;
	struct mapread_gen m;

	mapreads_gen_init(&mg, gen, gen_size);
	while (mapreads_gen_next(&mg, &m))
		map_insert(m.name, m.name_len, m.key, m.key_len, m.value, m.value_len);

	mapreads_gen_free(&mg);
}

static void ktest_insert(const void *buf, size_t size) {
	struct ktest_buf k;
	struct mapread_ktest m;
	const char null_ptr[8] = {};
	size_t max_value_size = 0;
	void *v;

	for (size_t i = 0; i < num_mapdefs; i++) {
		if (mapdefs[i].value_size > max_value_size)
			max_value_size = mapdefs[i].value_size;
	}
	v = calloc(max_value_size, 1);
	if (max_value_size && !v)
		err(-1, "calloc");

	ktest_init(&k, buf, size);

	while (mapreads_ktest_next(&k, &m, true)) {
		if (!memcmp(m.read_res, null_ptr, 8))
			continue;
		if (!m.value) {
			m.value = v;
			m.value_len = -1;
		}
		map_insert(m.name, m.name_len, m.key, m.key_len, m.value, m.value_len);
	}

	free(v);
}

static void mapreads_insert(const void *buf, size_t size) {
	struct mapreads_json ms;
	struct mapread_json m;
	size_t max_key_size = 0;
	size_t max_value_size = 0;

	for (size_t i = 0; i < num_mapdefs; i++) {
		if (mapdefs[i].key_size > max_key_size)
			max_key_size = mapdefs[i].key_size;
		if (mapdefs[i].value_size > max_value_size)
			max_value_size = mapdefs[i].value_size;
	}
	m.key = malloc(max_key_size);
	if (max_key_size && !m.key)
		err(-1, "malloc");
	m.value = malloc(max_value_size);
	if (max_value_size && !m.value)
		err(-1, "malloc");
	mapreads_json_init(&ms, buf, size, max_key_size, max_value_size);

	while (mapreads_json_next(&ms, &m)) {
		map_insert(m.name, m.name_len, m.key, m.key_len, m.value, m.value_len);
	}

	mapreads_json_free(&ms);
	free(m.key);
	free(m.value);
}

static void ereport_insert(void) {

	size_t num;
	struct ereport_map *em = ereport_map_parse(0, &num);
	if (!em)
		return;

	if (num_mapdefs != 1)
		errx(-1, "ereport expects exactly one map");
	struct mapdef *m = &mapdefs[0];
	if (m->key_size != 4)
		errx(-1, "ereport expects four byte key");
	uint32_t value_size = NEXT_POW_OF_TWO(m->value_size);

	uint32_t key;
	char value[m->value_size] = {};
	for (size_t i = 0; i < num; i++) {
		key = em[i].offset/value_size;
		uint32_t offset = em[i].offset%value_size;
		if (offset > m->value_size)
			errx(-1, "beyond value size %zu at 0x%" PRIx32, m->value_size, em[i].offset);
		value[offset] = em[i].value;

		if (i+1 == num || em[i+1].offset/value_size != key) {
			bpf_map_insert(m->fd, &key, value, 0);
			memset(value, 0, m->value_size);
		}
	}
	ereport_map_free(0);
}

static void parse_elf(int fd, const void **bpf_b, size_t *bpf_size,
			struct mapdef **mapdefs, size_t *num_mapdefs) {
	Elf_Data *text = NULL;
	size_t text_idx = 0;
	Elf_Data *maps = NULL;
	size_t maps_idx = 0;
	Elf64_Shdr *rel_text_shdr = NULL;
	Elf_Data *rel_text_data = NULL;
	Elf_Data *symbols = NULL;
	size_t idx = 0;

	elf_version(EV_CURRENT);
	Elf *elf = elf_begin(fd, ELF_C_READ, NULL);
	if (!elf)
		errx(-1, "elf_begin: %s", elf_errmsg(-1));
	Elf64_Ehdr *ehdr = elf64_getehdr(elf);
	if (!ehdr)
		errx(-1, "elf64_getehdr: %s", elf_errmsg(-1));
	if (ehdr->e_machine != EM_BPF)
		errx(-1, "non BPF elf (machine: %i)", ehdr->e_machine);
	Elf_Scn *scn = elf_getscn(elf, ehdr->e_shstrndx);
	if (!scn)
		errx(-1, "elf_getscn: %s", elf_errmsg(-1));
	for (; scn; scn = elf_nextscn(elf, scn)) {
		idx++;
		Elf64_Shdr *shdr = elf64_getshdr(scn);
		if (!shdr)
			errx(-1, "elf64_getshdr: %s", elf_errmsg(-1));
		char *sname = elf_strptr(elf, ehdr->e_shstrndx, shdr->sh_name);
		if (!sname)
			continue;
		Elf_Data *data = elf_getdata(scn, NULL);
		if (!data)
			errx(-1, "elf_getdata: %s", elf_errmsg(-1));
		if (!strcmp(sname, ".text") || !strcmp(sname, "prog")) {
			text = data;
			text_idx = idx;
		} else if (!strcmp(sname, "maps")) {
			maps = data;
			maps_idx = idx;
		} else if (!strcmp(sname, ".symtab")) {
			symbols = data;
		} else if (!strcmp(sname, ".rodata")) {
			errx(-1, ".rodata not supported");
		}
	}
	idx = 0;
	scn = elf_getscn(elf, ehdr->e_shstrndx);
	if (!scn)
		errx(-1, "elf_getscn: %s", elf_errmsg(-1));
	for (; scn; scn = elf_nextscn(elf, scn)) {
		idx++;
		Elf64_Shdr *shdr = elf64_getshdr(scn);
		if (shdr->sh_type != SHT_REL) {
			continue;
		}
		char *sname = elf_strptr(elf, ehdr->e_shstrndx, shdr->sh_name);
		if (!sname)
			continue;
		if (shdr->sh_info != text_idx)
			continue;
		rel_text_shdr = shdr;
		rel_text_data = elf_getdata(scn, NULL);
		if (!rel_text_data)
			errx(-1, "elf_getdata: %s", elf_errmsg(-1));
	}

	if (!text)
		errx(-1, "no .text|prog section");
	if (text->d_type != ELF_T_BYTE)
		errx(-1, "wrong type of .text|prog section");
	*bpf_b = text->d_buf;
	*bpf_size = text->d_size;

	if (!symbols)
		return;
	if (symbols->d_type != ELF_T_SYM)
		errx(-1, "wrong type of .symtab section");
	if (!maps)
		return;
	if (maps->d_type != ELF_T_BYTE)
		errx(-1, "wrong type of maps section");
	if (!rel_text_shdr)
		return;

	for (size_t i = 0; i < rel_text_shdr->sh_size / rel_text_shdr->sh_entsize; i++) {
		GElf_Rel rel;
		if (!gelf_getrel(rel_text_data, i, &rel))
			errx(-1, "gelf_getrel: %s", elf_errmsg(-1));
		if (rel.r_offset + sizeof(struct bpf_insn) > text->d_size)
			errx(-1, ".text reloc beyond end");
		struct bpf_insn *instr = (struct bpf_insn *)((char *) text->d_buf + rel.r_offset);
		if (instr->code != (BPF_LD | BPF_DW | BPF_IMM) || instr->src_reg || instr->imm)
			errx(-1, "relocation of unsupported instr");
		instr->src_reg = BPF_PSEUDO_MAP_FD;
		instr->imm = GELF_R_SYM(rel.r_info);
	}

	*num_mapdefs = 0;
	*mapdefs = NULL;
	for (size_t i = 0; i < symbols->d_size / sizeof(GElf_Sym); i++) {
		GElf_Sym sym;
		if (!gelf_getsym(symbols, i, &sym))
			continue;
		if (sym.st_shndx != maps_idx)
			continue;
		char *sname = elf_strptr(elf, ehdr->e_shstrndx, sym.st_name);
		if (!sname)
			continue;
		if (sym.st_value + sym.st_size > maps->d_size)
			errx(-1, "map symbol beyond section end");
		*num_mapdefs += 1;
		*mapdefs = (struct mapdef *) realloc(*mapdefs, *num_mapdefs*sizeof(**mapdefs));
		if (!*mapdefs)
			err(-1, "realloc");
		struct {
			uint32_t type;
			uint32_t key_size;
			uint32_t value_size;
			uint32_t max_entries;
		} *m = (decltype(m))((char *) maps->d_buf + sym.st_value);
		if (sizeof(*m) > sym.st_size)
			errx(-1, "map symbol too small");
		for (size_t n = sizeof(*m); n < sym.st_size; n++) {
			if (((char *)maps->d_buf)[sym.st_value+n])
				err(-1, "unknown non-zero map option");
		}
		(*mapdefs)[*num_mapdefs-1] = (struct mapdef) {
			.num         = i,
			.name        = sname,
			.fd          = -1,
			.type        = (enum bpf_map_type) m->type,
			.key_size    = m->key_size,
			.value_size  = m->value_size,
			.max_entries = m->max_entries,
		};
	}
}

static void bpf_clear(unsigned int iface, const char* ifname, bool keep_maps) {
	bpf_clear_act(iface);
	bpf_clear_xdp(iface, ifname);
	if (!keep_maps)
		bpf_clear_maps(ifname);
	if (poll(NULL, 0, 100) == -1)
		err(-1, "poll(NULL, 0, 100)");
}

static void bpf_attach(enum bpf_prog_type prog_type, uint32_t xdp_mode,
		unsigned int iface, int bpf_fd) {

	switch ((int) prog_type) {
	case BPF_PROG_TYPE_SCHED_ACT:
		bpf_attach_act(iface, bpf_fd);
		break;
	case _BPF_PROG_TYPE_XDP:
		bpf_attach_xdp(iface, xdp_mode, bpf_fd);
		break;
	default:
		errx(-1, "unsupported bpf prog type");
	}
}

static void usage(char *argv0) {
	fprintf(stderr, "Usage: %s <prog-type> <mode> [options] <iface...>\n", argv0);
	fprintf(stderr, "Tasks: [default: attach program]\n");
	fprintf(stderr, "\t-p                 print jitted program\n");
	fprintf(stderr, "\t-l <[map:]index>   lookup map entry\n");
	fprintf(stderr, "BPF Program Type [default: none]:\n");
	fprintf(stderr, "\t-s                 scheduler action program\n");
	fprintf(stderr, "\t-X                 XDP program\n");
	fprintf(stderr, "Input Type [default: none]:\n");
	fprintf(stderr, "\t-b                 read binary program from input\n");
	fprintf(stderr, "\t-e                 read elf from input\n");
	fprintf(stderr, "\t-i <main>          read source code from input\n");
	fprintf(stderr, "\t-t                 read binary program from tar input\n");
	fprintf(stderr, "Options:\n");
	fprintf(stderr, "\t-c                 clear all attached programs\n");
	fprintf(stderr, "\t-d <file>          read map definiton from file\n");
	fprintf(stderr, "\t-D                 divide applicable map sizes to fit available memory\n");
	fprintf(stderr, "\t-E                 use map content from ereport from STDIN\n");
	fprintf(stderr, "\t-g <pattern>       generate map content from pattern\n");
	fprintf(stderr, "\t-G                 generic XDP\n");
	fprintf(stderr, "\t-k <file>          read ktest file for map content\n");
	fprintf(stderr, "\t-K <test>          select ktest from tar for map content\n");
	fprintf(stderr, "\t-m <file>          read map content from file\n");
	fprintf(stderr, "\t-o                 offload bpf program\n");
	fprintf(stderr, "\t-O                 open existing maps\n");
	fprintf(stderr, "\t-v                 verbose output\n");
	input_usage();
	exit(1);
}

int main(int argc, char **argv) {
	const char *nf_compile_argv[] = {"./scripts/nf-compile-simple.py", "-", NULL, "-", NULL};
	struct input_opts input_opts = {};
	struct input_tar tar = {};
	struct input_tar_file file = {};
	enum bpf_task task = BPF_TASK_ATTACH;
	enum program_mode pmode = PMODE_NONE;
	enum bpf_prog_type prog_type = BPF_PROG_TYPE_UNSPEC;
	bool clear = false;
	uint32_t xdp_mode = _XDP_FLAGS_DRV_MODE;
	struct iface {unsigned int index; const char* name;};
	std::vector<struct iface> ifaces;
	char ktest[64] = {};
	const char *gen = NULL;
	const char *mapdef_file   = NULL;
	const char *ktest_file    = NULL;
	const char *mapreads_file = NULL;
	const void *bpf_b      = NULL;
	const void *ktest_b    = NULL;
	const void *mapdef_b   = NULL;
	const void *mapreads_b = NULL;
	bool ereport = false;
	size_t bpf_size;
	size_t ktest_size;
	size_t mapdef_size;
	size_t mapreads_size;
	bool open_maps = false;
	bool divide_maps = false;
	char *lookup_map = NULL;
	unsigned long lookup_index = 0;
	int opt;
	int fd;
	int bpf_fd;

	while ((opt = getopt(argc, argv, "pl:" "sX" "bei:t" "cd:DEg:Gk:K:m:oOv" INPUT_OPTS)) != -1) {
		switch (opt) {
		case 'p':
			task = BPF_TASK_PRINT_JITTED;
			continue;
		case 'l':
			task = BPF_TASK_MAP_LOOKUP;
			if (char *colon = strchr(optarg, ':')) {
				lookup_map = optarg;
				colon[0] = 0;
				optarg = colon+1;
			}
			sscanf(optarg, "%lu", &lookup_index);
			continue;

		case 's':
			prog_type = BPF_PROG_TYPE_SCHED_ACT;
			continue;
		case 'X':
			prog_type = _BPF_PROG_TYPE_XDP;
			continue;

		case 'b':
			pmode = PMODE_BINARY;
			continue;
		case 'e':
			pmode = PMODE_ELF;
			continue;
		case 'i':
			pmode = PMODE_SOURCE;
			nf_compile_argv[2] = optarg;
			continue;
		case 't':
			pmode = PMODE_TAR;
			input_opts.tar = &input_tar_iterate;
			continue;

		case 'c':
			clear = true;
			continue;
		case 'd':
			mapdef_file = optarg;
			continue;
		case 'D':
			divide_maps = true;
			continue;
		case 'E':
			ereport = true;
			continue;
		case 'g':
			gen = optarg;
			continue;
		case 'G':
			xdp_mode = _XDP_FLAGS_SKB_MODE;
			continue;
		case 'k':
			ktest_file = optarg;
			continue;
		case 'K':
			snprintf(ktest, sizeof(ktest), "*/%s.ktest", optarg);
			continue;
		case 'm':
			mapreads_file = optarg;
			continue;
		case 'o':
			xdp_mode = _XDP_FLAGS_HW_MODE;
			continue;
		case 'O':
			open_maps = true;
			continue;
		case 'v':
			verbose = true;
			continue;
		}
		if (input_optparse(opt, &input_opts))
			continue;
		usage(argv[0]);
	}
	if (argc-optind < 1)
		usage(argv[0]);

	for (int i = optind; i < argc; i++) {
		unsigned int index = if_nametoindex(argv[i]);
		if (!index)
			err(-1, "if_nametoindex");
		ifaces.push_back(iface{index, argv[i]});
	}

	if (!clear && prog_type == BPF_PROG_TYPE_UNSPEC)
		usage(argv[0]);
	if (!clear && !pmode)
		usage(argv[0]);
	if (ereport && pmode != PMODE_NONE && !input_opts.path)
		usage(argv[0]);

	if (pmode == PMODE_ELF)
		input_opts.to_file = true;
	fd = input_open(&input_opts);

	if (mapdef_file)
		mapdef_b = input_map_file(mapdef_file, &mapdef_size);
	if (mapreads_file)
		mapreads_b = input_map_file(mapreads_file, &mapreads_size);
	if (ktest_file)
		ktest_b = input_map_file(ktest_file, &ktest_size);

	switch (pmode) {
	case PMODE_NONE:
		break;
	case PMODE_SOURCE:
		fd = input_filter_exec(fd, nf_compile_argv);
		[[fallthrough]];
	case PMODE_BINARY:
		bpf_b = input_map(fd, &bpf_size);
		if (poll(NULL, 0, 100) == -1)
			err(-1, "poll(NULL, 0, 100)");
		break;
	case PMODE_ELF:;
		parse_elf(fd, &bpf_b, &bpf_size, &mapdefs, &num_mapdefs);
		break;
	case PMODE_TAR:;
		input_tar_open(&input_opts, fd, &tar);
		while (input_tar_next(&tar, NULL, &file)) {
			if (!mapdef_b &&
			    !fnmatch("*.json", file.name, FNM_PATHNAME)) {
				mapdef_b = input_tar_map(&tar, &mapdef_size);
				mapdef_size = file.size;
			} else if (!bpf_b &&
			           !fnmatch("*.bpf", file.name, FNM_PATHNAME)) {
				bpf_b = input_tar_map(&tar, &bpf_size);
			} else if (!ktest_b && ktest[0] &&
			           !fnmatch(ktest, file.name, FNM_PATHNAME)) {
				ktest_b = input_tar_map(&tar, &ktest_size);
			}
			if (mapdef_b && bpf_b && (ktest_b || !ktest[0]))
				break;
		}
		break;
	}
	if (close(fd))
		err(-1, "close");
	if (ktest[0] && !ktest_b)
		errx(-1, "ktest not found");

	if (mapdef_b)
		mapdefs = mapdef_parse(mapdef_b, mapdef_size, &num_mapdefs);

	if (open_maps)
		maps_open(ifaces[0].name);

	if (clear) {
		for (const auto& [iface, name]: ifaces)
			bpf_clear(iface, name, open_maps);
		if (prog_type == BPF_PROG_TYPE_UNSPEC || !pmode)
			return 0;
	}
	if (!bpf_b)
		errx(-1, "no bpf binary found");

	switch (task) {
	case BPF_TASK_ATTACH:
	case BPF_TASK_PRINT_JITTED:
		bpf_fd = prog_load(prog_type, bpf_b, bpf_size,
			(xdp_mode == _XDP_FLAGS_HW_MODE) ? ifaces[0].index : 0,
			argv[optind], divide_maps);
		break;
	case BPF_TASK_MAP_LOOKUP:
		break;
	}

	if (gen)
		gen_insert(gen, strlen(gen));
	if (ktest_b)
		ktest_insert(ktest_b, ktest_size);
	if (mapreads_b)
		mapreads_insert(mapreads_b, mapreads_size);
	if (ereport)
		ereport_insert();

	switch (task) {
	case BPF_TASK_ATTACH:
		for (const auto& [iface, name]: ifaces)
			bpf_attach(prog_type, xdp_mode, iface, bpf_fd);
		break;
	case BPF_TASK_PRINT_JITTED:
		prog_dump(bpf_fd, (xdp_mode == _XDP_FLAGS_HW_MODE) ? ifaces[0].index : 0);
		break;
	case BPF_TASK_MAP_LOOKUP:
		map_lookup(ifaces[0].name, lookup_map, lookup_index);
		break;
	}

	return 0;
}

