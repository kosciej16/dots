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

local function goto_definition_or_fixture()
    -- Call the LSP definition function first
    vim.lsp.buf.definition()

    -- Capture the current line where the cursor is
    local current_line = vim.api.nvim_get_current_line()

    -- Pattern to identify test function declarations
    -- local is_test_function = current_line:match("^%s*(async%s+)?def%s+%w*test%w*")
    local is_test_function = current_line:match("^%s*(async%s+)?def%s+%w*test%w*")

    local is_fixture_parameter = false
    -- Check the line above for the presence of "fixture"
    local previous_line_number = vim.fn.line('.') - 1
    if previous_line_number > 0 then
        local previous_line = vim.api.nvim_buf_get_lines(0, previous_line_number - 1, previous_line_number, false)[1]
        is_fixture_parameter = previous_line and previous_line:match("fixture")
    end
    if is_test_function or is_fixture_parameter then
        -- If it looks like a test function, attempt to jump to a fixture
        require("custom.fixture").jump() -- Adjust to your function managing fixtures
    end
end
-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, silent = true, desc = "LSP " .. desc }
    end

    -- if client.name == "pyright" then
    --     client.server_capabilities.referencesProvider = false
    --     client.server_capabilities.definitionProvider = false
    -- end

    map("n", "<space>e", vim.diagnostic.open_float)
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
    map("n", "<leader>cd", vim.diagnostic.setloclist)
    map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    map("n", "gx", require "custom.fixture".jump)
    -- map("n", "gd", goto_definition_or_fixture, opts("Go to fixture or definition"))
    map("n", "gd", vim.lsp.buf.definition, opts("Go to fixture or definition"))
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
            "williamboman/mason.nvim",
            { "williamboman/mason-lspconfig.nvim", after = "mason.nvim" },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "basedpyright", "pyright", "lua_ls", "ruff", "rust_analyzer", "jedi_language_server" }, -- List of LSP servers to automatically install
            })

            local lspcfg = require("lspconfig")
            local util = require("lspconfig/util")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.publishDiagnostics = nil


            require("lspconfig").pyright.setup({
                -- on_attach = function(client, _)
                --     client.server_capabilities.referencesProvider = false
                --     client.server_capabilities.definitionProvider = false
                -- end,
                on_init = M.on_init,
                on_attach = M.on_attach,
                -- root_dir = util.root_pattern("pyrightconfig.json", ".git"),
                root_dir = util.root_pattern("pyproject.toml", "pyrightconfig.json", ".git"),

                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,

                            extraPaths = { "src", "../../libs/commons/src", "../../libs/anon_casc_combiner/src" },

                            -- diagnosticMode = 'openFiles',
                            -- diagnosticMode = 'workspace',
                            useLibraryCodeForTypes = true,
                            -- logLevel = 'Trace'
                        },
                    },
                },
            })

            lspcfg.ruff.setup({
                capabilities = capabilities,
                -- root_dir = util.root_pattern("pyrightconfig.json", ".git"),
                root_dir = util.root_pattern("pyproject.toml", "pyrightconfig.json", ".git"),
                -- root_dir = util.root_pattern("pyproject.toml", "pyrightconfig.json", ".git"),
            })

            -- lspcfg.jedi_language_server.setup {
            --     capabilities = capabilities,
            --     on_init = M.on_init,
            --     root_dir = util.root_pattern("pyproject.toml", "pyrightconfig.json", ".git"),
            --     -- on_attach = M.on_attach,
            --     init_options = {
            --         workspace = {
            --             extraPaths = { "src" },
            --         }
            --     },
            -- }
            lspcfg.lua_ls.setup({
                settings = {
                    Lua = {
                        format = {
                            enable = true,
                            defaultConfig = {
                                max_line_length = "120", -- Set your desired line length here
                            },
                        },
                    },
                },

                capabilities = capabilities,
                on_attach = M.on_attach,
            })
            lspcfg.rust_analyzer.setup({
                on_attach = M.on_attach,
                root_dir = util.root_pattern("Cargo.toml"),
                filetypes = { "rust" },
                settings = {
                    -- rustfmt = {
                    --     overrideCommand = {
                    --         'rustfmt',
                    --         '--config',
                    --         'max_width=100',
                    --     },
                    -- },

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
    {
        "AckslD/nvim-pytrize.lua",
        config = true,
    }
}
