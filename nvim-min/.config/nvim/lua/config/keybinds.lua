vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", "<cmd>Ex<cr>")
vim.keymap.set("n", "<leader>th", "<cmd>belowright split | term<cr>i")
vim.keymap.set("n", "<leader>tv", "<cmd>belowright vsplit | term<cr>i")

vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>bk", "<cmd>bd!<cr>")
