
#include "prandom_u32.h"

#include <stdint.h>
#include <stdio.h>

uint32_t prandom_u32_state(struct rnd_state *state) {
#define TAUSWORTHE(s, a, b, c, d) ((s & c) << d) ^ (((s << a) ^ s) >> b)
	state->s1 = TAUSWORTHE(state->s1,  6U, 13U, 4294967294U, 18U);
	state->s2 = TAUSWORTHE(state->s2,  2U, 27U, 4294967288U,  2U);
	state->s3 = TAUSWORTHE(state->s3, 13U, 21U, 4294967280U,  7U);
	state->s4 = TAUSWORTHE(state->s4,  3U, 12U, 4294967168U, 13U);

	return (state->s1 ^ state->s2 ^ state->s3 ^ state->s4);
}

static inline uint32_t __seed(uint32_t x, uint32_t m) {
	return (x < m) ? x + m : x;
}

static void prandom_warmup(struct rnd_state *state)
{
	/* Calling RNG ten times to satisfy recurrence condition */
	prandom_u32_state(state);
	prandom_u32_state(state);
	prandom_u32_state(state);
	prandom_u32_state(state);
	prandom_u32_state(state);
	prandom_u32_state(state);
	prandom_u32_state(state);
	prandom_u32_state(state);
	prandom_u32_state(state);
	prandom_u32_state(state);
}

void prandom_seed_full_state_fixed(struct rnd_state *state) {
	static struct rnd_state fixed_state = {0};
	uint32_t seeds[4] = {0x6e70707a, 0x263d8fce, 0x3e3bb1e6, 0xcf068f5e};

	if (fixed_state.s1 || fixed_state.s2 || fixed_state.s3 || fixed_state.s4) {
		*state = fixed_state;
		return;
	}

	state->s1 = __seed(seeds[0],   2U);
	state->s2 = __seed(seeds[1],   8U);
	state->s3 = __seed(seeds[2],  16U);
	state->s4 = __seed(seeds[3], 128U);

	prandom_warmup(state);
	fixed_state = *state;
}

