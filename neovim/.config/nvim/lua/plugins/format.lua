return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo", "Format" },
    opts = {
        notify_on_error = false,
        format_on_save = {
            timeout_ms = 800,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            lua = { "stylua" },
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)

        vim.api.nvim_create_user_command("Format", function(args)
            local format_opts = {
                async = false,
                timeout_ms = 1000,
                lsp_fallback = true,
            }

            if args.range > 0 then
                format_opts.range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, 0 },
                }
            end

            conform.format(format_opts)
        end, { range = true, desc = "Format buffer or range" })
    end,
}
