return {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
        local dashboard = require 'alpha.themes.dashboard'

        -- Set header
        dashboard.section.header.val = {
            [[                     ]],
            [[                     ]],
            [[                     ]],
            [[                     ]],
            [[ -. . --- ...- .. -- ]],
            [[     いただきます    ]],
            [[                     ]],
            [[                     ]],
        }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button('n', '|  new file', '<cmd>ene<CR>'),
            dashboard.button('spc e', '|  toggle file explorer', '<cmd>Yazi<CR>'),
            -- dashboard.button("spc ff", "|  find file", "<cmd>Telescope find_files<CR>"),
            -- dashboard.button("spc fw", "|  find word", "<cmd>Telescope live_grep<CR>"),
            dashboard.button('q', '|  quit', '<cmd>qa<CR>'),
        }

        -- Send config to alpha
        require('alpha').setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
    end,
}
