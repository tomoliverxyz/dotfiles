return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'thehamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio'
  },
  lazy = false,
  config = function()
    local dap = require('dap')
    local ui = require('dapui')

    require('nvim-dap-virtual-text').setup({})
    ui.setup({})

    -- auto open dapui on attach/launch
    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    -- auto close dapui on terminated/exited
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end

    -- adapters
    dap.adapters.lldb = {
      type = 'executable',
      command = vim.fn.exepath 'lldb-dap',
      name = 'lldb'
    }

    -- configurations
    dap.configurations.c = {
      {
        name = 'launch lldb',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        stopOnEntry = true
      }
    }
    dap.configurations.cpp = dap.configurations.c

    -- keybinds
    vim.keymap.set('n', '<leader>dd', dap.toggle_breakpoint, {})
    vim.keymap.set('n', '<F1>', dap.continue, {})
    vim.keymap.set('n', '<F2>', dap.step_into, {})
    vim.keymap.set('n', '<F3>', dap.step_over, {})
    vim.keymap.set('n', '<F4>', dap.step_out, {})
    vim.keymap.set('n', '<F5>', dap.step_back, {})
    vim.keymap.set('n', '<F12>', dap.restart, {})
  end
}
