return {
    { -- Auto detect indentation (#guess-indent)
        'nmac427/guess-indent.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {},
    }, --(#guess-indent)

    { -- Better copy/paste (#yanky)
        'gbprod/yanky.nvim',
        opts = {
            ring = { history_length = 20 },
            highlight = { timer = 250 },
        },
        keys = {
            { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
            { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
            { '=p', '<Plug>(YankyPutAfterLinewise)', desc = 'Put yanked text in line below' },
            { '=P', '<Plug>(YankyPutBeforeLinewise)', desc = 'Put yanked text in line above' },
            { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle forward through yank history' },
            { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle backward through yank history' },
            { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yanky yank' },
        },
    }, --(#yanky)

    { -- Search/replace in multiple files (#grug-far)
        'MagicDuck/grug-far.nvim',
        opts = { headerMaxWidth = 80 },
        cmd = 'GrugFar',
        keys = {
            {
                '<leader>sr',
                function()
                    local grug = require 'grug-far'
                    local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
                    grug.open {
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
                        },
                    }
                end,
                mode = { 'n', 'v' },
                desc = 'Search and Replace',
            },
        },
    }, --(#grug-far)

    { -- File explorer (#yazi)
        'mikavilpas/yazi.nvim',
        event = 'VeryLazy',
        dependencies = {
            'folke/snacks.nvim',
            'nvim-lua/plenary.nvim',
        },

        -- stylua: ignore
        keys = {
            { '-', mode = { 'n', 'v' }, '<cmd>Yazi<cr>', desc = 'Open yazi at the current file', },
            { '<leader>e', '<cmd>Yazi cwd<cr>', desc = "Open the file manager in nvim's working directory", },
        },

        opts = {
            open_for_directories = true,
            floating_window_scaling_factor = 1,
            yazi_floating_window_border = 'none',
        },
    }, --(#yazi)

    { -- Quarto support (#quarto-nvim)
        'quarto-dev/quarto-nvim',
        ft = { 'quarto', 'markdown', 'rmarkdown' },

        dependencies = {
            { -- LSP features and a code completion source for embedded code (#otter)
                'jmbuhr/otter.nvim',
                dependencies = { 'nvim-treesitter/nvim-treesitter' },
                opts = {},
            },

            { -- Markdown table generator (#vim-table-mode)
                'dhruvasagar/vim-table-mode',
                cmd = 'TableModeToggle',
                config = function()
                    vim.g.table_mode_corner = '|'
                end,
            },
        },

        opts = {
            debug = false,
            closePreviewOnExit = false,
            lspFeatures = {
                enabled = true,
                chunks = 'curly',
            },
            codeRunner = { enabled = false },
        },
    }, --(#quarto-nvim)

    { -- Auto closing tags for HTML and JSX
        'windwp/nvim-ts-autotag',
        event = 'InsertEnter',
        opts = {},
    },

    { -- Keymap references (#miniclue)
        'echasnovski/mini.clue',
        event = { 'BufReadPost', 'BufNewFile' },
        version = false,
        opts = function()
            local clue = require 'mini.clue'
            return {
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    clue.gen_clues.builtin_completion(),
                    clue.gen_clues.g(),
                    clue.gen_clues.marks(),
                    clue.gen_clues.registers(),
                    clue.gen_clues.windows(),
                    clue.gen_clues.z(),
                },

                window = {
                    delay = 250,
                },
            }
        end,
    }, --(#miniclue)

    { -- Autopairs (#minipairs)
        'echasnovski/mini.pairs',
        version = false,
        event = 'InsertEnter',
        opts = {},
    }, --(#minipairs)

    { -- Better text objects navigation (#miniai)
        'echasnovski/mini.ai',
        version = false,
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
        opts = function()
            local miniai = require 'mini.ai'

            return {
                n_lines = 300,
                custom_textobjects = {
                    f = miniai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
                    -- Whole buffer.
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line '$',
                            col = math.max(vim.fn.getline('$'):len(), 1),
                        }
                        return { from = from, to = to }
                    end,
                },
                -- Disable error feedback.
                silent = true,
                -- Don't use the previous or next text object.
                search_method = 'cover',
                mappings = {
                    -- Disable next/last variants.
                    around_next = '',
                    inside_next = '',
                    around_last = '',
                    inside_last = '',
                },
            }
        end,
    }, --(#miniai)

    { -- Hightlight pattern (#minihipatterns)
        'echasnovski/mini.hipatterns',
        version = false,
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            local hipatterns = require 'mini.hipatterns'
            hipatterns.setup {
                highlighters = {
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            }
        end,
    }, --(#minihipatterns)

    { -- Add-on surround actions (#minisurround)
        'echasnovski/mini.surround',
        version = false,
        opts = {},
    }, --(#minisurround)

    { -- Small Qoq plugins (#snacks)
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@diagnostic disable: undefined-global
        opts = function()
            local M = {}
            local enable = {
                'bufdelete',
                'git',
                'gitbrowse',
                'lazygit',
                'profiler',
                'quickfile',
                'animate',
                'zen',
            }

            for _, v in ipairs(enable) do
                M[v] = { enabled = true }
            end

            M.indent = { animate = { enabled = false } }

            M.picker = {
                ui_select = false,
                win = {
                    input = {
                        keys = {
                            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
                        },
                    },
                },
            }

            M.bigfile = {}

            M.styles = {
                lazygit = {
                    width = 0,
                    height = 0,
                },
            }

            return M
        end,

        -- stylua: ignore
        keys = { -- Snacks keymap (#snacks/keymap)
            -- #picker
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

            -- #git
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

            -- #lazygit
            { '<leader>go', function() Snacks.lazygit.open() end, desc = "Open lazygit"},

            -- #grep
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

            -- #search
            { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
            { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
            { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
            { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
            { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
            { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
            { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
            { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        }, --(#snacks/keymap)

        init = function()
            vim.api.nvim_create_user_command('ToggleZenMode', function()
                vim.g.codedim = not vim.g.codedim
                if vim.g.codedim then
                    Snacks.dim.enable()
                else
                    Snacks.dim.disable()
                end
                vim.notify('Code Dim ' .. (vim.g.codedim and 'enabled' or 'disabled'), vim.log.levels.INFO)
            end, { desc = 'Toggle wrap in current buffer', nargs = 0 })
        end,
        ---@diagnostic enable: undefined-global
    }, --(#snacks)
}
