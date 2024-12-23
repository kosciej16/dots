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
    local globs = { "~/.config/neomutt/", "~/.config/tmux/", "~/.config/bspwm/", "~/.config/sxhkd/", "~/.aliases/" }
    for _, g in ipairs(globs) do
        for _, path in ipairs(vim.split(vim.fn.globpath(g, "*"), "\n")) do
            table.insert(config_files, path)
        end
    end

    require('telescope.builtin').find_files({
        prompt_title = 'Open Config Files',
        cwd = '~',                  -- This sets the starting directory for the search
        search_dirs = config_files, -- This tells Telescope where to look
    })
end

local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local M = {}

local delta = previewers.new_termopen_previewer {
    get_command = function(entry)
        return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!' }
    end
}

builtin.my_git_commits = function(opts)
    opts = opts or {}
    opts.previewer = {
        delta,
        previewers.git_commit_message.new(opts),
        previewers.git_commit_diff_as_was.new(opts),
    }

    builtin.git_commits(opts)
end

M.my_git_bcommits = function(opts)
    opts = opts or {}
    opts.previewer = {
        delta,
        previewers.git_commit_message.new(opts),
        previewers.git_commit_diff_as_was.new(opts),
    }

    builtin.git_bcommits(opts)
end

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        init = function()
            map("n", "<C-[>", "<cmd> Telescope find_files follow=true<CR>")
            map("n", ",b", "<cmd> Telescope buffers<CR>")
            map("n", ",c", "<cmd> Telescope my_git_commits<CR>")
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
                        }
                    }
                },
                pickers = {
                    find_files = {
                        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
                        hidden = true
                    },
                    buffers = {
                        ignore_current_buffer = true,
                        sort_mru = true,
                    },
                },
            })
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

}
