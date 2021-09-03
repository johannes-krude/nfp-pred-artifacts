#pragma once

#include <atomic>
#include <mutex>
#include <string>
#include <deque>
#include <map>
#include <set>
#include <ostream>
#include <thread>
#include <sys/types.h>

class stats {
public:
	class counter;
	class clock;
	class cputime;
	class threadtime;
	class maxmem;
private:
	std::string name;

	static std::mutex mutex;
	static std::deque<const stats*> all;
public:
	stats(const std::string& name);
	~stats();
	virtual std::string str() const= 0;
	static void write(std::ostream& out);
};

class stats::counter : stats {
	std::atomic<unsigned long> counter = 0;
public:
	using stats::stats;
	void count();
	void down();
	std::string str() const override;
};

class stats::clock : stats {
	std::set<clockid_t> clocks = {};
	double time = 0;
public:
	using stats::stats;
	clock(const std::string& name, clockid_t clk_id);
	void add(clockid_t clk_id);
	void remove(clockid_t clk_id);
	std::string str() const override;
};

class stats::cputime : clock {
public:
	using clock::clock;
	cputime(const std::string& name, pid_t pid);
	void add(pid_t pid);
};

class stats::threadtime : clock {
public:
	using clock::clock;
	threadtime(const std::string& name, std::thread::native_handle_type handle);
	void add(std::thread::native_handle_type handle);
};

class stats::maxmem : stats {
	std::map<pid_t,int> fds = {};
public:
	using stats::stats;
	maxmem(const std::string& name, pid_t pid);
	void add(pid_t pid);
	void remove(pid_t pid);
	std::string str() const override;
};

