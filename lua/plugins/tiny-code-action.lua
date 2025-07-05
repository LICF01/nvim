return {
	"rachartier/tiny-code-action.nvim",
	event = "LspAttach",
	opts = {
		backend = "vim",
		picker = {
			"snacks",
			opts = {},
		},
	},

  -- stylua: ignore
	keys = {
		{ "<leader>ca", function() require("tiny-code-action").code_action() end, desc = "Actions", },
	}

,
}
