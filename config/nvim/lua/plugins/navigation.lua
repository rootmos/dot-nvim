return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")

            fzf.setup {
                fzf_colors = true,
                winopts = {
                    fullscreen = true,
                    border = "none",
                    preview = {
                        border = "noborder",
                    },
                },
            }

            vim.keymap.set("n", "<leader>f", fzf.files)
            vim.keymap.set("n", "<leader>t", fzf.git_files)
            vim.keymap.set("n", "<leader>s", fzf.git_status)
            vim.keymap.set("n", "<leader>k", fzf.manpages)
            vim.keymap.set("n", "<leader>b", fzf.buffers)
            vim.keymap.set("n", "<leader>j", fzf.jumps)
            vim.keymap.set("n", "<leader>r", fzf.resume)

            vim.keymap.set("n", "<leader>g", function()
                local cwd = vim.fn.getcwd()
                local sp = { cwd }

                local g = require("git").toplevel(cwd)
                if g ~= nil then
                    table.insert(sp, g)
                end

                fzf.grep {
                    search = vim.fn.expand("<cword>"),
                    search_paths = sp,
                }
            end)
        end
    }
}
