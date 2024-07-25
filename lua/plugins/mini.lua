-- [[ Description ]]

-- [[ Config ]]
return {
    'echasnovski/mini.nvim',
    config = function()
      -->  better around/inside textobjects
      require('mini.ai').setup { n_lines = 500 }
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote

      -->  surroudings
      require('mini.surround').setup()
      -- Example: 
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']

      -->  clue
      require('mini.clue').setup({
        triggers = {
          {mode = 'n', keys = '<Leader>'},
          {mode = 'n', keys = 's'},

          {mode = 'n', keys = '<C-w>'},
          {mode = 'x', keys = '<C-w>'},
        },
        window = {
          config = { anchor = 'NE', row = 'auto', col = 'auto', width = 'auto'},
          delay = 0,
        },
      })
    end,
}
