return { -- Autoformat
  'stevearc/conform.nvim',
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 10000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },

      ruby = { "rubocop" }, -- or "syntax_tree"
      -- Conform can also run multiple formatters sequentially
      -- python = { { 'ruff', 'black' } },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
  },
}
