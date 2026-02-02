print("hello")

local function split_env(l)
    local N = l:len()
    for i=1,N do
        if l:sub(i,i) == "=" then
            return l:sub(1, i - 1), l:sub(i + 1)
        end
    end
end

local function read_env_file(path)
    local f = io.open(path, "rb")
    local bs = f:read("*a")
    f:close()

    local N = bs:len()
    local i, j = 1, 1
    local es = {}
    while j <= N do
        local b = bs:byte(j)
        if b == 0 then
            assert(i <= j - 1)
            local e = bs:sub(i, j - 1)
            local k, v = split_env(e)
            --print("env", k, v)
            es[k] = v
            j = j + 1
            i = j
        else
            j = j + 1
        end
    end

    return es
end

local outer = read_env_file(os.getenv("DOT_NVIM_RUNTIME_DIR") .. "/outer.env")

local function merge_env(inner)
    local env = {}

    for k, v in pairs(outer) do
        env[k] = v
    end

    for k, v in pairs(inner or {}) do
        if type(k) == "number" then
            k, v = split_env(v)
        end
        env[k] = v
    end

    return env
end

local function mk_env_list(tbl)
    local list = {}
    for k, v in pairs(tbl) do
        table.insert(list, k .. "=" .. v)
    end
    return list
end

local spawn = vim.uv.spawn
vim.uv.spawn = function(cmd, opts, on_exit)
    local opts = opts or {}
    opts.env = mk_env_list(merge_env(opts.env))
    return spawn(cmd, opts, on_exit)
end

local system = vim.system
vim.system = function(cmd, opts, on_exit)
    local opts = opts or {}
    opts.env = merge_env(opts.env)
    opts.clear_env = true
    return system(cmd, opts, on_exit)
end

--vim.uv.spawn("./inner.sh", { env = { FOO = "lol" }, text = true }, function(a,b)
    --print(a, b)
--end)

vim.system({"./inner.sh"}, { env = { FOO = "lol" } }):wait()

print("bye")

vim.system({"sleep", "1"}):wait()
