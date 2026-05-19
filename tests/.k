export DOT_NVIM_TESTS_LOG_LEVEL=DEBUG

go() {
    ../nvim -l go.lua
    #make test.filetype-lua
    #./run --interactive --main
}
