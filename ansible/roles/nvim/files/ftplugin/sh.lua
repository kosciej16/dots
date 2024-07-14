local buf = vim.api.nvim_get_current_buf()

vim.api.nvim_buf_set_keymap(buf, 'n', '<leader>pc', ':!chmod +x %<CR>', { noremap = true, silent = true })

-- Set buffer-local non-recursive key mapping for <leader>pr
vim.api.nvim_buf_set_keymap(buf, 'n', '<leader>pr', [[<cmd>lua save_and_execute()<CR>]], { noremap = true, silent = true })

-- Function to save the current directory, change to the directory of the current file, execute the file, and then change back
function save_and_execute()
    local save_dir = vim.fn.getcwd()  -- Get current working directory
    vim.cmd('cd %:p:h')               -- Change to the directory of the current file
    vim.cmd('!%:p')                   -- Execute the file
    vim.cmd('cd ' .. save_dir)        -- Change back to the original directory
end
