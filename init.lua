if vim.loader then
    vim.loader.enable()
end

-- Set leader key before loading plugins --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, ' ', '<nop>', { silent = true })

-- Enable nerd font support --
vim.g.have_nerd_font = false

-- Import config modules --
require 'config'

-- Bootstrap lazy.nvim --
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

-- Put lazy into the runtimepath(rtp)
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup ('plugin', {
    change_detection = { notify = false },
    rocks = { enabled = false },
})
