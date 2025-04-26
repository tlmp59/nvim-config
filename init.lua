vim.loader.enable()

-- set leader key before loading plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- enable nerd font support
vim.g.have_nerd_font = true

-- import other modules in order
require 'option'

require 'keymap'

require 'manager'

require 'autocmd'

require('winbar').get_winbar()
