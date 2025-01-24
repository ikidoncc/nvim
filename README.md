# Neovim

Neovim settings

## Keymaps

**LSP**
| Descrição                    | Command           |
|------------------------------|-------------------|
| LSP Info                     | `<Leader>li`      |
| None-ls Info                 | `<Leader>lI`      |
| Hover Document               | `K`               |
| Format Document              | `<Leader>lf`      |
| Symbols Outline              | `<Leader>lS`      |
| Line Diagnostics             | `<Leader>ld`      |
| All Diagnostics              | `<Leader>lD`      |
| Code Actions                 | `<Leader>la`      |
| Source Code Actions          | `<Leader>lA`      |
| Signature Help               | `<Leader>lh`      |
| Rename                       | `<Leader>lr`      |
| Document Symbols             | `<Leader>ls`      |
| Workspace Symbols            | `<Leader>lG`      |
| Diagnostic Next              | `]d`              |
| Diagnostics Previous         | `[d`              | 
| Diagnostic Error Next        | `]e`              |
| Diagnostic Error Previous    | `[e`              |
| Diagnostic Warning Next      | `]w`              |
| Diagnostic Warning Previous  | `[w`              |
| Document Symbol Next         | `]y`              |
| Document Symbol Previous     | `[y`              |
| Declaration                  | `gD`              |
| Type Definition               | `gy`              |
| Definition                    | `gd`              |
| Implementation               | `gI`              |
| References                   | `<Leader>lR`      |

**Navigation**
|    Description   |    Command    |  
|------------------|---------------|
| Move left        |  Ctrl + `h`   |
| Move right       |  Ctrl + `l`   |
| Move down        |  Ctrl + `j`   |
| Move up          |  Ctrl + `k`   |

**Files**
|    Description   |    Command    |  
|------------------|---------------|
| Save             |  Leader + `w` |
| Close            |  Leader + `q` |

**Neotree**
|    Description   |    Command    |  
|------------------|---------------|
| Neotree toggle   |  Leader + `e` |

**Telescope**
|             Description            |        Command       |  
|------------------------------------|----------------------|  
| Resume previous search             |   Leader + `<CR>`    |  
| Marks                              |   Leader + `f'`      |  
| Buffers                             |   Leader + `fb`      |  
| Word at cursor                     |   Leader + `fc`      |  
| Commands                           |   Leader + `fC`      |  
| Find files                          |   Leader + `ff`       |  
| Find files (include hidden files)    |   Leader + `fF`      |  
| Help Tags                          |   Leader + `fh`      |  
| Keymaps                            |   Leader + `fk`      |  
| Man Pages                          |   Leader + `fm`      |  
| Notifications                       |   Leader + `fn`      |  
| Old Files                          |   Leader + `fo`      |  
| Registers                          |   Leader + `fr`      |  
| Colorschemes                       |   Leader + `ft`      |  
| Live Grep                          |   Leader + `fw`      |  
| Live Grep (include hidden files)    |   Leader + `fW`      |  
| Git Branches                       |   Leader + `gb`      |  
| Git Commits (repository)           |   Leader + `gc`      |  
| Git Commits (current file)          |   Leader + `gC`      |  
| Git Status                         |   Leader + `gt`      |  
| LSP Symbols                        |   Leader + `ls`      |  
| LSP Workspace Symbols              |   Leader + `lG`      |  

**Terminal**
|        Description       |      Command     |
|--------------------------|------------------|
| Open Floating Terminal   |   Leader + `tf`  |
| Open Horizontal Terminal |   Leader + `th`  |
| Open Vertical Terminal	 |   Leader + `tv`  |


## Features

- [x] [rose-pine/neovim](https://github.com/rose-pine/neovim) for a beautiful theme.  
- [x] [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) for a sleek and customizable statusline.  
- [x] [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) for seamless LSP-based autocompletion.  
- [x] [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) for efficient command-line autocompletion.  
- [x] [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) for buffer-based autocompletion.  
- [x] [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) for filesystem path autocompletion.  
- [x] [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) for a powerful snippet engine.  
- [x] [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) for LuaSnip integration with nvim-cmp.  
- [x] [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) for a collection of ready-to-use snippets.  
- [x] [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for powerful and extensible autocompletion.  
- [x] [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for Git integration in the sign column.  
- [x] [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) for adding indentation guides.  
- [x] [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim) for an outline window for code structure.  
- [x] [folke/noice.nvim](https://github.com/folke/noice.nvim) for a better notification and command UI.  
- [x] [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for advanced syntax highlighting and parsing.  
- [x] [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) for adding file icons.  
- [x] [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) for UI component utilities.  
- [x] [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) for customizable notifications.  
- [x] [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) for managing external tools and LSP servers.  
- [x] [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) for easy LSP server configuration with Mason.  
- [x] [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for quick and easy LSP configuration.  
- [x] [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) for injecting external tools into the LSP.  
- [x] [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for fuzzy finding and file navigation.  
- [x] [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) as a dependency for various plugins.  
- [x] [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) for faster fuzzy searching in Telescope.  
- [x] [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) for improved UI components like input and select.  
- [x] [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) for automatically closing pairs like brackets.  
- [x] [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) for a modern and flexible file explorer.  
- [x] [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) for managing terminal windows easily.  
