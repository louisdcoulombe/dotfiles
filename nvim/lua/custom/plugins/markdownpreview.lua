return {
  'iamcco/markdown-preview.nvim',
  build = 'cd app && npm install',
  setup = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.keymap.set('n', '<leader>xm', ':MardownPreview<cr>', { desc = 'MarkdownPreview' })
  end,
  ft = { 'markdown' },
}
