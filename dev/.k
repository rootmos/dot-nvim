ROOT=$(readlink -f "$K_DIR/..")
NVIM="$ROOT/nvim"

export DOT_NVIM_TESTS_WORKDIR="$K_DIR/workdir"
export DOT_NVIM_TESTS_TARGET="$NVIM"
export DOT_NVIM_TESTS_LOG_LEVEL=DEBUG

go() {
    ./tests "$@"
    #"$NVIM" -c ":luafile go.lua" "${1-foo.txt}"
}

deploy() {
    git push && git -C "$ROOT/../dot-nvim" pull
}
