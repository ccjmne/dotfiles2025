return {
  {
    'ntpeters/vim-better-whitespace', -- Can't be VeryLazy
    init = function()
      vim.g.show_spaces_that_precede_tabs = 1
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup {
        chunk = {
          enable = true,
          delay = 0,
          chars = { right_arrow = '─' },
          style = {
            vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('LineNrAbove')), 'fg', 'gui'),
            vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Error')), 'fg', 'gui'),
          },
        },
        indent = {
          enable = true,
        },
      }
    end
  },
}
