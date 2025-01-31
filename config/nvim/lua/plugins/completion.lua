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

    local function mkSources()
        return cmp.config.sources({
            {
                name = "buffer",
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                },
                indexing_interval = 100,
                indexing_batch_size = 1000,
            },
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = 'async_path' },
        })
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
        },
        config = mkConfig,
    },
}
