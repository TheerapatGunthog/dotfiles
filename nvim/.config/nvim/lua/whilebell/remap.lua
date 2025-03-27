-- Cache frequently used API functions for better performance
local keymap = vim.keymap.set
local api = vim.api
local fn = vim.fn

-- Set leader key
vim.g.mapleader = " "

-- ========================================================
-- EDITING AND NAVIGATION
-- ========================================================
local function setup_basic_editing_keys()
    -- Movement in visual mode
    keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
    keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })

    -- Movement and search with center alignment
    keymap("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
    keymap("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center" })
    keymap("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center" })
    keymap("n", "n", "nzzzv", { desc = "Next search result and center" })
    keymap("n", "N", "Nzzzv", { desc = "Previous search result and center" })
    -- This is going to get me cancelled
    keymap("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
    keymap("n", "Q", "<nop>", { desc = "Disable Ex mode" })
    keymap("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer with LSP" })
    -- Search and replace word under cursor
    keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        { desc = "Search and replace word under cursor" })
end

-- ========================================================
-- SPLIT AND TMUX NAVIGATION
-- ========================================================
local function setup_split_navigation()
    -- navigate splits
    keymap("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Navigate to left split/tmux pane" })
    keymap("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Navigate to right split/tmux pane" })
    keymap("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Navigate to split/tmux pane below" })
    keymap("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Navigate to split/tmux pane above" })

    -- resize splits
    keymap("n", "<leader><left>", ":vertical resize +20<cr>", { desc = "Increase vertical split size" })
    keymap("n", "<leader><right>", ":vertical resize -20<cr>", { desc = "Decrease vertical split size" })
end

-- ========================================================
-- CLIPBOARD AND REGISTER HANDLING
-- ========================================================
local function setup_clipboard_operations()
    -- greatest remap ever
    keymap("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

    -- next greatest remap ever : asbjornHaland
    keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
    keymap("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

    keymap({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without saving to register" })
end

-- ========================================================
-- QUICKFIX AND LOCATION LIST NAVIGATION
-- ========================================================
local function setup_list_navigation()
    keymap("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
    keymap("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
    keymap("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
    keymap("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })
end

-- ========================================================
-- CUSTOM PASTE FUNCTION (OPTIMIZED)
-- ========================================================
-- Function to paste and remove ^M characters more efficiently
local function paste_and_remove_cr()
    -- Use direct vim API call for paste
    api.nvim_command('normal! p')

    -- Check if we need to remove carriage returns (more efficient check)
    if fn.search('\r', 'nw') > 0 then
        -- Use substitute command with confirm=false for better performance
        api.nvim_command('%s/\\r//ge')
    end
end

-- Apply paste mappings with the optimized function
keymap('n', 'p', paste_and_remove_cr, { noremap = true, silent = true, desc = "Paste and remove ^M characters" })
keymap('v', 'p', paste_and_remove_cr, { noremap = true, silent = true, desc = "Paste and remove ^M characters" })

-- ========================================================
-- TMUX INTEGRATION (REFACTORED)
-- ========================================================
local function create_tmux_window()
    local current_dir = fn.expand('%:p:h')
    local file_name = fn.expand('%:t')
    local file_ext = fn.expand('%:e')

    -- Determine if this is a Python file once
    local is_python = file_ext == 'py'

    -- Use a single system call to check window count
    local window_count = tonumber(fn.system('tmux list-windows | wc -l'))

    if not window_count then return end

    if window_count > 1 then
        -- Get target window with a single system call
        local target_window = tonumber(fn.system('tmux list-windows -F "#{window_index}" | tail -n1'))

        -- Send command to existing window if it's a Python file
        if target_window and is_python then
            local run_cmd = string.format('tmux send-keys -t %d "cd %s && python %s" C-m',
                target_window, current_dir, file_name)
            fn.system(run_cmd)
        end
    else
        -- Create new window
        fn.system(string.format('tmux new-window -c "%s"', current_dir))

        -- Run Python script if applicable
        if is_python then
            fn.system(string.format('tmux send-keys "cd %s && python %s" C-m', current_dir, file_name))
        end
    end
end

-- Use the modern keymap API for consistency
keymap('n', '<leader>tp', create_tmux_window, {
    noremap = true,
    silent = true,
    desc = "Run current Python file in tmux window"
})

-- Initialize all key mappings
setup_basic_editing_keys()
setup_split_navigation()
setup_clipboard_operations()
setup_list_navigation()
