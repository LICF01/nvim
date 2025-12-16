return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,

	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = true, -- adds help for motions text_objects = false, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		preset = "modern",
		win = {
			border = "rounded", -- none, single, double, shadow, rounded
		},
		show_help = true,
		spec = {
			mode = { "n", "v" },
			{ "<leader>a", group = "ai" },
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
			{ "<leader>d", group = "debug" },
			{ "<leader>D", group = "databases" },
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
			{ "<leader>ut", group = "toggle" },
			{ "<leader>x", group = "diagnostics" },
			{ "<leader>z", group = "surround" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}
