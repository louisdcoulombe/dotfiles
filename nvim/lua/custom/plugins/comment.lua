return {
  'numToStr/Comment.nvim',
  config = function()
    local cm = require 'Comment.api'

    vim.keymap.set('n', 'gc', function()
      cm.toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
    end, { desc = 'Toggle comment line' })

    vim.keymap.set('v', 'gc', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = 'Toggle comment for selection' })
  end,
}
