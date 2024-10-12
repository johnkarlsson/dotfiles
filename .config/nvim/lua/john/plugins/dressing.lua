return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    cond = function() return not vim.g.vscode end,
}
