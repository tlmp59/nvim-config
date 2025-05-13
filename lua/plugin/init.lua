local M = {
    -- Colorscheme
    {
        'rebelot/kanagawa.nvim',
        priority = 1000,
        opts = {
            colors = {
                theme = { all = { ui = { bg_gutter = 'none' } } },
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    NormalFloat = { bg = 'none' },
                    FloatBorder = { bg = 'none' },
                    FloatTitle = { bg = 'none' },
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_m3 },
                    PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    BlinkCmpMenu = { bg = 'none' },
                    BlinkCmpMenuBorder = { fg = theme.ui.fg_dim, bg = 'none' },
                }
            end,
        },
        config = function(_, opts)
            require('kanagawa').setup(opts)
            vim.cmd.colorscheme 'kanagawa'
        end,
    },
}

return M
