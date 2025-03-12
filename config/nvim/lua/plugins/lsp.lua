local function mkConfig()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lspconfig = require("lspconfig")
    lspconfig.gopls.setup{
        capabilities = capabilities,
    }

    lspconfig.pyright.setup{
        capabilities = capabilities,
    }

    lspconfig.bashls.setup{}

    lspconfig.csharp_ls.setup{}

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
            vim.lsp.buf.format({async = false})
        end
    })

    vim.keymap.set("n", "<leader>d", function() vim.lsp.buf.definition() end)
    vim.keymap.set("n", '<leader>D', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
end

local function configureLspsaga()
    local lspsaga = require("lspsaga")
    lspsaga.setup{
        lightbulb = {
            enable = false,
        },
        symbol_in_winbar = {
            enable = false,
        },
    }

    vim.keymap.set("n", "<leader>h", function() require("lspsaga.codeaction"):code_action() end)
    vim.keymap.set("n", "<leader>T", function() require("lspsaga.symbol"):outline() end)
end

return {
    {
        "neovim/nvim-lspconfig",
        config = mkConfig,
    },
    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-tree/nvim-web-devicons",
        },
        config = configureLspsaga,
    }
}
