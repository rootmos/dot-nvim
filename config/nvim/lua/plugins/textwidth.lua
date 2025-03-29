return {
    "lcheylus/overlength.nvim",
    config = function()
        require("overlength").setup({
            disable_ft = { "gitcommit" },
        })
    end,
}
