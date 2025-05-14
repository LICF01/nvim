return {
	{
		"oskarrrrrrr/symbols.nvim",
		config = function()
			local r = require("symbols.recipes")
			require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
				-- custom settings here
				-- e.g. hide_cursor = false
			})
			vim.keymap.set("n", "<leader>ts", "<cmd> SymbolsToggle<CR>", { desc = "Symbols" })
		end,
	},
	{
		"stevearc/aerial.nvim",
		enabled = false,
		opts = {},
		-- Optional dependencies
		config = function()
			local aerial = require("aerial")
			-- Set up aerial
			aerial.setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})

			vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>", { desc = "Aerial" })
		end,
	},
}
