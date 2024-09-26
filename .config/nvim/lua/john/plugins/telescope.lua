-- https://vimawesome.com/plugin/telescope-nvim-care-of-itself
return {
    "nvim-telescope/telescope.nvim",
    cond = function() return not vim.g.vscode end,
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        -- local utils = require("telescope.utils")

        telescope.setup({
            pickers = {
                find_files = {
                    hidden = true,
                    --cwd = vim.loop.cwd,
                }
            },
            defaults = {
                layout_strategy = "vertical",
                layout_config = {
                    preview_height = 0.7,
                    vertical = { size = { width = "95%", height = "95%" } }
                },
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        local keymap = vim.keymap

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find open buffers" })
        keymap.set("n", "<leader>fh", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope search_history<cr>", { desc = "Find search history" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope command_history<cr>", { desc = "Find command history" })
        keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find normal mode keymappings" })
    end,
}
