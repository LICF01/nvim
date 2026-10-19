-- Loads on the first press of one of these keys, so it costs nothing at startup.
local function nav(fn)
	return function()
		require("nvim-tmux-navigation")[fn]()
	end
end

return {
	"alexghergh/nvim-tmux-navigation",
	keys = {
		{ "<C-h>", nav("NvimTmuxNavigateLeft"), mode = "n", desc = "Move to left pane" },
		{ "<C-j>", nav("NvimTmuxNavigateDown"), mode = "n", desc = "Move to lower pane" },
		{ "<C-k>", nav("NvimTmuxNavigateUp"), mode = "n", desc = "Move to upper pane" },
		{ "<C-l>", nav("NvimTmuxNavigateRight"), mode = "n", desc = "Move to right pane" },
		{ "<C-\\>", nav("NvimTmuxNavigateLastActive"), mode = "n", desc = "Last active pane" },
		{ "<C-Space>", nav("NvimTmuxNavigateNext"), mode = "n", desc = "Next pane" },
	},
	config = function()
		require("nvim-tmux-navigation").setup({
			disable_when_zoomed = true, -- defaults to false
		})
	end,
}
