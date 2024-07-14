local map = vim.keymap.set
return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
             --   Configuration here, or leave empty to use defaults
            })
        end
    },
    { 'alexghergh/nvim-tmux-navigation', config = function()

        local nvim_tmux_nav = require('nvim-tmux-navigation')

        nvim_tmux_nav.setup {
            disable_when_zoomed = true -- defaults to false
        }

        map('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
        map('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
        map('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
        map('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        map('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
        map('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

    end
},
{
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = "NvimTreeFindFile",
    init = function()
        map("n", "<leader>m", "<cmd> NvimTreeFindFile<CR>")
    end,
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("nvim-tree").setup {
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    }
                }
            }}
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            map('x', "<C-_>", "<Plug>(comment_toggle_linewise_visual)")
            require("Comment").setup({
                toggler = {
                    line = '<C-_>',
                },
            })
        end,
    },
    {
        'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
        config = function(x, opts)
            function foo(name, path, buffnr)
                return "abc"
            end
            -- require("bufferline").setup({options = {name_formatter=foo}})
            require("bufferline").setup()
        end,
        opts = {options = {numbers = "ordinal"}},
    },
    -- {
    --     "NvChad/base46",
    --     branch = "v2.0",
    --     build = function()
    --         require("base46").load_all_highlights()
    --     end,
    -- },
    'tpope/vim-rsi',
    {
        'jremmen/vim-ripgrep',
        config = function()
            map("n", "<leader>rr", ':Rg -w <c-r><c-w> --glob "!tests"<CR>')
            map("n", "<leader>ra", ':Rg --hidden<SPACE>')
            -- " search everywhere
            map("n", "<leader>re", ':Rg -w --hidden <c-r><c-w><CR>')
            -- search current directory word under cursor
            map("n", "<leader>rd", ':Rg <c-r><c-w> "%:p:h"<CR>')
            -- search current directory
            map("n", "<leader>rt", ':Rg  "%:p:h"<S-LEFT><LEFT>')
            -- search for filename nnoremap <leader>rf :Rg %:t:r<CR>
            -- search for word in clipboard
            map("n", "<leader>rc", ':Rg --hidden <c-r>"<CR>')
            -- search that omits tests
            map("n", "<leader>ro", ':Rg --glob "!tests" --hidden<SPACE>')
            -- search for filename
            map("n", "<leader>rf", ':Rg %:t:r<CR>')
            map("n", "<leader>rv", ':Rg --hidden  ~/.config/nvim<S-LEFT><LEFT>')
            map("n", "\\" , ':Rg<SPACE>')
        end,
        -- search for word under cursor that omits tests
        -- let g:rg_highlight=1
        --
        -- autocmd FileType qf setlocal nowrap
    },

    {
        'lambdalisue/suda.vim',
        config = function()
            map("c", "w!!", ":SudaWrite<CR>")
            map("c", "e!!", ":SudaRead<CR>")
        end
    },
    {
        'tummetott/unimpaired.nvim',
        event = 'VeryLazy',
        opts = {
            -- add options here if you wish to override the default settings
        },
    },
    {
        'vimwiki/vimwiki',
        init = function()
            local wiki_1 = {path= '~/.config/nvim/vimwiki/personal', syntax='markdown', ext='md'}
            local wiki_2 = {path= '~/.config/nvim/vimwiki/sf', syntax='markdown', ext='md'}
            vim.g.vimwiki_list = {{path = '~/Docs/Mywiki', syntax = 'markdown', ext = '.md'}}

            vim.g.vimwiki_map_prefix = "<leader>v"
            vim.g.vimwiki_list = {wiki_1, wiki_2}
            vim.g.vimwiki_ext2syntax = {
                ['.md'] = 'markdown',
                ['.markdown'] = 'markdown',
                ['.mdown'] = 'markdown'
            }
        end

    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {},
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        -- opts = {
        config = function()
            require("catppuccin").setup({
                flavour = "auto",
                background = {
                    light = "latte",
                    dark = "macchiato",
                    },
                transparent_background = true, -- disables setting the background color.
            })
        end
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    },
    {
        "FabijanZulj/blame.nvim",
        config = function()
            require("blame").setup()
        end
    },
    {
        "gregorias/coerce.nvim",
        tag = 'v1.0',
        config = true,
    }
}
