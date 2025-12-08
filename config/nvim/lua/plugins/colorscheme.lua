return {
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("solarized-osaka").setup({
                on_highlights = function(hl, c)
                    hl.CursorLine = { bg = c.base02, underline = true }
                    hl.StatusLineNC = { bg = c.base03 }
                end,
            })
            vim.cmd("colorscheme solarized-osaka")
        end,
    }
}
