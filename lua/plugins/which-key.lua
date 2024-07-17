return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		plugins = { spelling = {
			enabled = true,
			suggestions = 20,
		} },
		preset = "modern",
		spec = {
			mode = { "n", "v" },
			{ "<leader>b", group = "buffers" },
			{ "<leader>bc", group = "close" },
			{ "<leader>c", group = "code" },
			{ "<leader>cg", group = "git" },
			{ "<leader>cgb", group = "blame" },
			{ "<leader>cgd", group = "diff" },
			{ "<leader>cgo", group = "open" },
			{ "<leader>cgp", group = "preview" },
			{ "<leader>cgr", group = "reset" },
			{ "<leader>cgs", group = "stage" },
			{ "<leader>cgt", group = "toggle" },
			{ "<leader>cgu", group = "undo" },
			{ "<leader>cp", group = "paramters" },
			{ "<leader>cps", group = "swap" },
			{ "<leader>cpsp", desc = "swap previous" },
			{ "<leader>cpsn", desc = "swap next" },
			{ "<leader>e", group = "editor" },
			{ "<leader>f", group = "file/find" },
			{ "<leader>fg", group = "git" },
			{ "<leader>g", group = "git" },
			{ "<leader>q", group = "session" },
			{ "<leader>s", group = "search" },
			{ "<leader>t", group = "tools" },
			{ "<leader>tc", group = "CopilotChat" },
			{ "<leader>T", group = "Test" },
			{ "<leader>u", group = "ui" },
			{ "<leader>ug", group = "git" },
			{ "<leader>x", group = "diagnostics" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}
