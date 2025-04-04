return {
    {
        'vim-test/vim-test',
        dependencies = {
            "preservim/vimux"
        },
        init = function()
            vim.g["test#strategy"] = "vimux"
            vim.g["test#python#runner"] = 'pytest'
            map("n", "<leader>tv", ":TestNearest<CR>")
            -- map("n", "<leader>tf", ":TestFile<CR>")
            -- map("n", "<leader>ta", ":TestSuite<CR>")
            -- map("n", "<leader>tl", ":TestLast<CR>")
            -- map("n", "<leader>tv", ":TestVisit<CR>")
            -- map("n", "<leader>tq", ":VimuxCloseRunner<CR>")
        end
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
        },
        keys = {
            { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open output" },
            { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Open summary" },
            { "<leader>tt", function() require("neotest").run.run() end,                     desc = "Run nearest" },
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Run file" },
            { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Run debug" },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                    }),
                }
            })
        end
    }
}
