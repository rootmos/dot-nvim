vim.g.do_filetype_lua = 1
vim.filetype.add {
    filename = {
        [".k"] = "sh",
    },
    pattern = {
        [".*%.celx"] = "lua",
    },
}

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.tf",
    callback = function()
        vim.bo.filetype = "terraform"
    end,
})

vim.keymap.set("n", "<leader>d", function() vim.api.nvim_command(":filetype detect") end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "mail", "gitcommit", "tex", "markdown",
        "c", "python", "haskell", "lua", "go",
    },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en,sv"
    end,
})
