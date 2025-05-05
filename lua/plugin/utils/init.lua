local pconf = 'plugin.utils.'

local parsers = {
    'c',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'markdown',
    'markdown_inline',
    'yaml',
}

local formats = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    nix = { 'alejandra' },

    -- For filetypes without a formatter:
    ['_'] = { 'trim_whitespace', 'trim_newlines' },

    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
}

local lints = {
    -- <filetype> = { "<linter>" },
}

-- return vim.list_extend({
--     {
--         -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
--         'folke/lazydev.nvim',
--         ft = 'lua',
--         opts = {
--             library = {
--                 -- Load luvit types when the `vim.uv` word is found
--                 { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
--             },
--         },
--     },
-- })

return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },

    -- Tree-sitter --
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate', -- command to run when treesitter is installed or updated
        opts = require(pconf .. 'tree-sitter').setup(parsers),
    },

    -- Autocompletion --
    {
        'saghen/blink.cmp',
        event = 'InsertEnter',
        version = '1.*',
        dependencies = require(pconf .. 'blink').dependencies,
        opts = require(pconf .. 'blink').setup(),
        config = function(_, opts)
            require('blink.cmp').setup(opts)
            -- Extend neovim's client capabilities with the completion ones
            vim.lsp.config('*', {
                capabilities = require('blink-cmp').get_lsp_capabilities(nil, true),
            })
        end,
    },

    -- File Formating --
    {
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        cmd = 'ConformInfo',
        opts = require(pconf .. 'conform').setup(formats),
    },

    -- Code Analysis (Linting) --
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('lint').linters_by_ft = lints
            -- Autocommand which triggers linting on the specified events
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = vim.api.nvim_create_augroup('lint', { clear = true }),
                callback = function()
                    -- Only run the linter in buffers that is modifiable
                    if vim.opt_local.modifiable:get() then
                        require('lint').try_lint()
                    end
                end,
            })
        end,
    },
}
