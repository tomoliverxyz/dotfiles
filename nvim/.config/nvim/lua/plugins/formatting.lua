return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      formatters = {
        ['clang-format'] = {
          prepend_args = { '--style=file', '--fallback-style=LLVM' }
        }
      },
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' }
      },
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 500
      }
    })
  end
}
