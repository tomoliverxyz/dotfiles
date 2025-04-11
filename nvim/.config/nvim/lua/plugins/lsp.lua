return {
  -- autopairs
  { 'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  -- lsp
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

      -- diagnostics config
      vim.diagnostic.config({ virtual_text = true })

      -- servers
      local servers = { 'clangd', 'cmake' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            -- keybind options
            local opts = { noremap = true, silent = true, buffer = bufnr }
            -- lsp keybinds
            vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, opts)
            -- telescope keybinds
            vim.keymap.set('n', '<leader>gr', ':Telescope lsp_references<CR>', opts)
            vim.keymap.set('n', '<leader>ee', ':Telescope diagnostics<CR>', opts)
          end
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

      -- keybinds
      vim.keymap.set('n', '<leader>mm', ':Mason<CR>', {})
    end
  }
}
