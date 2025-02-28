return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
    },
    keys = function()
        local builtin = require("telescope.builtin")

        return {
            {
                "<leader>ff",
                builtin.find_files,
            },
            {
                "<leader>fg",
                builtin.live_grep,
            },
            {
                "<leader>fb",
                builtin.buffers,
            },
            {
                "<leader>fh",
                builtin.help_tags,
            },
            {
                "<leader>fr",
                builtin.oldfiles,
            },
            {
                "<leader>fc",
                builtin.commands,
            },
            {
                "<leader>fk",
                builtin.keymaps,
            },
            {
                "<leader>fd",
                builtin.diagnostics,
            },
        }
    end,
    config = function()
        local telescope = require("telescope")

        telescope.setup {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        }

        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
}
