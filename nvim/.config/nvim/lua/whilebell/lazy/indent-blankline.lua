return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup({
                indent = {
                    char = "│",
                    tab_char = "│",
                },
                scope = {
                    enabled = true,
                    show_start = true,
                    show_end = true,
                },
                exclude = {
                    filetypes = {
                        "help",
                        "alpha",
                        "dashboard",
                        "neo-tree",
                        "Trouble",
                        "lazy",
                        "mason",
                        "notify",
                        "toggleterm",
                    },
                    buftypes = {
                        "terminal",
                        "nofile",
                        "quickfix",
                        "prompt",
                    },
                },
            })
        end,
    },
}
