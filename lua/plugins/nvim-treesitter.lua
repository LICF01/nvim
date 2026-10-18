return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		init = function()
			-- Parsers come from enabled stacks (:Stack install rust / web ...).
			-- Only "core" is enabled by default; other stacks install on demand
			-- so work vs. personal machines stay lean.
			local stacks = require("utils.lang-stacks")
			local ensureInstalled = stacks.collect("treesitter")
			-- diff between already installed parsers and those that need to be installed
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			require("nvim-treesitter").install(parsersToInstall)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
					local has_parser = lang and vim.treesitter.query.get(lang, "indents") ~= nil

					-- syntax highlighting, provided by Neovim
					pcall(vim.treesitter.start)
					-- folds, provided by Neovim
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					-- Disable folding at startup
					vim.wo.foldenable = false
					-- indentation, provided by nvim-treesitter (only if parser is installed)
					if has_parser then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter")

			-- configure treesitter
			treesitter.setup({
				-- parsers are managed per-stack via :Stack install <group>;
				-- keep auto_install off so opening a file can't pull in a
				-- stack you haven't enabled.
				auto_install = false,
			})
		end,
	},
	-- Show context of the current function
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	config = function()
	-- 		local keymap = vim.keymap
	--
	-- 		local context = require("treesitter-context")
	--
	-- 		context.setup({
	-- 			enable = true,
	-- 			mode = "cursor",
	-- 			-- separator = "-",
	-- 		})
	--
	-- 		keymap.set("n", "[c", function()
	-- 			context.go_to_context(vim.v.count1)
	-- 		end, { desc = "Jump to context", silent = true })
	--
	-- 		keymap.set("n", "<leader>uc", ":TSContextToggle<CR>", { desc = "Toggle context" })
	-- 	end,
	-- },

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",

		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		"wurli/contextindent.nvim",
		-- This is the only config option; you can use it to restrict the files
		-- which this plugin will affect (see :help autocommand-pattern).
		opts = { pattern = "*" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
