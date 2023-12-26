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
				map("n", "<leader>ghs", gs.stage_hunk, { desc = "stage" })
				map("n", "<leader>ghr", gs.reset_hunk, { desc = "reset" })
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset" })
				map("n", "<leader>ghS", gs.stage_buffer, { desc = "stage buffer" })
				map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "undo stage" })
				map("n", "<leader>ghR", gs.reset_buffer, { desc = "reset buffer" })
				map("n", "<leader>ghp", gs.preview_hunk, { desc = "preview" })
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, { desc = "blame line" })
				map("n", "<leader>ghd", gs.diffthis, { desc = "diff" })
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>ugd", gs.toggle_deleted, { desc = "toggle deleted" })
				map("n", "<leader>ugb", gs.toggle_current_line_blame, { desc = "toggle line blame" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
	end,
}
