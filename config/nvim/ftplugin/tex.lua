-- TODO use iabbrev instead? vim.api.nvim_cmd({ cmd = "iabbrev", args = {"...", "\\textelp{}"}}, {})
vim.keymap.set("i", '""', "\\q", { buffer = true })
vim.keymap.set("i", "**", "\\emph{", { buffer = true })
vim.keymap.set("i", "__", "\\textbf{", { buffer = true })
vim.keymap.set("i", "...", "\\textelp{}", { buffer = true })

local function za(t)
    return function()
        local fn = vim.fn.expand("%")
        if fn:match("%.tex$") ~= nil then
            local name = fn:sub(1,-5)
            local path = string.format("%s.%s.pdf", name, t)
            if not vim.uv.fs_stat(path) then
                path = string.format("%s.pdf", name)
            end
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

map_leader({"i", "n"}, "i", item, { buffer = true })

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

map_leader({"i", "n"}, "I", itemize, { buffer = true })
vim.keymap.set({"i", "n"}, "<localleader>I", itemize, { buffer = true })
