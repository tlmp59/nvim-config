return {
	--> clue
	"echasnovski/mini.clue",
	event = "VimEnter",
	version = "*",
	config = function()
		---@param key string
		---@param mode string
		local M = function(mode, key)
			return { mode = mode, keys = key }
		end
		require("mini.clue").setup({
			triggers = {
				M("n", "<leader>"),
				M("n", "<C-w>"),
				M("n", "s"),
				M("n", "t"),
				M("n", "g"),
				M("n", "<C-g>"),

				M("v", "<leader>"),

				M("x", "<C-w>"),
			},
			window = {
				config = {
					anchor = "SW",
					row = "auto",
					col = "auto",
					width = "auto",
					border = "single",
				},
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
			scroll_down = "<C-d>",
			scroll_up = "<C-u>",
		})
	end,
}
