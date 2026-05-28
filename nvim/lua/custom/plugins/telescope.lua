return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of help_tags options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require 'telescope.actions'
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        mappings = {
          i = {
            -- ['<C-n>'] = actions.cycle_history_next,
            -- ['<C-p>'] = actions.cycle_history_prev,
            -- ['<C-j>'] = actions.move_selection_next,
            -- ['<C-k>'] = actions.move_selection_previous,
            ['<C-c>'] = actions.git_create_branch,
          },
          n = { q = actions.close },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Telescope::find
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = '[F]ind Marks' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fF', function()
      require('telescope.builtin').find_files { hidden = true, no_ignore = true }
    end, { desc = 'Find all files' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fG', function()
      require('telescope.builtin').live_grep {
        additional_args = function(args)
          return vim.list_extend(args, { '--hidden', '--no-ignore' })
        end,
      }
    end, { desc = '[F]ind words in all files' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
    -- vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    vim.keymap.set('n', "<leader>f'", builtin.marks, { desc = '[F]ind marks' })

    -- Telescope::Git
    vim.keymap.set('n', '<leader>gt', builtin.git_status, { desc = '[F]ind Git S[t]atus' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[F]ind git files' })
    vim.keymap.set('n', '<leader>gb', function()
      builtin.git_branches { use_file_path = true }
    end, { desc = 'Git branches' })
    vim.keymap.set('n', '<leader>gM', function()
      builtin.git_commits { use_file_path = true }
    end, { desc = 'Git commits' })
    vim.keymap.set('n', '<leader>gm', function()
      builtin.git_bcommits { use_file_path = true }
    end, { desc = 'Git commits' })
    vim.keymap.set('n', '<leader>gP', ':!git push<cr>', { desc = '[G]it [P]ush to remote' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>fo', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'fF Fuzzily search in current buffer' })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[F]ind [/] in Open Files' })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[F]ind [N]eovim files' })
    
    vim.keymap.set('n', '<leader>f.', function()
      builtin.find_files { cwd = '~/.dotfiles/' }
    end, { desc = 'Find dotfiles' })

    vim.keymap.set('n', '<leader>fz', function()
      builtin.find_files { cwd = '~/.oh-my-zsh/custom/' }
    end, { desc = 'Find in zsh config' })
  end,
}
