vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("qf", { clear = true }),
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":cclose<CR>", {})
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.py", "*.lua" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "fugitiveblame",
--     -- callback = function()
--     --     vim.api.nvim_buf_set_keymap(0, 'n', 'P', '1P', { noremap = true, silent = true })
--     -- end,
-- })
