#pragma once

#include <string>
#include <deque>
#include <map>
#include <vector>
#include <functional>
#include <memory>
#include <initializer_list>

class features {
public:
	class flag;
	template<class B> class strategies;
	template<class B, class S> class strategy;
	template<class B> class strategy_base;
	template<class B, class S> static std::shared_ptr<const features::strategy_base<B>> s(std::string name);
private:
	std::string name;

	static std::deque<std::reference_wrapper<features>>& all();
public:
	static bool parse(const std::string& str);
	static std::string values();
	static std::vector<std::string> examples();

	features(const std::string& name);
	virtual features& operator = (const std::string& value) = 0;
	virtual bool valid() = 0;
	virtual std::string value() = 0;
	virtual std::string example() = 0;
};

class features::flag : features {
	bool validity;
	bool enabled;
public:
	flag(const std::string& name, bool value);
	features::flag& operator = (const std::string& value) override;
	bool valid() override;
	std::string value() override;
	std::string example() override;
	operator bool ();
};


template<class B>
struct features::strategy_base {
	std::string name;
	virtual B& get() const = 0;
	strategy_base(std::string name)
		: name(name) {}
};

template<class B, class S>
struct features::strategy : public features::strategy_base<B> {
	strategy(std::string name)
		: strategy_base<B>(name) {};
	B& get() const override {
		thread_local S o;
		return o;
	}
};

template<class B, class S>
std::shared_ptr<const features::strategy_base<B>> features::s(std::string name) {
	return std::make_shared<const features::strategy<B,S>>(name);
}

template<class B>
class features::strategies : features {
	const std::vector<std::shared_ptr<const features::strategy_base<B>>> options;
	typename std::vector<std::shared_ptr<const features::strategy_base<B>>>::const_iterator selected;
public:
	strategies(const std::string& name, std::initializer_list<std::shared_ptr<const features::strategy_base<B>>> options)
		: features(name),
		  options(options),
		  selected(this->options.begin()) {}

	features::strategies<B>& operator = (const std::string& value) override {
		for (this->selected = this->options.begin(); this->selected != this->options.end(); this->selected++) {
			if ((*this->selected)->name == value)
				return *this;
		}
		return *this;
	}

	bool valid() override {
		return this->selected != this->options.end();
	}

	std::string value() override {
		std::string str = name + "=";
		if (this->selected != this->options.end())
			str += (*this->selected)->name;
		return str;
	}

	std::string example() override {
		std::string str = name + "=";
		if (this->selected != this->options.end())
			str += (*this->selected)->name;
		for (auto i = this->options.begin(); i != this->options.end(); i++) {
			if (i == this->selected)
				continue;
			str += "|" + (*i)->name;
		}
		return str;
	}

	B& operator () () {
		return (*this->selected)->get();
	}
};

