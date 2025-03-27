return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier.with({
                    filetypes = {
                        "javascript",
                        "typescript",
                        "json",
                        "html",
                        "css",
                        "scss",
                        "less",
                        "markdown",
                        "vue",
                        "yaml",
                        "graphql",
                        "jsx",
                        "tsx",
                        "flow",
                        "angular",
                    },
                }),
            },
            on_attach = function(client, bufnr)
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })
    end,
}
