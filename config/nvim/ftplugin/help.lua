vim.keymap.set("n", "<CR>", "<C-]>", { buffer = true })

-- HACK
vim.schedule(function()
    vim.bo.textwidth = 0
end)
