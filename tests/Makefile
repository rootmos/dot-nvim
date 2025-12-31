CURRENT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ROOT ?= $(realpath $(CURRENT_DIR)/..)
NVIM ?= $(ROOT)/nvim

LOG_LEVEL ?= INFO

export DOT_NVIM_TESTS_WORKDIR ?= $(CURRENT_DIR)/workdir
export DOT_NVIM_TESTS_TARGET = $(NVIM)
export DOT_NVIM_TESTS_LOG_LEVEL = $(LOG_LEVEL)

all: test.sanity-check test.main

test.%: FORCE
	./run --$*

.PHONY: all
FORCE:
