return {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
        require("crates").setup({
            completion = {
                cmp = {
                    enabled = true,
                },
            },
        })
    end,
}
