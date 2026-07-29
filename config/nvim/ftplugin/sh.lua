local chmodxed = nil
map_leader("n", "x", function()
    local st = not chmodxed

    if vim.system {
        "chmod",
        st and "+x" or "-x",
        vim.api.nvim_buf_get_name(0)
    }:wait().code ~= 0 then
        print("unable to chmod " .. vim.fn.expand("%"))
        return
    end

    chmodxed = st
    if st then
        print("chmod +x " .. vim.fn.expand("%"))
    else
        print("chmod -x " .. vim.fn.expand("%"))
    end
end)
