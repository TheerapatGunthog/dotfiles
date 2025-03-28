return {
    {
        "shaunsingh/solarized.nvim",
        name = "solarized",
        priority = 1000,
        config = function()
            vim.g.solarized_italic_comments = false
            vim.g.solarized_italic_keywords = false
            vim.g.solarized_italic_functions = false
            vim.g.solarized_italic_variables = false
            vim.g.solarized_contrast = true
            vim.g.solarized_borders = true
            vim.g.solarized_disable_background = false
        end
    },
    {
        "shaunsingh/nord.nvim",
        name = "nord",
        priority = 1000,
        config = function()
            vim.g.nord_contrast = true
            vim.g.nord_borders = false
            vim.g.nord_disable_background = true
            vim.g.nord_italic = false
            vim.g.nord_uniform_diff_background = true
            vim.g.nord_bold = true
        end
    },
    {
        "sainnhe/everforest",
        name = "everforest",
        priority = 1000,
        config = function()
            vim.g.everforest_background = 'soft'
            vim.g.everforest_enable_italic = 0
            vim.g.everforest_disable_italic_comment = 0
            vim.g.everforest_transparent_background = 1
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                transparent = true,
                no_italic = true,
                no_bold = false,
                no_underline = false,
            })
        end
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                styles = {
                    types = "NONE",
                    methods = "bold",
                    numbers = "NONE",
                    strings = "italic",
                    comments = "italic",
                    keywords = "bold",
                    constants = "NONE",
                    functions = "bold,italic",
                    operators = "NONE",
                    variables = "NONE",
                    parameters = "italic",
                    conditionals = "bold",
                    virtual_text = "italic",
                },
                options = {
                    transparency = false,
                    cursorline = true,
                }
            })
        end
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = { "rktjmp/lush.nvim" },
        lazy = false,    -- Load immediately
        priority = 1000, -- Load before other plugins
        config = function()
            vim.g.zenbones = {
                darkness = "warm",                    -- Warm tones for a softer dark look
                darken_comments = 0.2,                -- Slightly more darkening for comments (was 0.15)
                darken_non_text = 0.15,               -- Slightly more for non-text (was 0.1)
                darken_line_nr = 0.25,                -- Slightly less darkening for line numbers (was 0.3)
                colorize_diagnostic_underline = true, -- Keep colored underlines for diagnostics
                styles = {
                    comments = { "italic" },          -- Keep italic for subtle comment distinction
                    conditionals = { "bold" },        -- Bold for control flow visibility
                    folds = { "italic" },             -- Italic folds are fine
                    loops = { "bold" },               -- Bold loops for emphasis
                    functions = { "bold", "italic" }, -- Add italic to functions for extra clarity
                    keywords = { "bold" },            -- Bold keywords are good
                    strings = { "italic" },           -- Italic strings work well
                    variables = {},                   -- Plain variables for focus
                    numbers = { "italic" },           -- Italic numbers are fine
                    booleans = { "bold" },            -- Bold booleans for emphasis
                    properties = {},                  -- Plain properties are good
                    types = { "bold", "italic" },     -- Add italic to types for distinction
                },
                -- Additional tweaks for programming
                solid_line_nr = true,      -- Solid background for line numbers (better visibility)
                darken_cursor_line = 0.05, -- Subtle cursor line highlight
            }
        end,
    },
}
