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
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
			debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
			disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
			language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
			-- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
			-- temperature = 0.1,
			window = {
				layout = "vertical",
			},
			mappings = {
				complete = {
					insert = "<S-Tab>",
				},
			},
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>tcc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle chat" },
			{ "<leader>tcr", "<cmd>CopilotChatReset<cr>", desc = "Reset chat history and clear buffer" },
			{ "<leader>tcf", "<cmd>CopilotChatFix<cr>", desc = "Find fix for error" },
			{ "<leader>tce", "<cmd>CopilotChatExplain<cr>", desc = "Explain" },
			{ "<leader>tcE", "<cmd>CopilotChatTests<cr>", desc = "Explain & generate Tests" },
			{ "<leader>tco", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize selected code" },
			{ "<leader>tcd", "<cmd>CopilotChatDocs<cr>", desc = "Write documentation for the selected code" },
			{ "<leader>tcw", "<cmd>CopilotChatCommit<cr>", desc = "Write commit with commitizen convention" },
			{ "<leader>tcm", "<cmd>CopilotChatModels<cr>", desc = "View/select available models" },
			{
				"<leader>tch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "Show Help actions",
			},
			{
				"<leader>tcp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "Show Prompt actions",
			},
		},
	},
}
