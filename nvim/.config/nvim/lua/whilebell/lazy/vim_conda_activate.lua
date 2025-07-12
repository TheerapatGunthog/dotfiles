return {
	"kmontocam/nvim-conda",
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.keymap.set("n", "<leader>ca", "<cmd>CondaActivate<cr>", { desc = "Activate Conda Environment" })
		vim.keymap.set("n", "<leader>cd", "<cmd>CondaDeactivate<cr>", { desc = "Activate Conda Environment" })
	end,
}
