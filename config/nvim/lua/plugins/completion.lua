local function mkConfig()
    local cmp = require("cmp")
    local ls = require("luasnip")

    local function mkMapping()
        return cmp.mapping.preset.insert({
            ['<CR>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if ls.expandable() then
                        ls.expand()
                    elseif cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                else
                    fallback()
                end
            end),

            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if #cmp.get_entries() == 1 then
                        cmp.confirm({ select = true })
                    else
                        cmp.select_next_item()
                    end
                elseif ls.locally_jumpable(1) then
                    ls.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif ls.locally_jumpable(-1) then
                    ls.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        })
    end

    local function mkSources(ft)
        local src = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "async_path" },
        }

        if ft == "tex" then
            table.insert(src, {
                name = "spell",
                keyword_length = 3,
                keyword_pattern = [[\\\?\k\+]],
                option = {
                    --keep_all_entries = true,
                    --enable_in_context = function(params)
                        --return require("cmp.config.context").in_treesitter_capture('spell')
                    --end,
                    --preselect_correct_word = true,
                },
            })
        else
            table.insert(src, {
                name = "buffer",
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end,
                    keyword_pattern = [[\k\+]],
                },
                indexing_interval = 100,
                indexing_batch_size = 1000,
            })
        end

        return cmp.config.sources(src)
    end

    cmp.setup({
        snippet = {
            expand = function(args)
                ls.lsp_expand(args.body)
            end
        },
        mapping = mkMapping(),
        sources = mkSources(),
        preselect = cmp.PreselectMode.None,
        sorting = {
            priority_weight = 100,
        },
    })

    cmp.setup.filetype("tex", {
        sources = mkSources("tex"),
    })
end

return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "FelipeLema/cmp-async-path",
            "f3fora/cmp-spell",
        },
        config = mkConfig,
    },
}
