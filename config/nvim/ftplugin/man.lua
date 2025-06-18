vim.api.nvim_create_autocmd("FileType", {
    pattern = { "man" },
    callback = function()
        vim.opt_local.wrap = false
    end,
})
