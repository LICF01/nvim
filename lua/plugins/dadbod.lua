return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "sqlserver" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_show_database_icon = 1
		vim.g.db_ui_winwidth = 30

		vim.g.db_ui_table_helpers = {
			mssql = {
				{ name = "Top 100", query = "TOP 100" },
				{ name = "Count Rows", query = "COUNT(*)" },
			},
		}

		vim.keymap.set("n", "<leader>Dt", "<cmd>tab DBUIToggle<cr>", { desc = "Toggle DBUI" })
		vim.keymap.set("n", "<leader>Df", "<cmd>tab DBUIFindBuffer<cr>", { desc = "Find Buffer" })
		vim.keymap.set("n", "<leader>Da", "<cmd>DBUIAddConnection<cr>", { desc = "Add Connection" })
		vim.keymap.set("n", "<leader>Dq", "<cmd>tabclose<cr>", { desc = "Close Tab" })
	end,
}
