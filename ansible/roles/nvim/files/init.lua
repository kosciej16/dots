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
require("lazy").setup({{import = "plugins"}})

vim.cmd.colorscheme "catppuccin"

require "core"


function Foo(bufnr)
    print(bufnr)
end
