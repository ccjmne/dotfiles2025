vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.timeoutlen = 320

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'

vim.opt.undofile = true
vim.opt.updatetime = 320

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.opt.hlsearch = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', precedes = '<', extends = '>' }

require('config.utils')
require('config.lazy')
