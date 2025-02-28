return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        local mason = require("mason")
        local masonlsp = require("mason-lspconfig")

        mason.setup()
        masonlsp.setup({
            ensure_installed = {
                "html",
                "cssls",

                "clangd",
                "lua_ls",
                "pyright",

                "gopls",

                "cmake",
                "marksman",
                "yamlls",
                "taplo",
            },
        })

        local lspconfig = require("lspconfig")
        local servers = {
            html = {},
            cssls = {},

            clangd = {},
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            },
            gopls = {},
            pyright = {},

            cmake = {},
            marksman = {},
            yamlls = {},
            taplo = {},
        }


        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local on_attach = function(_, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            local set = vim.keymap.set

            set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            set("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            set("n", "<leader>lk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
            set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            set("n", "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        end

        for lsp, config in pairs(servers) do
            config.on_attach = on_attach
            config.capabilities = capabilities
            lspconfig[lsp].setup(config)
        end
    end,
}
