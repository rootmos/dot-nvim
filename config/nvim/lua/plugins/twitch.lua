return {
    {
        "rootmos/twitch-cli",
        lazy = false,
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/browse/nvim")
        end,
        --dev = true,
    }
}
