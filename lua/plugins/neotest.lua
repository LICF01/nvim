return {
	"nvim-neotest/neotest",
	dependencies = {
		"antoinemadec/FixCursorHold.nvim",
		"thenbe/neotest-playwright",
	},
	config = function()
		local neotest = require("neotest")

		neotest.setup({
			consumers = {
				-- add to your list of consumers
				playwright = require("neotest-playwright.consumers").consumers,
			},
			adapters = {
				require("neotest-playwright").adapter({
					options = {
						persist_project_selection = false,
						enable_dynamic_test_discovery = true,
						preset = "headed",
					},
				}),
			},
		})
	end,
  -- stylua: ignore
  keys = {
    { "<leader>Tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>TT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
    { "<leader>Tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>TS", function() require("neotest").run.stop() end, desc = "Stop" },
    { "<leader>Ta", function() require("neotest").playwright.attachment() end, desc = "Launch test attachment", },
  },
}
