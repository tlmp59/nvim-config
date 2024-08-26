return {
	"folke/zen-mode.nvim",
	keys = require("config.keymap").M_zenmode,
	cmd = { "ZenMode" },
	opts = {
		window = {
			backdrop = 1,
			width = 0.65,
		},
		plugins = {
			options = {
				ruler = true,
				showcmd = true,
			},
		},
	},
}
