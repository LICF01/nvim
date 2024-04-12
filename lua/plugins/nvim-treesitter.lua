return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },

				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = { enable = true },
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
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				-- auto install above language parsers
				auto_install = true,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

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
						enable = true,
						swap_next = {
							["<leader>cpsp"] = "@parameter.inner", -- swap object under cursor with next
						},
						swap_previous = {
							["<leader>cpsn"] = "@parameter.inner", -- swap object under cursor with previous
						},
					},
				},
			})
		end,
	},
	-- Show context of the current function
	{
		"nvim-treesitter/nvim-treesitter-context",
		enabled = false,
		opts = { mode = "cursor" },
		config = function()
			local keymap = vim.keymap
			keymap.set("n", "<leader>uc", "<cmd>TSContextToggle<CR>", { desc = "Toggle context" })
		end,
	},

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {},
	},
}
