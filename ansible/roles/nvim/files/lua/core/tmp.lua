local clients = vim.lsp.get_active_clients()
if #clients > 0 then
    local file = io.open("lsp_capabilities.txt", "w")
    if file then
        -- Convert table to string with vim.inspect
        local output = vim.inspect(clients[1])
        file:write(output)
        file:close()
        print("LSP capabilities written to lsp_capabilities.txt")
    else
        print("Failed to open file for writing")
    end
else
    print("No active LSP clients found")
end

function test_me()
    local lspconfig = require("lspconfig")
    -- local servers = lspconfig.util.available_servers()
    local clients = vim.lsp.get_active_clients()
    print(clients)
    -- local clients = vim.lsp.buf_get_clients(0) -- Gets clients for the currently active buffer
end
