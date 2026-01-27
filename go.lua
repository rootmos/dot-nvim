print("hello")

local clean = {
    NVIM = "",
    NVIM_APPNAME = "",
    NVIM_SNIPPETS = "",
    NVIM_SPELL = "",

    XDG_CONFIG_HOME = os.getenv("NVIM_OUTER_XDG_CONFIG_HOME"),
    XDG_DATA_HOME = os.getenv("NVIM_OUTER_XDG_DATA_HOME"),
    XDG_STATE_HOME = os.getenv("NVIM_OUTER_XDG_STATE_HOME"),

    NVIM_OUTER_XDG_CONFIG_HOME = "",
    NVIM_OUTER_XDG_DATA_HOME = "",
    NVIM_OUTER_XDG_STATE_HOME = "",

    NVIM_LOG_FILE = "",
    NVIM_PYTHON_LOG_FILE = "",
}

local function do_clean_env(opts)
    local opts = opts or {}

    local env = {}

    for k, v in pairs(clean) do
        env[k] = v
    end

    for k, v in pairs(opts.env or {}) do
        env[k] = v
    end

    opts.env = env
    return opts
end

local system = vim.system
vim.system = function(cmd, opts, on_exit)
    return system(cmd, do_clean_env(opts), on_exit)
end

local spawn = vim.uv.spawn
vim.uv.spawn = function(cmd, opts, on_exit)
    return spawn(cmd, do_clean_env(opts), on_exit)
end

--vim.system({"./inner.sh"}, { env = { NVIM_APPNAME = "lol" } }, function(o)
    --print(o.stdout)
--end):wait()

spawn("./inner.sh", { env = { "FOO=lol" }, text = true }, function(a,b)
    print(a, b)
end)

vim.system({"sleep", "1"}):wait()
