return {
	"j-morano/buffer_manager.nvim",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("buffer_manager").setup()
		require("config.keymap").M_bufmanage()
	end,
}
