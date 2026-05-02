vim.keymap.set("i", '"', "\\enquote{", { buffer = true })
vim.keymap.set("i", "*", "\\emph{", { buffer = true })

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
