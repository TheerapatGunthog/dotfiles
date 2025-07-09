return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Using latest version to get the most recent fixes
	cond = function()
		if vim.fn.has("nvim-0.10.1") == 0 then
			vim.notify("Avante requires Neovim 0.10.1 or later", vim.log.levels.WARN, { title = "Avante" })
			return false
		end
		return true
	end,
	init = function()
		-- Set recommended vim option for best Avante view compatibility
		vim.opt.laststatus = 3

		-- Create autocmd for Avante buffer
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "AvanteInput", "Avante" },
			callback = function()
				-- Set buffer-local options
				vim.opt_local.scrolloff = 999
			end,
		})
	end,
	opts = function()
		-- Set default provider and model directly
		local default_provider = "copilot"
		local default_model = "gpt-4o" -- Using a common and fast model

		local config = {
			provider = default_provider,
			auto_suggestions_provider = default_provider,

			-- Re-enabled built-in web search
			web_search_engine = {
				enabled = true,
			},
			providers = {
				copilot = {
					model = default_model,
				},
			},

			-- Simplified system prompt
			system_prompt = "You are an expert mathematician, logician and computer scientist with deep knowledge of Neovim, Lua, and programming languages. Provide concise, accurate responses with code examples when appropriate. For mathematical content, use clear notation and step-by-step explanations. \n IMPORTANT: Never create files, make git commits, or perform system changes without explicit permission. Always ask before suggesting any file modifications or system operations. Only use the SEARCH/REPLACE blocks to suggest changes.",
			-- Use Avante's default tools
			custom_tools = {},

			dual_boost = {
				enabled = false,
			},
			fallback = {
				enabled = false,
			},
			behaviour = {
				enable_claude_text_editor_tool_mode = true,
				enable_cursor_planning_mode = false,
				auto_suggestions = false,
				auto_suggestions_respect_ignore = true,
				auto_set_highlight_group = false,
				-- auto_set_keymaps = false, -- REMOVED to allow default keymaps
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
			token_counting = {
				enabled = true,
				show_in_status_line = false,
			},

			-- MAPPINGS TABLE REMOVED TO USE PLUGIN DEFAULTS

			hints = { enabled = false },
			windows = {
				position = "right",
				wrap = true,
				width = 45,
				sidebar_header = {
					enabled = false,
				},
				input = {
					prefix = "󰭹 ",
					height = 10,
					border = "rounded",
					start_insert = true,
				},
				edit = {
					border = "rounded",
					start_insert = true,
				},
				ask = {
					floating = true,
					start_insert = true,
					border = "rounded",
					focus_on_apply = "ours",
				},
			},
			highlights = {
				diff = {
					current = "DiffText",
					incoming = "DiffAdd",
				},
				sidebar = {
					header = "Title",
					selected = "PmenuSel",
					separator = "Comment",
				},
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

		-- Critical: Force all providers to use safe token limits
		if config.providers then
			for _, provider_config in pairs(config.providers) do
				if provider_config then
					provider_config.extra_request_body = provider_config.extra_request_body or {}
					provider_config.extra_request_body.max_tokens = 8192
				end
			end
		end

		-- CRITICAL: Fix the _defaults table for inheritance
		vim.defer_fn(function()
			local ok, avante_config = pcall(require, "avante.config")
			if ok and avante_config then
				if avante_config._options and avante_config._options.providers then
					for _, provider in pairs(avante_config._options.providers) do
						if provider.extra_request_body then
							provider.extra_request_body.max_tokens = 8192
						end
					end
				end
				if avante_config._defaults and avante_config._defaults.providers then
					for _, provider in pairs(avante_config._defaults.providers) do
						if provider.extra_request_body then
							provider.extra_request_body.max_tokens = 8192
						end
					end
				end
			end
		end, 100)

		return config
	end,
	config = function(_, opts)
		-- Disable dressing's select enhancement if you use it
		if pcall(require, "dressing") then
			require("dressing").setup({
				select = {
					enabled = false,
				},
			})
		end

		require("avante").setup(opts)
	end,
	build = "make",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"folke/snacks.nvim", -- for input provider snacks
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
