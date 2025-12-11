return {
	"eero-lehtinen/oklch-color-picker.nvim",
	event = "VeryLazy",
	version = "*",
	keys = {
		-- One handed keymap recommended, you will be using the mouse
		{
			"<leader>tp",
			function()
				require("oklch-color-picker").pick_under_cursor()
			end,
			desc = "Color pick under cursor",
		},
	},
	---@type oklch.Opts
	opts = {
		highlight = {
			style = "virtual_left",
		},
		enabled_lsps = { "tailwindcss", "cssls", "css_variables" },
		-- Disable builtin LSP colors introduced in Nvim 0.12 to avoid conflicts.
		disable_builtin_lsp_colors = true,
	},
}
