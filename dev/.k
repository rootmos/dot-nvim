ROOT=$(readlink -f "$K_DIR/..")
NVIM="$ROOT/nvim"

export TESTS_WORKDIR="$K_DIR/workdir"
export TESTS_TARGET="$NVIM"
export TESTS_LOG_LEVEL=DEBUG

go() {
    ./tests "$@"
    #"$NVIM" -c ":luafile go.lua" "${1-foo.txt}"
}

deploy() {
    git push && git -C "$ROOT/../dot-nvim" pull
}
