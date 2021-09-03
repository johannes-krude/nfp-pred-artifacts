#include "estimator/cfg.hpp"
#include "estimator/state.hpp"
#include "estimator/sat_checker.hpp"
#include "estimator/stats.hpp"
#include "estimator/features.hpp"
#include "version.h"

#include <iostream>
#include <memory>
#include <sstream>
#include <fstream>
#include <cstdlib>
#include <cstring>
#include <csignal>
#include <ctime>
#include <getopt.h>
#include <sys/sysinfo.h>
#include <openssl/sha.h>
#include <err.h>

//LDLIBS=rt
//LDLIBS=crypto


bool mem_available() {
	struct sysinfo info;
	if (sysinfo(&info) == -1)
		err(-1, "sysinfo()");
	return info.freeram + info.bufferram >= info.totalram/2;
}

static void usage(char *argv0) {
	fprintf(stderr, "Usage: %s [mode] [options]\n", argv0);
	fprintf(stderr, "Mode:\n");
	fprintf(stderr, "\t-k (default)       worst bit-rate analysis (DRAM & processors)\n");
	fprintf(stderr, "\t-m                 worst bit-rate analysis (processors only)\n");
	fprintf(stderr, "\t-q                 worst bit-rate analysis (DRAM only)\n");
	fprintf(stderr, "\t-i                 worst packet-rate analysis (DRAM & processors)\n");
	fprintf(stderr, "\t-l                 worst packet-rate analysis (processors only)\n");
	fprintf(stderr, "\t-p                 worst packet-rate analysis (DRAM only)\n");
	fprintf(stderr, "\t-g                 output cfg as DOT\n");
	fprintf(stderr, "Options:\n");
	fprintf(stderr, "\t-c <count=-1>      stop after count satisfiable paths\n");
	fprintf(stderr, "\t-C <cycles=%3u>    per packet firmware cycles\n", cfg::COST_FIRMWARE);
	fprintf(stderr, "\t-f <file>          input asm file\n");
	fprintf(stderr, "\t-L <analysis=Mode> 0: no, 1: without z3, 2: with z3\n");
	fprintf(stderr, "\t-M <MTU=%4u>      set MTU\n", cfg::MTU);
	fprintf(stderr, "\t-o <file>          output file\n");
	fprintf(stderr, "\t-S                 print settings\n");
	fprintf(stderr, "\t-t <threads=%zu>     number of threads\n", cfg::PARALLELISM);
	fprintf(stderr, "\t-T <timeout>       terminate after timeout\n");
	fprintf(stderr, "\t-U <unroll_limit>  unroll loops\n");
	fprintf(stderr, "\t-w <workers=%2u>    NIC bpf workers\n", cfg::NUM_WORKERS);
	fprintf(stderr, "\t-A                 debug symbolic assignments\n");
	fprintf(stderr, "\t-I <id,...>        debug instructions\n");
	fprintf(stderr, "\t-F <features>      configure features\n");
	fprintf(stderr, "\t-Z                 debug z3 invocation\n");
	fprintf(stderr, "Features:\n");
	for (auto s: features::examples())
		fprintf(stderr, "\t%s\n", s.c_str());
	exit(1);
}

int main(int argc, char** argv){
	static cfg* cfg;
	std::istream *in = &std::cin;
	std::ifstream fin;
	static std::ostream *out = &std::cout;
	std::ofstream fout;
	enum {
		MODE_DOT = 0,
		MODE_PACKETRATE = 1,
		MODE_PROC_PACKETRATE = 2,
		MODE_DRAM_PACKETRATE = 3,
		MODE_BITRATE = 4,
		MODE_PROC_BITRATE = 5,
		MODE_DRAM_BITRATE = 6,
	} mode = MODE_BITRATE;
	int static_analysis = -1;
	bool print_settings = false;
	long timeout = 0;
	size_t count = -1;
	int opt;

	std::ios_base::sync_with_stdio(false);

	while ((opt = getopt(argc, argv, "giklmpqc:C:f:L:M:o:St:T:U:w:AF:I:Z")) != -1) {
		switch (opt) {
		case 'g':
			mode = MODE_DOT;
			continue;
		case 'i':
			mode = MODE_PACKETRATE;
			continue;
		case 'k':
			mode = MODE_BITRATE;
			continue;
		case 'l':
			mode = MODE_PROC_PACKETRATE;
			continue;
		case 'm':
			mode = MODE_PROC_BITRATE;
			continue;
		case 'p':
			mode = MODE_DRAM_PACKETRATE;
			continue;
		case 'q':
			mode = MODE_DRAM_BITRATE;
			continue;
		case 'c':
			sscanf(optarg, "%zu", &count);
			continue;
		case 'C':
			sscanf(optarg, "%u", &cfg::COST_FIRMWARE);
			continue;
		case 'f':
			fin.open(optarg, std::ios::in);
			if (fin.fail())
				err(-1, "opening %s ", optarg);
			in = &fin;
			continue;
		case 'L':
			sscanf(optarg, "%i", &static_analysis);
			continue;
		case 'M':
			sscanf(optarg, "%" SCNu32, &cfg::MTU);
			continue;
		case 'o':
			fout.exceptions(std::ifstream::badbit);
			fout.open(optarg, std::ios::out | std::ios::trunc);
			if (fout.fail())
				err(-1, "opening %s ", optarg);
			out = &fout;
			continue;
		case 'S':
			print_settings = true;
			continue;
		case 't':
			sscanf(optarg, "%zu", &cfg::PARALLELISM);
			continue;
		case 'T':
			sscanf(optarg, "%lu", &timeout);
			continue;
		case 'U': {
			while (char* n = strchr(optarg, ',')) {
				std::uint32_t id = -1;
				std::size_t limit = 0;
				sscanf(optarg, "%zu:%" PRIu32, &limit, &id);
				if (id == (uint32_t) -1) {
					cfg::UNROLL_LIMIT = limit;
				} else {
					cfg::UNROLL_LIMITS[id] = limit;
				}
				optarg = n+1;
			}
			std::uint32_t id = -1;
			std::size_t limit = 0;
			sscanf(optarg, "%zu:%" PRIu32, &limit, &id);
			if (id == (uint32_t) -1) {
				cfg::UNROLL_LIMIT = limit;
			} else {
				cfg::UNROLL_LIMITS[id] = limit;
			}
			continue; }
		case 'w':
			sscanf(optarg, "%u", &cfg::NUM_WORKERS);
			continue;
		case 'A':
			state::debug_assignments = true;
			continue;
		case 'F':
			while (char* n = strchr(optarg, ',')) {
				*n = 0;
				if (!features::parse(optarg))
					usage(argv[0]);
				optarg = n+1;
			}
			if (!features::parse(optarg))
				usage(argv[0]);
			continue;
		case 'I': {
			uint32_t id = 0;
			while (char* n = strchr(optarg, ',')) {
				sscanf(optarg, "%" PRIu32, &id);
				state::debug_instrs.insert(id);
				optarg = n+1;
			}
			sscanf(optarg, "%" PRIu32, &id);
			state::debug_instrs.insert(id);
			continue; }
		case 'Z':
			sat_checker::debug = true;
			continue;
		}
		usage(argv[0]);
	}
	if (argc-optind != 0)
		usage(argv[0]);

	std::string asm_listing(std::istreambuf_iterator<char>(*in), {});
	if (in->fail())
		err(-1, "reading");

	if (static_analysis == -1)
		static_analysis = (mode+2)/3;

	std::signal(SIGINT, [](int) {
		stats::write(*out);
		std::quick_exit(128+SIGINT);
	});
	std::signal(SIGUSR1, [](int) {
		stats::write(*out);
	});

	if (print_settings) {
		std::time_t time = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
		*out << "time: " << std::ctime(&time);
		*out << "compiled at: " << version_date << "\n";
		*out << "git version: " << version_git << "\n";
		if (version_git_status[0])
			*out << "git status: " << version_git_status << "\n";
		*out << "z3: " << sat_checker::z3_version() << "\n";

		switch (mode) {
		case MODE_PACKETRATE:
			*out << "mode: packetrate\n";
			break;
		case MODE_BITRATE:
			*out << "mode: bitrate\n";
			break;
		case MODE_PROC_PACKETRATE:
			*out << "mode: proc packetrate\n";
			break;
		case MODE_PROC_BITRATE:
			*out << "mode: proc bitrate\n";
			break;
		case MODE_DRAM_PACKETRATE:
			*out << "mode: DRAM packetrate\n";
			break;
		case MODE_DRAM_BITRATE:
			*out << "mode: DRAM bitrate\n";
			break;
		case MODE_DOT:
			*out << "mode: cfg\n";
			break;
		}
		switch (static_analysis) {
		case 0:
			*out << "static_analysis: none\n";
			break;
		case 1:
			*out << "static_analysis: without z3\n";
			break;
		case 2:
			*out << "static_analysis: with z3\n";
			break;
		}

		*out << "features: " << features::values() << "\n";
		*out << "bpf-workers: " << cfg::NUM_WORKERS << "\n";
		*out << "input: ";
		unsigned char hash[SHA256_DIGEST_LENGTH];
		SHA256_CTX sha256;
		SHA256_Init(&sha256);
		SHA256_Update(&sha256, asm_listing.c_str(), asm_listing.size());
		SHA256_Final(hash, &sha256);
		for(int i = 0; i < SHA256_DIGEST_LENGTH; i++)
			*out <<  std::hex << std::setw(2) << std::setfill('0') << (int)hash[i];
		*out << std::dec << "\n";

		*out << "\n" << std::flush;
	}

	if (timeout) {
		std::signal(SIGALRM, [](int) {
			*out << "\n";
			cfg->report_timeout();
			out->flush();
			std::quick_exit(0);
		});
		timer_t timerid;
		if (timer_create(CLOCK_MONOTONIC, NULL, &timerid))
			err(-1, "timer_create(CLOCK_MONOTONIC)");
		itimerspec timer_value = {{},{timeout,0}};
		if (timer_settime(timerid, 0, &timer_value, NULL))
			err(-1, "timer_settime(%lu)", timeout);
	}

	cfg = new std::remove_pointer<decltype(cfg)>::type(asm_listing, *out);
	if (static_analysis >= 1)
		cfg->static_analysis(static_analysis >= 2);
	switch (mode) {
	case MODE_DOT:
		cfg->save_dot_graph();
		break;
	case MODE_PACKETRATE:
		cfg->enumerate_by_packetrate(count);
		break;
	case MODE_BITRATE:
		cfg->enumerate_by_bitrate(count);
		break;
	case MODE_PROC_PACKETRATE:
		cfg->enumerate_by_proc_packetrate(count);
		break;
	case MODE_PROC_BITRATE:
		cfg->enumerate_by_proc_bitrate(count);
		break;
	case MODE_DRAM_PACKETRATE:
		cfg->enumerate_by_dram_packetrate(count);
		break;
	case MODE_DRAM_BITRATE:
		cfg->enumerate_by_dram_bitrate(count);
		break;
	}
	delete cfg;

	if (out->fail())
		errx(-1, "error writing output");

	return 0;
}

