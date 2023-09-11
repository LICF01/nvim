return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		local blankline = require("indent_blankline")

		vim.opt.list = true
		vim.opt.listchars:append("space:⋅") -- space symbol
		-- vim.opt.listchars:append("eol:↴") -- end of the line symbol

		blankline.setup({
			show_current_context = true,
			show_current_context_start = true,
			-- show_end_of_line = false,
			space_char_blankline = " ",
		})
	end,
}
