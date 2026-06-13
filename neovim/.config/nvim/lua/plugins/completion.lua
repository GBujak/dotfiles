return {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        keymap = {
            preset = "default",
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        completion = {
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },
            menu = {
                border = "single",
            },
            documentation = {
                window = {
                    border = "single",
                },
            },
        },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
        signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
}
