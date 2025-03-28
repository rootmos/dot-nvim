vim.g.do_filetype_lua = 1
vim.filetype.add {
    filename = {
        [".k"] = "sh",
    },
    pattern = {
        [".*%.celx"] = "lua",
    },
    extension = {
       sms = "sms",
       chat = "chat",
    },
}

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.tf",
    callback = function()
        vim.bo.filetype = "terraform"
    end,
})

vim.keymap.set("n", "<leader>r", function() vim.api.nvim_command(":filetype detect") end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "gitcommit", "tex", "markdown",
        "c", "python", "haskell", "lua", "go",
        "mail", "sms", "chat",
    },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en,sv"
    end,
})
