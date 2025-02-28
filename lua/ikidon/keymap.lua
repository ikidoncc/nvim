local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set the leader key to space (" ")
vim.g.mapleader = " "

-- Save and quit key mappings
set("n", "<leader>w", ":w<CR>", opts)  -- Save file
set("n", "<leader>W", ":wa<CR>", opts)  -- Save all file
set("n", "<leader>q", ":q<CR>", opts)  -- Quit Neovim
set("n", "<leader>Q", ":q!<CR>", opts)  -- Quit Forced Neovim
set("n", "<leader>e", ":Ex<CR>", opts) -- Open file explorer (netrw)

-- Remap arrow keys in insert mode for navigation
set("i", "<C-h>", "<Left>", opts)  -- Move left
set("i", "<C-l>", "<Right>", opts) -- Move right
set("i", "<C-j>", "<Down>", opts)  -- Move down
set("i", "<C-k>", "<Up>", opts)    -- Move up

-- Window navigation key mappings
set("n", "<C-h>", "<C-w>h", opts) -- Move to left window
set("n", "<C-l>", "<C-w>l", opts) -- Move to right window
set("n", "<C-j>", "<C-w>j", opts) -- Move to bottom window
set("n", "<C-k>", "<C-w>k", opts) -- Move to top window

-- Split key maps
set("n", "<leader>sh", ":split<CR>", opts) -- Split to horizontal
set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split to vertical
