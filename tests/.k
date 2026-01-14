ROOT=$(readlink -f "$K_DIR/..")
export ROOT

export DOT_NVIM_TESTS_LOG_LEVEL=DEBUG

go() {
    #make test.filetype-lua
    ./run --interactive --main
}

deploy() {
    git push && git -C "$ROOT/../dot-nvim" pull
}
