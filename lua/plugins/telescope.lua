return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		defaults = {
			-- prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				width = 0.87,
				preview_cutoff = 120,
			},
			path_display = { "truncate " },
			mappings = {
				i = {
					["<C-k>"] = require("telescope.actions").move_selection_previous,
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<C-q>"] = require("telescope.actions").send_selected_to_qflist
						+ require("telescope.actions").open_qflist,
					["<C-h>"] = "which_key",
				},
				n = { ["q"] = require("telescope.actions").close },
			},
			file_ignore_patterns = { "node_modules" },
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				aerial = {
					-- Display symbols as <root>.<parent>.<symbol>
					show_nesting = {
						["_"] = false, -- This key will be the default
						json = true, -- You can set the option for specific filetypes
						yaml = true,
					},
					-- Available modes: symbols, lines, both
					show_columns = "both",
				},
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")

		telescope.setup(opts)
	end,
	keys = {
		{
			"<leader>ff",
			"<cmd>Telescope find_files<CR>",
			desc = "Files in cwd",
		},
		{ "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Files in cwd" },
		{ "<leader>.", "<cmd>Telescope find_files<cr>", desc = "Files in cwd" },
		-- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
		{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "String in buffer" },
		{ "<leader>fS", "<cmd>Telescope live_grep<cr>", desc = "String in cwd" },
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "String under cursor in cwd" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffer" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help page" },
		{ "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man page" },
		{ "<leader>fv", "<cmd>Telescope vim_options<cr>", desc = "Vim option" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymap" },
		{ "<leader>fl", "<cmd>Telescope highlights<cr>", desc = "Available highlights" },
		{ "<leader>fgc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
		{ "<leader>fgC", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer's commits" },
		{ "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
		{ "<leader>fgs", "<cmd>Telescope git_status<cr>", desc = "Status" },
		{ "<leader>cs", "<cmd>Telescope aerial<cr>", desc = "Symbols" },
		aerial = {
			-- Display symbols as <root>.<parent>.<symbol>
			show_nesting = {
				["_"] = false, -- This key will be the default
				json = true, -- You can set the option for specific filetypes
				yaml = true,
			},
			-- Available modes: symbols, lines, both
			show_columns = "both",
		},
		{ "<leader>fgS", "<cmd>Telescope git_stash<cr>", desc = "Stash" },
	},
}
