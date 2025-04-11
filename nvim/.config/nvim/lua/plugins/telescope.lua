return {
  -- fzf sorter
  { 'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  -- telescope
  { 'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').load_extension('fzf')
      local builtin = require('telescope.builtin')

      -- file pickers
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      -- vim pickers
      vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
      -- git pickers
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
      vim.keymap.set('n', '<leader>gg', builtin.git_status, {})
    end
  }
}
