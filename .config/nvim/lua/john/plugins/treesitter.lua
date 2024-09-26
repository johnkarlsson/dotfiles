return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile", "VimEnter" },
    build = ":TSUpdate",
    -- https://github.com/vscode-neovim/vscode-neovim/issues/715#issuecomment-1831010197
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        -- https://github.com/nvim-treesitter/nvim-treesitter
        treesitter.setup({
            modules = {},
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            highlight = { enable = true, },
            indent = { enable = true },
            autotag = { enable = true, }, -- enable autotagging (w/ nvim-ts-autotag plugin)
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
                    -- init_selection = "<C-n>",
                    node_incremental = "<CR>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}
