return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local ibl = require("ibl")

		-- local highlight = {
		-- 	"CursorColumn",
		-- 	"Whitespace",
		-- }
		ibl.setup({

			whitespace = {
				-- highlight = highlight,
				remove_blankline_trail = true,
			},

			scope = { enabled = true },
		})
	end,
}
