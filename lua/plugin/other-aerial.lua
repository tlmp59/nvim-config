return {
	"stevearc/aerial.nvim",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			layout = {
				max_width = 0.2,
				min_width = 0.1,
				default_direction = "prefer_right",
			},
			placement = "edge",
		})
		require("config.keymap").M_aerial()
	end,
}
