return {
  -- colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        transparent_background = true
      })
      vim.cmd.colorscheme 'catppuccin'
    end
  },
  -- icons
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true
  },
  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = { theme = 'catppuccin' }
      })
    end
  }
}
