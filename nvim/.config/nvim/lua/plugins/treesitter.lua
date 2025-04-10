return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local configs = require('nvim-treesitter.configs')
    configs.setup({
      ensure_installed = {
        -- required
        'lua', 'vim', 'vimdoc', 'query',
        -- cpp development
        'c', 'cmake', 'cpp'
      },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
