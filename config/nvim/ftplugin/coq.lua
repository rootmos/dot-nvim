vim.api.nvim_set_keymap("n", "<F9>", "$:CoqToLine<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<F9>", "<Esc>$:CoqToLine<CR>", { noremap = true })
