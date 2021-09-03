#pragma once

#include <thread>
#include <mutex>
#include <condition_variable>
#include <functional>
#include <map>

#include <iostream>

class thread_pool {
private:
	std::mutex mutex;
	std::condition_variable cf;
	std::condition_variable cd;
	std::condition_variable cw;
	std::vector<std::thread> threads = {};
	unsigned long delegated = 0;
	unsigned long performed = 0;
	std::function<void()> f;
	bool quit = false;

	void thread_handler();
public:
	thread_pool(std::size_t size);
	~thread_pool();
	void delegate(std::function<void()> f);
	void wait();
	std::vector<std::thread::native_handle_type> thread_handles();
	template <typename TI, typename TO, typename C>
	void complete_in_order(C container, std::function<TO(TI)> d, std::function<void(TO)> c);

	template <typename T>
	class orderered_completion_state;
	template <typename T>
	orderered_completion_state<T> ordered_completion() {
		return orderered_completion_state<T>(*this);
	};
};

template <typename T>
class thread_pool::orderered_completion_state {
	friend thread_pool;
private:
	thread_pool& pool;
	unsigned long started = 0;
	unsigned long completed = 0;
	std::mutex mutex;
	std::map<unsigned long,std::function<void(unsigned long)>> results;

	orderered_completion_state(thread_pool& pool)
		: pool(pool) {}

	void sync(std::function<void(unsigned long)> c, unsigned int index) {
		{
			std::lock_guard guard(this->mutex);
			if (index  > this->completed) {
				this->results[index] = c;
				return;
			}
			c(index);
			this->completed++;
			for (auto r = this->results.begin(); r != this->results.end(); r = this->results.erase(r)) {
				if (r->first != this->completed)
					break;
				r->second(this->completed);
				this->completed++;
			}
		}
	}

public:
	template<typename F>
	auto lock(F c) {
		{
			std::lock_guard guard(this->mutex);
			return c();
		}
	}

	void sync(std::function<void(unsigned long)> c) {
		unsigned int index = this->started++;
		sync(c, index);
	}

	void delegate(std::function<T()> d, std::function<void(T, unsigned long)> c) {
		unsigned int index = this->started++;
		pool.delegate([this,index,d,c] {
			T e = d();
			sync([c, e] (unsigned long i) {
				c(e, i);
			}, index);
		});
	}

	void may_delegate(std::function<T()> d, std::function<void(T, unsigned long)> c, bool may) {
		if (may) {
			delegate(d, c);
		} else {
			T e = d();
			sync([c, e] (unsigned long i) {
				c(e, i);
			});
		}
	}

	bool waiting(std::size_t i) {
		return this->results.find(i) != this->results.end();
	}
};

