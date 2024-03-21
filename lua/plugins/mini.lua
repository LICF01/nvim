return {
	{
		"echasnovski/mini.pairs",
		version = false,
		config = function()
			local pairs = require("mini.pairs")
			pairs.setup()
		end,
	},
	{
		"echasnovski/mini.animate",
		version = false,
		opts = function()
			-- don't use animate when scrolling with the mouse
			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			return {
				resize = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				scroll = {
					timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
			}
		end,
	},
	{
		"echasnovski/mini.cursorword",
		version = false,
		config = function()
			local cursorword = require("mini.cursorword")
			cursorword.setup()
		end,
	},
	--
	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function()
			local indentscope = require("mini.indentscope")
			indentscope.setup()
		end,
	},
	-- {
	-- 	"echasnovski/mini.completion",
	-- 	version = false,
	-- 	config = function()
	-- 		local completion = require("mini.completion")
	-- 		completion.setup()
	-- 	end,
	-- },
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding", mode = { "n", "v" } },
				{ opts.mappings.find, desc = "Find right surrounding", mode = { "n", "v" } },
				{ opts.mappings.find_left, desc = "Find left surrounding", mode = { "n", "v" } },
				{ opts.mappings.highlight, desc = "Highlight surrounding", mode = { "n", "v" } },
				{ opts.mappings.replace, desc = "Replace surrounding", mode = { "n", "v" } },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`", mode = { "n", "v" } },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
}
