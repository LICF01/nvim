return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local stacks = require("utils.lang-stacks")

		-- Enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Nothing is installed here. Packages are installed only by
		-- :Stack install <stack> (see utils/lang-stacks.lua), so startup never
		-- downloads a server or adapter that this machine doesn't use.
		--
		-- automatic_enable = false: servers are enabled only by the explicit list
		-- in lspconfig.lua, so a server mason has installed but no enabled stack
		-- owns never attaches with default config.
		mason_lspconfig.setup({
			automatic_enable = false,
		})

		-- Single entry point for group installs/uninstalls.
		stacks.setup_command()
	end,
}
