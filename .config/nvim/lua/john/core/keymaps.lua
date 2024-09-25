vim.g.mapleader = ","

local keymap = vim.keymap

keymap.set("n", "<leader> ", ":nohl<CR>", { desc = "Clear search highlights" })

-- keymap.set("n", "<leader>s", ":lua require('nvim-treesitter.incremental_selection').node_incremental()<CR>", { desc = "Treesitter Incremental Selection" })
-- keymap.set({"n", "v", "i"}, "<leader>s", ":lua require('nvim-treesitter.incremental_selection').node_incremental()<CR>", { desc = "Treesitter Incremental Selection" })
-- keymap.set("v", "<leader>s", ":lua require('nvim-treesitter.incremental_selection').init_selection()<CR>", { desc = "Treesitter Incremental Selection" })

-- vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua require("nvim-tree.api").tree.expand_all()<CR>', { noremap = true, silent = true })


