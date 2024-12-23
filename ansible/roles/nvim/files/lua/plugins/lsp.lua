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

M = {}
-- vim.lsp.set_log_level("debug")
-- vim.lsp.set_log_level("info")
M.on_init = function(client, bufnr)
    -- print(vim.inspect(client.config.settings.python.analysis.extraPaths))
end

local function append_pyright_ignore(error_code)
    if error_code then
        vim.cmd("normal! A  # pyright: ignore[" .. error_code .. "]")
    end
end

local function get_pyright_error_code()
    local diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
    for _, diagnostic in ipairs(diagnostics) do
        return diagnostic.code
    end
end

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, silent = true, desc = "LSP " .. desc }
    end

    map("n", "<space>e", vim.diagnostic.open_float)
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
    map("n", "<leader>cd", vim.diagnostic.setloclist)
    map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    map("n", "K", vim.lsp.buf.hover, opts("hover information"))
    map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
    -- map("i", "gc", vim.lsp.buf.completion, opts("Completion"))
    map("n", "<leader>cs", vim.lsp.buf.signature_help, opts("Show signature help"))
    map("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
    map("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
    map("n", "<leader>cf", function()
        vim.lsp.buf.format({ async = true })
    end, opts("Format file"))
    map("n", "<leader>ci", function()
        append_pyright_ignore(get_pyright_error_code())
    end, opts("pyright ignore"))

    map("n", "<leader>cwl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("List workspace folders"))

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))

    -- map("n", "<leader>ra", function()
    --   require "nvchad.lsp.renamer"()
    -- end, opts "NvRenamer")

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    map("n", "gr", vim.lsp.buf.references, opts("Show references"))
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

local original_config = vim.lsp.handlers["workspace/configuration"]

-- vim.lsp.handlers['workspace/configuration'] = vim.lsp.with(
--   original_config, {
--     -- Disable signs
--     extraPaths = {"tests"},
--   }
-- )
-- Override workspace/configuration handler

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim",
            "williamboman/mason.nvim",
            { "williamboman/mason-lspconfig.nvim", after = "mason.nvim" },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "lua_ls", "ruff", "rust_analyzer" }, -- List of LSP servers to automatically install
            })

            -- Set up pyright with nvim-lspconfig
            -- vim.lsp.set_log_level("debug")

            -- Improve lua lsp to work with neovim code
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
            local lspcfg = require("lspconfig")
            local util = require("lspconfig/util")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("lspconfig").pyright.setup({
                capabilities = capabilities,
                on_new_config = function(config, root_dir)
                    print(config, root_dir)
                    -- root_dir = util.root_pattern(".git", ".pyrightconfig.json"),
                end,

                -- local std_lib_path = '/usr/lib/python' .. python_version
                -- local site_packages_path = venv_path .. '/lib/python' .. python_version .. '/site-packages'

                on_init = M.on_init,
                on_attach = M.on_attach,
                root_dir = util.root_pattern(".git", "pyrightconfig.json"),

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
                        },
                    },
                },
            })

            -- lspcfg.ruff_lsp.setup {}
            lspcfg.ruff.setup({
                -- capabilities = capabilities,
            })

            lspcfg.lua_ls.setup({
                capabilities = capabilities,
                on_attach = M.on_attach,
            })
            lspcfg.rust_analyzer.setup({
                on_attach = M.on_attach,
                root_dir = util.root_pattern("Cargo.toml"),
                filetypes = { "rust" },
                settings = {
                    ["rust_analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                    },
                },
            })
        end,
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
}
