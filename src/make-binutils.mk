
$(BUILD_DIR)/bpf: $(BUILD_DIR)/libiberty.a
$(BUILD_DIR)/bpf: $(BUILD_DIR)/libbfd.a
$(BUILD_DIR)/bpf: $(BUILD_DIR)/libopcodes.a
$(BUILD_DIR)/main_bpf.o: $(BUILD_DIR)/diagnostics.h
$(BUILD_DIR)/main_bpf.o: $(BUILD_DIR)/symcat.h
$(BUILD_DIR)/main_bpf.o: $(BUILD_DIR)/ansidecl.h
$(BUILD_DIR)/main_bpf.o: $(BUILD_DIR)/dis-asm.h
$(BUILD_DIR)/diagnostics.h $(BUILD_DIR)/symcat.h $(BUILD_DIR)/ansidecl.h $(BUILD_DIR)/dis-asm.h: $(BUILD_DIR)/binutils-2.34
	cp $^/include/$(@F) $@
$(BUILD_DIR)/main_bpf.o: $(BUILD_DIR)/bfd.h
$(BUILD_DIR)/main_bpf.o: $(BUILD_DIR)/bfd_stdint.h
$(BUILD_DIR)/bfd.h $(BUILD_DIR)/bfd_stdint.h: $(BUILD_DIR)/binutils-2.34-build
	cp $^/bfd/$(@F) $@
$(BUILD_DIR)/libiberty.a: $(BUILD_DIR)/binutils-2.34-build
	cp $(BUILD_DIR)/binutils-2.34-build/libiberty/$(@F) $@
$(BUILD_DIR)/libbfd.a: $(BUILD_DIR)/binutils-2.34-build
	cp $(BUILD_DIR)/binutils-2.34-build/bfd/$(@F) $@
$(BUILD_DIR)/libopcodes.a: $(BUILD_DIR)/binutils-2.34-build
	cp $(BUILD_DIR)/binutils-2.34-build/opcodes/$(@F) $@
$(BUILD_DIR)/binutils-2.34-build: $(BUILD_DIR)/binutils-2.34
	mkdir -p $@
	cd $@; ../binutils-2.34/configure --target=nfp-elf --disable-nls --disable-gdb --disable-libdecnumber --disable-readline --disable-sim; make
$(BUILD_DIR)/binutils-2.34: $(BUILD_DIR)/binutils-2.34.tar.bz2
	tar -f $^ -C $(BUILD_DIR) -xj
$(BUILD_DIR)/binutils-2.34.tar.bz2:
	wget https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.bz2 -O $@

