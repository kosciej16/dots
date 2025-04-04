local function change_proxy(is_azure)
    local proxy = nil
    if is_azure then
        proxy = "http://dowolkry:PupaBzikPekin.11@126.179.0.206:9090"
    end
    require("codecompanion.config").adapters.opts.proxy = proxy
end

function open_chat(is_azure)
    change_proxy(is_azure)
    if is_azure then
        vim.cmd('CodeCompanionChat azure_openai')
    else
        vim.cmd('CodeCompanionChat')
    end
end

return {
    {
        "olimorris/codecompanion.nvim",
        keys = {
            { "<leader>ap", ":lua open_chat(true)<cr>",            mode = { "n", "v", }, desc = "open azure_ai chat with proxy" },
            { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>",   desc = "toogle chat" },
            { "<leader>an", ":lua open_chat(false)<cr>",           mode = { "n", "v" },  desc = "open new chat" },
            { "<leader>aa", "<cmd>CodeCompanionChat<cr>",          mode = { "v" } },
            { "ga",         "<cmd>CodeCompanionChat Add<cr><esc>", mode = { "v" },       desc = "add code to chat" }
        },
        cmd = {
            ["cc"] = { "CodeCompanion", "Expand 'cc' into 'CodeCompanion' in the command line" }
        },
        -- init = function()
        --     map("n", "<leader>ap", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
        --     map("n", "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
        --     map("v", "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
        --     map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
        --
        --     -- Expand 'cc' into 'CodeCompanion' in the command line
        --     vim.cmd([[cab cc CodeCompanion]])
        -- end,
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
            "nvim-treesitter/nvim-treesitter",
            { "echasnovski/mini.diff", version = false },
        },
        config = function()
            require("codecompanion").setup({
                opts = {
                    log_level = "DEBUG",
                },
                strategies = {
                    chat = {
                        keymaps = {
                            close = {
                                modes = {
                                    n = "<C-c>",
                                    i = "<C-c>",
                                },
                                index = 3,
                                callback = function()
                                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, true, true), 'n',
                                        true)
                                end,
                                description = "Toggle Chat",
                            },
                        },
                        adapter = "anthropic",
                    },
                    inline = {
                        adapter = "anthropic",
                    },
                },
                display = {
                    action_palette = {
                        provider = "telescope",
                    },
                    -- diff = {
                    --     provider = "mini_diff",
                    -- },
                },
                adapters = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            name = "sonnet", -- Give this adapter a different name to differentiate it from the default ollama adapter
                            env = {
                                api_key = "cmd:pass api_keys/anthropic",
                            },
                            schema = {
                                model = {
                                    default = "claude-3-5-sonnet-20241022",
                                },
                                -- num_ctx = {
                                --     default = 16384,
                                -- },
                                -- num_predict = {
                                --     default = -1,
                                -- },
                            },
                        })
                    end,
                    azure_openai = function()
                        return require("codecompanion.adapters").extend("azure_openai", {
                            env = {
                                api_key = "sk-_kIO-96m5zmFK-uNJZVJvQ",
                                -- api_key = "cmd:pass api_keys/pom_ai",
                                endpoint = "https://llmproxy.ai.orange",
                            },
                            schema = {
                                model = {
                                    default = "openai/gpt-4o",
                                    choices = {
                                        "openai/gpt-4o",
                                        "gpt-4o-mini",
                                        "gpt-4-turbo-preview",
                                        "gpt-4",
                                        "gpt-3.5-turbo",
                                    }
                                },
                            },
                        })
                    end,
                    opts = {
                        --- prompt for llm
                        -- system_prompt = function(adapter)
                        --     if adapter.schema.model.default == "llama3.1:latest" then
                        --         return "My custom system prompt"
                        --     end
                        --     return "My default system prompt"
                        -- end,
                        -- allow_insecure = true, -- Use if required
                        -- proxy = "http://dowolkry:PupaBzikPekin.11@126.179.0.206:9090",
                        -- proxy = nil,
                    },
                    openai = function()
                        return require("codecompanion.adapters").extend("openai", {
                            env = {
                                api_key = "cmd:pass api_keys/openai",
                            },
                        })
                    end,
                },
            })
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "echasnovski/mini.icons",
        },
        opts = { file_types = { "markdown", "codecompanion" } },
    },
    -- require("codecompanion").setup({
    --     adapters = {
    --         ollama = function()
    --             return require("codecompanion.adapters").extend("openai_compatible", {
    --                 env = {
    --                     url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
    --                     api_key = "OpenAI_API_KEY", -- optional: if your endpoint is authenticated
    --                     chat_url = "/v1/chat/completions", -- optional: default value, override if different
    --                 },
    --             })
    --         end,
    --     },
    -- }),
}
