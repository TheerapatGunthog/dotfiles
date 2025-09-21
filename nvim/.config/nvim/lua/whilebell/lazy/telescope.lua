return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		do
			local util = vim.lsp.util

			local function detect_offset_encoding(bufnr)
				local c = vim.lsp.get_clients({ bufnr = bufnr or 0 })
				return (c[1] and c[1].offset_encoding) or "utf-16"
			end

			local _symbols_to_items = util.symbols_to_items
			util.symbols_to_items = function(symbols, bufnr, client_id, offset_encoding)
				if type(offset_encoding) ~= "string" then
					offset_encoding = detect_offset_encoding(bufnr)
				end
				return _symbols_to_items(symbols, bufnr, client_id, offset_encoding)
			end

			-- รักษาซิกเนเจอร์: (bufnr?, position_encoding?)
			local _make_position_params = util.make_position_params
			util.make_position_params = function(bufnr, position_encoding)
				if type(position_encoding) ~= "string" then
					position_encoding = detect_offset_encoding(bufnr)
				end
				return _make_position_params(bufnr, position_encoding)
			end
		end

		require("telescope").setup({
			defaults = {},
			pickers = {
				find_files = { hidden = true, no_ignore = true },
			},
		})

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Search with Grep" })

		vim.keymap.set("n", "<leader>pl", function()
			builtin.lsp_document_symbols({
				symbols = { "Class", "Function", "Method", "Constructor" },
			})
		end, { desc = "Search a function,class on file" })
	end,
}
