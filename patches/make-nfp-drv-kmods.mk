
$(BUILD_DIR)/nfp-drv-kmods/src/nfp.ko: $(BUILD_DIR)/nfp-drv-kmods
	cd $(BUILD_DIR)/nfp-drv-kmods; make

$(BUILD_DIR)/nfp-drv-kmods:
	rm -rf $@.tmp
	git clone -n https://github.com/Netronome/nfp-drv-kmods $@.tmp
	cd $@.tmp; git checkout 89a77d5aaf5eca56d92fee6bc88bde7fac47645a
	cd $@.tmp; git config user.name make
	cd $@.tmp; git config user.email anon@make
	cd $@.tmp; git am ../../patches/nfp-drv-kmods-89a77d5a-use-array-ptr-from-gprB_23.patch
	mv $@.tmp $@

