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

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"astro",
				"copilot",
				"cssls",
				"cssmodules_ls",
				"css_variables",
				"docker_language_server",
				"emmet_language_server",
				"graphql",
				"html",
				"lua_ls",
				"marksman",
				-- "pyright",
				"pylsp",
				"sqls",
				"tailwindcss",
				"vtsls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			-- list of formatters and linterns for mason to install
			ensure_installed = {
				"biome",
				"chrome-debug-adapter",
				"eslint_d",
				"firefox-debug-adapter",
				"js-debug-adapter",
				"markdownlint-cli2",
				"markdown-toc",
				"prettierd",
				"stylua",
				"sqlfmt",
				"ruff",
			},
		})
	end,
}
