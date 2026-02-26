return {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
        keymap = {
            preset = "default",
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
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
