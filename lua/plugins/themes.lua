return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					"tokyonight-night",
					"tokyonight-storm",
					"tokyonight-day",
					"tokyonight-moon",
					"onedark",
					"onelight",
					"onedark_vivid",
					"onedark_dark",
					"vaporwave",
					"catppuccin-latte",
					"catppuccin-frappe",
					"catppuccin-macchiato",
					"catppuccin-mocha",
					{
						name = "horizon-dark",
						colorscheme = "horizon",
						before = [[ vim.opt.background = "dark" ]],
					},
					{
						name = "horizon-light",
						colorscheme = "horizon",
						before = [[ vim.opt.background = "light" ]],
					},
				},
				livePreview = true,
			})
		end,
	},
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
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{ "akinsho/horizon.nvim", version = "*" },
}
