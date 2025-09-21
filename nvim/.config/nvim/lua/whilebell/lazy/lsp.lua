return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"stevearc/conform.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})

		require("mason").setup({
			ensure_installed = { "black", "stylua" },
			ui = {
				icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
			},
		})

		-- mason-lspconfig v2+ auto-enables servers via vim.lsp.enable() by default.
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "vimls", "pylsp" },
			-- automatic_enable = true, -- default
		})

		-- Global defaults for all LSP clients
		vim.lsp.config("*", {
			capabilities = capabilities,
			-- on_attach = on_attach, -- uncomment if you have it
		})

		-- pylsp
		vim.lsp.config("pylsp", {
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = { enabled = false, ignore = { "E501", "W503", "E203" }, maxLineLength = 9999 },
						mccabe = { enabled = true, threshold = 30 },
					},
				},
				python = {
					analysis = {
						typeCheckingMode = "off",
						reportMissingImports = false,
						reportMissingTypeStubs = false,
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		-- lua_ls
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim", "on_attach" } },
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})

		-- Enable the configs now (mason-lspconfig will also enable on install)
		vim.lsp.enable({ "pylsp", "lua_ls", "vimls" })

		-- nvim-cmp
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources(
				{ { name = "nvim_lsp" }, { name = "luasnip" } },
				{ { name = "buffer" }, { name = "path" } }
			),
		})

		-- diagnostics UI
		vim.diagnostic.config({
			virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- conform
		require("conform").setup({
			formatters_by_ft = { python = { "black" }, lua = { "stylua" } },
			format_on_save = { lsp_format = "disable", async = false, timeout_ms = 500 },
		})
	end,
}
