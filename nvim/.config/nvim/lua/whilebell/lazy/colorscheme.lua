return {
	-- Gruvbox colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("gruvbox").setup({
				overrides = {
					SignColumn = { bg = "#282828" },
					NvimTreeCutHL = { fg = "#fb4934", bg = "#282828" },
					NvimTreeCopiedHL = { fg = "#b8bb26", bg = "#282828" },
					DiagnosticSignError = { fg = "#fb4934", bg = "#282828" },
					DiagnosticSignWarn = { fg = "#fabd2f", bg = "#282828" },
					DiagnosticSignHint = { fg = "#8ec07c", bg = "#282828" },
					DiagnosticSignInfo = { fg = "#d3869b", bg = "#282828" },
					DiffText = { fg = "#ebdbb2", bg = "#3c3836" },
					DiffAdd = { fg = "#ebdbb2", bg = "#32361a" },
				},
				transparent_mode = false,
			})
		end,
	},

	-- Everforest colorscheme
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
			})
		end,
	},
}
