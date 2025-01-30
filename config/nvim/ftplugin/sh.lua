local chmodxed = nil
vim.keymap.set("n", "<leader>x", function()
    chmodxed = not chmodxed

    vim.fn.system {
        "chmod",
        chmodxed and "+x" or "-x",
        vim.api.nvim_buf_get_name(0)
    }

    if chmodxed then
        print("chmod +x " .. vim.fn.expand("%"))
    else
        print("chmod -x " .. vim.fn.expand("%"))
    end
end)
