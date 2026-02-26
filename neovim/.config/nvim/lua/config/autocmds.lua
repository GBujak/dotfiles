local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local writing_group = augroup("UserWritingPreferences", { clear = true })

autocmd("FileType", {
    group = writing_group,
    pattern = { "markdown", "typst" },
    callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.formatoptions = "tca"
    end,
})

local web_indent_group = augroup("UserWebIndent", { clear = true })

autocmd("FileType", {
    group = web_indent_group,
    pattern = {
        "html",
        "css",
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
        "vue",
        "svelte",
    },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})

local terminal_group = augroup("UserTerminalKeymaps", { clear = true })

autocmd("TermOpen", {
    group = terminal_group,
    pattern = "term://*",
    callback = function()
        vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { buffer = true, silent = true })
    end,
})

local java_indent_group = augroup("UserJavaIndent", { clear = true })

autocmd("FileType", {
    group = java_indent_group,
    pattern = "java",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(bufnr) then
                return
            end

            vim.api.nvim_buf_call(bufnr, function()
                if vim.bo.filetype ~= "java" then
                    return
                end

                vim.opt_local.tabstop = 4
                vim.opt_local.shiftwidth = 4
                vim.opt_local.softtabstop = 4

                -- Default Java cindent continuation is 2 * shiftwidth. Force 1 * shiftwidth
                -- so pressing <CR> inside parentheses indents by 4 spaces, not 8.
                if not vim.bo.cinoptions:find("%(1s", 1, false) then
                    vim.opt_local.cinoptions:append("(1s")
                end
            end)
        end)
    end,
})
