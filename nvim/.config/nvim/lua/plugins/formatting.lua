return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      formatters = {
        zig_fmt = {
          command = 'zig fmt',
          stdin = true
        }
      },
      formatters_by_ft = {
        zig = { 'zig_fmt' }
      },
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 500
      }
    })
  end
}
