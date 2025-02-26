return {
    {
        "https://github.com/junegunn/fzf.vim",
        dependencies = {
            { "junegunn/fzf" },
        },
        config = function()
            local function spec()
                return {
                    options = { "--color=16" },
                    dir = vim.fn.getcwd(),
                }
            end

            vim.keymap.set("n", "<leader>f", function() vim.fn["fzf#vim#files"]("", spec()) end)
            vim.keymap.set("n", "<leader>t", function() vim.fn["fzf#vim#gitfiles"]("--cached --others --exclude-standard", spec()) end)
            vim.keymap.set("n", "<leader>a", function() vim.fn["fzf#vim#ag"](vim.fn.expand("<cword>"), spec()) end)
            vim.keymap.set("n", "<leader>b", function() vim.fn["fzf#vim#buffers"]("", spec()) end)
            vim.keymap.set("n", "<leader>j", function() vim.fn["fzf#vim#jumps"](spec()) end)
        end,
    },
}
