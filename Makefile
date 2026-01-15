CURRENT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

tests:
	$(MAKE) -C tests

build:
	build/build.sh

deploy:
	git -C $(CURRENT_DIR)/../dot-nvim pull

.PHONY: tests build deploy
