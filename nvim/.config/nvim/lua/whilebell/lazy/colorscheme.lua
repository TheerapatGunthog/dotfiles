return {
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
    {
        "sainnhe/everforest",
        priority = 1000,
        name = "everforest",
        config = function()
            vim.g.everforest_background = "soft" -- soft, medium, hard
            vim.g.everforest_enable_italic = 1
            vim.g.everforest_better_performance = 1
            vim.g.everforest_transparent_background = 0
        end
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function()
            require("kanagawa").setup({
            })
        end
    }
}
