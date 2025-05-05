local M = {}

M.dependencies = {
    {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
            -- Build Step is needed for regex support in snippets.
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
}

M.setup = function()
    return {
        keymap = { preset = 'default' },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
            list = {
                -- Insert items while navigating the completion list.
                selection = { preselect = false, auto_insert = true },
                max_items = 10,
            },

            -- By default, you may press `<c-space>` to show the documentation.
            documentation = { auto_show = false },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'lazydev' },
            providers = {
                lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
            },
        },
        snippets = { preset = 'luasnip' },

        -- See :h blink-cmp-config-fuzzy for more information
        fuzzy = { implementation = 'prefer_rust_with_warning' },

        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = true },
    }
end

return M
