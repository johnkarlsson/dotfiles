return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
        require("nvim-treesitter.configs").setup({
            modules = {},
            ensure_installed = {},
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                        ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                        ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                        ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                        ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                        ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

                        ["a/"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
                        ["i/"] = { query = "@comment.inner", desc = "Select inner part of a comment" },

                        ["ar"] = { query = "@return.outer", desc = "Select outer part of return statement" },
                        ["ir"] = { query = "@return.inner", desc = "Select inner part of return statement" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>sna"] = "@parameter.inner",
                        ["<leader>snm"] = "@function.outer",
                    },
                    swap_previous = {
                        ["<leader>spa"] = "@parameter.inner",
                        ["<leader>spm"] = "@function.outer",
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
                        ["]a"] = { query = "@parameter.inner", desc = "Next parameter/argument start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                        ["]r"] = { query = "@return.outer", desc = "Next return start" },
                        ["]/"] = { query = "@comment.outer", desc = "Next comment start" },
                    },
                    goto_next_end = {
                        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
                        ["]A"] = { query = "@parameter.inner", desc = "Next parameter/argument end" },
                        ["]C"] = { query = "@class.outer", desc = "Next class end" },
                        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                        ["]R"] = { query = "@return.outer", desc = "Next return end" },
                        ["]?"] = { query = "@comment.outer", desc = "Next comment end" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@call.outer", desc = "Previous function call start" },
                        ["[m"] = { query = "@function.outer", desc = "Previous method/function def start" },
                        ["[a"] = { query = "@parameter.inner", desc = "Previous parameter/argument start" },
                        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
                        ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
                        ["[r"] = { query = "@return.outer", desc = "Previous return start" },
                        ["[/"] = { query = "@comment.outer", desc = "Previous comment start" },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = "@call.outer", desc = "Previous function call end" },
                        ["[M"] = { query = "@function.outer", desc = "Previous method/function def end" },
                        ["[A"] = { query = "@parameter.inner", desc = "Previous parameter/argument end" },
                        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                        ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
                        ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
                        ["[R"] = { query = "@return.outer", desc = "Previous return end" },
                        ["[?"] = { query = "@comment.outer", desc = "Previous comment end" },
                    },
                }
            },
        })

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- make ;, work for movements above
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
        -- fix broken ;, for fFtT
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
