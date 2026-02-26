local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        local lines = {
            "Failed to clone lazy.nvim:",
            out,
            "",
            "Press any key to exit...",
        }
        vim.api.nvim_echo({ { table.concat(lines, "\n"), "ErrorMsg" } }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
}, {
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { "habamax" },
    },
    checker = {
        enabled = false,
    },
    change_detection = {
        notify = false,
    },
})
