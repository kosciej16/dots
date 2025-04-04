local M = {}

local Job = require("plenary.job")
local Path = require("plenary.path")

local function normal(cmd)
    vim.cmd(string.format("normal! %s", cmd))
end

local function get_word_under_cursor()
    local savereg = vim.fn.getreginfo('"')
    normal("yiw")
    local word = vim.fn.getreg('"')
    vim.fn.setreg('"', savereg)
    return word
end

local function parse_raw_fixture_output(cwd, lines)
    local fixtures = {}
    local pattern = "^([^_][%w_]*) .*%-%- (%S*):(%d*)"
    for _, line in ipairs(lines) do
        local name, path, linenr = line:match(pattern)
        if name ~= nil and string.find(path, ".direnv") == nil then
            fixtures[name] = {
                file = cwd .. "/" .. path,
                linenr = tonumber(linenr),
            }
        end
    end
    return fixtures
end

local fixtures = {}

local function get_root()
    local clients = vim.lsp.get_active_clients()

    for _, client in ipairs(clients) do
        if client.name == "pyright" then
            -- root_dir = client.config.root_dir or client.config.workspace_folders[1].uri
            root_dir = client.config.root_dir
        end
    end
    return root_dir
end
local function fetch_fixtures()
    local cwd = get_root()
    if cwd ~= nil then
        Job:new({
            command = "pytest",
            args = { "--fixtures", "-v" },
            cwd = cwd,
            on_exit = vim.schedule_wrap(function(j, return_val)
                if return_val == 0 then
                    fixtures = parse_raw_fixture_output(cwd, j:result())
                else
                    vim.notify(string.format("failed to query fixtures: %s", table.concat(j:result(), "\n")))
                end
            end),
        }):start()
    end
end

function M.jump()
    local fixture = get_word_under_cursor()
    local fixture_location = fixtures[fixture]
    if fixture_location == nil then
        vim.notify(string.format('fixture "%s" not found', fixture))
    else
        local file = fixture_location.file
        local linenr = fixture_location.linenr
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file ~= file then
            vim.cmd("edit " .. file)
        end
        -- vim.api.nvim_command("edit " .. file)
        vim.api.nvim_win_set_cursor(0, { linenr, 0 })
        vim.fn.search(fixture)
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("FetchFixturesOnLsp", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "pyright" then
            fetch_fixtures()
        end
    end
})

return M
