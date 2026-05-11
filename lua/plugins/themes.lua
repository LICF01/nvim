return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			cache = true,
			style = "night",
			terminal_colors = true,
			styles = {
				comments = "NONE",
				keywords = "italic",
				functions = "NONE",
				variables = "NONE",
				sidebars = "dark",
				floats = "dark",
			},
		},
		config = function()
			require("tokyonight").setup({
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.BlinkCmpMenu = {
						bg = c.bg_dark,
					}
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = prompt,
					}
					hl.TelescopePromptBorder = {
						bg = prompt,
						fg = prompt,
					}
					hl.TelescopePromptTitle = {
						bg = prompt,
						fg = prompt,
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					-- hl.BlinkCmpMenu = {
					-- 	bg = "none",
					-- 	fg = c.fg_dark,
					-- }
				end,
			})

			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	lazy = true,
	-- 	priority = 1000,
	-- },
	-- {
	-- 	lazy = true,
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- },
	-- { "akinsho/horizon.nvim", version = "*", lazy = true },
}
