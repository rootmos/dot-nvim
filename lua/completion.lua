vim.g.coq_settings = { auto_start = true }

--local luasnip = require("luasnip")

--local cmp = require("cmp")
--cmp.setup {
--    preselect = cmp.PreselectMode.Item,
--    snippet = {
--        expand = function(args)
--            --luasnip.lsp_expand(args.body)
--        end,
--    },
--    window = {
--    },
--    mapping = cmp.mapping.preset.insert {
--        ["<C-Space>"] = cmp.mapping.complete(),
--        ["<Tab>"] = cmp.mapping.confirm{ select = true },
--    },
--    sources = cmp.config.sources {
--        { name = "buffer" },
--    }, {
--        { name = "path" },
--    },
--}

--require("cmp_nvim_lsp").default_capabilities(
  --vim.lsp.protocol.make_client_capabilities())

--require("lspconfig")
