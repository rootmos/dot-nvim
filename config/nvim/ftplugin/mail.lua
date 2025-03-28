vim.opt_local.linebreak = true
vim.opt_local.formatoptions:append("lj")
vim.opt_local.joinspaces = false
vim.opt_local.wrap = true

local longLines = true -- i.e. default is short lines
function toggleLongLines()
    longLines = not longLines
    if longLines then
        vim.opt_local.textwidth = 1073741824
        require("overlength").disable()
        print("long lines")
    else
        vim.opt_local.textwidth = 72
        require("overlength").enable()
        print("short lines")
    end
end
toggleLongLines()
vim.keymap.set("n", "<leader>l", toggleLongLines)
