return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = true },
		lazygit = { enabled = false, configure = false }, -- very slow, I use a tmux floating panel
		indent = { enabled = false },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		scope = { enabled = true },
		picker = {
			layout = "default",
		},
	},
	 -- stylua: ignore
	keys = {
		{ "<leader>fe", function() Snacks.explorer() end, desc = "File in explorer", },
		{ "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Buffers", },
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep", },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History", },
		{ "<leader>.", function() Snacks.picker.files() end, desc = "Find Files", },
		-- find
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers", },
		{ "<leader>fC", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File", },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files", },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files", },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent", },
		-- LSP
		{ "<leader>cd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", },
		{ "<leader>cR", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Show References", },
		{ "<leader>cI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation", },
		{ "<leader>ct", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition", },
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols", },
		-- Grep
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines", },
		{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers", },
		{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep", },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" }, },
		-- search
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers", },
		{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds", },
		{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History", },
		{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands", },
		{ "<leader>sx", function() Snacks.picker.diagnostics() end, desc = "Diagnostics", },
		{ "<leader>bx", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics", },
		{ "<leader>bX", function() Snacks.picker.diagnostics() end, desc = "All Diagnostics", },
		{ "<leader>cxb", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics", },
		{ "<leader>cxa", function() Snacks.picker.diagnostics() end, desc = "All Diagnostics", },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages", },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights", },
		{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps", },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps", },
		{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List", },
		{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages", },
		{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks", },
		{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume", },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List", },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes", },
		{ "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects", },
		{ "<leader>tz", function() Snacks.zen() end, desc = "Toggle Zen Mode", },
		{ "<leader>bz", function() Snacks.zen.zoom() end, desc = "Toggle Zen Mode", },
		{ "<leader>uz", function() Snacks.zen() end, desc = "Toggle Zen Mode", },
		{ "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom", },
		{ "<leader>bs", function() Snacks.scratch() end, desc = "Scratch Buffer", },
		{ "<leader>bS", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer", },
		{ "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History", },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
		{ "<leader>fR", function() Snacks.rename.rename_file() end, desc = "Rename File", },
		{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" }, },
		{ "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line", },
		{ "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History", },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit", },
		{ "<leader>gS", function() Snacks.picker.git_status() end, desc = "Git Status", },
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },

		{ "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal", },
		{ "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore", },
		{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" }, },
		{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" }, },
		{ "<leader>N", desc = "Neovim News", function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- turn Snacks off while the cmp menu is open, turn it back on afterward
				local group = vim.api.nvim_create_augroup("BlinkCmpSnacksToggle", { clear = true })

				vim.api.nvim_create_autocmd("User", {
					group = group,
					pattern = "BlinkCmpMenuOpen",
					callback = function()
						vim.g.snacks_animate = false
					end,
				})

				vim.api.nvim_create_autocmd("User", {
					group = group,
					pattern = "BlinkCmpMenuClose",
					callback = function()
						vim.g.snacks_animate = true
					end,
				})

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
