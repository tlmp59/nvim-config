return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = {"BufReadPost", "BufWritePost", "BufNewFile"},
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"lazy",
					"mason",
					"notify",
					"oil",
				},
			},
		},
		main = "ibl",
	},
}
