return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cond = function() return not vim.g.vscode end,
    event = "VeryLazy",
    opts = {
        mode = "cursor",
        max_lines = 0,
        multiline_threshold = 3,
    },
}
