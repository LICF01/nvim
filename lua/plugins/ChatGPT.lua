return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		require("chatgpt").setup()

		local keymap = vim.keymap

		keymap.set({ "n", "v" }, "<leader>tcc", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
		keymap.set(
			{ "n", "v" },
			"<leader>tce",
			"<cmd>ChatGPTEditWithInstruction<CR>",
			{ desc = "Edit with instruction" }
		)
		keymap.set(
			{ "n", "v" },
			"<leader>tcg",
			"<cmd>ChatGPTRun grammar_correction<CR>",
			{ desc = "Grammar Correction" }
		)
		keymap.set({ "n", "v" }, "<leader>tct", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
		keymap.set({ "n", "v" }, "<leader>tck", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
		keymap.set({ "n", "v" }, "<leader>tcd", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
		keymap.set({ "n", "v" }, "<leader>tca", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
		keymap.set({ "n", "v" }, "<leader>tco", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
		keymap.set({ "n", "v" }, "<leader>tcs", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
		keymap.set({ "n", "v" }, "<leader>tcf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
		keymap.set({ "n", "v" }, "<leader>tce", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
		keymap.set({ "n", "v" }, "<leader>tcr", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
		keymap.set(
			{ "n", "v" },
			"<leader>tcl",
			"<cmd>ChatGPTRun code_readability_analysis<CR>",
			{ desc = "Code Readability Analysis" }
		)
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
