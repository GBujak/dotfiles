return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "saghen/blink.cmp",
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            })

            local java_formatter = vim.fn.stdpath("config") .. "/formatters/java-kotlin-like.xml"
            vim.lsp.config("jdtls", {
                capabilities = capabilities,
                settings = {
                    java = {
                        format = {
                            enabled = true,
                            settings = {
                                url = vim.uri_from_fname(java_formatter),
                                profile = "KotlinLike",
                            },
                        },
                        import = {
                            gradle = {
                                wrapper = {
                                    enabled = false,
                                },
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = { "lua_ls" },
                automatic_enable = true,
            })
        end,
    },
}
