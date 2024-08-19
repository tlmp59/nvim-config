vim.loader.enable()

-- load setting for setup
local setting = require("config.setting")
setting.opt_global()
setting.opt_local()

--- load default keymaps before load plugins
local keymap = require("config.keymap")
keymap.M_unused()
keymap.M_utils()
keymap.M_buftabwin()
keymap.M_info()

-- load lazy plugin manager
require("config.manager")

--- load autocmds
local autocmd = require("config.autocmd")
autocmd.restore_cursor_position_in_file()
autocmd.hl_yanked_text()
autocmd.hide_unnamed_buf_on_startup()
autocmd.disable_autoformat()
