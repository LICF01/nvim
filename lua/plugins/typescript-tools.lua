return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
		settings = {
			tsserver_plugins = {
				-- styled components intelisense suppport
				-- for TypeScript v4.9+
				"@styled/typescript-styled-plugin",
				-- or for older TypeScript versions
				-- "typescript-styled-plugin",
			},
		},
	},
	on_attach = function(_, opts)
		local tstools = require("typescript-tools")

		tstools.setup(opts)

		-- set keymaps
		local keymap = vim.keymap
		keymap.set("n", "<leader>cO", "<cmd>TSToolsOrganizeImports<CR>", { desc = "Sort and remove unused imports" })
		keymap.set("n", "<leader>co", "<cmd>TSToolsSortImports<CR>", { desc = "Sort imports" })
		keymap.set("n", "<leader>cu", "<cmd>TSToolsRemoveUnusedImports<CR>", { desc = "Remove unused imports" })
		keymap.set("n", "<leader>cU", "<cmd>TSToolsRemoveUnused<CR>", { desc = "Remove all unused statements" })
		keymap.set("n", "<leader>cA", "<cmd>TSToolsAddMissingImports<CR>", { desc = "Add missing imports" })
		keymap.set("n", "<leader>cS", "<cmd>TSToolsGoToSourceDefinition<CR>", { desc = "Go to source definition" })
	end,
}
