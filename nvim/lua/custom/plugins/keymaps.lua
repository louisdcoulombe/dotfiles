vim.keymap.set('n', ']]', ']]zz', { desc = 'Recenter when moving block' })
vim.keymap.set('n', '[[', '[[zz', { desc = 'Recenter when moving block' })

vim.keymap.set('n', '<A-Right>', ':vertical resize +5<CR>', { desc = 'Recenter when moving block' })
vim.keymap.set('n', '<A-Left>', ':vertical resize -5<CR>', { desc = 'Recenter when moving block' })
vim.keymap.set('n', '<A-Up>', ':resize +5<CR>', { desc = 'Recenter when moving block' })
vim.keymap.set('n', '<A-Down>', ':resize -5<CR>', { desc = 'Recenter when moving block' })

-- ["<leader>d"] = {"[[\"_d]]", desc="Delete without affecting buffer"},
vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank remaining line' })
vim.keymap.set('n', '<leader>p', '[["_dP]]', { desc = 'Paste from clipboard' })
-- vim.keymap.set('n', '<leader>d', '[["_d]]', { desc = 'Delete without affecting buffer' })
vim.keymap.set('n', '<leader>y', '[["+y]]', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', '[["+Y]]', { desc = 'Copy to clipboard (Y)' })
vim.keymap.set('n', '<leader><tab>', ':bn<cr>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>`', ':bp<cr>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>d', ':bd!<cr>', { desc = 'Close active buffer' })
vim.keymap.set('n', '<leader>D', ':%bd|e#', { desc = 'Close all but active buffer' })
vim.keymap.set('v', '<leader>d', '[["_d]]', { desc = 'Delete without affecting buffer' })
vim.keymap.set('n', '<leader>xj', ":%!jq '.'", { desc = 'Format JSON' })

-- Run test file if it's a test_ otherwise run pytest in folder
-- vim.keymap.set('n', '<leader>xt', function()
--   local fn = vim.fn.expand '%:p'
--   if string.find(fn, 'test_') then
--     vim.api.nvim_command '!pytest %<cr>'
--   else
--     local str = '!pytest ' .. vim.fn.expand '%:h' .. '<cr>'
--     print(str)
--     vim.api.nvim_command(str)
--   end
-- end, { desc = 'Run test file' })

-- ADVENT OF CODE PYTHON
-- vim.keymap.set('n', '<leader>xt', ':!pytest % <bar> tee %:h/test.log<cr>', { desc = 'Run test file' })
-- vim.keymap.set('n', '<leader>x1', ':!python3 % --p 0 <bar> tee %:h/out.log<cr>', { desc = 'Run Part 1' })
-- vim.keymap.set('n', '<leader>x2', ':!python3 % --p 1 <bar> tee %:h/out.log<cr>', { desc = 'Run Part 2' })

-- ADVENT OF CODE RUBY
-- Ruby test runner (using RSpec or plain ruby)
vim.keymap.set('n', '<leader>xt', ':!unset HTTP_PROXY && ruby -Ilib:test % <bar> tee %:h/test.log<cr>', { desc = 'Run Ruby test file' })

-- Ruby Part 1
vim.keymap.set('n', '<leader>x1', ':!unset HTTP_PROXY && ruby % -p 1 <bar> tee %:h/out.log<cr>', { desc = 'Run Ruby Part 1' })

-- Ruby Part 2
vim.keymap.set('n', '<leader>x2', ':!unset HTTP_PROXY && ruby % -p 2 <bar> tee %:h/out.log<cr>', { desc = 'Run Ruby Part 2' })

-- ["<leader>p"] = {"[[\"_dP]]", desc="Paste from clipboard"},
-- ["<leader>y"] = {"[[\"+y]]", desc="Copy to clipboard"},
--
-- ["<leaderapplication_idY"] = application_state
-- ["<leader>xm"] = {":MarkdownPreview<cr>", desc="MarkdownPreview"},
--
-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- vim.opt.hlsearch = true
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>%(application_id)s

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

return {}
