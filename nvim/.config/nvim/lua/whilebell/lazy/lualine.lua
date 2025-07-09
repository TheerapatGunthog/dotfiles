return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				-- Use proper Nerd Font characters for separators
				component_separators = { left = "", right = "" }, -- Example: Powerline arrow pointing right for left sections, inv arrow for right sections
				section_separators = { left = "", right = "" }, -- Match component separators

				disabled_filetypes = {
					"NvimTree",
					"Trouble",
					"help",
					"terminal",
					"lazy",
				},
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"branch",
						icon = "",
						color = { fg = "#61afef" },
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						colored = true,
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = { modified = "●", readonly = "ReadOnly", unnamed = "[No Name]" },
						color = { fg = "#98c379", gui = "bold" },
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
						colors = {
							error = "Error",
							warn = "Warning",
							info = "Info",
							hint = "Hint",
						},
					},
				},
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {
				"fugitive",
				"nvim-tree",
				"quickfix",
				"toggleterm",
				"man",
				"mason",
				"trouble",
			},
		})
	end,
}
