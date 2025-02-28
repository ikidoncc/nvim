local opt = vim.opt

-- Enable line numbers
opt.number = true

-- Show relative line numbers
opt.relativenumber = true

-- Set indentation width to 4 spaces
opt.shiftwidth = 4

-- Set the number of spaces per tab
opt.tabstop = 4

-- Convert tabs to spaces
opt.expandtab = true

-- Highlight the current line
opt.cursorline = true

-- Set the timeout length for mapped sequences (in milliseconds)
opt.timeoutlen = 1000

-- Enable incremental search (show matches while typing)
opt.incsearch = true

-- Enable true color support for better visuals
opt.termguicolors = true

-- Keep 20 lines visible above and below the cursor when scrolling
opt.scrolloff = 20

-- Enable smart case search: case insensitive unless uppercase is used
opt.smartcase = true
