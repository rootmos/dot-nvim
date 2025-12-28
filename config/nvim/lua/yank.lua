local M = {
    reg = "+",
    wordsep = " \t,|",
    modes = {
        "word",
        "paragraph",
        "line",
    },
}

local ns = vim.api.nvim_create_namespace("yank")

local function get_paragraph(pos)
    local buf, row, col, _ = unpack(pos)

    local function get(r)
        local ls = vim.api.nvim_buf_get_lines(buf, r-1, r, false)
        local n = #ls
        if n == 1 then
            return ls[1]
        elseif n ~= 0 then
            error("unexpected number of lines?")
        end
    end

    local l = get(row)
    if l == nil or l == "" then
        return nil, nil, nil
    end

    local ls = {l}

    local s = row
    while true do
        local l = get(s-1)
        if l == nil or l == "" then
            break
        end
        table.insert(ls, 1, l)
        s = s - 1
    end

    local t, tl = row, #l
    while true do
        local l = get(t+1)
        if l == nil or l == "" then
            break
        end
        table.insert(ls, l)
        tl = #l
        t = t + 1
    end

    return ls, {s-1, 0}, {t, tl}
end

local function is_wordsep(c)
    local ws = M.wordsep
    for i = 1,#ws do
        local s = ws:sub(i, i)
        if s == c then
            return true
        end
    end
    return false
end

local function get_word(pos)
    local buf, row, col, _ = unpack(pos)
    local ls = vim.api.nvim_buf_get_lines(buf, row-1, row, false)
    local l = ls[1]
    local L = #l

    if is_wordsep(l:sub(col, col)) then
        return
    end

    local i, j = col, col

    while i > 1 and not is_wordsep(l:sub(i-1,i-1)) do
        i = i - 1
    end

    while j < L and not is_wordsep(l:sub(j+1,j+1)) do
        j = j + 1
    end

    return l:sub(i, j), {row-1, i-1}, {row-1, j}
end

local function get_line(pos)
    local buf, row, _, _ = unpack(pos)
    local ls = vim.api.nvim_buf_get_lines(buf, row-1, row, false)
    local l = ls[1]
    local L = #l
    return l, {row-1, 0}, {row-1, L}
end

local function join_lines(ls, sep)
    local sep = sep or " "
    local text = ""
    for _, l in ipairs(ls) do
        -- TODO strip l
        if text ~= "" then
            text = text .. sep
        end
        text = text .. l
    end
    return text
end

local function do_highlight(bufnr, start, finish)
    vim.hl.range(bufnr, ns, "Search", start, finish, { timeout = 300 })
end

function M.paragraph(pos)
    local pos = pos or vim.fn.getpos(".")
    local ls, start, finish = get_paragraph(pos)

    do_highlight(pos[1], start, finish)

    return join_lines(ls)
end

function M.word(pos)
    local pos = pos or vim.fn.getpos(".")
    local text, start, finish = get_word(pos)

    do_highlight(pos[1], start, finish)

    return text
end

function M.line(pos)
    local pos = pos or vim.fn.getpos(".")
    local text, start, finish = get_line(pos)

    do_highlight(pos[1], start, finish)

    return text
end

function M.yank(mode)
    local m = (vim.b.yank or M.modes)[mode or 1]

    local f
    if type(m) == "table" then
        f = m[2]
        m = m[1]
    end
    if not f then
        f = function(text) vim.fn.setreg(M.reg, text) end
    end

    if m == "word" then
        f(M.word())
    elseif m == "paragraph" then
        f(M.paragraph())
    elseif m == "line" then
        f(M.line())
    else
        error(string.format("requesting unexpected mode: %s (%s)", m, mode))
    end
end

return setmetatable(M, {
    __call = function(N, mode)
        return function()
            N.yank(mode)
        end
    end,
})
