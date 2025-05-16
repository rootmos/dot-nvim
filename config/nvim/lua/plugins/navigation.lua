return {
    --{
        --"ibhagwan/fzf-lua",
        --dependencies = { "nvim-tree/nvim-web-devicons" },
        --config = function()
            --local fzf = require("fzf-lua")

            --fzf.setup {
                --fzf_colors = true,
                --winopts = {
                    --fullscreen = true,
                    --border = "none",
                    --preview = {
                        --border = "noborder",
                    --},
                --},
            --}

            --vim.keymap.set("n", "<leader>f", fzf.files)
            --vim.keymap.set("n", "<leader>t", fzf.git_files)
            --vim.keymap.set("n", "<leader>s", fzf.git_status)
            --vim.keymap.set("n", "<leader>k", fzf.manpages)
            --vim.keymap.set("n", "<leader>b", fzf.buffers)
            --vim.keymap.set("n", "<leader>j", fzf.jumps)
            --vim.keymap.set("n", "<leader>r", fzf.resume)

            --vim.keymap.set("n", "<leader>g", function()
                --local cwd = vim.fn.getcwd()
                --local sp = { cwd }

                --local g = require("git").toplevel(cwd)
                --if g ~= nil then
                    --table.insert(sp, g)
                --end

                --fzf.grep {
                    --search = vim.fn.expand("<cword>"),
                    --search_paths = sp,
                --}
            --end)
        --end
    --},
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

            telescope.setup {
                defaults = {
                    layout_config = {
                        height = 0.95,
                        width = 0.80,
                    },
                    mappings = {
                        i = {
                            ["<C-g>"] = actions.close,
                        },
                        n = {
                            ["<C-g>"] = actions.close,
                        },
                    },
                },
            }

            vim.keymap.set("n", "<leader>t", builtin.git_files)
            vim.keymap.set("n", "<leader>f", builtin.find_files)
            vim.keymap.set("n", "<leader>g", builtin.live_grep)
            vim.keymap.set("n", "<leader>G", builtin.grep_string)
            vim.keymap.set("n", "<leader>j", builtin.jumplist)
            vim.keymap.set("n", "<leader>s", builtin.git_status)
            vim.keymap.set("n", "<leader>r", builtin.resume)
            vim.keymap.set("n", "<leader>k", builtin.man_pages)
            vim.keymap.set("n", "<leader>=", builtin.spell_suggest)

            vim.keymap.set("n", "<leader>b", function()
                builtin.buffers {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    sort_mru = true,
                }
            end)
        end,
    },
}
