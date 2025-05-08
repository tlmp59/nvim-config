local M = vim.keymap.set

-- Disable mouse and arrow movement
M('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
M('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
M('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
M('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Remove highlight after search
M('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Mouse movement with word wrap --
M('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
M('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keep screen centered when moving around
M('n', '*', '*zzzv')
M('n', '#', '#zzzv')
M('n', ',', ',zzzv')
M('n', ';', ';zzzv')
M('n', 'n', 'nzzzv')
M('n', 'N', 'Nzzzv')

-- Keep selected after moving with < and >
M('v', '<', '<gv')
M('v', '>', '>gv')

-- Seemlessly naviagate between split windows
M('n', '<C-h>', ':wincmd h<cr>', { desc = 'Move focus to the left window', silent = true })
M('n', '<C-l>', ':wincmd l<cr>', { desc = 'Move focus to the right window', silent = true })
M('n', '<C-j>', ':wincmd j<cr>', { desc = 'Move focus to the lower window', silent = true })
M('n', '<C-k>', ':wincmd k<cr>', { desc = 'Move focus to the upper window', silent = true })

-- Change window postision
M('n', '<C-w>h', ':wincmd H<CR>', { desc = 'Change window position to far left', silent = true })
M('n', '<C-w>l', ':wincmd L<CR>', { desc = 'Change window position to far right', silent = true })
M('n', '<C-w>j', ':wincmd J<CR>', { desc = 'Change window position to far bottom', silent = true })
M('n', '<C-w>k', ':wincmd K<CR>', { desc = 'Change window position to far top', silent = true })

-- Windows size adjustment
M('n', '<C-Left>', ':vertical resize +10<CR>', { silent = true })
M('n', '<C-Right>', ':vertical resize -10<CR>', { silent = true })
M('n', '<C-Up>', ':resize +10<CR>', { silent = true })
M('n', '<C-Down>', ':resize -10<CR>', { silent = true })

-- Windows manipulations
M('n', '<C-w>"', '<cmd>split<cr>', { noremap = true, desc = 'Split window horizontally', silent = true })
M('n', '<C-w>%', '<cmd>vsplit<cr>', { noremap = true, desc = 'Split window vertically', silent = true })
