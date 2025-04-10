--
-- nvim lazy
--

local api = vim.api
local fn = vim.fn
local loop = vim.loop
local opt = vim.opt
local uv = vim.uv
local v = vim.v

-- install lazy
--
local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (uv or loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if v.shell_error ~= 0 then
    api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' }
    }, true, {})
    fn.getchar()
    os.exit(1)
  end
end

-- add lazy to nvim path
--
opt.rtp:prepend(lazypath)

-- load plugins
--
require('lazy').setup({
  spec = {
    { import = 'plugins' }
  },
  install = { colorscheme = { 'catppuccin' } },
  ui = { border = 'rounded' },
  checker = { enabled = false }
})
