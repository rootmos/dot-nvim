local Lazy = require("lazy")

local opts = {
    wait = true,
    concurrency = 1,
    show = true,
}

local function main()
    local clean = Lazy.clean(opts)
    local install = Lazy.install(opts)
    local update = Lazy.update(opts)

    local runner = clean:wait(function()
        install:wait(function()
            update:wait(function(x)
                vim.print("INSTALL:", install)
                vim.print("UPDATE:", update)
            end)
        end)
    end)

    return runner
end

local ok, msg = pcall(main)
vim.print(ok, msg)
os.exit(0)
