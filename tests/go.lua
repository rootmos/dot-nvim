local function go(l)
    local _, i = vim.regex([[^\s*]]):match_str(l)
    if vim.startswith(l:sub(i+1), [[\item]]) then
        return
    end

    print(l)
end

go("   \tbar")
go("   \t")
go("   \\item")
