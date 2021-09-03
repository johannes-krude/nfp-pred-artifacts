
#include "estimator/features.hpp"

#include <string>
#include <deque>
#include <map>
#include <vector>
#include <functional>


std::deque<std::reference_wrapper<features>>& features::all() {
	static std::deque<std::reference_wrapper<features>> all;
	return all;
};

features::features(const std::string& name)
	: name(name) {
	all().push_back(*this);
}

std::string features::values() {
	std::string str = "";

	for (const auto f: all()) {
		str += f.get().value() + ",";
	}

	if (str.size())
		str.erase(str.end()-1);

	return str;
}

std::vector<std::string> features::examples() {
	std::vector<std::string> r;
	r.reserve(all().size());

	for (const auto f: all())
		r.push_back(f.get().example());

	return r;
}

bool features::parse(const std::string& str) {
	std::string key = str;
	std::string value = "";

	auto eq = key.find("=");
	if (eq != std::string::npos) {
		value = key.substr(eq+1);
		key = key.substr(0, eq);
	} else if (str.rfind("no-", 0) == 0) {
		value = "no";
		key = key.substr(3);
	} else {
		value = "yes";
	}

	for (auto f: all()) {
		if (f.get().name != key)
			continue;
		f.get() = value;
		if (!f.get().valid())
			return false;
		return true;
	}
	return false;
}

features::flag::flag(const std::string& name, bool value)
	: features(name),
	  validity(true),
	  enabled(value) {}

std::string features::flag::value() {
	if (enabled) {
		return name;
	} else {
		return "no-" + name;
	}
}

std::string features::flag::example() {
	if (enabled) {
		return "(no-)" + name;
	} else {
		return "no-" + name;
	}
}

features::flag& features::flag::operator = (const std::string& value) {
	if (value == "no" || value == "false") {
		this->validity = true;
		this->enabled = false;
	} else if (value == "yes" || value == "true") {
		this->validity = true;
		this->enabled = true;
	} else {
		this->validity = false;
	}
	return *this;
}

bool features::flag::valid() {
	return this->validity;
}

features::flag::operator bool () {
	return this->enabled;
}

