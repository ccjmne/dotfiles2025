return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function() vim.cmd.colorscheme 'catppuccin' end,
  opts = {
    -- Use colors.none to revert something's colour
    -- See available colours at: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
    custom_highlights = function(colors)
      -- C = require('catppuccin.palettes').get_palette 'mocha'
      -- U = require 'catppuccin.utils.colors'
      return {
        LineNr = { fg = colors.overlay2 },
        LineNrAbove = { fg = colors.overlay0 },
        LineNrBelow = { fg = colors.overlay0 },
        NonText = { fg = colors.mantle, bg = colors.text },
        ExtraWhitespace = { fg = colors.surface0, bg = colors.red },
        Whitespace = { fg = colors.surface0 },
        MiniStatuslineInactive = { fg = colors.overlay2 },
        TelescopeBorder = { fg = colors.surface0 },
        TelescopeMultiSelection = { fg = colors.yellow },
        TelescopePromptBorder = { fg = colors.surface2 },
        TelescopePromptPrefix = { fg = colors.blue },
        TelescopeSelectionCaret = { fg = colors.yellow, bg = colors.surface0 },
        TelescopeTitle = { fg = colors.blue },
      }
    end,
    show_end_of_buffer = true,
    integrations = {
      dap = true,
      dap_ui = true,
      mason = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
    },
  },
}
