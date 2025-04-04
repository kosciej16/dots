return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            -- dependencies = { "nvim-neotest/nvim-nio" },
            -- stylua: ignore
            keys = {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
            },
            opts = {},
            config = function(_, opts)
                -- setup dap config by VsCode launch.json file
                -- require("dap.ext.vscode").load_launchjs()
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup(opts)
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open({})
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close({})
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close({})
                end
            end,
        },
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_installation = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},

                -- You'll need to check that you have the required things installed
                -- online, please don't ask me how to install them :)
                ensure_installed = { "python" },
            },
        },
        -- {
        --     "mfussenegger/nvim-dap-python",
        --     keys = {
        --         { "<leader>dd", function() require('dap-python').test_method() end, desc = "Test method with debug", },
        --         { "<leader>df", function() require('dap-python').test_class() end,  desc = "Test class with debug", },
        --         { "<leader>dx", function() require('dap-python').test_method() end, desc = "Toggle Breakpoint",      mode = { "v" } },
        --     },
        --     config = function(_, opts)
        --         require('dap-python').setup("uv")
        --         require('dap-python').test_runner = 'pytest'
        --     end
        --
        -- }
    },
    keys = {
        {
            "<leader>dB",
            function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
            desc = "Breakpoint Condition",
        },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,             desc = "Toggle Breakpoint", },
        { "<leader>dc", function() require("dap").continue() end,                      desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                 desc = "Run to Cursor", },
        { "<leader>dg", function() require("dap").goto_() end,                         desc = "Go to Line (No Execute)", },
        { "<leader>di", function() require("dap").step_into() end,                     desc = "Step Into", },
        { "<leader>dj", function() require("dap").down() end,                          desc = "Down", },
        { "<leader>dk", function() require("dap").up() end,                            desc = "Up", },
        { "<leader>dl", function() require("dap").run_last() end,                      desc = "Run Last", },
        { "<leader>do", function() require("dap").step_out() end,                      desc = "Step Out", },
        { "<leader>dO", function() require("dap").step_over() end,                     desc = "Step Over", },
        { "<leader>dp", function() require("dap").pause() end,                         desc = "Pause", },
        { "<leader>dr", function() require("dap").repl.toggle() end,                   desc = "Toggle REPL", },
        { "<leader>ds", function() require("dap").session() end,                       desc = "Session", },
        { "<leader>dt", function() require("dap").terminate() end,                     desc = "Terminate", },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,              desc = "Widgets", },
    },
    config = function()
        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        local icons = {
            Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
            Breakpoint = " ",
            BreakpointCondition = " ",
            BreakpointRejected = { " ", "DiagnosticError" },
            LogPoint = ".>",
        }
        for name, sign in pairs(icons) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define(
                "Dap" .. name,
                { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
            )
        end
        require("dap").configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    return '/usr/bin/python3'
                end,
            },
            -- Doesn't work, went with nvim-dap-python for now
            -- {
            --     name = "Pytest: Current File",
            --     type = "python",
            --     request = "launch",
            --     module = "pytest",
            --     args = {
            --         "${file}",
            --         "-sv",
            --         "--log-cli-level=INFO",
            --         "--log-file=test_out.log"
            --     },
            --     console = "integratedTerminal",
            -- }
        }
    end,
}
