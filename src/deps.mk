
BUILD_TARGETS= $(patsubst %,$(BUILD_DIR)/%, \
	read \
	gen-packets \
	check-rx \
	bwmeasure \
	statistics \
	nfp-estimator \
	bpf \
)

read_OBJS = \
	$(BUILD_DIR)/input.o

gen-packets_LDLIBS = -lpcap -lm
gen-packets_OBJS = \
	$(BUILD_DIR)/gen.o \
	$(BUILD_DIR)/prandom_u32.o \
	$(BUILD_DIR)/ereport.o \
	$(BUILD_DIR)/input.o \
	$(BUILD_DIR)/ktest.o

check-rx_OBJS = \
	$(BUILD_DIR)/ereport.o \
	$(BUILD_DIR)/input.o \
	$(BUILD_DIR)/ktest.o

bwmeasure_LDLIBS = -lm
bwmeasure_OBJS = \
	$(BUILD_DIR)/measure.o \
	$(BUILD_DIR)/statistics.o \
	$(BUILD_DIR)/hwinfo.o \
	$(BUILD_DIR)/convert.o

statistics_LDLIBS = -lm
statistics_OBJS = \
	$(BUILD_DIR)/convert.o \
	$(BUILD_DIR)/input.o \
	$(BUILD_DIR)/statistics.o \
	$(BUILD_DIR)/hwinfo.o

nfp-estimator_LDLIBS = -lrt -lcrypto -lstdc++ -lpthread
nfp-estimator_OBJS = \
	$(BUILD_DIR)/estimator/features.o \
	$(BUILD_DIR)/estimator/stats.o \
	$(BUILD_DIR)/estimator/sat_checker.o \
	$(BUILD_DIR)/estimator/unsat_core.lex.o \
	$(BUILD_DIR)/estimator/unsat_core.tab.o \
	$(BUILD_DIR)/estimator/model.lex.o \
	$(BUILD_DIR)/estimator/model.tab.o \
	$(BUILD_DIR)/estimator/state.o \
	$(BUILD_DIR)/estimator/expr.o \
	$(BUILD_DIR)/estimator/instr.o \
	$(BUILD_DIR)/estimator/instr.tab.o \
	$(BUILD_DIR)/estimator/instr.lex.o \
	$(BUILD_DIR)/estimator/cfg.o \
	$(BUILD_DIR)/estimator/thread_pool.o

bpf_LDLIBS = -lelf -lbfd -lopcodes -lz -liberty -ldl -lstdc++
bpf_OBJS = \
	$(BUILD_DIR)/ereport.o \
	$(BUILD_DIR)/input.o \
	$(BUILD_DIR)/mapdef.o \
	$(BUILD_DIR)/jsmn.o \
	$(BUILD_DIR)/bpf.o \
	$(BUILD_DIR)/ktest.o \
	$(BUILD_DIR)/mapreads.o \
	$(BUILD_DIR)/gen.o \
	$(BUILD_DIR)/prandom_u32.o

$(BUILD_DIR)/estimator/sat_checker.o: $(BUILD_DIR)/estimator/model.tab.hpp
$(BUILD_DIR)/estimator/sat_checker.o: $(BUILD_DIR)/estimator/model.lex.hpp
$(BUILD_DIR)/estimator/sat_checker.o: $(BUILD_DIR)/estimator/unsat_core.tab.hpp
$(BUILD_DIR)/estimator/sat_checker.o: $(BUILD_DIR)/estimator/unsat_core.lex.hpp
$(BUILD_DIR)/estimator/instr.o: $(BUILD_DIR)/estimator/instr.lex.hpp
$(BUILD_DIR)/estimator/instr.o: $(BUILD_DIR)/estimator/instr.tab.hpp
$(BUILD_DIR)/estimator/model.lex.o: $(BUILD_DIR)/estimator/model.tab.hpp
$(BUILD_DIR)/estimator/unsat_core.lex.o: $(BUILD_DIR)/estimator/unsat_core.tab.hpp
$(BUILD_DIR)/estimator/instr.lex.o: $(BUILD_DIR)/estimator/instr.tab.hpp

