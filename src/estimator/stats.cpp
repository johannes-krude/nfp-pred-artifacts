
#include "estimator/stats.hpp"

#include <atomic>
#include <string>
#include <deque>
#include <ostream>
#include <algorithm>
#include <vector>
#include <ctime>
#include <cstring>
#include <thread>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <err.h>


std::mutex stats::mutex;
std::deque<const stats*> stats::all = {};


stats::stats(const std::string& name)
	: name(name) {
	std::lock_guard lock(mutex);

	all.push_back(this);
}

stats::~stats() {
	std::remove(all.begin(), all.end(), this);
}

void stats::write(std::ostream& out) {
	std::lock_guard lock(mutex);

	for (const stats* s: all)
		out << s->name << ": " << s->str() << std::endl;
}

void stats::counter::count() {
	counter++;
}

void stats::counter::down() {
	counter--;
}

std::string stats::counter::str() const {
	return std::to_string(this->counter);
}

void stats::clock::add(clockid_t clk_id) {
	struct timespec tp;

	if (!this->clocks.insert(clk_id).second)
		return;

	if (clock_gettime(clk_id, &tp))
		err(-1, "clock_gettime");
	this->time -= tp.tv_sec + (tp.tv_nsec/1000000000.0);
}

void stats::clock::remove(clockid_t clk_id) {
	struct timespec tp;

	if (!this->clocks.erase(clk_id))
		return;

	if (clock_gettime(clk_id, &tp))
		err(-1, "clock_gettime");
	this->time += tp.tv_sec + (tp.tv_nsec/1000000000.0);
}

std::string stats::clock::str() const {
	double t = this->time;
	for (auto clk_id: this->clocks) {
		struct timespec tp;
		if (clock_gettime(clk_id, &tp))
			err(-1, "clock_gettime");
		t += tp.tv_sec + (tp.tv_nsec/1000000000.0);
	}
	return std::to_string(t) + " s";
}

stats::cputime::cputime(const std::string& name, pid_t pid)
	: clock(name) {
	add(pid);
}

void stats::cputime::add(pid_t pid) {
	clockid_t clk_id;
	if (clock_getcpuclockid(pid, &clk_id))
		err(-1, "clock_getcpuclockid(%u)", pid);
	clock::add(clk_id);
}

stats::threadtime::threadtime(const std::string& name, std::thread::native_handle_type handle)
	: clock(name) {
	add(handle);
}

void stats::threadtime::add(std::thread::native_handle_type handle) {
	clockid_t clk_id;
	if (pthread_getcpuclockid(handle, &clk_id))
		err(-1, "pthread_getcpuclockid");
	clock::add(clk_id);
}

stats::maxmem::maxmem(const std::string& name, pid_t pid)
	: stats(name) {
	add(pid);
}

void stats::maxmem::add(pid_t pid) {
	std::string filename = "/proc/" + (pid ? std::to_string(pid) : "self") + "/status";
	int fd = open(filename.c_str(), O_RDONLY);
	if (fd == -1)
		err(-1, "open(%s)", filename.c_str());
	this->fds[pid] = fd;
}

void stats::maxmem::remove(pid_t pid) {
	auto i = this->fds.find(pid);
	if (close(i->second))
		err(-1, "close(/proc/*/status)");
	this->fds.erase(i);
}

static size_t getVmHWM(int fd) {
	static std::vector<char> buf = std::vector<char>(4096, 0);

retry:
	char* l = buf.data();
	if (lseek(fd, 0, SEEK_SET) == -1)
		err(-1, "lseek(/proc/*/status)");
	int s = read(fd, l, buf.size()-1);
	if (s == -1)
		err(-1, "read(/proc/*/status)");
	if (s == (int) buf.size()-1) {
		buf.resize(buf.size() + buf.size()/2);
		goto retry;
	}

	buf[s] = 0;
	for (;;) {
		l = strstr(l, "VmHWM:");
		if (!l)
			errx(-1, "VmHWM not found");
		if (l != buf.data() && l[-1] != '\n') {
			l++;
			continue;
		}
		break;
	}
	l = l + strlen("VmHWM:");
	while (*l == ' ')
		l++;

	size_t vmhwm;
	int n = 0;
	sscanf(l, "%zu kB\n%n", &vmhwm, &n);
	if (!n)
		errx(-1, "VmHWM malformed");
	return vmhwm;
}

std::string stats::maxmem::str() const {
	size_t maxmem = 0;
	for (auto [pid, fd]: this->fds)
		maxmem += getVmHWM(fd);
	return std::to_string(maxmem) + " kB";
}

