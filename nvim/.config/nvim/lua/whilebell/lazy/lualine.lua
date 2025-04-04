return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "│", right = "│" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "NvimTree", "Trouble", "help" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    { "branch", icon = "" },
                    {
                        "diff",
                        symbols = { added = " ", modified = " ", removed = " " },
                        colored = true,
                    },
                },
                lualine_c = {
                    { "filename", path = 1, symbols = { modified = "●", readonly = "", unnamed = "[No Name]" } },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    }
                },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {}
            },
            extensions = { "fugitive", "nvim-tree", "quickfix", "toggleterm" }
        })
    end,
}
