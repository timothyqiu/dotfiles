-- move selected lines vertically
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- lsp
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
vim.keymap.set("n", "<F3>", function() vim.lsp.buf.format({async = true}) end)
vim.keymap.set("x", "<F3>", function() vim.lsp.buf.format({async = true}) end)
vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

-- misc
vim.keymap.set("n", "<leader>q", ":cclose<CR>")
vim.keymap.set("n", "<leader>vnc", ":Ex ~/.config/nvim/<CR>")
