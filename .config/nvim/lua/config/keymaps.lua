-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "Mode enter command mode" })
map("i", "jk", "<ESC>", { desc = "Mode enter normal mode" })

map("n", "<M-S-Up>", "<CMD> m-2 <CR>", { desc = "Linsel move up" })
map("n", "<M-S-Down>", "<CMD> m+1 <CR>", { desc = "Linsel move down" })
map("n", "<M-P>", "yyp", { desc = "Linsel Duplicate" })

map("n", "<C-q>", "<CMD> q <CR>", { desc = "Quit single file" })
map("n", "<C-M-q>", "<CMD> qa <CR>", { desc = "Quit all file" })

map("n", "ngt", "<CMD> tabnew <CR>", { desc = "Creates a new Tab" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
