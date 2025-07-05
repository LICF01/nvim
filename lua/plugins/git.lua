return {
	{
		"sindrets/diffview.nvim",
		keys = {
			{
				"<leader>td",
				"<cmd>DiffviewOpen<CR>",
				desc = "Open Diffview",
			},
			{
				"<leader>cgod",
				"<cmd>DiffviewOpen<CR>",
				desc = "Open Diffview",
			},
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
				"<leader>cgon",
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
					map("n", "<leader>cgsh", gs.stage_hunk, { desc = "stage" })
					map("n", "<leader>cgrh", gs.reset_hunk, { desc = "reset" })
					map("v", "<leader>cgsh", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "stage" })
					map("v", "<leader>cgrh", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "reset" })
					map("n", "<leader>cgsb", gs.stage_buffer, { desc = "stage buffer" })
					map("n", "<leader>cgus", gs.undo_stage_hunk, { desc = "undo stage" })
					map("n", "<leader>cgrb", gs.reset_buffer, { desc = "reset buffer" })
					map("n", "<leader>cgph", gs.preview_hunk, { desc = "preview hunk" })
					map("n", "<leader>cgbl", function()
						gs.blame_line({ full = true })
					end, { desc = "blame line" })
					map("n", "<leader>cgdf", gs.diffthis, { desc = "Diff file" })
					map("n", "<leader>cgdF", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>cgud", gs.toggle_deleted, { desc = "toggle deleted" })
					map("n", "<leader>cgub", gs.toggle_current_line_blame, { desc = "toggle line blame" })
					map("n", "<leader>cgtd", gs.toggle_deleted, { desc = "toggle deleted" })
					map("n", "<leader>cgtl", gs.toggle_current_line_blame, { desc = "toggle line blame" })
					map("n", "<leader>utd", gs.toggle_deleted, { desc = "toggle deleted" })
					map("n", "<leader>utl", gs.toggle_current_line_blame, { desc = "toggle line blame" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
}
