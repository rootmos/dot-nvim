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

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "~" }

vim.api.nvim_set_keymap("i", "hh", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("i", "uu", "<Esc>:w<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "ii", "<Esc>:wall<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "q", "<NOP>", { noremap = true })
vim.api.nvim_set_keymap("n", "Q", "<NOP>", { noremap = true })

vim.api.nvim_set_keymap("n", "<F8>", ":wall<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<F8>", "<Esc>:wall<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-F8>", ":wall<CR>:qall<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-F8>", "<Esc>:wall<CR>:qall<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-F8>", ":wall<CR>:qall<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<S-F8>", "<Esc>:wall<CR>:qall<CR>", { noremap = true })

vim.g.mapleader = ","
vim.g.maplocalleader = '-'

vim.keymap.set("n", "<leader>z", function() vim.api.nvim_command(':%s/\\s\\+$//c') end)

function resetTabs(t)
    local t = t or 4
    vim.opt.tabstop = t
    vim.opt.softtabstop = t
    vim.opt.shiftwidth = t
end
resetTabs(4)

require("config.lazy")

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
