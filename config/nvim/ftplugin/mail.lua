vim.opt_local.spell = true
vim.opt_local.spelllang = "en,sv"
vim.opt_local.linebreak = true
vim.opt_local.formatoptions:append("lj")
vim.opt_local.joinspaces = false

function toggleWrap()
    if vim.opt_local.wrap:get() then
        vim.opt_local.textwidth = 1073741824
        vim.opt_local.wrap = false
        print("long lines")
    else
        vim.opt_local.textwidth = 72
        vim.opt_local.wrap = true
        print("wrapped lines")
    end
end
toggleWrap()

vim.keymap.set("n", "<leader>w", toggleWrap)
