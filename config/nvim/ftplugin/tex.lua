vim.keymap.set("i", '""', "\\q{", { buffer = true })
vim.keymap.set("i", '"""', "\\qo{", { buffer = true })
vim.keymap.set("i", '""""', "\\qi{", { buffer = true })
vim.keymap.set("i", "**", "\\emph{", { buffer = true })
vim.keymap.set("i", "__", "\\textbf{", { buffer = true })

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

local function item()
    local pos = pos or vim.fn.getpos(".")
    local buf, row, col, off = unpack(pos)
    local ls = vim.api.nvim_buf_get_lines(buf, row-1, row, false)
    local l = ls[1]
    vim.fn.assert_equal(buf, 0)

    local _, i = vim.regex([[^\s*]]):match_str(l)
    if not vim.startswith(l:sub(i+1), [[\item]]) then
        vim.cmd([[keeppatterns .s/^\s*/\\item /]])
        col = col - i + 6
    else
        vim.cmd([[keeppatterns .s/^\s*//]])
        col = col - i
    end

    local i = vim.api.nvim_eval(vim.bo.indentexpr)
    local indent = ""
    for _ = 1, i do
        indent = indent .. " "
    end
    vim.cmd("keeppatterns .s/^\\s*/" .. indent .. "/")
    col = col + i

    vim.fn.setpos(".", {buf, row, col, off})
end

vim.keymap.set({"i", "n"}, "<leader>i", item, { buffer = true })

local ls = require("luasnip")

local function resolve_snippet(name)
    for _, s in ipairs(ls.get_snippets("tex")) do
        if s.name == name then
            return s
        end
    end
end

local function itemize()
    local s = resolve_snippet("\\itemize")
    ls.snip_expand(s)
end

vim.keymap.set({"i", "n"}, "<leader>I", itemize, { buffer = true })
vim.keymap.set({"i", "n"}, "<localleader>I", itemize, { buffer = true })
