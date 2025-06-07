return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true

        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            actions = {
                open_file = {
                    quit_on_open = true, -- closes nvim-tree after opening a file
                },
            },
            view = {
                number = true,
                relativenumber = true,
                adaptive_size = true,
                float = {
                    enable = false,
                    quit_on_focus_loss = true,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local window_w = 60
                        local window_w_int = math.floor(window_w)
                        local center_x = (screen_w - window_w_int) / 2
                        return {
                            border = "rounded",
                            relative = "editor",
                            width = window_w_int,
                            col = center_x,
                            title = " File Explorer ",
                            title_pos = "center",
                        }
                    end,
                },
                width = {
                    min = 60,
                    max = 120,
                },
            },
            renderer = {
                group_empty = true,
                icons = {
                    show = {
                        git = true,
                        file = true,
                        folder = false,
                        folder_arrow = true,
                    },
                    glyphs = {
                        folder = {
                            arrow_closed = "⏵",
                            arrow_open = "⏷",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "⌥",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "⊖",
                            ignored = "◌",
                        },
                    },
                },
            },
            filters = {
                dotfiles = false,
                git_ignored = false,
            },
        })

        -- Keymap to toggle Nvim Tree
        vim.api.nvim_set_keymap('n', '<leader>pv', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
}
