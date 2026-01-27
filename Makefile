CURRENT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

tests: build
	$(MAKE) -C tests

build:
	build/build.sh

install: build
	build/spell.sh

clean:
	rm -rf $(CURRENT_DIR)/root $(CURRENT_DIR)/share $(CURRENT_DIR)/state

deploy: tests
	git -C $(CURRENT_DIR)/../dot-nvim pull $(CURRENT_DIR)
	make -C $(CURRENT_DIR)/../dot-nvim install


.PHONY: tests build install clean deploy
