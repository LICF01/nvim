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
		config = function()
			local animate = require("mini.animate")
			animate.setup()
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

	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function()
			local indentscope = require("mini.indentscope")
			indentscope.setup()
		end,
	},
	{
		"echasnovski/mini.completion",
		version = false,
		config = function()
			local completion = require("mini.completion")
			completion.setup()
		end,
	},
}
