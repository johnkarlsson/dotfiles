return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/lazydev.nvim", opts = {} },
    },
    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local keymap = vim.keymap

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings
                -- See `:help vim.lsp.*` for documentation
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                opts.desc = "Show documentation for what is under the cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        })

        -- rust-analyzer is installed via rustup, not Mason:
        --   rustup component add rust-analyzer
        vim.lsp.config('rust_analyzer', {
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                    cargo = {
                        allFeatures = true,
                    },
                    inlayHints = {
                        typeHints = { enable = true },
                        parameterHints = { enable = true },
                        chainingHints = { enable = true },
                    },
                },
            },
        })

        vim.lsp.inlay_hint.enable(true)

        -- Requires: ghcup install hls
        vim.lsp.config('hls', {
            capabilities = capabilities,
            filetypes = { 'haskell', 'lhaskell', 'cabal' },
        })

        -- Python: prefer the project venv's pyright-langserver over Mason's.
        -- Mason prepends its bin to PATH, so its pyright-langserver shadows the
        -- venv's and can lag the project's uv-locked pyright (e.g. Mason 1.1.406
        -- vs locked 1.1.409 disagree on TF 2.19's lazy `keras` export). Using the
        -- venv binary keeps the editor, `uv run pyright`, and CI in lockstep and
        -- binds the right site-packages; falls back to Mason's when there's no venv.
        local function pyright_cmd()
            local candidates = {}
            if vim.env.VIRTUAL_ENV then
                table.insert(candidates, vim.env.VIRTUAL_ENV .. "/bin/pyright-langserver")
            end
            table.insert(candidates, vim.fn.getcwd() .. "/.venv/bin/pyright-langserver")
            for _, bin in ipairs(candidates) do
                if vim.fn.executable(bin) == 1 then
                    return { bin, "--stdio" }
                end
            end
            return { "pyright-langserver", "--stdio" }
        end

        vim.lsp.config('pyright', {
            capabilities = capabilities,
            cmd = pyright_cmd(),
        })

        vim.lsp.enable('lua_ls')
        vim.lsp.enable('rust_analyzer')
        vim.lsp.enable('hls')
        vim.lsp.enable('pyright')
    end,
}
