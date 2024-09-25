return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        -- https://github.com/nvim-treesitter/nvim-treesitter
        treesitter.setup({
            modules = {},
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = {
                enable = true,
            },
            ensure_installed = {
                "json",
                "lua",
                "yaml",
                "markdown",
                "markdown_inline",
                "bash",
                "vim",
                "gitignore",
                "python",
                "html",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    -- node_incremental = "<leader>s",
                    -- scope_incremental = false,
                    -- node_decremental = "<leader><bs>",
                    -- init_selection = "<C-n>",
                    node_incremental = "<CR>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}

-- lua require('nvim-treesitter.incremental_selection').init_selection()
