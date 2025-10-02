return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cond = function() return not vim.g.vscode end,
    config = function()
        local nvimtree = require("nvim-tree")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.g.nvim_tree_respect_buf_cwd = 1

        nvimtree.setup({
            update_cwd = true,
            update_focused_file = { enable = true },
            view = {
                width = 35,
                relativenumber = false,
            },
            -- change folder arrow icons
            renderer = {
                highlight_git = true,
                indent_markers = {
                    enable = true,
                },
                icons = {
                    show = {
                        git = true,
                    }
                }
                -- icons = {
                --     glyphs = {
                --         folder = {
                --             arrow_closed = "", -- arrow when folder is closed
                --             arrow_open = "", -- arrow when folder is open
                --         },
                --     },
                -- },
            },
            actions = {
                change_dir = {
                  enable = true
                },
                -- disable window_picker for
                -- explorer to work well with window splits
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                custom = { ".DS_Store", ".git$" },
            },
            git = {
                enable = true,
                ignore = true,
            },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        -- keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR><cmd>lua require('nvim-tree.api').tree.expand_all()<CR>", { desc = "Toggle file explorer" })
        keymap.set("n", "<leader>eb", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer on current file" })
    end
}
