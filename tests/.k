ROOT=$(readlink -f "$K_DIR/..")
export ROOT

#export LOG_LEVEL=DEBUG

go() {
    make test.filetype-lua
}

deploy() {
    git push && git -C "$ROOT/../dot-nvim" pull
}
