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


vim.keymap.set("n", "<leader>tt", function()
  local line = vim.api.nvim_get_current_line()

  -- Match an existing checkbox like "- [ ] foo"
  local prefix, box, rest = line:match("^(%s*[-+*]%s*)%[([ xX]?)%]%s*(.*)$")
  if prefix then
    -- Toggle checkbox
    if box == "x" or box == "X" then
      vim.api.nvim_set_current_line(prefix .. "[ ] " .. rest)
    else
      vim.api.nvim_set_current_line(prefix .. "[x] " .. rest)
    end
  else
    -- Handle non-checkbox lines
    local indent = line:match("^(%s*)") or ""
    local content = line:sub(#indent + 1)

    -- Remove a single leading special char (*, -, +, #) and space if present
    content = content:gsub("^[-+*#]%s+", "", 1)

    vim.api.nvim_set_current_line(indent .. "- [ ] " .. content)
  end
end, { desc = "Toggle Markdown Checkbox" })

vim.keymap.set("n", "<leader>tT", function()
  local line = vim.api.nvim_get_current_line()
  -- Match "- [ ] ", "- [x] ", or "- [X] " with optional leading indent
  local indent, content = line:match("^(%s*)%- %[[ xX]%] (.*)$")
  if content then
    vim.api.nvim_set_current_line(indent .. content)
  end
end, { desc = "Remove Markdown Checkbox" })

-- keymap.set("n", "<leader>s", ":lua require('nvim-treesitter.incremental_selection').node_incremental()<CR>", { desc = "Treesitter Incremental Selection" })
-- keymap.set({"n", "v", "i"}, "<leader>s", ":lua require('nvim-treesitter.incremental_selection').node_incremental()<CR>", { desc = "Treesitter Incremental Selection" })
-- keymap.set("v", "<leader>s", ":lua require('nvim-treesitter.incremental_selection').init_selection()<CR>", { desc = "Treesitter Incremental Selection" })

-- vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua require("nvim-tree.api").tree.expand_all()<CR>', { noremap = true, silent = true })


