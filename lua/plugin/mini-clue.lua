return {
	--> clue
	"echasnovski/mini.clue",
	version = "*",
	config = function()
		require("mini.clue").setup({
			triggers = {
				{ mode = "n", keys = "<leader>" },
				{ mode = "v", keys = "<leader>" },

				{ mode = "n", keys = "<C-w>" },
				{ mode = "x", keys = "<C-w>" },

				{ mode = "n", keys = "s" },
				{ mode = "n", keys = "t" },
				{ mode = "n", keys = "g" },

				{ mode = "n", keys = "<C-g>" },
			},
			window = {
				config = { anchor = "SW", row = "auto", col = "auto", width = "auto", border = "single" },
				delay = 0,
			},
			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				require("mini.clue").gen_clues.builtin_completion(),
				require("mini.clue").gen_clues.g(),
				require("mini.clue").gen_clues.marks(),
				require("mini.clue").gen_clues.registers(),
				require("mini.clue").gen_clues.z(),
			},
		})
	end,
}
