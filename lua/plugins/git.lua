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
		config = function()
			local gitsigns = require("gitsigns")

			gitsigns.setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "󰍵" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "│" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]h", function()
						if vim.wo.diff then
							return "]h"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "next hunk" })

					map("n", "[h", function()
						if vim.wo.diff then
							return "[h"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "previous hunk" })

					-- Actions
					map("n", "<leader>gsh", gs.stage_hunk, { desc = "stage" })
					map("n", "<leader>grh", gs.reset_hunk, { desc = "reset" })
					map("v", "<leader>gsh", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "stage" })
					map("v", "<leader>grh", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "reset" })
					map("n", "<leader>gsb", gs.stage_buffer, { desc = "stage buffer" })
					map("n", "<leader>gus", gs.undo_stage_hunk, { desc = "undo stage" })
					map("n", "<leader>grb", gs.reset_buffer, { desc = "reset buffer" })
					map("n", "<leader>gph", gs.preview_hunk, { desc = "preview hunk" })
					map("n", "<leader>gbl", function()
						gs.blame_line({ full = true })
					end, { desc = "blame line" })
					map("n", "<leader>gbb", ":Gitsigns blame<cr>", { desc = "bar" })
					-- map("n", "<leader>gdf", gs.diffthis, { desc = "Diff file" })
					-- map("n", "<leader>gdF", function()
					-- 	gs.diffthis("~")
					-- end)
					map("n", "<leader>gdw", ":Gitsigns toggle_word_diff<cr>", { desc = "toggle word diff" })
					map("n", "<leader>gtd", gs.toggle_deleted, { desc = "toggle deleted" })
					map("n", "<leader>gtl", gs.toggle_current_line_blame, { desc = "toggle line blame" })
					map("n", "<leader>utl", gs.toggle_current_line_blame, { desc = "toggle line blame" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
}
