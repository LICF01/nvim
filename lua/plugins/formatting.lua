return {
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd.with({
						extra_filetypes = { "astro" },
					}),
					-- null_ls.builtins.diagnostics.eslint.with({
					-- 	extra_filetypes = { "astro" },
					-- }),
					null_ls.builtins.completion.spell,
				},
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										--  only use null-ls for formatting instead of lsp server
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,
			})
			vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
		end,
	},
	-- {
	-- 	"stevearc/conform.nvim",
	-- 	lazy = true,
	-- 	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	-- 	cmd = "ConformInfo",
	-- 	keys = {
	-- 		{
	-- 			"<leader>cF",
	-- 			function()
	-- 				require("conform").format({ formatters = { "injected" } })
	-- 			end,
	-- 			mode = { "n", "v" },
	-- 			desc = "Format Injected Langs",
	-- 		},
	-- 		{
	-- 			"<leader>cf",
	-- 			function()
	-- 				require("conform").format({
	-- 					timeout_ms = 500,
	-- 					lsp_fallback = true,
	-- 				})
	-- 			end,
	-- 			mode = { "n", "v" },
	-- 			desc = "Format file or range (in visual mode)",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		formatters_by_ft = {
	-- 			["javascript"] = { { "prettierd", "prettier" } },
	-- 			["javascriptreact"] = { { "prettierd", "prettier" } },
	-- 			["typescript"] = { { "prettierd", "prettier" } },
	-- 			["typescriptreact"] = { { "prettierd", "prettier" } },
	-- 			["vue"] = { { "prettierd", "prettier" } },
	-- 			["css"] = { { "prettierd", "prettier" } },
	-- 			["scss"] = { { "prettierd", "prettier" } },
	-- 			["less"] = { { "prettierd", "prettier" } },
	-- 			["html"] = { { "prettierd", "prettier" } },
	-- 			["json"] = { { "prettierd", "prettier" } },
	-- 			["jsonc"] = { { "prettierd", "prettier" } },
	-- 			["yaml"] = { { "prettierd", "prettier" } },
	-- 			["markdown"] = { { "prettierd", "prettier" } },
	-- 			["markdown.mdx"] = { { "prettierd", "prettier" } },
	-- 			["graphql"] = { { "prettierd", "prettier" } },
	-- 			["handlebars"] = { { "prettierd", "prettier" } },
	-- 		},
	-- 		format_on_save = {
	-- 			timeout_ms = 500,
	-- 			lsp_fallback = true,
	-- 		},
	-- 	},
	-- },
}
