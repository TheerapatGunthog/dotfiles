return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Use the latest version
	cond = function()
		if vim.fn.has("nvim-0.10.1") == 0 then
			vim.notify("Avante requires Neovim 0.10.1 or later", vim.log.levels.WARN, { title = "Avante" })
			return false
		end
		return true
	end,

	init = function()
		-- Recommended by Avante: Ensure UI stability
		vim.opt.laststatus = 3
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "AvanteInput", "Avante" },
			callback = function()
				vim.opt_local.scrolloff = 999
			end,
		})
	end,

	opts = function()
		local default_provider = "copilot"
		local default_model = "gpt-4o" -- Fast/good model of Copilot; can use this short name after auth

		local config = {
			provider = default_provider,
			auto_suggestions_provider = default_provider,

			web_search_engine = { enabled = true },

			providers = {
				copilot = {
					model = default_model,
					-- Limit tokens for safety and focus
					extra_request_body = {
						max_tokens = 8192,
						temperature = 0.2,
					},
				},
			},

			system_prompt = "You are an expert mathematician, logician and computer scientist with deep knowledge of Neovim, Lua, and programming languages. "
				.. "Provide concise, accurate responses with code examples when appropriate. For mathematical content, use clear notation and step-by-step explanations. "
				.. "IMPORTANT: Never create files, make git commits, or perform system changes without explicit permission. "
				.. "Always ask before suggesting any file modifications or system operations. Only use the SEARCH/REPLACE blocks to suggest changes.",

			custom_tools = {},

			dual_boost = { enabled = false },
			fallback = { enabled = false },

			behaviour = {
				enable_claude_text_editor_tool_mode = true,
				enable_cursor_planning_mode = false,
				auto_suggestions = false,
				auto_suggestions_respect_ignore = true,
				auto_set_highlight_group = false,
				-- auto_set_keymaps = false, -- Use the plugin's keymap
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = true,
				minimize_diff = true,
				preserve_state = true,
				require_confirmation_for_actions = true,
				disable_file_creation = true,
				disable_git_operations = true,
				respect_enter_key = true,
				use_cwd_as_project_root = false,
			},

			token_counting = { enabled = true, show_in_status_line = false },

			hints = { enabled = false },

			windows = {
				position = "right",
				wrap = true,
				width = 45,
				sidebar_header = { enabled = false },
				input = { prefix = "󰭹 ", height = 10, border = "rounded", start_insert = true },
				edit = { border = "rounded", start_insert = true },
				ask = { floating = true, start_insert = true, border = "rounded", focus_on_apply = "ours" },
			},

			highlights = {
				diff = { current = "DiffText", incoming = "DiffAdd" },
				sidebar = { header = "Title", selected = "PmenuSel", separator = "Comment" },
			},

			diff = {
				autojump = true,
				list_opener = "copen",
				override_timeoutlen = 500,
				inline_preview = true,
				gutter_markers = true,
				enhanced_display = true,
			},
		}

		return config
	end,

	-- Safe build on Windows
	build = "make",

	config = function(_, opts)
		if pcall(require, "dressing") then
			require("dressing").setup({ select = { enabled = false } })
		end
		require("avante").setup(opts)
	end,

	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.pick",
		"nvim-telescope/telescope.nvim",
		"ibhagwan/fzf-lua",
		"folke/snacks.nvim",
		"zbirenbaum/copilot.lua", -- Required for provider = 'copilot'
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = { file_types = { "markdown", "Avante" } },
			ft = { "markdown", "Avante" },
		},
	},
}
