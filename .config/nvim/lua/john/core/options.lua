vim.cmd("let g:netrw_liststyle = 3")

-- Map MDX files to markdown filetype
vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})

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

-- Enable text wrapping for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true  -- wrap at word boundaries
    vim.opt_local.number = false
  end,
})

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

-- Custom foldtext: prefix in FoldedPrefix highlight, content retains treesitter syntax colors
function _G.custom_foldtext()
    local start = vim.v.foldstart
    local line_count = vim.v.foldend - start + 1
    local line = vim.fn.getline(start)
    local prefix = vim.v.folddashes .. " " .. line_count .. " lines: "

    local result = { { prefix, "FoldedPrefix" } }

    if #line == 0 then
        return result
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local row = start - 1
    local prev_hl = nil
    local chunk = ""

    for i = 0, #line - 1 do
        local hl = nil
        local best_priority = -1
        local ok, info = pcall(vim.inspect_pos, bufnr, row, i)
        if ok then
            for _, ts in ipairs(info.treesitter) do
                local pri = ts.priority or 100
                if pri > best_priority then
                    best_priority = pri
                    hl = ts.hl_group
                end
            end
        end

        if hl ~= prev_hl then
            if chunk ~= "" then
                table.insert(result, { chunk, prev_hl })
            end
            chunk = line:sub(i + 1, i + 1)
            prev_hl = hl
        else
            chunk = chunk .. line:sub(i + 1, i + 1)
        end
    end

    if chunk ~= "" then
        table.insert(result, { chunk, prev_hl })
    end

    return result
end
vim.opt.foldtext = "v:lua.custom_foldtext()"

-- Use LSP folding when available, but not for markdown (treesitter folds are better)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        if vim.bo[args.buf].filetype == "markdown" then
            return
        end
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.foldingRangeProvider then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

vim.g.omni_sql_default_compl_type  = 'syntax'
vim.g.ftplugin_sql_omni_key = '<nop>'
