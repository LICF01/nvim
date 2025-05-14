return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = false,
	branch = "v3.x",
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		"saifulapm/neotree-file-nesting-config", -- add plugin as dependency. no need any other config or setup call
	},
	opts = {
		hide_root_node = true,
		retain_hidden_root_indent = true,
		filesystem = {
			follow_current_file = { enabled = true },
			filtered_items = {
				show_hidden_count = false,
				never_show = {
					".DS_Store",
				},
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true,
				expander_collapsed = "",
				expander_expanded = "",
			},
		},
		close_if_last_window = true,
		enable_git_status = true,
		enable_diagnostics = true,
		open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
		source_selector = {
			winbar = true,
			statusline = false,
		},
		window = {
			mappings = {
				["e"] = function()
					vim.api.nvim_exec("Neotree focus filesystem left", true)
				end,
				["b"] = function()
					vim.api.nvim_exec("Neotree focus buffers left", true)
				end,
				["o"] = "system_open",
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
			},
		},
		buffers = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
		},
		commands = {
			system_open = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				-- macOs: open file in default application in the background.
				vim.fn.jobstart({ "xdg-open", "-g", path }, { detach = true })
				-- Linux: open file in default application
				vim.fn.jobstart({ "xdg-open", path }, { detach = true })

				-- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
				local p
				local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
				if lastSlashIndex then
					p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
				else
					p = path -- If no slash found, return original path
				end
				vim.cmd("silent !start explorer " .. p)
			end,
		},
	},
	config = function(_, opts)
		opts.nesting_rules = require("neotree-file-nesting-config").nesting_rules
		require("neo-tree").setup(opts)

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>et", "<cmd>Neotree reveal toggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<leader>fe", "<cmd>Neotree reveal toggle<CR>", { desc = "File in explorer" }) -- toggle file explorer on current file
		keymap.set("n", "<leader>be", "<cmd>Neotree buffers<CR>", { desc = "Open buffers in file explorer" })

		-- Diagnostics signs
		vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
	end,
}
