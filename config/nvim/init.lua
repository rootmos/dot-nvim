DOT_NVIM_TESTS = os.getenv("DOT_NVIM_TESTS")

if not DOT_NVIM_TESTS then
    require("main")
else
    local result_path = os.getenv("DOT_NVIM_TESTS_RESULT_PATH")
    local f = io.open(result_path, "w")

    local function ts()
        local rt = vim.uv.clock_gettime("realtime")
        f:write(string.format("%d.%09d\n", rt["sec"], rt["nsec"]))
    end

    ts()
    local sc, msg = pcall(require, "main")
    ts()

    f:write(string.format("%d\n", sc and 1 or 0))
    if not sc then
        f:write(msg)
    end
    f:close()

    vim.cmd { cmd = sc and "quit" or "cquit" }
end
