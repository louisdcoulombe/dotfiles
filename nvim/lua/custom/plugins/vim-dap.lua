return {
  {
    'mfussenegger/nvim-dap',
    config = function() end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('mason').setup()
      require('mason-nvim-dap').setup {
        ensure_installed = { 'stylua', 'debugpy', 'delve' },
        handlers = {}, -- sets up dap in the predefined manner
      }
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      {
        'rcarriga/cmp-dap',
        dependencies = { 'nvim-cmp' },
      },
    },
    config = function()
      require('neodev').setup {
        library = { plugins = { 'nvim-dap-ui' }, types = true },
      }

      require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
        sources = {
          { name = 'dap' },
        },
      })

      require('dapui').setup()
      local dap, dapui = require 'dap', require 'dapui'
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end, { desc = 'Debugger: Start' })

      -- maps.n["<F17>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
      vim.keymap.set('n', '<F17>', function()
        dap.terminate()
      end, { desc = 'Debugger: Start' })

      -- maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
      vim.keymap.set('n', '<F29>', function()
        dap.restart_frame()
      end, { desc = 'Debugger: Restart' })
      -- maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
      vim.keymap.set('n', '<F6>', function()
        dap.pause()
      end, { desc = 'Debugger: Pause' })
      -- maps.n["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
      vim.keymap.set('n', '<F9>', function()
        dap.toggle_breakpoint()
      end, { desc = 'Debugger: Toggle Breakpoint' })

      -- maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
      vim.keymap.set('n', '<F10>', function()
        dap.step_over()
      end, { desc = 'Debugger: Step Over (F10)' })

      vim.keymap.set('n', '<leader>bo', function()
        dap.step_over()
      end, { desc = 'Debugger: Step Over (F10)' })

      -- maps.n["<leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F11)" }
      vim.keymap.set('n', '<leader>bi', function()
        dap.step_into()
      end, { desc = 'Debugger: Step Over (F11)' })

      -- maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
      vim.keymap.set('n', '<F11>', function()
        dap.step_into()
      end, { desc = 'Debugger: Step Into' })

      -- maps.n["<F23>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" } -- Shift+F11
      vim.keymap.set('n', '<F23>', function()
        dap.step_out()
      end, { desc = 'Debugger: Step Out' })

      -- maps.n["<leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (S-F11)" }
      vim.keymap.set('n', '<leader>bO', function()
        dap.step_out()
      end, { desc = 'Debugger: Step Over (S-F11)' })
      --

      -- maps.n["<leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
      vim.keymap.set('n', '<leader>bb', function()
        dap.toggle_breakpoint()
      end, { desc = 'Debugger: Toggle Breakpoint' })
      -- maps.n["<leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
      vim.keymap.set('n', '<leader>bB', function()
        dap.clear_breakpoints()
      end, { desc = 'Debugger: Toggle Breakpoint' })

      -- maps.n["<leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
      vim.keymap.set('n', '<leader>bc', function()
        dap.continue()
      end, { desc = 'Debugger: Continue (F5)' })

      -- maps.n["<leader>dC"] = {
      vim.keymap.set('n', '<leader>bC', function()
        vim.ui.input({ prompt = 'Condition: ' }, function(condition)
          if condition then
            require('dap').set_breakpoint(condition)
          end
        end)
      end, { desc = 'Conditional Breakpoint (S-F9)' })

      -- maps.n["<leader>dq"] = { function() require("dap").close() end, desc = "Close Session" }
      vim.keymap.set('n', '<leader>bq', function()
        dap.close()
      end, { desc = 'Debugger: Close session' })

      -- maps.n["<leader>dQ"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F5)" }
      vim.keymap.set('n', '<leader>bQ', function()
        dap.terminate()
      end, { desc = 'Debugger: Terminate (S-F5)' })

      -- maps.n["<leader>dp"] = { function() require("dap").pause() end, desc = "Pause (F6)" }
      vim.keymap.set('n', '<leader>bp', function()
        dap.pause()
      end, { desc = 'Debugger: Pause (F6)' })

      -- maps.n["<leader>dr"] = { function() require("dap").restart_frame() end, desc = "Restart (C-F5)" }
      vim.keymap.set('n', '<leader>bf', function()
        dap.restart_frame()
      end, { desc = 'Debugger: Restart (C-F5)' })

      -- maps.n["<leader>ds"] = { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" }
      vim.keymap.set('n', '<leader>bs', function()
        dap.run_to_cursor()
      end, { desc = 'Debugger: Run to cursor' })

      vim.keymap.set('n', '<leader>bE', function()
        vim.ui.input({ prompt = 'Expression: ' }, function(expr)
          if expr then
            require('dapui').eval(expr, { enter = true })
          end
        end)
      end, { desc = 'Evaluate Input' })
      --
      --   maps.v["<leader>dE"] = { function() require("dapui").eval() end, desc = "Evaluate Input" }
      vim.keymap.set('n', '<leader>bE', function()
        dapui.eval()
      end, { desc = 'Debugger: Evaluate input' })

      --   maps.n["<leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
      vim.keymap.set('n', '<leader>bu', function()
        dapui.toggle()
      end, { desc = 'Debugger: Toggle debugger UI' })

      --   maps.n["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }
      vim.keymap.set('n', '<leader>bh', function()
        dapui.hover()
      end, { desc = 'Debugger: Debugger Hover' })
    end,
  },
}
