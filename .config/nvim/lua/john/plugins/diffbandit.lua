return {
    "CoreyKaylor/diffbandit.nvim",
    cond = function() return not vim.g.vscode end,
    cmd = {
        "DiffBandit",
        "DiffBanditBuffers",
        "DiffBanditFolderDiff",
        "DiffBanditGit",
        "DiffBanditGitCurrent",
        "DiffBanditCommitPanel",
        "DiffBanditGitMenu",
        "DiffBanditGitLog",
        "DiffBanditGitCommit",
        "DiffBanditGitCompare",
        "DiffBanditGitCheckout",
        "DiffBanditMerge",
        "DiffBanditLaunch",
    },
    keys = {
        { "<leader>gd", "<cmd>DiffBanditGitCurrent<cr>", desc = "Diff current file against git" },
    },
    config = function()
        require("diffbandit").setup()
    end,
}
