return {
    "zbirenbaum/copilot.lua",
    config = function()
        -- Setup Copilot plugin
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                -- We are managing the <Tab> key in a more complex way below,
                -- so we can remove the direct 'accept' mapping here.
                -- If you still want to map 'accept' to <Tab> directly within Copilot's
                -- own keymap table, you would typically integrate with nvim-cmp
                -- or add a fallback here. For this fix, we'll manage it
                -- with a custom keymap.set that includes the fallback logic.
                keymap = {
                    -- 'accept' is handled by our custom <Tab> mapping below
                    -- 'dismiss' can stay here or be moved to the custom keymap too
                    dismiss = "<C-]>", -- Example: Use Ctrl-] to dismiss
                    next = "<M-]>",    -- Alt-]
                    prev = "<M-[>",    -- Alt-[
                },
            },
            panel = {
                enabled = false, -- Disable the separate suggestion panel if you prefer inline
            },
            -- ... other copilot settings you might have ...
        })

        -- Custom Keymap for <Tab> to handle Copilot, then fallback to normal tab
        vim.keymap.set("i", "<Tab>", function()
            -- Check if Copilot has a suggestion visible
            if require("copilot.suggestion").is_visible() then
                -- If visible, accept the suggestion
                require("copilot.suggestion").accept()
            else
                -- If no Copilot suggestion, perform the default tab behavior
                -- This feeds a literal Tab keypress to Neovim.
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
            end
        end, { desc = "Accept Copilot Suggestion or Tab" })

        -- Keymap: Dismiss Copilot suggestion with Shift-Tab (or another key)
        -- This can remain as is, or you could integrate it into a comprehensive <S-Tab> mapping
        -- if you also use nvim-cmp and want <S-Tab> to navigate previous completion items or snippets.
        vim.keymap.set("i", "<S-Tab>", function()
            require("copilot.suggestion").dismiss()
        end, { desc = "Copilot Dismiss Suggestion" })
    end,
}
