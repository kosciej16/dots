return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local ls = require("luasnip")
            local i = ls.insert_node
            local s = ls.snippet
            local t = ls.text_node

            -- ls.add_snippets(
            --     "all",
            --     { s("dupadupa", {
            --         i(1),
            --         t("text"),
            --         i(2),
            --         t("text again"),
            --         i(3),
            --     }) }
            -- )
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                -- "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                -- 'hrsh7th/cmp-cmdline',
                -- {
                --     "windwp/nvim-autopairs",
                --     opts = {
                --         fast_wrap = {},
                --         disable_filetype = { "TelescopePrompt", "vim" },
                --     },
                --     config = function(_, opts)
                --         require("nvim-autopairs").setup(opts)
                --
                --         -- setup cmp for autopairs
                --         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                --         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                --     end,
                -- },
            },
        },
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()
            -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/kosciej/.config/nvim/snippets" } })

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<C-i>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),

                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },

                    -- {
                    --     name = "buffer",
                    --     option = {
                    --         get_bufnrs = function()
                    --             return vim.api.nvim_list_bufs()
                    --         end
                    --     },
                    -- },
                    { name = "nvim_lua" },
                    { name = "path" },
                },
            })
            -- cmp.setup.cmdline({ '/', '?' }, {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = {
            --         { name = 'buffer' }
            --     }
            -- })
            -- cmp.setup.cmdline(':', {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = cmp.config.sources({
            --         { name = 'path' }
            --     }, {
            --         { name = 'cmdline' }
            --     }),
            --     matching = { disallow_symbol_nonprefix_matching = false }
            -- })
        end,
    },
}
