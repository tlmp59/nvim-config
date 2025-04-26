-- Setting options
-- See `:help vim.opt`
-- For more options, check `:help option-list`

-- Enable auto indentation
vim.opt.autoindent = true

-- Enable break indent
vim.opt.breakindent = true

-- Confirmation for unsaved file
vim.opt.confirm = true

-- Show which line the cursor is on
vim.opt.cursorline = true

-- Make relative number default
vim.opt.relativenumber = true

-- Enable termguicolors
vim.opt.termguicolors = true

-- Make mouse movement smoother
vim.opt.smoothscroll = true

-- Don't show mode, since it already in status line
vim.opt.showmode = false

-- Make cursor a single block
vim.opt.guicursor = ''

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Mouse options: "a" all, "n" normal, "i" insert, "v" visual
vim.opt.mouse = "n"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sync clipboard between OS and Neovim
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- Configure search behaviours
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Save undo history to undodir
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Configure tab indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Hide statusline
vim.opt.laststatus = 0
vim.opt.statusline = '%#Normal#'

-- Configure whitespace characters display in the editor
vim.opt.list = true
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }

-- Configure how completion menus behave
vim.opt.completeopt = 'menuone,noselect'

-- Preview substitutions live, as w type
vim.opt.inccommand = 'split'

-- Hide nonexist line indicator
vim.opt.fillchars:append({ eob = ' ' })

-- Hide tabline
vim.opt.showtabline = 1

-- Allow only n command line
vim.opt.cmdheight = 1

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Disable unsused default plugin
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
    "python3_provider",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
