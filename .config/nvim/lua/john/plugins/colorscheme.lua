return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        -- local bg = "#011628"
        local bg_dark = "#011423"
        -- local bg_highlight = "#143652"
        local bg_search = "#CC5C5C"
        -- local bg_visual = "#275378"
        local fg = "#CBE0F0"
        -- local fg_dark = "#B4D0E9"
        local fg_gutter = "#627E97"
        -- local border = "#547998"

        require("tokyonight").setup({
            style = "night",
            on_colors = function(colors)
                colors.fg = fg
                -- colors.bg = bg
                -- colors.bg_dark = bg_dark
                colors.bg_float = bg_dark
                -- colors.bg_highlight = bg_highlight
                -- colors.bg_popup = bg_dark
                colors.bg_search = bg_search
                -- colors.bg_sidebar = bg_dark
                -- colors.bg_visual = bg_visual
                -- colors.border = border
                -- colors.fg_dark = fg_dark
                -- colors.fg_float = fg
                colors.fg_gutter = fg_gutter
                -- colors.fg_sidebar = fg_dark
                colors.bg_statusline = "none"
                -- colors.bg_search = "none"
                colors.bg_sidebar = "none"
                colors.bg = "none"
             end
        })

        vim.cmd("colorscheme tokyonight")

        vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#192838" })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#FFEE8C", fg=000000, })
    end
}
