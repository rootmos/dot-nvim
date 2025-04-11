vim.g.do_filetype_lua = 1
vim.filetype.add {
    filename = {
        [".k"] = "sh",
    },
    pattern = {
        [".*%.celx"] = "lua",
    },
    extension = {
       sms = "sms",
       chat = "chat",
    },
}

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.tf",
    callback = function()
        vim.bo.filetype = "terraform"
    end,
})

vim.keymap.set("n", "<leader>r", function() vim.api.nvim_command(":filetype detect") end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "gitcommit", "tex", "markdown",
        "c", "python", "haskell", "lua", "go",
        "mail", "sms", "chat",
    },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en,sv"

        local enc = vim.bo.fileencoding
        if enc == "" then
            enc = "utf-8"
        end

        local spellfile = ""
        for _, fn in ipairs{ "personal", "en", "sv" } do
            local path = vim.fs.joinpath(
                os.getenv("NVIM_SPELL"),
                string.format("%s.%s.add", fn, enc)
            )

            vim.cmd { cmd = "mkspell", args = { path }, bang = true, mods = { silent = true } }

            if spellfile ~= "" then
                spellfile = spellfile .. ","
            end
            spellfile = spellfile .. path
        end
        vim.opt_local.spellfile = spellfile
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sh", "c" },
    callback = function()
        vim.keymap.set("n", "K", function()
            vim.cmd { cmd = "Man", args = { vim.fn.expand("<cword>") }, mods = { hide = true } }
        end)
    end,
})
