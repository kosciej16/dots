local opt = vim.opt
local g = vim.g
local map = vim.keymap.set

opt.number = true
opt.visualbell = true
opt.wildmode = "list:longest,full"
opt.wildignore = "*.o,*~,*.pyc"

local undodir = vim.fn.expand('$HOME') .. '/.nvim/undodir'

if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, 'p', 0700)
end

opt.undodir = undodir
opt.undofile = true
opt.swapfile = false
opt.encoding = "utf-8"
opt.whichwrap:append "<,>,h,l"
opt.lazyredraw = true
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.scrolloff = 3
opt.matchpairs:append "<:>"
opt.hidden = true
opt.smartindent = true
opt.nrformats = ""
opt.tags = "~/.nvim/python_tags;/"
opt.synmaxcol = 1500 -- avoid slow rendering for long lines"
opt.autoread = true
vim.cmd([[
  autocmd CursorHold,CursorHoldI * checktime
  " Optionally, you can tweak the update time
  set updatetime=1000  " 1000 milliseconds
]])


-- Formatting
opt.tabstop = 4
opt.shiftwidth = 0
opt.softtabstop = 8
opt.expandtab = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.gdefault = true

map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })
map({ 'n', 'v', 's', 'o' }, ';', ':')
map('n', '<C-s>', ':update<CR>', { noremap = true })
map('n', '\'', '`', { noremap = true })
map('n', '`', '\'', { noremap = true })
map('n', '`', '\'', { noremap = true })
map('n', '<leader>/', ':nohlsearch<CR>', { noremap = true })
map('n', 'gv', '`[V`]')
map('i', '<C-r><C-r>', '<C-o>:checktime<CR>', { noremap = true, silent = true })



map('v', '<C-s>', '<C-C>:update<CR>', { noremap = true })
map('v', '<C-c>', '"+y', { noremap = true })
map('v', '<C-x>', '"+d', { noremap = true })
map('v', 'p', '"_dP', { noremap = true })

map('i', '<C-v>', '<C-r>+', { noremap = true })
map('i', 'jk', '<ESC>', { noremap = true })
map('i', '<C-s>', '<C-O>:update<CR>', { noremap = true })

map('c', '<C-P>', '<Up>', { noremap = true })
map('c', '<C-N>', '<Down>', { noremap = true })

local function open_last()
    -- Check if the alternate buffer is loaded
    local alt_bufnr = vim.fn.bufnr('#')
    if vim.fn.bufloaded(alt_bufnr) then
        -- Switch to the alternate buffer and delete the current one
        vim.cmd("b# | bd #")
    else
        -- If alternate buffer isn't available, go to next buffer and delete the current one
        vim.cmd("bnext | bd #")
    end
end

map('n', '<leader>q', open_last)
map('n', "<C-p>", ":bnext<CR>")
map('n', "<C-n>", ":bprev<CR>")


local function qf_toogle()
    local buffer_open = false
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == 'NvimTree' then
            buffer_open = true
            break
        end
    end

    if buffer_open then
        vim.cmd('NvimTreeClose')
        return
    end
    local opened = false
    for i = 1, vim.fn.winnr('$') do
        if vim.fn.getwinvar(i, '&syntax') == 'qf' then
            opened = true
            break
        end
    end
    if opened then
        vim.cmd('cclose')
    else
        vim.cmd('cope')
    end
end

map('n', '<C-q>', qf_toogle)

-- relative - .config/nvim/vimrc_parts/mappings.vim
map('n', '<leader>fr', ':let @+ = expand("%")<CR>', { desc = "Copy relative path" })
-- absolute - /home/kosciej/.config/nvim/vimrc_parts/mappings.vim
map('n', '<leader>ff', ':let @+ = expand("%:p")<CR>', { desc = "Copy absolute path" })
-- name - mappings.vim
map('n', '<leader>fn', ':let @+ = expand("%:t")<CR>', { desc = "Copy filename" })
-- directory - /home/kosciej/.config/nvim/vimrc_parts
map('n', '<leader>fd', ':let @+ = expand("%:p:h")<CR>', { desc = "Copy directory path" })
-- with line -  .config/nvim/vimrc_parts/mappings.vim:25
map('n', '<leader>fl', ':let @+ = join([expand("%"),  line(".")], ":")<CR>', { desc = "Copy path with line number" })
-- as import -  .config.nvim.vimrc_parts.mappings
map('n', '<leader>fi', ':let @+ = substitute(expand("%:r"), "/", ".", "g")<CR>', { desc = "Copy as python import" })
-- content
map('n', '<leader>fc', ':%y+<CR>', { desc = "" })

vim.cmd [[
command! LspRestart lua vim.lsp.stop_client(vim.lsp.get_active_clients()); vim.cmd('edit')
]]


require "core.aucommands"
require "core.keymaps"
