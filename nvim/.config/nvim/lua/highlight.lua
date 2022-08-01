local treesitter_configs = require "nvim-treesitter.configs"
treesitter_configs.setup{
    ensure_installed = {
        "svelte",
        "css",
        "typescript",
    },
    highlight = {
        enable = true,
    },
}
