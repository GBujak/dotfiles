local map = vim.keymap.set

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "<leader>B", function()
    vim.cmd("write")
    vim.cmd("bdelete")
end, { desc = "Write and close buffer" })

map("n", "<leader>O", function()
    vim.cmd("wall")
    vim.cmd("%bdelete")
end, { desc = "Write all and close all buffers" })

map("n", "gn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "gN", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "List references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code actions" })

map("n", "<C-n>", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "<C-p>", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

map("n", "<leader>t", function()
    vim.cmd("vsplit | vertical resize 80 | terminal")
end, { desc = "Open terminal split" })
