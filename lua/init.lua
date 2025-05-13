-- Bootstrap lazy.nvim
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

-- Setup lazy.nvim and init core plugins
require('lazy').setup({
    { -- Configure Lua LSP to recognize completion, annotations, and signatures of Neovim APIs
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },

    { -- Highlight, and code naviation (#trs)
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate', -- command to run when treesitter is installed or updated
        opts = {
            auto_install = false,
            ensure_installed = {
                -- list of parsers to install
                'c',
                'lua',
                'vim',
                'vimdoc',
                'query',
                'markdown',
                'markdown_inline',
                'yaml',
                'python',
            },

            highlight = {
                enable = true,

                -- disable treesitter on large file
                disable = function(_, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    ---@diagnostic disable-next-line: undefined-field
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },

            indent = { enable = true, disable = { 'ruby' } },
        },
    },

    { -- File auto format (#fmt)
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        cmd = 'ConformInfo',
        opts = {
            notify_on_error = false,

            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return {
                        timeout_ms = 500,
                        lsp_format = 'fallback',
                    }
                end
            end,

            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'isort', 'black' },
                -- For filetypes without a formatter:
                ['_'] = { 'trim_whitespace', 'trim_newlines' },

                -- You can use 'stop_after_first' to run the first available formatter from the list
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },
        },
    },

    { -- Code auto completion (#cmp)
        'saghen/blink.cmp',
        event = 'InsertEnter',
        version = '1.*',
        dependencies = {
            -- Snippets engine
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                    -- Build step is needed for regex support in snippets.
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
                opts = {},
            },
        },

        opts = {
            keymap = { preset = 'default' },
            appearance = { nerd_font_variant = 'mono' },
            completion = {
                list = {
                    -- Insert items while navigating the completion list.
                    selection = { preselect = false, auto_insert = true },
                    max_items = 10,
                },

                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { auto_show = true },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                },
            },
            snippets = { preset = 'luasnip' },

            -- Blink.cmp includes an optional, recommended rust fuzzy matcher, which automatically downloads a prebuilt binary when enabled.
            -- See :h blink-cmp-config-fuzzy for more information
            fuzzy = { implementation = 'lua' },

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = true },
        },

        config = function(_, opts)
            require('blink.cmp').setup(opts)

            -- Extend neovim's client capabilities with the completion ones
            vim.lsp.config('*', { capabilities = require('blink-cmp').get_lsp_capabilities(nil, true) })
        end,
    },

    { -- Check for code errors without actual running code (#lnt)
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require 'lint'
            lint.linters_by_ft = {
                -- <filetype> = { "<linter>" },
            }

            -- Autocommand which triggers linting on the specified events
            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    -- Only run the linter in buffers that is modifiable
                    if vim.opt_local.modifiable:get() then
                        lint.try_lint()
                    end
                end,
            })
        end,
    },

    { -- Fuzzy find (#fzf)
    },

    { -- File explorer (#exp)
        'mikavilpas/yazi.nvim',
        cmd = 'Yazi',
        opts = {
            open_for_directories = true,
            keymaps = {
                show_help = '<f1>',
            },
            floating_window_scaling_factor = 0.8,
            yazi_floating_window_border = 'rounded',
        },
    },

    { import = 'plugin' }, -- other optional plugins
}, {
    ui = { border = 'rounded' },
    change_detection = { notify = false },
    rocks = { enabled = false },
})
