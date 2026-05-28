return {
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup()
    end,
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
  },
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup()
      vim.keymap.set('n', '<leader>rn', ':IncRename ', { desc = 'Rename' })
    end,
  },
}
