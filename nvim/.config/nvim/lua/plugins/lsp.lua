return {
  { 'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  { 'neovim/nvim-lspconfig',
    dependencies = {
      -- autocomplete
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'l3mon4d3/luasnip',
      -- installer
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      -- mason
      require('mason').setup({
        ui = { border = 'rounded' }
      })
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'cmake' }
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      local luasnip = require('luasnip')
      local cmp = require('cmp')
      local autopairs = require('nvim-autopairs.completion.cmp')

      -- servers
      local servers = { 'clangd', 'cmake' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities
        })
      end

      -- autocomplete
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' })
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' }
        },
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered()
        }
      })

      -- autopairs and autocomplete
      cmp.event:on('confirm_done', autopairs.on_confirm_done())

      -- keybindings
      vim.keymap.set('n', '<leader>mm', ':Mason<CR>', {})
    end
  }
}
