if vim.loader then
    vim.loader.enable()
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, ' ', '<nop>', { silent = true })

-- Enable support for nerdfont (#nerdfont)
vim.g.have_nerd_font = false

-- User options (#opts) --
-- See `:help vim.opt` and `:help option-list` for more information
local options = {
    -- Enable auto indentation
    autoindent = true,

    -- Enable break indent
    breakindent = true,

    -- Confirmation for unsaved file
    confirm = true,

    -- Show which line the cursor is on
    cursorline = true,

    -- Encoding
    encoding = 'utf-8',
    fileencoding = 'utf-8',

    -- Make relative number default
    relativenumber = true,

    -- Enable termguicolors
    termguicolors = true,

    -- Make mouse movement smoother
    smoothscroll = true,

    -- Don't show edit mode
    showmode = true,

    -- Make cursor a single block
    guicursor = '',

    -- Keep signcolumn on by default
    signcolumn = 'yes',

    -- Mouse options: "a" all, "n" normal, "i" insert, "v" visual
    mouse = 'n',

    -- Configure how new splits should be opened
    splitright = true,
    splitbelow = true,

    -- Configure search behaviours
    ignorecase = true,
    smartcase = true,
    incsearch = true,
    hlsearch = false,

    -- Save undo history to undodir
    swapfile = false,
    backup = false,
    undofile = true,

    -- Configure tab indent
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    -- Configure characters display in the editor
    list = true,
    listchars = { tab = '| ', trail = '·', nbsp = '␣' },
    fillchars = { msgsep = '─' },

    -- Configure how completion menus behave
    completeopt = 'menuone,noselect,noinsert',
    pumheight = 15,

    -- Preview substitutions live, as w type
    inccommand = 'split',

    -- Hide tabline
    showtabline = 0,

    -- Allow only n command line
    cmdheight = 1,

    -- Decrease update time
    updatetime = 300,

    -- Decrease mapped sequence wait time
    timeoutlen = 500,
    ttimeoutlen = 10,

    -- Default wrap option
    wrap = false,
    linebreak = true,

    -- Default float border
    winborder = 'rounded',

    -- Stay center
    scrolloff = 10,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Short messages
vim.opt.shortmess:append {
    w = true,
    s = true,
}

-- Disable unsused default plugin (#disable) --
local disabled_built_ins = {
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
    'spellfile_plugin',
    'matchit',
    'python3_provider',
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
end

-- Sync clipboard between OS and Neovim
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)
--(#opts)

-- User commands (#ucmd) --
vim.api.nvim_create_user_command('ToggleWrap', function()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify('Wrap ' .. (vim.wo.wrap and 'enabled' or 'disabled'), vim.log.levels.INFO)
end, { desc = 'Toggle wrap in current buffer', nargs = 0 })
--(#ucmd)

-- User auto-commands (#acmd) --
---@param desc string
local augroup = function(desc)
    return vim.api.nvim_create_augroup('user/' .. desc, { clear = true })
end

-- source:
vim.api.nvim_create_autocmd('BufHidden', {
    group = augroup 'delete_no_name',
    desc = 'Delete [No Name] buffers',
    callback = function(args)
        if args.file == '' and vim.bo[args.buf].buftype == '' and not vim.bo[args.buf].modified then
            vim.schedule(function()
                pcall(vim.api.nvim_buf_delete, args.buf, {})
            end)
        end
    end,
})

-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/autocmds.lua#L29
vim.api.nvim_create_autocmd('FileType', {
    group = augroup 'close_with_q',
    desc = 'Close with <q>',
    pattern = {
        'git',
        'help',
        'man',
        'qf',
        'scratch',
        'grug-far',
    },
    callback = function(args)
        vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
    end,
})

-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/autocmds.lua#L44
vim.api.nvim_create_autocmd('CmdwinEnter', {
    group = augroup 'execute_cmd_and_stay',
    desc = 'Execute command and stay in the command-line window',
    callback = function(args)
        vim.keymap.set({ 'n', 'i' }, '<S-CR>', '<cr>q:', { buffer = args.buf })
    end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    group = augroup 'last_location',
    desc = 'Go to the last location when opening a buffer',
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd 'normal! g`"zz'
        end
    end,
})

-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/autocmds.lua#L118C1-L125C3
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup 'hl_on_yank',
    desc = 'Highlight on yank',
    callback = function()
        -- Setting a priority higher than the LSP references one.
        vim.hl.on_yank { higroup = 'Visual', priority = 250 }
    end,
})
--(#acmd)

-- LSP config (#lsp) --
local methods = vim.lsp.protocol.Methods

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    -- Keymap
    local M = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    M('[d', function()
        vim.diagnostic.jump { count = -1 }
    end, 'Previous diagnostic')
    M(']d', function()
        vim.diagnostic.jump { count = 1 }
    end, 'Next diagnostic')
    M('[e', function()
        vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
    end, 'Previous error')
    M(']e', function()
        vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
    end, 'Next error')

    -- Features: Highlight word under cursor
    -- source: https://github.com/dam9000/kickstart-modular.nvim/blob/master/lua/kickstart/plugins/lspconfig.lua#L125
    if client:supports_method(methods.textDocument_documentHighlight, bufnr) then
        local highlight_augroup = vim.api.nvim_create_augroup('user/lsp_highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('user/lsp_detach', { clear = true }),
            callback = function(_args)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = _args.buf }
            end,
        })
    end

    -- Features: Adding inlay hints command if supported (remember to enable features in server config)
    -- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/commands.lua#L6C1-L12C49
    if client:supports_method(methods.textDocument_inlayHint, bufnr) then
        vim.api.nvim_create_user_command('LspInlayHints', function()
            local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
            vim.lsp.inlay_hint.enable(not enabled)

            vim.notify(string.format('%s inlay-hints', enabled and 'Disable' or 'Enable'), vim.log.levels.INFO)
        end, { desc = 'Toggle inlay hints', nargs = 0 })
    end
end

-- Update features when registering dynamic capbilities
-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L216
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
        return
    end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

-- Enable LSP servers
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user/lsp_attach', { clear = true }),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true, -- ensure cmd runs only once, then automatically removed
    callback = function()
        local servers = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ':t:r')
            end)
            :totable()

        vim.lsp.enable(servers)
    end,
})
--(#lsp)

-- Diagnostic config (#diag) --
-- See :help vim.diagnostic.Opts for more details
local dicons = require('icon').diagnostics

-- Define the diagnostic signs.
-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L146
for severity, icon in pairs(dicons) do
    local hl = 'DiagnosticSign' .. severity:sub(1, 1) .. severity:sub(2):lower()
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

vim.diagnostic.config {
    virtual_text = {
        prefix = '',
        spacing = 2,
        format = function(diagnostic)
            -- Use shorter, nicer names for some sources:
            local special_sources = {
                ['Lua Diagnostics.'] = 'lua',
                ['Lua Syntax Check.'] = 'lua',
            }

            local message = dicons[vim.diagnostic.severity[diagnostic.severity]]
            if diagnostic.source then
                message = string.format('%s %s', message, special_sources[diagnostic.source] or diagnostic.source)
            end
            if diagnostic.code then
                message = string.format('%s[%s]', message, diagnostic.code)
            end

            return message .. ' '
        end,
    },
    float = {
        border = 'rounded',
        source = 'if_many',
        -- Show severity icons as prefixes.
        prefix = function(diag)
            local level = vim.diagnostic.severity[diag.severity]
            local prefix = string.format(' %s ', dicons[level])
            return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
        end,
    },

    -- Disable signs in the gutter.
    signs = false,
}

-- Override the virtual text diagnostic handler so that the most severe diagnostic is shown first.
local show_handler = vim.diagnostic.handlers.virtual_text.show
assert(show_handler)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide
vim.diagnostic.handlers.virtual_text = {
    show = function(ns, bufnr, diagnostics, opts)
        table.sort(diagnostics, function(diag1, diag2)
            return diag1.severity > diag2.severity
        end)
        return show_handler(ns, bufnr, diagnostics, opts)
    end,
    hide = hide_handler,
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
})
--(#diag)--

-- Install plugin (#lazy) --
require 'init'
--(#lazy)

-- Useful user-defined builtin keymaps (#keymap)
local keys = {
    -- Disable mouse and arrow movement
    { 'n', '<left>', '<cmd>echo "Use h to move!!"<CR>' },
    { 'n', '<right>', '<cmd>echo "Use l to move!!"<CR>' },
    { 'n', '<up>', '<cmd>echo "Use k to move!!"<CR>' },
    { 'n', '<down>', '<cmd>echo "Use j to move!!"<CR>' },

    -- Remove highlight after search
    { 'n', '<Esc>', '<cmd>nohlsearch<CR>' },

    -- Keep screen centered when moving around
    { 'n', '*', '*zzzv' },
    { 'n', '#', '#zzzv' },
    { 'n', ',', ',zzzv' },
    { 'n', ';', ';zzzv' },
    { 'n', 'n', 'nzzzv' },
    { 'n', 'N', 'Nzzzv' },

    -- Keep selected after moving with < and >
    { 'v', '<', '<gv' },
    { 'v', '>', '>gv' },

    -- Seemlessly naviagate between split windows
    { 'n', '<C-h>', ':wincmd h<cr>', { desc = 'Move focus to the left window', silent = true } },
    { 'n', '<C-l>', ':wincmd l<cr>', { desc = 'Move focus to the right window', silent = true } },
    { 'n', '<C-j>', ':wincmd j<cr>', { desc = 'Move focus to the lower window', silent = true } },
    { 'n', '<C-k>', ':wincmd k<cr>', { desc = 'Move focus to the upper window', silent = true } },

    -- Better vertical movement with word wrap
    { 'n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
    { 'n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },

    -- Windows size adjustment
    { 'n', '<C-Left>', ':vertical resize +10<CR>', { silent = true } },
    { 'n', '<C-Right>', ':vertical resize -10<CR>', { silent = true } },
    { 'n', '<C-Up>', ':resize +10<CR>', { silent = true } },
    { 'n', '<C-Down>', ':resize -10<CR>', { silent = true } },

    -- Windows splits
    { 'n', '<C-w>"', '<cmd>split<cr>', { noremap = true, desc = 'Split window horizontally', silent = true } },
    { 'n', '<C-w>%', '<cmd>vsplit<cr>', { noremap = true, desc = 'Split window vertically', silent = true } },
}

vim.iter(keys):map(function(v)
    vim.keymap.set(v[1], v[2], v[3], v[4] or {})
end)
--(#keymap)

-- Disable statusbar (#statb) --
vim.opt.laststatus = 0
vim.opt.statusline = '%#HorSplit#'
--(#stats)

-- Winbar config (#winb) --
--(#winb)
