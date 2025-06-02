return {
    "zbirenbaum/copilot.lua",
    config = function()
        require("copilot").setup({
            -- Enable Copilot suggestions
            suggestion = { enabled = true, auto_trigger = true },
        })

        -- Keymap: Accept Copilot suggestion with Tab
        vim.keymap.set("i", "<Tab>", function()
            require("copilot.suggestion").accept()
        end, { desc = "Copilot Accept Suggestion" })

        -- keymap: Dismiss Copilot suggestion with Shift-Tab
        vim.keymap.set("i", "<S-Tab>", function()
            require("copilot.suggestion").dismiss()
        end, { desc = "Copilot Dismiss Suggestion" })
    end,
}
