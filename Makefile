CURRENT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: tests
tests:
	$(MAKE) -C tests

.PHONY: build
build:
	build/build.sh
