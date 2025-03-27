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
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.zenbones = {
                lighness = "dim",                     -- "dim" for dark theme (options: bright, dim, auto)
                darkness = "stark",                   -- "stark" for deep dark theme (options: stark, warm, cool)
                darken_comments = 0.15,               -- less darkening in dark mode (comments are already dark)
                darken_non_text = 0.1,                -- less darkening for non-text in dark mode
                darken_line_nr = 0.3,                 -- still keep line numbers visible
                colorize_diagnostic_underline = true, -- colorize diagnostic underlines
                -- Styles are "bold", "italic", "underline", "undercurl", "strikethrough"
                styles = {
                    comments = { "italic" },   -- italicize comments
                    conditionals = { "bold" }, -- bold conditionals for better visibility
                    folds = { "italic" },      -- italic folds for differentiation
                    loops = { "bold" },        -- bold loops for emphasis
                    functions = { "bold" },    -- bold functions for clarity
                    keywords = { "bold" },     -- bold keywords for emphasis
                    strings = { "italic" },    -- italic strings to distinguish from variables
                    variables = {},            -- keep variables plain for readability
                    numbers = { "italic" },    -- italic numbers for distinction
                    booleans = { "bold" },     -- bold booleans for visibility
                    properties = {},           -- keep properties plain
                    types = { "bold" },        -- bold types for better structure
                }
            }
        end
    },
}
