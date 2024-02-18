-- map the leader key
vim.g.mapleader = " " -- Sets the leader key

local keymap = vim.keymap

-- remaps Esc key to
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- buffers
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bN", "<cmd>BufferLineMoveNext<cr>", { desc = "Move to next pos" })
keymap.set("n", "<leader>bP", "<cmd>BufferLineMovePrev<cr>", { desc = "Next to prev pos" })
keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close all left" })
keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<cr>", { desc = "Close all right" })
keymap.set("n", "<leader>bca", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close all but current" })
keymap.set("n", "<leader>bcp", "<cmd>BufferLinePickClose<cr>", { desc = "Pick and close" })
keymap.set("n", "<leader>bf", "<cmd>BufferLinePick<cr>", { desc = "Pick" })
keymap.set("n", "<leader>bF", "<cmd>BufferLinePickClose<cr>", { desc = "Pick and close" })
keymap.set("n", "<leader>bP", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin current" })
keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>")
keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>")
keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>")
keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>")
keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>")
keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>")
keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>")
keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>")
keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>")

-- save file
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- quit
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
	keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
