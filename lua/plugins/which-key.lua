return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			["<leader>b"] = { name = "+buffers", c = "close" },
			["<leader>c"] = {
				name = "+code",
				c = "Copilot",
				g = {
					name = "+git",
					b = "+blame",
					d = "+diff",
					o = "+open",
					p = "+preview",
					r = "+reset",
					s = "+stage",
					t = "+toggle",
					u = "+undo",
				},
				p = { name = "+paramters", s = { name = "+swap", p = "swap previous", n = "swap next" } },
			},
			["<leader>e"] = { name = "+editor" },
			["<leader>f"] = { name = "+file/find", g = "+git" },
			["<leader>g"] = { name = "+git" },
			["<leader>q"] = { name = "+session" },
			["<leader>s"] = { name = "+search" },
			["<leader>t"] = { name = "+tools", c = "+CopilotChat" },
			["<leader>T"] = { name = "+Test" },
			["<leader>u"] = { name = "+ui", g = "git" },
			["<leader>x"] = { name = "+diagnostics" },
			["g"] = { name = "", s = "surround" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
