return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- for file icons
	},
	event = "VeryLazy",
	config = function()
		-- Use a consistent keymap function
		local keymap = vim.keymap.set

		-- Keymap for navigation (converted to bufferline commands)
		keymap("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
		keymap("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
		keymap(
			"n",
			"<leader>1",
			"<Cmd>BufferLineGoToBuffer 1<CR>",
			{ desc = "Go to buffer 1", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>2",
			"<Cmd>BufferLineGoToBuffer 2<CR>",
			{ desc = "Go to buffer 2", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>3",
			"<Cmd>BufferLineGoToBuffer 3<CR>",
			{ desc = "Go to buffer 3", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>4",
			"<Cmd>BufferLineGoToBuffer 4<CR>",
			{ desc = "Go to buffer 4", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>5",
			"<Cmd>BufferLineGoToBuffer 5<CR>",
			{ desc = "Go to buffer 5", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>6",
			"<Cmd>BufferLineGoToBuffer 6<CR>",
			{ desc = "Go to buffer 6", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>7",
			"<Cmd>BufferLineGoToBuffer 7<CR>",
			{ desc = "Go to buffer 7", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>8",
			"<Cmd>BufferLineGoToBuffer 8<CR>",
			{ desc = "Go to buffer 8", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>9",
			"<Cmd>BufferLineGoToBuffer 9<CR>",
			{ desc = "Go to buffer 9", noremap = true, silent = true }
		)
		keymap(
			"n",
			"<leader>0",
			"<Cmd>BufferLineGoToBuffer -1<CR>",
			{ desc = "Go to last buffer", noremap = true, silent = true }
		) -- Go to last buffer

		-- Keymap for tab actions (since mode is "tabs")
		keymap("n", "<leader>bn", "<Cmd>tabnew<CR>", { desc = "New tab" })
		keymap("n", "<leader>bc", "<Cmd>tabclose<CR>", { desc = "Close tab" })

		require("bufferline").setup({
			options = {
				-- This is the most important option to get the behavior you wanted
				mode = "tabs",

				animation = false,

				always_show_bufferline = false,

				-- Don't show the close button
				show_close_icon = false,
				show_buffer_close_icons = false,

				-- Separator style from your barbar config
				separator_style = "thin",

				-- Icons from your barbar config
				modified_icon = "●",

				-- Diagnostics settings
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					if level == vim.diagnostic.severity.ERROR then
						return ""
					end
					return ""
				end,

				-- Sidebar offset
				offsets = {
					{
						filetype = "NvimTree",
						text = "FILE-EXPLORER",
						highlight = "Directory",
						separator = true,
					},
					{
						filetype = "undotree",
						text = "UNDO-TREE",
						separator = true,
					},
				},

				-- Set max name length
				max_name_length = 25,
			},
		})
	end,
}
