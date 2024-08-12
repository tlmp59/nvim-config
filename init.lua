vim.loader.enable()

-- load setting for setup
require("config.setting").global()

-- load lazy plugin manager
require("config.manager")

--- load autocmds
local autocmd = require("config.autocmd")
autocmd.restore_cursor_position_in_file()
autocmd.hl_yanked_text()
autocmd.hide_unnamed_buf_on_startup()
autocmd.call_starter_when_no_buf()

--- load keymaps
local keymap = require("config.keymap")
keymap.M_unused()
keymap.M_utils()
keymap.M_buftabwin()
