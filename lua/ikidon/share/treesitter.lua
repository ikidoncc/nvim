return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "c",
            "cpp",
            "cmake",

            "python",

            "go",
            "gosum",
            "gowork",

            "lua",
            "luadoc",

            "vim",
            "json",
            "markdown",
            "markdown_inline",
        },
        auto_install = true,
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
