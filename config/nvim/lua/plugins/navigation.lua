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

            --map_leader("n", "f", fzf.files)
            --map_leader("n", "t", fzf.git_files)
            --map_leader("n", "s", fzf.git_status)
            --map_leader("n", "k", fzf.manpages)
            --map_leader("n", "b", fzf.buffers)
            --map_leader("n", "j", fzf.jumps)
            --map_leader("n", "r", fzf.resume)

            --map_leader("n", "g", function()
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

            map_leader("n", "t", builtin.git_files)
            map_leader("n", "f", builtin.find_files)
            map_leader("n", "g", builtin.live_grep)
            map_leader("n", "G", builtin.grep_string)
            map_leader("n", "j", builtin.jumplist)
            map_leader("n", "s", builtin.git_status)
            map_leader("n", "r", builtin.resume)
            map_leader("n", "k", builtin.man_pages)
            map_leader("n", "=", builtin.spell_suggest)
            map_leader("n", "h", builtin.help_tags)

            map_leader("n", "b", function()
                builtin.buffers {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    sort_mru = true,
                }
            end)
        end,
    },
}
