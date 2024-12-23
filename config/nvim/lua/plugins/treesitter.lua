return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'markdown', 'javascript', 'typescript', 'java', 'query', 'diff', 'gitcommit', 'git_rebase' },
        auto_install = true,
        highlight = {
          enable = true,
          language_tree = true,
          disable = function() return vim.fn.getfsize(vim.fn.expand('%')) > 1024 * 100 end,
        },
      }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'query' },
        callback = function()
          vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = 0 })
        end,
      })
    end,
  },
  {
    'Wansmer/treesj',
    keys = {
      { 'gS', '<CMD>TSJSplit<CR>', desc = 'Split TSNode' },
      { 'gJ', '<CMD>TSJJoin<CR>',  desc = 'Join TSNode' },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}
