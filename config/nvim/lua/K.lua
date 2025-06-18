function K(page)
    vim.cmd { cmd = "Man", args = { page }, mods = { hide = true } }
end

vim.api.nvim_create_user_command("K", function(params)
    local page = params.fargs[1]
    if page == nil then
        page = vim.fn.expand("<cword>")
        if page == "" then
            return
        end
    end
    K(page)
end, {
    nargs = "?",
    complete = function(...)
        return require("man").man_complete(...)
    end,
})
