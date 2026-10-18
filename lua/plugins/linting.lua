return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		-- A linter is kept only if an enabled stack lists it in `linters`.
		local stacks = require("utils.lang-stacks")
		local full = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			json = { "eslint_d", "biomejs" },
			markdown = { "markdownlint-cli2" },
		}
		lint.linters_by_ft = stacks.filter_tool_map(full, "linters")

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- vim.keymap.set("n", "<leader>l", function()
		-- 	require("lint").try_lint()
		-- end, { desc = "Trigger linting for current file" }),
	end,
}
