return {
	{
		"esmuellert/codediff.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = "CodeDiff",
		keys = {
			{
				"<leader>gdd",
				"<cmd>CodeDiff<CR>",
				desc = "Diffview",
			},
			{
				"<leader>gdh",
				"<cmd>CodeDiff history<CR>",
				desc = "History",
			},
			-- {
			-- 	"<leader>ghr",
			-- 	function()
			-- 		vim.ui.input({ prompt = "Commit range (e.g., origin/main..HEAD): " }, function(input)
			-- 			if input then
			-- 				vim.cmd("CodeDiff history " .. input)
			-- 			end
			-- 		end)
			-- 	end,
			-- 	desc = "Diff: commits in range",
			-- },
			-- {
			-- 	"<leader>ghp",
			-- 	function()
			-- 		vim.ui.input({ prompt = "File path: " }, function(input)
			-- 			if input then
			-- 				vim.cmd("CodeDiff history HEAD~10 " .. input)
			-- 			end
			-- 		end)
			-- 	end,
			-- 	desc = "Diff: commits for specific file",
			-- },
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim",
		},
		config = true,
		opts = {
			graph_style = "kitty",
		},
		keys = {
			{
				"<leader>tn",
				"<cmd>Neogit<CR>",
				desc = "Neogit",
			},
			{
				"<leader>gon",
				"<cmd>Neogit<CR>",
				desc = "Neogit",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Last Hunk")
				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "First Hunk")

				-- Actions
				map({ "n", "x" }, "<leader>ghs", gs.stage_hunk, "stage")
				map({ "n", "x" }, "<leader>ghr", gs.reset_hunk, "reset")
				map("n", "<leader>ghS", gs.stage_buffer, "stage buffer's")
				map("n", "<leader>ghR", gs.reset_buffer, "reset buffer's")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "undo stage")
				map("n", "<leader>ghpi", gs.preview_hunk_inline, "preview inline")
				map("n", "<leader>ghpf", gs.preview_hunk, "preview float")
				map("n", "<leader>gbl", function()
					gs.blame_line({ full = true })
				end, "line")
				map("n", "<leader>gbb", function()
					gs.blame()
				end, "buffer")
				map("n", "<leader>ghd", gs.diffthis, "diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "diff This ~")
				map("n", "<leader>gdw", ":Gitsigns toggle_word_diff<cr>", "word diff")
				map("n", "<leader>gtd", gs.toggle_deleted, "deleted")
				map("n", "<leader>gtl", gs.toggle_current_line_blame, "line blame")

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
}
