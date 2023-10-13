return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = { enabled = false },
				suggestion = {
					enabled = false,
					auto_trigger = true,
					debounce = 50,
					keymap = {
						accept = "<M-CR>",
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dissmiss = "<M-Esc>",
					},
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
