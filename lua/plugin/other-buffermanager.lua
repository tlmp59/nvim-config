return {
	"j-morano/buffer_manager.nvim",
	event = "BufEnter",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("buffer_manager").setup()
		vim.keymap.set("n", "<leader>bm", function()
			require("buffer_manager.ui").toggle_quick_menu()
		end, { desc = "Buffer menu", noremap = true })
	end,
}
