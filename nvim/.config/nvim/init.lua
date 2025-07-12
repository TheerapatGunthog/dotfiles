require("whilebell")
local todo_float = require("todofloat")

todo_float.setup({
	target_file = "~/Notes/todo.md",
})

vim.keymap.set("n", "<leader>td", ":Td<CR>", { noremap = true, silent = true, desc = "Open To-Do Float" })

vim.cmd("colorscheme gruvbox")

-- Set a miniconda3 interpreter for Neovim
vim.g.python3_host_prog = "/home/whilebell/miniconda3/bin/python"
