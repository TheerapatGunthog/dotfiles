return {
	-- Everforest Colorscheme
	{
		"sainnhe/everforest",
		-- It's okay to keep priority if you want it loaded early,
		-- but generally not strictly necessary for themes if you set them later.
		-- priority = 1000,
		name = "everforest",
		config = function()
			vim.g.everforest_background = "soft" -- soft, medium, hard
			vim.g.everforest_enable_italic = 1
			vim.g.everforest_better_performance = 1
			vim.g.everforest_transparent_background = 0
		end,
	},

	-- Rose Pine Colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({})
		end,
	},
}
