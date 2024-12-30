return {
	"sphamba/smear-cursor.nvim",
	opts = {
		legacy_computing_symbols_support = true,
		transparent_bg_fallback_color = "#191A25",
	},
	keys = {
		{
			"<leader>uS",
			mode = { "n" },
			"<cmd>SmearCursorToggle<cr>",
			desc = "Smear cursor",
		},
	},
}
