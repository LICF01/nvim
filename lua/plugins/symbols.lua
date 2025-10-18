return {
	{
		"stevearc/aerial.nvim",
		enabled = true,
		opts = {},
		-- Optional dependencies
		config = function()
			local aerial = require("aerial")
			-- Set up aerial
			aerial.setup({

				backends = { "lsp", "markdown", "asciidoc", "man" },
				filter_kind = false,
				layout = {
					resize_to_content = false,
					win_opts = {
						winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
						signcolumn = "yes",
						statuscolumn = " ",
					},
				},
				show_guides = true,
				guides = {
					mid_item = "├╴",
					last_item = "└╴",
					nested_top = "│ ",
					whitespace = "  ",
				},
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "<leader>css", "<cmd>AerialToggle right<CR>", { desc = "Symbols sidebar" })
					vim.keymap.set("n", "<leader>csn", "<cmd>AerialNavToggle<CR>", { desc = "Navigation" })
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})

			vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>", { desc = "Aerial" })
		end,
	},
}
