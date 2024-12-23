return {
  'uga-rosa/translate.nvim',
  cmd = 'Translate',
  keys = function()
    local keys = {
      { '<Leader>tr', '<CMD>Translate en<CR>', mode = { 'n', 'v' }, desc = 'Translate selection to English' },
      { '<Leader>tr.', '<CMD>Translate en<CR>', mode = { 'n', 'v' }, desc = 'Translate selection to English' },
    }
    local langs = { e = 'en', d = 'de', f = 'fr' }
    for l, L in pairs(langs) do
      table.insert (keys, { '<Leader>tr'..l, '<CMD>Translate '..L..'<CR>', mode = { 'n', 'v' }, desc = 'Translate selection to '..string.upper(L) })
      table.insert (keys, { '<Leader>tr'..l..'.', '<CMD>Translate '..L..'<CR>', mode = { 'n', 'v' }, desc = 'Translate selection to '..string.upper(L) })
      for r, R in pairs(langs) do
        if r ~= l then
          table.insert (keys, {
            '<Leader>tr'..l..r,
            '<CMD>Translate '..L..' -source='..R..'<CR>',
            mode = { 'n', 'v' },
            desc = 'Translate selection to '..string.upper(L)..' from '..string.upper(R)
          })
        end
      end
    end
    return keys
  end,
  opts = {
    default = {
      command = 'google',
      output = 'replace',
    },
    parse_before = 'no_handle',
    silent = true,
  },
}
