
all: build
clean: build-clean
.PHONY: all clean
.SUFFIXES:
.SECONDARY:
.DELETE_ON_ERROR:


include */make.mk
include */make-*.mk
