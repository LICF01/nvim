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
			["<leader>c"] = { name = "+code", c = "Copilot", g = { name = "git", h = "hunk", u = "UI" } },
			["<leader>e"] = { name = "+explorer" },
			["<leader>f"] = { name = "+file/find", g = "git" },
			["<leader>g"] = { name = "+git" },
			["<leader>q"] = { name = "+session" },
			["<leader>s"] = { name = "+search" },
			["<leader>t"] = { name = "+tools", c = "ChatGPT" },
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
