if true then return {} end
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    { 'nvim-telescope/telescope-ui-select.nvim' },

    { 'echasnovski/mini.icons', version = false, opts = { style = 'ascii' } },
  },
  config = function()
    require 'telescope' .setup {
      defaults = {
        results_title = false,
        mappings = {
          i = { ['<c-space>'] = 'to_fuzzy_refine' },
        },
        borderchars = {
          prompt = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
          results = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
          preview = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
        },
        path_display = { 'smart' },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require 'telescope.themes' .get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    -- pcall(require('telescope').load_extension, 'fzf')
    require 'telescope' .load_extension 'ui-select'

    local builtin = require 'telescope.builtin'
    -- stylua: ignore start
      vim.keymap.set('n', '<leader>sh', function() builtin.help_tags { preview_title = '' } end,                               { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', function() builtin.keymaps { preview_title = '' } end,                                 { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function() builtin.find_files { preview_title = '' } end,                              { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', function() builtin.builtin { preview_title = '' } end,                                 { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', function() builtin.grep_string { preview_title = '' } end,                             { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', function() builtin.live_grep { preview_title = '' } end,                               { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', function() builtin.diagnostics { preview_title = '' } end,                             { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', function() builtin.resume { preview_title = '' } end,                                  { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>-',  function() builtin.oldfiles { preview_title = '', prompt_title = 'Recent Files' } end, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader>/',  function () builtin.current_buffer_fuzzy_find { preview_title = '' } end,              { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader><leader>', function() builtin.buffers { preview_title = '' } end,                           { desc = '[ ] Find existing buffers' })
    -- stylua: ignore end

    vim.keymap.set('n', '<leader>s.f', function()
      builtin.find_files { prompt_title = 'Find Hidden Files', find_command = { 'rg', '--files', '--hidden', '--glob=!.git' }, preview_title = '' }
    end, { desc = '[S]earch [.]idden [F]iles' })
    vim.keymap.set('n', '<leader>s.g', function()
      builtin.live_grep { prompt_title = 'Live Grep in Hidden Files', additional_args = { '--hidden', '--glob=!.git' }, preview_title = '' }
    end, { desc = '[S]earch [.]idden files by [G]rep' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        preview_title = '',
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config', preview_title = '' }
    end, { desc = '[S]earch [N]eovim files' })

    vim.keymap.set('n', '<leader>sm', function()
      -- TODO: figure out an elegant way to not have this hard-coded
      builtin.find_files { cwd = vim.env.HOME .. '/git/dotfiles', preview_title = '', find_command = { 'rg', '--files', '--hidden', '--glob=!.git' } }
    end, { desc = '[S]earch [M]y Dotfiles' })
  end,
}
