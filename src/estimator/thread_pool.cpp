#include "estimator/thread_pool.hpp"

#include <thread>
#include <mutex>
#include <condition_variable>
#include <functional>

//LDLIBS=pthread


void thread_pool::thread_handler() {
	std::unique_lock lock(this->mutex);

	for (;;) {
		this->cf.wait(lock, [this] {return this->f || this->quit;});
		if (this->quit)
			break;
		std::function<void()> f;
		f.swap(this->f);
		lock.unlock();
		this->cd.notify_one();
		f();
		lock.lock();
		this->performed += 1;
		this->cw.notify_one();
	}
}

thread_pool::thread_pool(std::size_t size) {
	for (std::size_t i = 0; i < size; i++)
		this->threads.emplace_back(&thread_pool::thread_handler, this);
}

thread_pool::~thread_pool() {
	{
		std::unique_lock lock(this->mutex);
		this->quit = true;
	}
	this->cf.notify_all();
	for (std::thread& t: this->threads)
		t.join();
}

void thread_pool::delegate(std::function<void()> f) {
	if (!this->threads.size()) {
		f();
		return;
	}
	{
		std::unique_lock lock(this->mutex);
		this->delegated += 1;
		this->f = f;
	}
	this->cf.notify_one();
	{
		std::unique_lock lock(this->mutex);
		this->cd.wait(lock, [this] {return !this->f;});
	}
}

void thread_pool::wait() {
	std::unique_lock lock(this->mutex);

	this->cw.wait(lock, [this] {return this->delegated == this->performed;});
}

std::vector<std::thread::native_handle_type> thread_pool::thread_handles() {
	std::vector<std::thread::native_handle_type> handles;

	for (auto& t: this->threads)
		handles.push_back(t.native_handle());

	return handles;
}

