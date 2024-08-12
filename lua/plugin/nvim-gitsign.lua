return {
	------------------------------------------------------------------------------
	--> [[ Git signatures: gitsigns ]]
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				require("config.keymap").M_gitsigns(bufnr)
			end,
		},
	},
}
