-- =============================
-- Vim General Settings
-- =============================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.timeoutlen = 1000
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 15

-- Defines the leader as space
vim.g.mapleader = " "

-- ==========================
-- Keyboard Mappings
-- ==========================
local keymap = vim.keymap.set

-- Save and exit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file", silent = true })
keymap("n", "<leader>q", ":q<CR>", { desc = "Close file", silent = true })

-- Navigation between Splits
keymap("n", "<C-h>", "<C-w>h", { desc = "Move left" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move right" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move down" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move up" })

-- ==========================
-- LSP Settings
-- ==========================
-- General Shortcuts for LSP
keymap("n", "<Leader>li", vim.cmd.LspInfo, { desc = "LSP Info" })
keymap("n", "<Leader>lI", ":NullLsInfo<CR>", { desc = "None-ls Info", silent = true })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover Document" })
keymap("n", "<Leader>lf", vim.lsp.buf.format, { desc = "Format Document" })
keymap("n", "<Leader>lS", ":AerialToggle<CR>", { desc = "Symbols Outline", silent = true })
keymap("n", "<Leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap("n", "<Leader>lD", vim.diagnostic.setqflist, { desc = "All Diagnostics" })
keymap("n", "<Leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
keymap("n", "<Leader>lA", vim.lsp.buf.code_action, { desc = "Source Code Actions" })
keymap("n", "<Leader>lh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
keymap("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename" })

-- Navigation between Symbols and References
keymap("n", "<Leader>ls", vim.lsp.buf.document_symbol, { desc = "Document Symbols" })
keymap("n", "<Leader>lG", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols" })
keymap("n", "<Leader>lR", vim.lsp.buf.references, { desc = "References" })

-- Navigation between Diagnostics
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic Next" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostics Previous" })
keymap("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Diagnostic Error Next" })
keymap("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Diagnostic Error Previous" })
keymap("n", "]w", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Diagnostic Warning Next" })
keymap("n", "[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Diagnostic Warning Previous" })

-- Navigation between Symbols
keymap("n", "]y", function()
  require("aerial").next()
end, { desc = "Document Symbol Next" })
keymap("n", "[y", function()
  require("aerial").prev()
end, { desc = "Document Symbol Previous" })

-- Navigation between Declarations and References
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
keymap("n", "gy", vim.lsp.buf.type_definition, { desc = "Type Definition" })
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
keymap("n", "gI", vim.lsp.buf.implementation, { desc = "Implementation" })

-- ==========================
-- Lazy.nvim Configuration
-- ==========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ==========================
-- Plugin Configuration
-- ==========================
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
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup()
      end,
    },
    {
      "hrsh7th/cmp-nvim-lsp",
    },
    {
      "hrsh7th/cmp-cmdline",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
    },
    {
      "hrsh7th/nvim-cmp",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        local cmp = require("cmp")

        cmp.setup({
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-u>"] = cmp.mapping.scroll_docs(4),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
          }, {
            { name = "buffer" },
          }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            {
              name = "cmdline",
              option = {
                ignore_cmds = { "Man", "!" },
              },
            },
          }),
          matching = { disallow_symbol_nonprefix_matching = false },
        })
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
        },
      },
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {},
    },
    {
      "stevearc/aerial.nvim",
      opts = {},
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      opts = {
        cmdline = {
          view = "cmdline_popup",
        },
        popupmenu = {
          enable = true,
          backend = "nui",
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
        },
      },
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
      end,
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
          ensure_installed = {
            -- Lua
            "lua_ls",

            -- GoLang
            "gopls",
          },
        })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.lua_ls.setup({
          cabilities = capabilities,
        })
        lspconfig.gopls.setup({
          cabilities = capabilities,
        })
      end,
    },
    {
      "nvimtools/none-ls.nvim",
      config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
          sources = {
            -- Lua
            null_ls.builtins.formatting.stylua,
            --null_ls.builtins.diagnostics.selene,

            -- GoLang
            null_ls.builtins.formatting.goimports,
            null_ls.builtins.formatting.goimports_reviser,
            null_ls.builtins.formatting.golines,
            null_ls.builtins.code_actions.gomodifytags,
            null_ls.builtins.diagnostics.revive,
            null_ls.builtins.diagnostics.golangci_lint,
            null_ls.builtins.diagnostics.staticcheck,

            -- Others
            null_ls.builtins.completion.spell,
            null_ls.builtins.code_actions.gitsigns,
          },
        })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = {
        "nvim-lua/plenary.nvim",
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
          },
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
          builtin.live_grep({
            additional_args = function()
              return { "--hidden" }
            end,
          })
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
                ".DS_Store",
              },
            },
          },
        })

        vim.keymap.set(
          "n",
          "<Leader>e",
          ":Neotree toggle<CR>",
          { desc = "Toggle Neo-tree", noremap = true, silent = true }
        )
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
          ensure_installed = { "lua", "vim", "vimdoc", "go" },
          auto_install = true,
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
          size = function(self)
            local size_map = {
              vertical = 65,
              horizontal = 20,
              default = 20,
            }

            if self.direction == "vertical" or self.direction == "horizontal" then
              return size_map[self.direction]
            end

            return size_map["default"]
          end,
          hide_numbers = true,
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          shell = vim.o.shell,
          direction = "float",
          float_opts = {
            border = "rounded",
          },
          responsiveness = {
            horizontal_breakpoint = 135,
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
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin",
      },
    },
  },
})
