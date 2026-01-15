vim.opt_local.linebreak = true
vim.opt_local.formatoptions:append("lj")
vim.opt_local.joinspaces = false
vim.opt_local.wrap = true

vim.b.yank = { "paragraph", "word" }

local longLines
function toggleLongLines(init)
    if init then
        longLines = false -- i.e. default is short lines
    else
        longLines = not longLines
    end

    if longLines then
        vim.opt_local.textwidth = 1073741824
        require("overlength").disable()
        if not init then
            print("long lines")
        end
    else
        vim.opt_local.textwidth = 72
        require("overlength").enable()
        if not init then
            print("short lines")
        end
    end
end
toggleLongLines(true)
vim.keymap.set("n", "<leader>l", toggleLongLines)
