return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()

            local hooks = require("ibl.hooks")
            hooks.register(
                hooks.type.ACTIVE,
                function(bufnr)
                    local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
                    return ft == "python"
                end
            )
        end,
    },
}
