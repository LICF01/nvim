return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts_extend = { "spec" },
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
		preset = "helix",
		win = {
			border = "rounded", -- none, single, double, shadow, rounded
		},
		show_help = true,
		spec = {
			mode = { "n", "v" },
			{ "<leader>a", group = "ai" },
			{
				"<leader>b",
				group = "buffer",
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			},
			{ "<leader>bc", group = "close" },
			{ "<leader>c", group = "code" },
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
			{ "<leader>gh", group = "hunk" },
			{ "<leader>ghp", group = "preview Hunk" },
			{ "<leader>gd", group = "diff" },
			{ "<leader>gb", group = "blame" },
			{ "<leader>go", group = "open" },
			{ "<leader>gt", group = "toggle" },
			{ "<leader>gu", group = "undo" },

			{ "<leader>q", group = "session" },
			{ "<leader>s", group = "search" },
			{ "<leader>t", group = "tools" },
			{ "<leader>tc", group = "CopilotChat" },
			{ "<leader>T", group = "Test" },
			{ "<leader>u", group = "ui" },
			{ "<leader>ut", group = "toggle" },
			{ "<leader>x", group = "diagnostics" },

			{ "[", group = "prev" },
			{ "]", group = "next" },
			{ "g", group = "goto" },
			{ "gp", group = "preview" },
			{ "gr", group = "lsp" },
			{ "gs", group = "surround" },
			{ "z", group = "fold" },
			{
				"<leader>w",
				group = "windows",
				proxy = "<c-w>",
				expand = function()
					return require("which-key.extras").expand.win()
				end,
			},
			-- better descriptions
			-- { "gx", desc = "Open with system app" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}
