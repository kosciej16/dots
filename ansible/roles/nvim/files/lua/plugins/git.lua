map = vim.keymap.set

return {
    {
        "tpope/vim-fugitive",
        init = function()
            map("n", "<leader>m", "<cmd> NvimTreeFindFile<CR>")
            map("n", "<leader>gw", ":Gwrite!<cr>")
            map("n", "<leader>gr", ":Gread<space>")
            map("n", "<leader>gr", ":Git fetch <bar> :Git reset --hard origin/master")
            map("n", "<leader>ge", ":Gedit<space>")
            map("n", "<leader>gp", ":Git push<cr>")
            map("n", "<leader>gs", ":Git<cr>")
            map("n", "<leader>gff", ":Gdiff<cr>")
            map("n", "<leader>gfm", ":Gdiff origin/master")
            map("n", "<leader>ga", ":Git commit --amend --no-edit")
            map("n", "<leader>gc", ":Git commit<cr>")
            map("n", "<leader>gu", ":Git add -u<cr>")
            map("n", "<leader>gq", ":Git add -u <bar> :Git commit --amend --no-edit --no-verify <bar> :Git push -f<cr>")
            map("n", "<leader>gb", ":Git blame<cr>")
            map("n", "<leader>goo", ":.GBrowse<cr>")
            map("n", "<leader>goy", ":.GBrowse!<cr>")
            map("n", "<leader>go", ":GBrowse<cr>")

            vim.api.nvim_create_autocmd("User", {
                pattern = "fugitive",
                callback = function()
                    -- Assuming fugitive exposes a similar function in Lua or through vim.fn interface
                    local buf_type = vim.fn['fugitive#buffer']().type()
                    if buf_type:match("^(tree|blob)$") then
                        vim.api.nvim_buf_set_keymap(0, 'n', '..', ':edit %:h<CR>', { noremap = true, silent = true })
                    end
                end
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"fugitiveblame", "fugitive"},
                callback = function()
                    -- Set the buffer-local keymap
                    vim.api.nvim_buf_set_keymap(0, 'n', 'q', 'gq', { silent = true })
                end
            })
        end
    },
    "tpope/vim-rhubarb",
    {
        'shumphrey/fugitive-gitlab.vim',
        init = function()
            vim.g.fugitive_gitlab_domains = {'https://ci-gitlab.corpnet.pl'}
            vim.api.nvim_create_user_command(
            'Browse',
            function (opts)
                vim.fn.system { 'xdg-open', opts.fargs[1] }
            end,
            { nargs = 1 }
            )
        end
    },

}
