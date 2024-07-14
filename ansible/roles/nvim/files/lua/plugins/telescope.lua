function open_config_files()
    local config_files = {
        '~/.config/nvim/init.lua',
        '~/.config/bspwm/bspwmrc',
        "~/.zshrc",
        "~/.zshenv",
        "~/.profile",
        "~/repos/other/new_comp/steps",
        "~/.gitconfig",
        "~/.config/khal/config",
        "~/.config/vdirsyncer/config",
        "~/.config/qutebrowser/config.py",
        "~/.mbsyncrc",
        "~/.msmtprc",
    }
    local globs = { "~/.config/neomutt/", "~/.config/tmux/", "~/.config/bspwm/", "~/.config/sxhkd/", "~/.aliases/"}
    for _, g in ipairs(globs) do
        for _, path in ipairs(vim.split(vim.fn.globpath(g, "*"), "\n")) do
            table.insert(config_files, path)
        end
    end

    require('telescope.builtin').find_files({
        prompt_title = 'Open Config Files',
        cwd = '~',  -- This sets the starting directory for the search
        search_dirs = config_files,  -- This tells Telescope where to look
    })
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
        map("n", "<C-[>", "<cmd> Telescope find_files follow=true<CR>")
        map("n", ",b", "<cmd> Telescope buffers<CR>")
        map("n", ",c", "<cmd> Telescope git_commits<CR>")
        map('n', ',d', '<cmd>lua open_config_files()<CR>')
    end,
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "TelescopeResults",
            command = "setlocal nofoldenable"
        })
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = require "telescope.actions".move_selection_next,
                        ["<C-k>"] = require "telescope.actions".move_selection_previous
                    }}
                },
                pickers = {
                    buffers = {
                        ignore_current_buffer = true,
                        sort_mru = true,
                    },
                },
            })
            end
        }
