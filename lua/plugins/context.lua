return {
	"ahkohd/context.nvim",
	config = function()
		local context = require("context")
		context.setup({
			picker = context.pickers.snacks,

			-- Custom prompts with template variables
			prompts = {
				explain = "Explain {this}",
				fix = "Fix the issue at {position}",
				review = "Review {file} for issues",
				diagnose = "Help with:\n{diagnostics}",
			},
			-- Prepend @ to position output (default: true)
			position_prefix = true,
		})
	end,
	keys = {
		{
			"<leader>fc",
			function()
				require("context").pick()
			end,
			desc = "Context",
			mode = { "n", "v" },
		},
	},
}
