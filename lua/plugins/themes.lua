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
					-- hl.BlinkCmpMenu = {
					-- 	bg = "none",
					-- 	fg = c.fg_dark,
					-- }
				end,
			})

			-- lua/local.lua can pick another scheme for this machine.
			vim.cmd.colorscheme(require("utils.machine").colorscheme or "tokyonight-night")
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
