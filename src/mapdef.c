
#include "mapdef.h"
#include "jsmn.h"

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include <err.h>

struct mapdef *mapdef_parse(const void *buf, size_t size, size_t *num) {
	jsmn_parser p;
	jsmntok_t *tokens;
	size_t num_tokens;
	size_t num_mapdefs;
	struct mapdef *mapdefs = NULL;
	int rc;

	jsmn_init(&p);
	rc = jsmn_parse(&p, buf, size, NULL, 0);
	if (rc < 0)
		errx(-1, "invalid mapdef json");
	num_tokens = rc;
	if (!num_tokens)
		errx(-1, "invalid mapdef json structure");
	tokens = calloc(num_tokens, sizeof(*tokens));
	if (!tokens)
		err(-1, "calloc");
	jsmn_init(&p);
	rc = jsmn_parse(&p, buf, size, tokens, num_tokens);
	if (rc < 0)
		errx(-1, "jsmn_parse error");

	if (tokens[0].type != JSMN_OBJECT ||
	    tokens[0].size*12 != num_tokens-1)
		errx(-1, "malformed mapdef json structure");
	num_mapdefs = tokens[0].size;
	mapdefs = calloc(num_mapdefs, sizeof(*mapdefs));
	if (!mapdefs)
		err(-1, "calloc");
	for (size_t i = 1; i < num_tokens; i += 12) {
		if (tokens[i+0].type != JSMN_STRING ||
		    tokens[i+1].type != JSMN_OBJECT ||
		    tokens[i+1].size != 5 ||
		    tokens[i+2].type != JSMN_STRING ||
		    tokens[i+2].end - tokens[i+2].start != 4 ||
		    memcmp(buf+tokens[i+2].start, "type", 4) ||
		    tokens[i+4].type != JSMN_STRING ||
		    tokens[i+4].end - tokens[i+4].start != 8 ||
		    memcmp(buf+tokens[i+4].start, "key_size", 8) ||
		    tokens[i+6].type != JSMN_STRING ||
		    tokens[i+6].end - tokens[i+6].start != 9 ||
		    memcmp(buf+tokens[i+6].start, "leaf_size", 9) ||
		    tokens[i+8].type != JSMN_STRING ||
		    tokens[i+8].end - tokens[i+8].start != 11 ||
		    memcmp(buf+tokens[i+8].start, "max_entries", 11) ||
		    tokens[i+10].type != JSMN_STRING ||
		    tokens[i+10].end - tokens[i+10].start != 4 ||
		    memcmp(buf+tokens[i+10].start, "name", 4) ||
		    tokens[i+3].type != JSMN_PRIMITIVE ||
		    tokens[i+5].type != JSMN_PRIMITIVE ||
		    tokens[i+7].type != JSMN_PRIMITIVE ||
		    tokens[i+9].type != JSMN_PRIMITIVE ||
		    tokens[i+11].type != JSMN_STRING)
			errx(-1, "invalid mapdef json structure");
		struct mapdef *m = &mapdefs[(i-1)/12];
		*m = (struct mapdef) { .fd = -1 };
		sscanf(buf+tokens[i+0].start, "%"SCNu64, &m->num);
		sscanf(buf+tokens[i+3].start, "%u", &m->type);
		sscanf(buf+tokens[i+5].start, "%zu", &m->key_size);
		sscanf(buf+tokens[i+7].start, "%zu", &m->value_size);
		sscanf(buf+tokens[i+9].start, "%zu", &m->max_entries);
		m->name = strndup(buf+tokens[i+11].start,
		                  tokens[i+11].end - tokens[i+11].start);
		if (!m->name)
			err(-1, "strndup");
	}

	free(tokens);

	if (num)
		*num = num_mapdefs;
	return mapdefs;
}

