CURRENT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ROOT ?= $(realpath $(CURRENT_DIR)/..)
NVIM ?= $(ROOT)/nvim

LOG_LEVEL ?= INFO

export DOT_NVIM_TESTS_WORKDIR ?= $(CURRENT_DIR)/workdir
export DOT_NVIM_TESTS_TARGET = $(NVIM)
export DOT_NVIM_TESTS_LOG_LEVEL = $(LOG_LEVEL)

all: test.sanity-check test.main test.filetype-lua filetypes

test.%: FORCE
	./run --$*

test.filetype-%: FORCE
	./run --filetype=$*

FILETYPES ?= $(ALL_FILETYPES)
ALL_FILETYPES += gitcommit tex markdown text man
ALL_FILETYPES += c python haskell lua go sh bash
ALL_FILETYPES += mail sms chat

.PHONY: filetypes
filetypes: $(foreach ft,$(FILETYPES),test.filetype-$(ft))

.PHONY: clean
clean:
	rm -rf $(WORKDIR)

.PHONY: all
FORCE:
