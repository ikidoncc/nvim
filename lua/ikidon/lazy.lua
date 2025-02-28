-- Define the path where Lazy.nvim will be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if Lazy.nvim is not installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- Repository URL for Lazy.nvim
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    -- Clone Lazy.nvim from GitHub
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

    -- Check if the git command failed
    if vim.v.shell_error ~= 0 then
        -- Display an error message in Neovim
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})

        -- Wait for user input before exiting
        vim.fn.getchar()
        os.exit(1)
    end
end

-- Prepend Lazy.nvim's path to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Load Lazy.nvim and set up the plugin configuration from "ikidon.share"
require("lazy").setup("ikidon.share")
