local M = {}

local function esc()
    local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
end

function M.line()
    local cur, vis = vim.fn.getpos("."), vim.fn.getpos("v")
    local visual = not vim.deep_equal(cur, vis)

    local a, b = 1, vim.fn.line("$")
    if visual then
        a, b = cur[2], vis[2]
    end

    if a == b then
        return
    elseif b < a then
        a, b = b, a
    end

    while true do
        local l = math.random(a, b)
        if l ~= cur[2] then
            cur[2] = l
            vim.fn.setpos(".", cur)
            if visual then
                esc()
            end
            return
        end
    end
end

return M
