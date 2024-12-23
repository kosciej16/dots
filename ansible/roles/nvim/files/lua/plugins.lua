local map = vim.keymap.set
function Dupa()
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

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
    {
        'alexghergh/nvim-tmux-navigation',
        config = function()
            local nvim_tmux_nav = require('nvim-tmux-navigation')

            nvim_tmux_nav.setup {
                disable_when_zoomed = true -- defaults to false
            }

            -- map('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            -- map('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            -- map('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            -- map('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
            -- map('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
            -- map('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
        end,
        keys = {
            { "<C-h>",     function() require('nvim-tmux-navigation').NvimTmuxNavigateLeft() end },
            { "<C-j>",     function() require('nvim-tmux-navigation').NvimTmuxNavigateDown() end },
            { "<C-k>",     function() require('nvim-tmux-navigation').NvimTmuxNavigateUp() end },
            { "<C-l>",     function() require('nvim-tmux-navigation').NvimTmuxNavigateRight() end },
            { "<C-\\>",    function() require('nvim-tmux-navigation').NvimTmuxNavigateLastActive() end },
            { "<C-Space>", function() require('nvim-tmux-navigation').NvimTmuxNavigateNext() end },
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        cmd = "NvimTreeFindFile",
        init = function()
            map("n", "<leader>m", "<cmd> NvimTreeFindFile<CR>")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup {
                -- on_attach = Dupa,
                view = { adaptive_size = true },
                actions = {
                    open_file = {
                        window_picker = {
                            enable = false,
                        }
                    }
                } }
            -- vim.api.nvim_create_autocmd("FileType", {
            --     pattern = "NvimTree",
            --     callback = function()
            --         vim.api.nvim_buf_set_keymap(0, 'n', 'x', 'k', { silent = true })
            --     end,
            -- })
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
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function(x, opts)
            function foo(name, path, buffnr)
                return "abc"
            end

            -- require("bufferline").setup({options = {name_formatter=foo}})
            require("bufferline").setup()
        end,
        opts = { options = { numbers = "ordinal" } },
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
            map("n", "<leader>ra", ':Rg --hidden -g "!.git"<SPACE>')
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
            map("n", "\\", ':Rg<SPACE>')
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
            local wiki_1 = { path = '~/.config/nvim/vimwiki/personal', syntax = 'markdown', ext = 'md' }
            local wiki_2 = { path = '~/.config/nvim/vimwiki/sf', syntax = 'markdown', ext = 'md' }
            local wiki_3 = { path = '~/.config/nvim/vimwiki/pom', syntax = 'markdown', ext = 'md' }

            vim.g.vimwiki_map_prefix = "<leader>v"
            vim.g.vimwiki_list = { wiki_1, wiki_2, wiki_3 }
            vim.g.vimwiki_ext2syntax = {
                ['.md'] = 'markdown',
                ['.markdown'] = 'markdown',
                ['.mdown'] = 'markdown'
            }
        end

    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "auto",
            background = {
                light = "latte",
                dark = "macchiato",
            },
            transparent_background = true, -- disables setting the background color.
            integrations = {
                telescope = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                cmp = true,
                mason = true,
                gitsigns = true,
                which_key = true,
            }
        }
    },
    {
        "gregorias/coerce.nvim",
        tag = 'v1.0',
        config = true,
    },
    -- Plugin that disables other plugins when open big file
    'pteroctopus/faster.nvim',
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            -- REQUIRED
            harpoon:setup()
            -- REQUIRED

            vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
            vim.keymap.set("n", ",h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)

            -- Toggle previous & next buffers stored within Harpoon list
            -- vim.keymap.set("n", "<S-P>", function() harpoon:list():prev() end)
            -- vim.keymap.set("n", "<S-N>", function() harpoon:list():next() end)
        end,
        -- keys = {
        --     { "<leader>ha", function() require "harpoon":list():add() end,                                   desc = "desc2" },
        --     { "<leader>hl", function() require "harpoon.ui":toggle_quick_menu(require "harpoon":list()) end, desc = "desc" },
        --     { "<C-S-P>",    function() require "harpoon":list():prev() end,                                  desc = "desc" },
        --     { "<C-S-N>",    function() require "harpoon":list():next() end,                                  desc = "desc" },
        --
        --     -- { "<C-h>",     function() require('nvim-tmux-navigation').NvimTmuxNavigateLeft() end },
        --     -- { "<C-j>",     function() require('nvim-tmux-navigation').NvimTmuxNavigateDown() end },
        --     -- { "<C-k>",     function() require('nvim-tmux-navigation').NvimTmuxNavigateUp() end },
        --     -- { "<C-l>",     function() require('nvim-tmux-navigation').NvimTmuxNavigateRight() end },
        --     -- { "<C-\\>",    function() require('nvim-tmux-navigation').NvimTmuxNavigateLastActive() end },
        --     -- { "<C-Space>", function() require('nvim-tmux-navigation').NvimTmuxNavigateNext() end },
        -- }
    },
    "rhysd/clever-f.vim",
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        opts = {

            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml", "yaml"
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
        -- init = function(plugin)
        --     -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        --     -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        --     -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        --     -- Luckily, the only things that those plugins need are the custom queries, which we make available
        --     -- during startup.
        --     require("lazy.core.loader").add_to_rtp(plugin)
        --     require("nvim-treesitter.query_predicates")
        -- end,
    },
    {
        "folke/which-key.nvim",
        opts = {
            notify = false
        },
    },
}
