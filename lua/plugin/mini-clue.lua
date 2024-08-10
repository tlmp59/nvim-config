return {
	--> clue
	"echasnovski/mini.clue",
	version = "*",
	opts = {
		triggers = {
			{ mode = "n", keys = "<leader>" },
			{ mode = "v", keys = "<leader>" },
			{ mode = "n", keys = "s" },
			{ mode = "n", keys = "t" },

			{ mode = "n", keys = "<C-w>" },
			{ mode = "x", keys = "<C-w>" },
		},
		window = {
			config = { anchor = "SE", row = "auto", col = "auto", width = "auto", border = "rounded" },
			delay = 0,
		},
	},
}
