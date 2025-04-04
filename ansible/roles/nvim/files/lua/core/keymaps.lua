local map = vim.keymap.set

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +4<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -4<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -4<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +4<cr>", { desc = "Increase Window Width" })
