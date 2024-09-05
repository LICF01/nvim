local o = vim.o -- behaves like :set but with global scope
local opt = vim.opt -- behaves like :set

-- UI settings
opt.guifont = "JetBrains Mono:h10"
opt.termguicolors = true -- true color support
opt.cursorline = true -- highlight the current line
opt.number = true -- enable line numbers
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- lines of context
opt.sidescrolloff = 4 -- columns of context
opt.wrap = false -- disable line wrapping
opt.splitbelow = true -- split below instead of above
opt.splitright = true -- split right instead of left

-- Indentation
opt.expandtab = false -- convert tabs to spaces
opt.tabstop = 2 -- tab length to n spaces
opt.shiftwidth = 2 -- change the number of space characters inserted for indentation
opt.smartindent = true -- do smart autoindenting when starting a new line
opt.autoindent = true -- copy the indent of the previous line
opt.smarttab = true -- make tab behaviour smarter

-- Clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Search
opt.hlsearch = true -- highlight matching search
opt.ignorecase = true -- case insensitive on search..
opt.smartcase = true -- ..unless there's a capital letter

o.swapfile = false -- disable swap file
