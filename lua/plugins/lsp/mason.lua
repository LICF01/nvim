return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

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

		-- Only ensure the stacks enabled on THIS machine (persisted in
		-- stdpath("data")/lang-stacks.json). Use e.g.:
		--   :Stack install rust   (personal)
		--   :Stack install web    (work / React)
		--   :Stack uninstall rust (removes binaries AND disables LSP/formatters)
		local lsp_ensure = stacks.collect("lsp")
		local tool_ensure = stacks.collect("tools")

		-- Disable automatic_installation so mason doesn't try to install
		-- everything on startup.
		mason_lspconfig.setup({
			ensure_installed = lsp_ensure,
			automatic_installation = false,
		})

		-- Don't run on start to avoid popups/long startup installs.
		mason_tool_installer.setup({
			ensure_installed = tool_ensure,
			run_on_start = false,
		})

		-- Single entry point for group installs/uninstalls.
		stacks.setup_command()
	end,
}
