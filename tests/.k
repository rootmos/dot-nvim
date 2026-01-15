export DOT_NVIM_TESTS_LOG_LEVEL=DEBUG

go() {
    #make test.filetype-lua
    ./run --interactive --main
}
