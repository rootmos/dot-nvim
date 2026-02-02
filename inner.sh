#!/bin/bash

set -o nounset -o pipefail -o errexit

env | grep -E '(XDG|FOO)' | tee .env
#env | grep DOT_NVIM | tee .env
#env | grep NVIM | tee the-env
#env | tee .env

#firefox --new-window "http://portal"
