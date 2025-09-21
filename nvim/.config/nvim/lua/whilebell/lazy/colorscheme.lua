return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "main",
			dark_variant = "main",
			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true, -- Handle deprecated options automatically
			},
			styles = {
				bold = true,
				italic = false,
				transparency = true,
			},
		})
		vim.cmd.colorscheme("rose-pine")
	end,
}
