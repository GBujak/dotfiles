return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "<leader>f",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find files",
        },
        {
            "<leader>g",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Live grep",
        },
        {
            "<leader>h",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Help tags",
        },
        {
            "<leader>b",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>T",
            function()
                local file = vim.api.nvim_buf_get_name(0)
                local cwd = file ~= "" and vim.fs.dirname(file) or (vim.uv or vim.loop).cwd()
                require("telescope.builtin").find_files({ cwd = cwd })
            end,
            desc = "Find files from current file dir",
        },
        {
            "<leader>z",
            function()
                local builtin = require("telescope.builtin")
                local ok = pcall(builtin.git_files, {
                    show_untracked = true,
                })
                if not ok then
                    builtin.find_files()
                end
            end,
            desc = "Git files (fallback all files)",
        },
    },
    opts = {
        defaults = {
            sorting_strategy = "ascending",
            layout_config = {
                prompt_position = "top",
            },
        },
        pickers = {
            buffers = {
                sort_mru = true,
                ignore_current_buffer = true,
            },
        },
    },
}
