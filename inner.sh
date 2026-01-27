#!/bin/bash

set -o nounset -o pipefail -o errexit

#env | grep XDG_CONFIG
#env | grep NVIM | tee the-env
env | tee .env

#firefox --new-window "http://portal"
