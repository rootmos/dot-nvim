local function go()
    local buf, row, col, off = unpack(vim.fn.getpos("."))

    local n = vim.fn.line("$")
    if n <= 1 then
        return
    end

    while true do
        local l = math.random(n)
        if l ~= row then
            vim.fn.setpos(".", {buf, l, col, off})
            break
        end
    end
end

vim.keymap.set("n", "zz", go)
