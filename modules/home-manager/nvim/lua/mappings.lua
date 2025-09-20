require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.keymap.set({"n", "v"}, "<C-c>", "\"*y", { desc = "Copy Text" })
vim.keymap.set({"n", "v"}, "<C-v>", "\"*p", { desc = "Paste Text" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
