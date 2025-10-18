return {
	"shellRaining/hlchunk.nvim",
	lazy = true,
	event = { "BufReadPre", "BufAdd", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					-- right_arrow = ">",
					right_arrow = "─",
				},
			},
			indent = {
				enable = true,
			},
		})
	end,
}
