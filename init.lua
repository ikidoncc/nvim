vim.opt.number          = true
vim.opt.relativenumber	= true
vim.opt.shiftwidth      = 2
vim.opt.tabstop		      = 2
vim.opt.expandtab	      = true
vim.opt.cursorline	    = true
vim.opt.timeoutlen      = 1000
vim.opt.swapfile        = false
vim.opt.backup          = false
vim.opt.incsearch       = true
vim.opt.termguicolors   = true
vim.opt.scrolloff       = 15

vim.g.mapleader         = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { 
      "rose-pine/neovim", 
      name = "rose-pine",
      config = function()
        vim.cmd("colorscheme rose-pine-moon")
      end
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = {
        "nvim-lua/plenary.nvim"
      },
      config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        
        telescope.setup({
          defaults = {
            mappings = {
              i = { ["<esc>"] = actions.close },
            },
          },
          extensions = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        })

        vim.keymap.set("n", "<Leader><CR>", builtin.resume, { desc = "Resume previous search" })
        vim.keymap.set("n", "<Leader>f'", builtin.marks, { desc = "Marks" })
        vim.keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<Leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Word at cursor" })
        vim.keymap.set("n", "<Leader>fC", builtin.commands, { desc = "Commands" })
        vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<Leader>fF", function()
          builtin.find_files({ hidden = true })
        end, { desc = "Find files (include hidden files)" })
        vim.keymap.set("n", "<Leader>fh", builtin.help_tags, { desc = "Help Tags" })
        vim.keymap.set("n", "<Leader>fk", builtin.keymaps, { desc = "Keymaps" })
        vim.keymap.set("n", "<Leader>fm", builtin.man_pages, { desc = "Man Pages" })
        --vim.keymap.set("n", "<Leader>fn", builtin.notifications, { desc = "Notifications" })
        vim.keymap.set("n", "<Leader>fo", builtin.oldfiles, { desc = "Old Files" })
        vim.keymap.set("n", "<Leader>fr", builtin.registers, { desc = "Registers" })
        vim.keymap.set("n", "<Leader>ft", builtin.colorscheme, { desc = "Colorschemes" })
        vim.keymap.set("n", "<Leader>fw", builtin.live_grep, { desc = "Live Grep" })
        vim.keymap.set("n", "<Leader>fW", function()
          builtin.live_grep({ additional_args = function() return { "--hidden" } end })
        end, { desc = "Live Grep (include hidden files)" })
        vim.keymap.set("n", "<Leader>gb", builtin.git_branches, { desc = "Git Branches" })
        vim.keymap.set("n", "<Leader>gc", builtin.git_commits, { desc = "Git Commits (repository)" })
        vim.keymap.set("n", "<Leader>gC", builtin.git_bcommits, { desc = "Git Commits (current file)" })
        vim.keymap.set("n", "<Leader>gt", builtin.git_status, { desc = "Git Status" })
        vim.keymap.set("n", "<Leader>ls", builtin.lsp_document_symbols, { desc = "LSP Symbols" })
        vim.keymap.set("n", "<Leader>lG", builtin.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })
      end
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
    },
    {
      "stevearc/dressing.nvim",
      opts = {},
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim",
      },
      config = function()
        require("neo-tree").setup({
          popup_border_style = "rounded",
          enable_git_status = true,
          enable_diagnostics = true,
          source_selector = {
            winbar = false,
            statusline = false,
          },
          filesystem = {
            filtered_items = {
              hide_dotfiles = false,
              hide_by_name = {
                ".git",
                ".DS_Store"
              }
            } 
          }
        })

        vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree", noremap = true, silent = true })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
          ensure_installed = { "lua", "vim", "vimdoc", },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true }
        })
      end
    },
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
        local toggleterm = require("toggleterm")

        toggleterm.setup({
          size = 20,
          hide_numbers = true,
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          shell = vim.o.shell,
          direction = "float",
          float_opts = {
            border = "rounded"
          }
        })

        local Terminal = require("toggleterm.terminal").Terminal

        local function open_float()
          local float_term = Terminal:new({ direction = "float" })
          float_term:toggle()
        end

        local function open_horizontal()
          local horizontal_term = Terminal:new({ direction = "horizontal" })
          horizontal_term:toggle()
        end

        local function open_vertical()
          local vertical_term = Terminal:new({ direction = "vertical" })
          vertical_term:toggle()
        end

        vim.keymap.set("n", "<Leader>tf", open_float, { desc = "Open Floating Terminal" })
        vim.keymap.set("n", "<Leader>th", open_horizontal, { desc = "Open Horizontal Terminal" })
        vim.keymap.set("n", "<Leader>tv", open_vertical, { desc = "Open Vertical Terminal" })
      end,
    },
  },
  checker = { enabled = true },
})
