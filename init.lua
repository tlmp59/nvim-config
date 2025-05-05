if vim.loader then
    vim.loader.enable()
end

-- Set leader key before loading plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, ' ', '<nop>', { silent = true })

-- Enable nerd font support
vim.g.have_nerd_font = true

-- -- Import important modules
require("bootstrap")
