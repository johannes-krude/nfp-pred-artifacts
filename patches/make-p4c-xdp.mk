
P4C_XDP=$(BUILD_DIR)/p4c/build/p4c-xdp

BPF_CFLAGS += -I $(BUILD_DIR)/p4c/extensions/p4c-xdp/tests/ -I $(BUILD_DIR)/p4c/backends/ebpf/runtime/ -I $(BUILD_DIR)/p4c/backends/ebpf/runtime/usr/include/bpf/

$(BUILD_DIR)/p4c/build/p4c-xdp: $(BUILD_DIR)/p4c $(BUILD_DIR)/p4c/extensions/p4c-xdp
	mkdir -p $(@D)
	cd $(@D); cmake ..
	make -C $(@D)


$(BUILD_DIR)/p4c/extensions/p4c-xdp: $(BUILD_DIR)/p4c $(BUILD_DIR)/p4c/backends/ebpf/runtime/contrib/libbpf
	@mkdir -p $(@D)
	rm -rf $@.tmp
	git clone -n https://github.com/vmware/p4c-xdp.git $@.tmp
	cd $@.tmp; git checkout 43f166c017c5428d662ca6717ede9ff359ca5dd4
	cd $@.tmp; git config user.name make
	cd $@.tmp; git config user.name anon@make
	cd $@.tmp; git am ../../../../patches/p4c-xdp-43f166c-removed-output-port-table.patch
	mv $@.tmp $@

$(BUILD_DIR)/p4c/backends/ebpf/runtime/contrib/libbpf: $(BUILD_DIR)/p4c
	cd $(BUILD_DIR)/p4c/backends/ebpf; python ./build_libbpf

$(BUILD_DIR)/p4c:
	@mkdir -p $(@D)
	rm -rf $@.tmp
	git clone -n https://github.com/p4lang/p4c.git $@.tmp
	cd $@.tmp; git checkout 609032a42f3f29729d46a1ebb70d6626da6ac5a4
	cd $@.tmp; git submodule update --init --recursive
	mv $@.tmp $@
