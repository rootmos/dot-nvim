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

vim.keymap.set("n", "<leader>z", function() vim.cmd(':%s/\\s\\+$//c') end)

function resetTabs(t)
    local t = t or 4
    vim.opt.tabstop = t
    vim.opt.softtabstop = t
    vim.opt.shiftwidth = t
end
resetTabs(4)

require("me")
require("config.lazy")
require("filetypes")
require("K")

do
    local yank = require("yank")
    vim.keymap.set("n", "<leader>y", yank(1))
    vim.keymap.set("n", "<leader>Y", yank(2))
    vim.keymap.set("n", "<leader>p", '"' .. yank.reg .. 'p')
    vim.keymap.set("n", "<leader>P", '"' .. yank.reg .. 'P')
end

-- https://stackoverflow.com/a/19620009
vim.keymap.set("n", "Q", ":b#|bd#<CR>")

function fileFinder()
    require("telescope.builtin").git_files()
end


if os.getenv("TESTS") then
    vim.schedule(function() vim.cmd.quit { bang = true } end)

    local sanity_check = os.getenv("TESTS_SANITY_CHECK")
    if sanity_check ~= nil then
        error(sanity_check)
    end

    local token_path = os.getenv("TESTS_TOKEN_PATH")
    if token_path ~= nil then
        local rt = vim.uv.clock_gettime("realtime")
        local f = io.open(token_path, "w")
        f:write(string.format("%d.%09d", rt["sec"], rt["nsec"]))
        f:close()
    end
end
