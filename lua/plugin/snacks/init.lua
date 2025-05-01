local pconf = "plugin.snacks."

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		explorer = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		picker = require(pconf .. "picker").opts,
		scroll = { enabled = true },
	},
	keys = require(pconf .. "picker").keymaps,
}
