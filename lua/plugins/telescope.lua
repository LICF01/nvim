return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
				},
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap
		local builtin = require("telescope.builtin")

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files in cwd" })
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
		keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "String in buffer" })
		keymap.set("n", "<leader>fS", builtin.live_grep, { desc = "String in cwd" })
		keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "String under cursor in cwd" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffer" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help page" })
		keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Man page" })
		keymap.set("n", "<leader>fv", builtin.vim_options, { desc = "Vim option" })
		keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymap" })
		keymap.set("n", "<leader>fl", builtin.highlights, { desc = "Available highlights" })
		keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Commits" })
		keymap.set("n", "<leader>gC", builtin.git_bcommits, { desc = "Buffer's commits" })
		keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Branches" })
		keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Status" })
		keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "Stash" })
	end,
}
