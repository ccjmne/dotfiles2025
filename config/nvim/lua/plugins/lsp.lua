return {
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    keys = function(_, keys)
      local inline = true
      return {
        {
          '<Leader>tq',
          function()
            inline = not inline
            vim.diagnostic.config { virtual_text = inline, virtual_lines = not inline }
          end,
          desc = '[T]oggle Diagnostics Style',
        },
        unpack(keys),
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      require 'mason'.setup {}
      require 'mason-lspconfig'.setup()
      require 'lspconfig'.lua_ls.setup {}
      require 'lspconfig'.ts_ls.setup {}
      require 'lspconfig'.rust_analyzer.setup {}
    end
  },
}
