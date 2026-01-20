local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
end

local function autosave_if_git()
    if is_git_repo() then
        vim.cmd("silent! write")
    end
end

-- Autosave when leaving insert mode - if in a git repo
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
    pattern = "*",
    callback = autosave_if_git,
})


-- CD to git root on startup
local root = vim.fn.trim(vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'))
if root ~= '' then vim.cmd('cd ' .. root) end
