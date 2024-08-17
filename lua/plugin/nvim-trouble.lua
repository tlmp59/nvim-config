return {
	"folke/trouble.nvim",
	event = "VimEnter",
	cmd = "Trouble",
	config = function()
		require("trouble").setup()
		require("config.keymap").M_trouble()
	end,
}
