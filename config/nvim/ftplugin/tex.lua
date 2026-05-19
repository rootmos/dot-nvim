vim.keymap.set("i", '"', "\\enquote{", { buffer = true })
vim.keymap.set("i", "**", "\\emph{", { buffer = true })

local function za(t)
    return function()
        local fn = vim.fn.expand("%")
        if fn:match("%.tex$") ~= nil then
            local path = fn:sub(1,-4) .. t .. ".pdf"
            vim.system({ "za", path }, { detached = true })
        end
    end
end
vim.keymap.set("n", "za", za("draft"), { buffer = true })
vim.keymap.set("n", "zA", za("final"), { buffer = true })

vim.opt_local.iskeyword:append("+")

local function itemize()
    local pos = pos or vim.fn.getpos(".")
    local buf, row, col, off = unpack(pos)
    local ls = vim.api.nvim_buf_get_lines(buf, row-1, row, false)
    local l = ls[1]

    local _, i = vim.regex([[^\s*]]):match_str(l)
    if not vim.startswith(l:sub(i+1), [[\item]]) then
        vim.cmd([[keeppatterns .s/^\s*/\\item /]])
        vim.fn.setpos(".", {buf, row, col - i + 6, off})
    end
end

vim.keymap.set("i", ",i", itemize, { buffer = true })
vim.keymap.set("n", ",i", itemize, { buffer = true })
