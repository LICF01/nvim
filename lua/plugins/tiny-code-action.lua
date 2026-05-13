return {
	"rachartier/tiny-code-action.nvim",
	event = "LspAttach",
	opts = {
		--- The backend to use, currently only "vim", "delta", "difftastic", "diffsofancy" are supported
		backend = "delta",
		picker = {
			"snacks",
			opts = {
				-- layout = "vertical",
				layout = {
					layout = {
						backdrop = false,
						width = 0.5,
						min_width = 80,
						height = 0.8,
						min_height = 30,
						box = "vertical",
						border = true,
						title = "{title} {live} {flags}",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", height = 0.6, border = "top" },
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>ca",
			function()
				require("tiny-code-action").code_action()
			end,
			mode = { "n", "x" },
			desc = "Actions",
			noremap = true,
		},
	},
}
