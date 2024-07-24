return {
    {
        "altercation/vim-colors-solarized",
        lazy = false,
        priority = 1000,
        config = function()
            vim.api.nvim_command("colorscheme solarized")
        end,
    }
}
