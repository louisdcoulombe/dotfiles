return {
  'jvdmeulen/json-fold.nvim',
  config = function()
    require('json-fold').setup()

    -- keybinding for the min (un-)fold actions
    vim.api.nvim_set_keymap('n', '<leader>jc', ':JsonFoldFromCursor<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>jd', ':JsonUnfoldFromCursor<CR>', { noremap = true, silent = true })

    -- keybinding for the max (un-)fold actions
    vim.api.nvim_set_keymap('n', '<leader>jC', ':JsonMaxFoldFromCursor<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>jD', ':JsonMaxUnfoldFromCursor<CR>', { noremap = true, silent = true })
  end,
}
