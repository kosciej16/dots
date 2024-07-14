local M = {}
map = vim.keymap.set

-- vim.lsp.buf.add_workspace_folder()
-- vim.lsp.buf.clear_references()
-- vim.lsp.buf.code_action()
-- vim.lsp.buf.completion()
-- vim.lsp.buf.declaration()
-- vim.lsp.buf.definition()
-- vim.lsp.buf.document_highlight()
-- vim.lsp.buf.document_symbol()
-- vim.lsp.buf.execute_command()
-- vim.lsp.buf.format()
-- vim.lsp.buf.hover()
-- vim.lsp.buf.implementation()
-- vim.lsp.buf.incoming_calls()
-- vim.lsp.buf.list_workspace_folders()
-- vim.lsp.buf.outgoing_calls()
-- vim.lsp.buf.rename()
-- vim.lsp.buf.server_ready()
-- vim.lsp.buf.signature_help()
-- vim.lsp.buf.type_definition()
-- vim.lsp.buf.workspace_symbol()

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
map('n', '<space>e', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<space>q', vim.diagnostic.setloclist)

M = {}
map = vim.keymap.set
-- vim.lsp.set_log_level("debug")
vim.lsp.set_log_level("info")
M.on_init = function(client, bufnr)
    -- print(vim.inspect(client.config.settings.python.analysis.extraPaths))
end

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "K", vim.lsp.buf.hover, opts "hover information")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("i", "gc", vim.lsp.buf.completion, opts "Completion")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
    map("n", "<leader>fm", function()
        vim.lsp.buf.format { async = true }
    end, opts "abc")

    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

    -- map("n", "<leader>ra", function()
    --   require "nvchad.lsp.renamer"()
    -- end, opts "NvRenamer")

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

function Test(folder)
    -- vim.lsp.buf.add_workspace_folder(folder)

    -- Restart pyright language server
    for _, client in pairs(vim.lsp.get_active_clients()) do
        if client.name == "pyright" then
            client.stop()
            vim.defer_fn(function()
                vim.lsp.start_client(client.config)
            end, 500)
        end
    end
end

local original_config = vim.lsp.handlers['workspace/configuration']

-- vim.lsp.handlers['workspace/configuration'] = vim.lsp.with(
--   original_config, {
--     -- Disable signs
--     extraPaths = {"tests"},
--   }
-- )
-- Override workspace/configuration handler

return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                'hrsh7th/cmp-cmdline',
                {
                    "windwp/nvim-autopairs",
                    opts = {
                        fast_wrap = {},
                        disable_filetype = { "TelescopePrompt", "vim" },
                    },
                    config = function(_, opts)
                        require("nvim-autopairs").setup(opts)

                        -- setup cmp for autopairs
                        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                    end,
                },


            },
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),

                sources = {
                    { name = "nvim_lsp" },
                    {
                        name = "buffer",
                        option = {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end
                        },
                    },
                    -- { name = "nvim_lua" },
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
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            { "williamboman/mason-lspconfig.nvim", after = "mason.nvim" },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "lua_ls", "ruff" }, -- List of LSP servers to automatically install
            })

            -- local mason_registry = require("mason-registry")
            -- if not mason_registry.is_installed("pyright") then
            --     mason_registry.get_package("pyright"):install()
            --     -- mason_registry.install_package("pyright")
            -- end

            -- Set up pyright with nvim-lspconfig
            -- vim.lsp.set_log_level("debug")

            require("lspconfig").pyright.setup({
                on_new_config = function(config, root_dir)
                    print(config, root_dir)
                    -- root_dir = util.root_pattern(".git", ".pyrightconfig.json"),
                end,

                -- local std_lib_path = '/usr/lib/python' .. python_version
                -- local site_packages_path = venv_path .. '/lib/python' .. python_version .. '/site-packages'



                on_init = M.on_init,
                on_attach = M.on_attach,
                settings = {
                    python = {
                        analysis = {
                            -- extraPaths = {'/home/kosciej/.local/share/nvim/mason/packages/pyright/node_modules/pyright/dist/typeshed-fallback/stdlib'},
                            -- autoSearchPaths = true,
                            -- extraPaths = {"tests"},
                            -- diagnosticMode = 'openFiles',
                            -- diagnosticMode = 'workspace',
                            useLibraryCodeForTypes = true,
                            -- logLevel = 'Trace'

                        }
                    }
                },
            })
            require 'lspconfig'.ruff_lsp.setup {}

            require("lspconfig").lua_ls.setup({
                on_attach = M.on_attach,
            })
        end
    }
}
