do
    local path = os.getenv("DOT_NVIM_MESSAGES")
    if path then
        local super = vim.notify

        local f = io.open(path, "a+")
        vim.notify = function(msg, level, opts)
            f:write(os.date("%Y-%m-%dT%H:%M:%S%z"))
            f:write(" ")
            f:write(msg)
            f:write("\n")
            f:flush()

            return super(msg, level, opts)
        end

        function print(...)
            vim.notify(vim.inspect(...))
        end
    end
end

DOT_NVIM_TESTS = os.getenv("DOT_NVIM_TESTS")
if not DOT_NVIM_TESTS then
    return require("main")
end

local f = io.open(os.getenv("DOT_NVIM_TESTS_RESULT_PATH"), "w")

local function ts()
    local rt = vim.uv.clock_gettime("realtime")
    f:write(string.format("%d.%09d\n", rt["sec"], rt["nsec"]))
    f:flush()
end

ts()
local sc, msg = pcall(require, "main")

vim.schedule(function()
    ts()

    f:write(string.format("%d\n", sc and 1 or 0))
    if not sc then
        f:write(msg)
        f:flush()
    end

    vim.cmd { cmd = sc and "quit" or "cquit" }
end)
