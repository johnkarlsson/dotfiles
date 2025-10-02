vim.g.mapleader = ","

local keymap = vim.keymap

keymap.set("n", "<leader> ", ":nohl<CR>:checktime<CR>", { desc = "Clear search highlights. Also checktime" })
keymap.set("n", "<leader>cc", ":!cursor %<CR><CR>", { desc = "Open current file in Cursor IDE" })

keymap.set('n', '<M-h>', '<C-w>h', { noremap = true, silent = true })
keymap.set('n', '<M-j>', '<C-w>j', { noremap = true, silent = true })
keymap.set('n', '<M-k>', '<C-w>k', { noremap = true, silent = true })
keymap.set('n', '<M-l>', '<C-w>l', { noremap = true, silent = true })
keymap.set('n', '<M-H>', '<C-w>H', { noremap = true, silent = true })
keymap.set('n', '<M-J>', '<C-w>J', { noremap = true, silent = true })
keymap.set('n', '<M-K>', '<C-w>K', { noremap = true, silent = true })
keymap.set('n', '<M-L>', '<C-w>L', { noremap = true, silent = true })

keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true })


vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-c>', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-c>', '<Esc>', { noremap = true })

-- keymap.set("n", "<leader>s", ":lua require('nvim-treesitter.incremental_selection').node_incremental()<CR>", { desc = "Treesitter Incremental Selection" })
-- keymap.set({"n", "v", "i"}, "<leader>s", ":lua require('nvim-treesitter.incremental_selection').node_incremental()<CR>", { desc = "Treesitter Incremental Selection" })
-- keymap.set("v", "<leader>s", ":lua require('nvim-treesitter.incremental_selection').init_selection()<CR>", { desc = "Treesitter Incremental Selection" })

-- vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua require("nvim-tree.api").tree.expand_all()<CR>', { noremap = true, silent = true })


