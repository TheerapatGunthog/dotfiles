return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({
                icons = true,        -- Enable icons for better visualization
                position = "bottom", -- Position at the bottom for more space when dealing with data science errors
                height = 10,         -- Reasonable height for error messages
                width = 50,
                mode = "workspace_diagnostics",
                fold_open = "▾", -- Symbol for expanded folds
                fold_closed = "▸", -- Symbol for collapsed folds
                group = true, -- Group results by file
                padding = true, -- Add padding
                action_keys = { -- Customize keys for data workflow
                    close = "q",
                    cancel = "<esc>",
                    refresh = "r",
                    jump = { "<cr>", "<tab>" },
                    toggle_mode = "m",    -- Toggle between different modes
                    toggle_preview = "P", -- Toggle preview of code
                    preview = "p",
                    hover = "K",          -- Show documentation
                },
                auto_jump = {},           -- Auto-jump to first item
                signs = {
                    error = "E",
                    warning = "W",
                    hint = "H",
                    information = "I"
                },
            })

            -- Basic toggle
            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end, { desc = "Toggle trouble window" })

            -- Navigate between diagnostic items
            vim.keymap.set("n", "]t", function()
                require("trouble").next({ skip_groups = true, jump = true })
            end, { desc = "Jump to next trouble/diagnostic item" })

            vim.keymap.set("n", "[t", function()
                require("trouble").previous({ skip_groups = true, jump = true })
            end, { desc = "Jump to previous trouble/diagnostic item" })

            -- Show specific diagnostics relevant to data science workflows
            vim.keymap.set("n", "<leader>tw", function()
                require("trouble").toggle("workspace_diagnostics")
            end, { desc = "Show workspace diagnostics in trouble" })

            vim.keymap.set("n", "<leader>td", function()
                require("trouble").toggle("document_diagnostics")
            end, { desc = "Show document diagnostics in trouble" })

            -- Quick access to definition and references (useful for exploring libraries)
            vim.keymap.set("n", "<leader>tq", function()
                require("trouble").toggle("quickfix")
            end, { desc = "Show quickfix list in trouble" })

            vim.keymap.set("n", "<leader>tl", function()
                require("trouble").toggle("loclist")
            end, { desc = "Show location list in trouble" })

            -- Especially useful for Python: jump to definition
            vim.keymap.set("n", "gd", function()
                require("trouble").toggle("lsp_definitions")
            end, { desc = "Show definitions in trouble" })

            -- Find references to symbols (great for exploring data science libraries)
            vim.keymap.set("n", "gr", function()
                require("trouble").toggle("lsp_references")
            end, { desc = "Show references in trouble" })
        end,
    },
}
