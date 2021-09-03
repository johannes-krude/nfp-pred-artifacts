#ifndef _PRANDOM_U32_H
#define _PRANDOM_U32_H

#include <stdint.h>

struct rnd_state {
	uint32_t s1, s2, s3, s4;
};
void prandom_seed_full_state_fixed(struct rnd_state *state);
uint32_t prandom_u32_state(struct rnd_state *state);

#endif
