vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function() vim.highlight.on_yank({ timeout = 50 }) end,
})

vim.keymap.set('n', '<Leader>x', '<CMD>.lua<CR>')
vim.keymap.set('n', '<Leader><Leader>x', '<CMD>source %<CR>')
vim.keymap.set('v', '<Leader>x', ':lua<CR>')

vim.keymap.set('n', '<Esc>', '<CMD>nohlsearch<CR>')
-- Figure out better. See https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lists.lua
-- Also consider https://github.com/kevinhwang91/nvim-bqf
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<Leader>l', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-n>', '<CMD>cnext<CR>', { desc = 'Jump to next quickfix entry' })
vim.keymap.set('n', '<C-p>', '<CMD>cprev<CR>', { desc = 'Jump to previous quickfix entry' })

vim.api.nvim_create_user_command('Title', function(opts)
  local padchar = opts.fargs[1] or '='
  local lo, hi
  if opts.count == -1 then     -- Normal mode, see https://www.petergundel.de/neovim/lua/hack/2023/12/17/get-neovim-mode-when-executing-a-command.html
    lo, hi = vim.fn.line '.', vim.fn.line '.'
  else
    _, lo = unpack(vim.fn.getpos "'<")
    _, hi = unpack(vim.fn.getpos "'>")
  end

  for i = lo, hi do
    local head = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]:gsub('%s*[%.=-]*$', '')
    local pad = (vim.bo.textwidth > 0 and vim.bo.textwidth or 80) - #head - 1     -- vim."bo" stands for Buffer Options
    if pad > 0 then
      vim.api.nvim_buf_set_lines(0, i - 1, i, false, { head .. ' ' .. string.rep(padchar, pad) })
    end
  end
end, { range = true, nargs = '?' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help' },
  callback = function()
    -- TODO: Consider mapping to :bd or :BD, along with other :q mappings
    vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = 0 })
  end,
})
