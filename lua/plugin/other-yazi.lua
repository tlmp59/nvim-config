return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = require("config.keymap").M_yazi,
	opts = {
		open_for_directories = true,
		keymaps = {
			show_help = "<f1>",
		},
		floating_window_scaling_factor = 1.0,
		yazi_floating_window_border = "none",
	},
}
