local P = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.config").setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
                ensure_installed = {
                    "c", "lua", "bash", "terraform"
                },
            }
        end,
    },
    { "scrooloose/nerdcommenter" },
    {
        "rootmos/tabs-vs-spaces",
        lazy = false,
        priority = 500,
        config = function()
            require('tabs-vs-spaces.config'){
                default = 4,
                make = -1,
                yaml = 2,
                haskell = 2,
                terraform = 2,
                go = -1,
                python = false,
            }
        end,
    },
}

local function add(ft, ps)
    for _, p in ipairs(ps) do
        if type(p) == "string" then
            p = { p }
        end
        p.ft = ft
        table.insert(P, p)
    end
end

add("python", {
    {
        "stsewd/isort.nvim",
        build = ":UpdateRemotePlugins",
        config = function()
            vim.keymap.set("n", "<leader>i", vim.cmd["Isort"])
        end,
    }
})

return P
