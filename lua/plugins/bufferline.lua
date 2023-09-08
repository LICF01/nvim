return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers",
			diagnostics = false,
			always_show_bufferline = true,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					separator = true,
				},
			},
		},
		highlights = {
			fill = {
				fg = "#EC5F67",
				bg = "#21242B",
			},
			indicator_selected = {
				fg = "#EC5F67",
			},
			separator_selected = {
				fg = "#22262D",
			},
			separator_visible = {
				fg = "#22262D",
			},
			separator = {
				fg = "#22262D",
			},
			offset_separator = {
				bg = "#282c34",
			},
		},
	},
}
