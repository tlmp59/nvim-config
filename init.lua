-- leader must be set before loading any plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- load setting for setup
require('opt')
require('keymap')
require('manager')
require('autocmd')

