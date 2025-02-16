return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup {
            options = {
                -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
                theme = "solarized_dark",
            },
            sections = {
                lualine_x = { "encoding", "filetype" },
            },
        }
    end,
}
