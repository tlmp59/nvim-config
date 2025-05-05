return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            prompt = ' ',
            layout = { circle = false },
            ui_select = false,
            icons = {
                files = { enbled = false },
            },
            auto_close = true,
        },

        notifier = {
            padding = true,
            margin = { top = 0, right = 0, bottom = 0 },
            top_down = true,
            style = 'minimal',
        },
    },

    keys = {
        {
            '<leader>n',
            function()
                Snacks.picker.notifications()
            end,
            desc = 'Notification History',
        },
    },
}
