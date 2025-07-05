return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"RRethy/nvim-treesitter-textsubjects",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({
				-- ensure these language parsers are installed
				ensure_installed = {
					"astro",
					"bash",
					"css",
					"diff",
					"dockerfile",
					"gitignore",
					"graphql",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"prisma",
					"python",
					"query",
					"regex",
					"svelte",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				-- auto install above language parsers
				auto_install = true,
				-- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					move = {
						enable = false,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]F"] = "@function.inner",
							-- ["]]"] = { query = "@class.outer", desc = "Next class start" },
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
							goto_next_end = {
								["]f"] = "@function.outer",
								["]c"] = "@class.outer",
							},
							goto_previous_start = {
								["[f"] = "@function.outer",
								["[c"] = "@class.outer",
							},
							goto_previous_end = {
								["[f"] = "@function.outer",
								["[c"] = "@class.outer",
							},
							-- Below will go to either the start or the end, whichever is closer.
							-- Use if you want more granular movements
							-- Make it even more gradual by adding multiple queries and regex.
							goto_next = {
								["]i"] = "@conditional.outer",
							},
							goto_previous = {
								["[i"] = "@conditional.outer",
							},
						},
					},
					select = {
						enable = false,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment region" },
							["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment region" },

							["a:"] = {
								query = "@parameter.outer",
								desc = "Select outer part of a parameter/field region",
							},
							["i:"] = {
								query = "@parameter.inner",
								desc = "Select inner part of a parameter/field region",
							},

							["ai"] = {
								query = "@conditional.outer",
								desc = "Select outer part of a conditional region",
							},
							["ii"] = {
								query = "@conditional.inner",
								desc = "Select inner part of a conditional region",
							},

							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },

							["ab"] = { query = "@block.outer", desc = "Select outer part of a block region" }, -- overrides default text object block of parenthesis to parenthesis
							["ib"] = { query = "@block.inner", desc = "Select inner part of a block region" }, -- overrides default text object block of parenthesis to parenthesis

							["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
							["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },

							["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						},
						include_surrounding_whitespace = true,
					},
					swap = {
						enable = false,
						swap_next = {
							["<leader>cpsp"] = "@parameter.inner", -- swap object under cursor with next
						},
						swap_previous = {
							["<leader>cpsn"] = "@parameter.inner", -- swap object under cursor with previous
						},
					},
					lsp_interop = {
						enable = false,
						border = "none",
						floating_preview_opts = {},
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
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
