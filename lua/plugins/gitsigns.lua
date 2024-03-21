return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({

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
				map("n", "<leader>cghs", gs.stage_hunk, { desc = "stage" })
				map("n", "<leader>cghr", gs.reset_hunk, { desc = "reset" })
				map("v", "<leader>cghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage" })
				map("v", "<leader>cghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset" })
				map("n", "<leader>cgbS", gs.stage_buffer, { desc = "stage buffer" })
				map("n", "<leader>cgbu", gs.undo_stage_hunk, { desc = "undo stage" })
				map("n", "<leader>cgbR", gs.reset_buffer, { desc = "reset buffer" })
				map("n", "<leader>cghp", gs.preview_hunk, { desc = "preview hunk" })
				map("n", "<leader>cgb", function()
					gs.blame_line({ full = true })
				end, { desc = "blame line" })
				map("n", "<leader>cgd", gs.diffthis, { desc = "diff" })
				map("n", "<leader>cgD", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>cgud", gs.toggle_deleted, { desc = "toggle deleted" })
				map("n", "<leader>cgub", gs.toggle_current_line_blame, { desc = "toggle line blame" })
				map("n", "<leader>ugd", gs.toggle_deleted, { desc = "toggle deleted" })
				map("n", "<leader>ugb", gs.toggle_current_line_blame, { desc = "toggle line blame" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
	end,
}
