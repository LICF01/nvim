local g = vim.g -- vim.g sets global variables
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- map the leader key
g.mapleader = " " -- Sets the leader key

-- remaps Esc key to
map("i", "jk", "<Esc>", opts)

