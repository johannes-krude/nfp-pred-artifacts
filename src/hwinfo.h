#ifndef _HWINFO_H
#define _HWINFO_H

struct hwinfo {
	const char  *name;
	const char  *description;
	const char  *clock;
};

const struct hwinfo *hwinfo_native(void);
const struct hwinfo *hwinfo_find(const char *name);

#endif
