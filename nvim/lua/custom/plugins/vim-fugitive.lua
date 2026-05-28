return {
  'tpope/vim-fugitive',
  lazy = false,
  config = function()
    vim.keymap.set('n', '<leader>gg', ':G<cr>', { desc = 'Fugitive' })
    vim.keymap.set('n', '<leader>gc', ':G commit<cr>', { desc = 'Fugitive' })
  end,
}
