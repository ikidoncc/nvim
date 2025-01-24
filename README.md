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
- [x] [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) for an elegant bar status
