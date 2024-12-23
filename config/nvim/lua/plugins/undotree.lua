return {
  'mbbill/undotree',
  keys = {
    { '<Leader>tu', '<CMD>UndotreeToggle<CR>', desc = 'Toggle Undotree' },
  },
  config = function()
    vim.g.undotree_WindowLayout = 1
    vim.g.undotree_DiffAutoOpen = 0
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_HelpLine = 0
    vim.g.undotree_DiffCommand = 'git diff --no-index'
    vim.g.undotree_SplitWidth = 30
  end,
}
