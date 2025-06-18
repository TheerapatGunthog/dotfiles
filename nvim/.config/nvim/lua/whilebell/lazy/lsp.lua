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

		-- *** CORRECTED: Add 'black' (and 'ruff') to mason.setup() ensure_installed ***
		require("mason").setup({
			ensure_installed = {
				"black",
				"stylua",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Setup pylsp
		require("lspconfig").pylsp.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							enabled = true,
							ignore = { "E501", "W503" },
							maxLineLength = 9999,
						},
						mccabe = {
							enabled = true,
							threshold = 30, -- Increase the threshold to a value higher than 27
						},
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

		-- Setup lua_ls
		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "on_attach" },
					},
					workspace = {
						-- Optional: might help with some other third-party warnings
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"vimls",
				"pylsp",
			},
			handlers = {
				function(server_name) -- default handler
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						-- No on_attach for auto-format here, conform.nvim handles it.
					})
				end,
			},
		})

		-- *** CONFORM.NVIM SETUP (no change needed here, it correctly refers to "black") ***
		require("conform").setup({
			formatters_by_ft = {
				python = { "black" }, -- This refers to the 'black' executable installed by mason.nvim
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_format = "disable",
				async = false,
				timeout_ms = 500,
			},
		})

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
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
		})

		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
