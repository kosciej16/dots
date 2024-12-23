vim.opt.foldmethod = "indent"

local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_set_keymap(buf, 'n', '<leader>pr', ':!python %<CR>', { noremap = true, silent = true })
