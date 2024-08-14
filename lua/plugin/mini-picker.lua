return {
	--> [[ Fuzzy searching: mini-picker ]]
	"echasnovski/mini.pick",
	version = "*",
	event = "VimEnter",
	dependencies = { "echasnovski/mini.extra", version = "*", opts = {} },
	config = function()
		local pick = require("mini.pick")

		pick.setup({
			mappings = {
				move_down = "<C-j>",
				move_up = "<C-k>",
				move_start = "<C-g>",

				scroll_down = "<C-d>",
				scroll_left = "<C-u>",
				scroll_right = "<C-l>",
				scroll_up = "<C-k>",

				stop = "<Esc>",
			},

			options = {
				use_cache = true,
				content_from_bottom = false,
			},

			window = {
				config = function()
					local height = math.floor(0.618 * vim.o.lines)
					local width = math.floor(0.618 * vim.o.columns)
					return {
						anchor = "NW",
						height = height,
						width = width,
						row = math.floor(0.5 * (vim.o.lines - height)),
						col = math.floor(0.5 * (vim.o.columns - width)),
					}
				end,
			},
		})
		require("config.keymap").M_picker()
	end,
}
