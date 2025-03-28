local M = {
    reg = "+",
}

local ns = vim.api.nvim_create_namespace("yank")

function get_paragraph(pos)
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
        return nil
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

    --return ls, {buf, s, 0, off}, {buf, t, tl, off}
    return ls, {s-1, 0}, {t, tl}
end

function M.yank_paragraph(reg, sep)
    local sep = sep or " "

    local pos = vim.fn.getpos(".")
    local ls, start, finish = get_paragraph(pos)

    if ls == nil then
        return nil
    end

    local text = ""
    for _, l in ipairs(ls) do
        if text ~= "" then
            text = text .. " "
        end
        text = text .. l
    end
    vim.fn.setreg(M.reg, text)

    vim.hl.range(pos[1], ns, "Search", start, finish, { timeout = 300 })

    return text
end

return M
