-- Keymaps
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader><leader>', '<cmd>so<CR>')
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>')

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
