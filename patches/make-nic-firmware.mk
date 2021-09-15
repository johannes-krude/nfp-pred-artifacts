
$(BUILD_DIR)/nic-firmware:
	@mkdir -p $(@D)
	rm -rf $@.tmp
	git clone -n https://github.com/Netronome/nic-firmware $@.tmp
	cd $@.tmp; git reset --hard 3b81141487ef3ffa0ca732f412b7a7fd029f6f0a
	cd $@.tmp; git checkout master
	cd $@.tmp; git config user.name make
	cd $@.tmp; git config user.name anon@make
	cd $@.tmp; git am ../../patches/nic-firmware-3b811414-0001-enable-BPF-flavor.patch
	cd $@.tmp; git am ../../patches/nic-firmware-3b811414-0002-remove-non-BPF-functionality-from-datapath.patch
	cd $@.tmp; git am ../../patches/nic-firmware-3b811414-0003-1Gb-Array-in-gprB_23.patch
	mv $@.tmp $@

