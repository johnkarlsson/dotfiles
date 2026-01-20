vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.number = true

opt.autoread = true
-- Set up autocommands to trigger checktime
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained" }, {
  group = vim.api.nvim_create_augroup('AutoReload', {}),
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd('checktime')
    end
  end
})
opt.updatetime = 1
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

if vim.g.vscode then
  vim.g.mapleader = ","
  local vscode = require('vscode')
  local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, function() vscode.call(rhs) end, { noremap = true, silent = true })
  end
  map('n', '<leader>hr', 'git.revertSelectedRanges')

  map('n', 'zM', 'editor.foldAll') -- Fold all
  map('n', 'zR', 'editor.unfoldAll') -- Unfold all
  map('n', 'zc', 'editor.fold') -- Fold (at cursor)
  map('n', 'zC', 'editor.foldRecursively') -- Fold recursively (at cursor, and inside)
  map('n', 'zo', 'editor.unfold') -- Unfold (at cursor)
  map('n', 'zO', 'editor.unfoldRecursively') -- Unfold recursively (at cursor, and inside)
  map('n', 'za', 'editor.toggleFold') -- Toggle fold (at cursor)
  map('n', 'zm2', 'editor.foldLevel2') -- Fold level 2
  map('n', 'zm3', 'editor.foldLevel3') -- Fold level 3
  map('n', 'zm/', 'editor.foldAllBlockComments') -- Fold all block comments
  -- Git navigation and operations
  map('n', ']h', 'workbench.action.editor.nextChange')
  map('n', '[h', 'workbench.action.editor.previousChange')
  map('n', '<leader>hr', 'git.revertSelectedRanges')
  map('n', '<leader>hb', 'git.blame.toggleEditorDecoration')
  map('n', '<leader>hs', 'git.stageSelectedRanges')
  map('n', '<leader>hR', 'git.clean')
  map('n', '<leader>hu', 'git.unstage')
  map('n', '<leader>hS', 'git.stageAll')
  map('n', '<leader>hd', 'git.openChange')
  --
  --
  map('n', 'gR', 'references-view.findReferences')
  map('n', 'gr', 'editor.action.referenceSearch.trigger')
  map('n', 'gD', 'editor.action.revealDefinition')
  map('n', 'gd', 'editor.action.peekDefinition')

  map('n', '[d', 'editor.action.marker.next')
  map('n', ']d', 'editor.action.marker.prev')

end

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")  -- use system clipboard as default register

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 5
vim.opt.foldminlines = 1

-- Use LSP folding when available, otherwise keep treesitter
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.foldingRangeProvider then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

vim.g.omni_sql_default_compl_type  = 'syntax'
vim.g.ftplugin_sql_omni_key = '<nop>'
