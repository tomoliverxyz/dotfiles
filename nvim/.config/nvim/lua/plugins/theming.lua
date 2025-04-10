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
        options = {
          theme = 'catppuccin',
          ignore_focus = {
            'dapui_watches', 'dapui_breakpoints',
            'dapui_scopes', 'dapui_console',
            'dapui_stacks', 'dap-repl'
          }
        }
      })
    end
  }
}
