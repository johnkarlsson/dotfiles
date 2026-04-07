return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",

    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Case-sensitive prefix filter for all completion sources
        local function prefix_filter(entry, ctx)
            if not ctx.offset or not ctx.cursor_before_line then
                return true
            end
            local input = string.sub(ctx.cursor_before_line, ctx.offset)
            if input == "" then
                return true
            end
            local item = entry:get_completion_item()
            return vim.startswith(item.label, input)
        end

        -- Shell-style "complete as much as possible" using visible entries
        local function complete_common_prefix()
            local entries = cmp.get_entries()
            if #entries == 0 then return end
            if #entries == 1 then
                cmp.confirm({ select = true })
                return
            end
            -- Compute longest common prefix across visible entries
            local common = entries[1]:get_word()
            for i = 2, #entries do
                local w = entries[i]:get_word()
                local j = 0
                while j < #common and j < #w and common:byte(j + 1) == w:byte(j + 1) do
                    j = j + 1
                end
                common = common:sub(1, j)
                if common == "" then return end
            end
            -- Get what's already typed
            local cursor = vim.api.nvim_win_get_cursor(0)
            local line = vim.api.nvim_get_current_line()
            local col = cursor[2]
            local start = col
            while start > 0 and line:sub(start, start):match('[%w_]') do
                start = start - 1
            end
            local typed = line:sub(start + 1, col)
            if #common > #typed and vim.startswith(common, typed) then
                vim.fn.feedkeys(common:sub(#typed + 1), 'n')
            end
        end

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            matching = {
                disallow_fuzzy_matching = true,
                disallow_partial_matching = true,
                disallow_prefix_unmatching = true,
                disallow_fullfuzzy_matching = true,
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping(function()
                    if cmp.visible() then
                        complete_common_prefix()
                    else
                        cmp.complete()
                    end
                end, { 'i', 'c' }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", entry_filter = prefix_filter },
                { name = "nvim_lsp_signature_help" },
                { name = "luasnip", entry_filter = prefix_filter },
                { name = "path", entry_filter = prefix_filter },
            }, {
                { name = "buffer", entry_filter = prefix_filter },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                    mode = "symbol",
                    max_width = 50,
                    -- symbol_map = { Copilot = "C" },
                }),
            },
        })
    end,
}
