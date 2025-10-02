return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")

        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({})
        -- mason.setup({
        --     ui = {
        --         icons = {
        --         },
        --     },
        -- })

        mason_lspconfig.setup({
            -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
            ensure_installed = {
                "html",
                "pyright",
                "yamlls",
                "jsonls",
                "lua_ls",
                "rust_analyzer",
                "hls"
            },
        })

        local lspconfig = require("lspconfig")
        lspconfig.hls.setup {}
    end,
}
