vim.opt.modeline = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.colorcolumn = "+1"
vim.opt.signcolumn = "number"

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "~" }

vim.keymap.set("i", "hh", "<Esc>", { noremap = true })
vim.keymap.set("i", "uu", "<Esc>:w<CR>", { noremap = true })
vim.keymap.set("i", "ii", "<Esc>:wall<CR>", { noremap = true })
vim.keymap.set("n", "q", "<NOP>", { noremap = true })
vim.keymap.set("n", "Q", "<NOP>", { noremap = true })

vim.keymap.set("n", "<F8>", ":wall<CR>", { noremap = true })
vim.keymap.set("i", "<F8>", "<Esc>:wall<CR>", { noremap = true })
vim.keymap.set("n", "<C-F8>", ":wall<CR>:qall<CR>", { noremap = true })
vim.keymap.set("i", "<C-F8>", "<Esc>:wall<CR>:qall<CR>", { noremap = true })
vim.keymap.set("n", "<S-F8>", ":wall<CR>:qall<CR>", { noremap = true })
vim.keymap.set("i", "<S-F8>", "<Esc>:wall<CR>:qall<CR>", { noremap = true })

vim.g.mapleader = ","
vim.g.maplocalleader = '-'

vim.keymap.set("n", "<leader>z", function() vim.cmd(':%s/\\s\\+$//ce') end)

function resetTabs(t)
    local t = t or 4
    vim.opt.tabstop = t
    vim.opt.softtabstop = t
    vim.opt.shiftwidth = t
end
resetTabs(4)

me = require("me")

require("preserve_env")
require("config.lazy")
require("filetypes")
require("K")
require("providers")

do
    local clipboard = require("clipboard")
    vim.keymap.set("n", "<leader>y", function() clipboard.yank(1) end)
    vim.keymap.set("n", "<leader>Y", function() clipboard.yank(2) end)
    vim.keymap.set("v", "<leader>y", '"' .. clipboard.reg .. 'y') -- TODO what's the lua equivalent?
    vim.keymap.set({"n", "i"}, "<leader>p", function() clipboard.paste {} end)
    vim.keymap.set({"n", "i"}, "<leader>P", function() clipboard.paste { before = true } end)
end

-- https://stackoverflow.com/a/19620009
vim.keymap.set("n", "Q", ":b#|bd#<CR>")

function fileFinder()
    require("telescope.builtin").git_files()
end

require("tests")
