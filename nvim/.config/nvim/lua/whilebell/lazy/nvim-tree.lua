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
            view = {
                number = true,
                relativenumber = true,
                adaptive_size = true,
                float = {
                    enable = true,
                    quit_on_focus_loss = true,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = 80
                        local window_h = 25
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w_int) / 2
                        local center_y = ((screen_h - window_h_int) / 2) - 1
                        return {
                            border = "rounded",
                            relative = "editor",
                            width = window_w_int,
                            height = window_h_int,
                            row = center_y,
                            col = center_x,
                            title = " File Explorer ",
                            title_pos = "center",
                        }
                    end,
                },
                width = {
                    min = 80,
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
