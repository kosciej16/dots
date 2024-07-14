-- {
--     "nvim-neotest/neotest",
--     dependencies = {
--         "nvim-neotest/nvim-nio",
--         "nvim-lua/plenary.nvim",
--         "antoinemadec/FixCursorHold.nvim",
--         "nvim-treesitter/nvim-treesitter",
--         "tree-sitter/tree-sitter-python",
--         "nvim-neotest/neotest-python",
--     },
--     config = function()
--         map("n", "<leader>tt", ':lua require("neotest").run.run()<CR>')
--
--         require("neotest").setup({
--             adapters = {
--                 require("neotest-python")
--             }
--         })
--     end
-- }
--
return {
    'vim-test/vim-test',
    dependencies = {
        "preservim/vimux"
    },
    init = function()
        vim.g["test#strategy"] = "vimux"
        vim.g["test#python#runner"] = 'pytest'
        map("n", "<leader>tt", ":TestNearest<CR>")
        map("n", "<leader>tf", ":TestFile<CR>")
        map("n", "<leader>ta", ":TestSuite<CR>")
        map("n", "<leader>tl", ":TestLast<CR>")
        map("n", "<leader>tv", ":TestVisit<CR>")
        map("n", "<leader>tq", ":VimuxCloseRunner<CR>")
    end
}
