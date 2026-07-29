return {
    {
        "mbbill/undotree",
        config = function()
            map_leader("n", "u", function()
                vim.cmd.UndotreeShow()
                vim.cmd.UndotreeFocus()
            end)
        end,
    },
}
