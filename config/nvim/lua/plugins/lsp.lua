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
end

return {
    {
        "neovim/nvim-lspconfig",
        config = mkConfig,
    },
}
