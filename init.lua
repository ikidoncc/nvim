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

local keymap = vim.keymap.set
-- Save and exit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file"  })
keymap("n", "<leader>q", ":q<CR>", { desc = "Close file" })

-- Navigation between splits
keymap("n", "<C-h>", "<C-w>h", { desc = "Move left"  })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move right" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move down"  })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move up"    })

-- LSP Configurações Gerais
keymap("n", "<Leader>li", vim.cmd.LspInfo, { desc = "LSP Info" })
keymap("n", "<Leader>lI", function() require("null-ls").info() end, { desc = "None-ls Info" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover Document" })
keymap("n", "<Leader>lf", vim.lsp.buf.format, { desc = "Format Document" })
keymap("n", "<Leader>lS", ":AerialToggle<CR>", { desc = "Symbols Outline" })
keymap("n", "<Leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap("n", "<Leader>lD", vim.diagnostic.setqflist, { desc = "All Diagnostics" })
keymap("n", "<Leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
keymap("n", "<Leader>lA", vim.lsp.buf.code_action, { desc = "Source Code Actions" })
keymap("n", "<Leader>lh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
keymap("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename" })

-- Símbolos e Referências
keymap("n", "<Leader>ls", vim.lsp.buf.document_symbol, { desc = "Document Symbols" })
keymap("n", "<Leader>lG", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols" })
keymap("n", "<Leader>lR", vim.lsp.buf.references, { desc = "References" })

-- Navegação de Diagnósticos
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic Next" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostics Previous" })
keymap("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Diagnostic Error Next" })
keymap("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Diagnostic Error Previous" })
keymap("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Diagnostic Warning Next" })
keymap("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Diagnostic Warning Previous" })

-- Navegação de Símbolos
keymap("n", "]y", function() require("aerial").next() end, { desc = "Document Symbol Next" })
keymap("n", "[y", function() require("aerial").prev() end, { desc = "Document Symbol Previous" })

-- Navegação entre Definições e Declarações
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
keymap("n", "gy", vim.lsp.buf.type_definition, { desc = "Type Definition" })
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
keymap("n", "gI", vim.lsp.buf.implementation, { desc = "Implementation" })


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
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      ---@module "ibl"
      ---@type ibl.config
      opts = {},
    },
    {
      "rcarriga/nvim-notify",
      config = function()
        local notify = require("notify")

        notify.setup({
          stages = "fade_in_slide_out",
          timeout = 3000,
          render = "default",
        })

        vim.notify = notify
        vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          local level = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
          vim.notify(result.message, level, { title = client.name })
        end
      end
    },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls", "gopls" }
        })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")

        lspconfig.lua_ls.setup({})
        lspconfig.gopls.setup({})
      end,
    },
    {
      "rebelot/heirline.nvim",
      config = function()
        require("heirline").setup({})
      end,
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
        vim.keymap.set("n", "<Leader>fn", function()
          telescope.extensions.notify.notify()
        end, { desc = "Notifications" })
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

        telescope.load_extension("notify")
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
    {
      "stevearc/dressing.nvim",
      opts = {},
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
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
              },
            },
          },
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
          ensure_installed = { "lua", "vim", "vimdoc", "go" },
          auto_install  = true,
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
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
          },
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
