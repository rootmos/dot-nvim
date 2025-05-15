local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

vim.keymap.set("n", "<space>h", ht.hoogle.hoogle_signature, opts)

local hoogle = require("telescope").load_extension("hoogle")
vim.keymap.set("n", "<space>H", hoogle.hoogle, opts)
