return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	config = function()
		require("trouble").setup()
		require("config.keymap").M_trouble()
	end,
}
