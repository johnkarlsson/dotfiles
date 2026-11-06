-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
-- Requires `tree-sitter` CLI (brew install tree-sitter-cli).
local ensure_installed = {
    "json",
    "lua",
    "yaml",
    "markdown",
    "markdown_inline",
    "bash",
    "vim",
    "gitignore",
    "python",
    "html",
    "rust",
    "haskell",
    "mermaid",
}

local highlight_disable = { "mermaid" }

local function attach(buf, lang)
    if not vim.tbl_contains(highlight_disable, lang) then
        vim.treesitter.start(buf, lang)
    end
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    -- Incremental selection via the built-in `an`/`in` (Neovim 0.12+).
    -- Buffer-local so <CR> keeps its meaning in e.g. quickfix windows.
    vim.keymap.set("n", "<CR>", "van", { buffer = buf, remap = true, desc = "Start treesitter selection" })
    vim.keymap.set("x", "<CR>", "an", { buffer = buf, remap = true, desc = "Expand treesitter selection" })
    vim.keymap.set("x", "<BS>", "in", { buffer = buf, remap = true, desc = "Shrink treesitter selection" })
end

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    -- https://github.com/vscode-neovim/vscode-neovim/issues/715#issuecomment-1831010197
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.install(ensure_installed)
        require("nvim-ts-autotag").setup()

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("john_treesitter", { clear = true }),
            callback = function(args)
                local buf = args.buf
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then
                    return
                end
                if vim.treesitter.language.add(lang) then
                    attach(buf, lang)
                elseif vim.tbl_contains(treesitter.get_available(), lang) then
                    -- Auto-install missing parsers, then attach once ready
                    treesitter.install(lang):await(function()
                        vim.schedule(function()
                            if vim.api.nvim_buf_is_valid(buf) and vim.treesitter.language.add(lang) then
                                attach(buf, lang)
                            end
                        end)
                    end)
                end
            end,
        })
    end,
}
