vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end


-- print("XDG_CONFIG_HOME: " .. (os.getenv("XDG_CONFIG_HOME") or "Not set"))
-- print("Config home: " .. vim.fn.stdpath("config"))

-- print("Data home: " .. vim.fn.stdpath("data"))

vim.opt.rtp:prepend(lazypath)
-- require("lazyvim.config")
require("lazy").setup({ { import = "plugins" } })

vim.cmd.colorscheme "catppuccin"

require "core"
require "custom.fixture"


function Foo(bufnr)
    print(bufnr)
end

function Test()
    local lspconfig = require("lspconfig")
    -- local servers = lspconfig.util.available_servers()
    local clients = vim.lsp.get_active_clients()
    -- local servers = lspconfig.util.available_servers()
    -- local clients = vim.lsp.get_active_clients
    local file = io.open("pliczek", "w")
    for i, client in ipairs(clients) do
        -- print(client.config.root_dir)
        -- print(client.root_dir)
        file:write(vim.inspect(client))
        -- print(client.config.autostart)
        -- print(client.id
        -- local root_dir = client.config.root_dir or client.config.workspace_folders[1].uri
        -- print("LSP Root Directory: " .. root_dir)
    end

    -- local clients = vim.lsp.buf_get_clients(0) -- Gets clients for the currently active buffer
end
