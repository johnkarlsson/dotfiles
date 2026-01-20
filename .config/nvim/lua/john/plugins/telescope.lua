-- https://vimawesome.com/plugin/telescope-nvim-care-of-itself
return {
    "nvim-telescope/telescope.nvim",
    cond = function() return not vim.g.vscode end,
    -- branch = "0.1.x",
    branch = "master",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require('telescope.builtin')
        -- local utils = require("telescope.utils")
        -- local config = require('telescope.config')
        telescope.load_extension("live_grep_args")

        -- Return a list of unique files from the quickfix list
        local quickfix_files = function()
            local qflist = vim.fn.getqflist()
            local files = {}
            local seen = {}
            for k in pairs(qflist) do
                local path = vim.fn.bufname(qflist[k]["bufnr"])
                if not seen[path] then
                    files[#files + 1] = path
                    seen[path] = true
                end
            end
            table.sort(files)
            return files
        end

        -- Invoke live_grep on all files in quickfix
        local grep_on_quickfix = function()
            local paths = quickfix_files()
            require('telescope').extensions.live_grep_args.live_grep_args({ search_dirs = paths })
        end


        telescope.setup({
            pickers = {
                live_grep = {
                    additional_args = function(_)
                        return {"--hidden"}
                    end
                },
                find_files = {
                    hidden = true,
                    --cwd = vim.loop.cwd,
                }
            },
            defaults = {
                file_ignore_patterns = { "%.git/", "%.venv", "node_modules/" },
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
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        local keymap = vim.keymap

        keymap.set('n', '<leader>fG', grep_on_quickfix, {})
        keymap.set("n", "<leader>ft", function() builtin.live_grep { default_text = "- \\[ \\]" } end, { desc = "Search unchecked todos" })
        keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Fuzzy find files in quickfix list" })
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find open buffers" })
        keymap.set("n", "<leader>fh", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find symbols" })
        keymap.set("n", "<leader>fS", "<cmd>Telescope git_status<cr>", { desc = "Find git status" })
        -- keymap.set("n", "<leader>fc", "<cmd>Telescope command_history<cr>", { desc = "Find command history" })
        keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find normal mode keymappings" })
        keymap.set("v", "<leader>fc", builtin.git_bcommits_range, { noremap = true, silent = true, desc = "Find file commits in visual range" })
        keymap.set("n", "<leader>fc", builtin.git_bcommits, { noremap = true, silent = true, desc = "Find file commits in visual range" })
    end,
}
