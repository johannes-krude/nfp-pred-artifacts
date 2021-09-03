
EXAMPLE_DIR=./examples
OUT_DIR=./out

P4C_XDP?= p4c-xdp
BPF_CLANG?= clang


$(OUT_DIR)/%.c: $(EXAMPLE_DIR)/%.c
	@mkdir -p $(@D)
	cp $< $@

$(OUT_DIR)/%.c: $(EXAMPLE_DIR)/%.sh
	@mkdir -p $(@D)
	$< > $@

$(OUT_DIR)/%.c:
	@mkdir -p $(@D)
	./scripts/mk-example $* -e c -o $(OUT_DIR) -s $(EXAMPLE_DIR)


$(OUT_DIR)/xdp-%.bc: $(OUT_DIR)/xdp-%.c
	$(BPF_CLANG) $(BPF_CFLAGS) -I $(EXAMPLE_DIR) -O2 -emit-llvm -c -o $@ $<

$(OUT_DIR)/%.bpf.o: $(OUT_DIR)/%.bc
	llc -march=bpf -filetype=obj -o $@ $<

$(OUT_DIR)/xdp-%.c: $(EXAMPLE_DIR)/xdp-%.p4
	@mkdir -p $(@D)
	$(P4C_XDP) -o $@ $<


-include $(OUT_DIR)/*.d
