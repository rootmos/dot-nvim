return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "L3MON4D3/LuaSnip" },
        config = function()
            local cmp = require("cmp")
            local ls = require("luasnip")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        ls.lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if ls.expandable() then
                                ls.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
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
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "buffer" },
                }),
            })
        end,
    },
    {
        "hrsh7th/cmp-buffer",
        dependencies = { "hrsh7th/nvim-cmp" },
    },
}
