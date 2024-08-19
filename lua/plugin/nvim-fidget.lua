return {
	"j-hui/fidget.nvim",
	event = "VeryLazy",
	config = function()
		require("fidget").setup({
			notification = {
				override_vim_notify = true,
				window = {
					normal_hl = "Normal",
					winblend = 10,
					border = "",
					zindex = 45,
					max_width = 0,
					max_height = 0,
					x_padding = 1,
					y_padding = 0,
					align = "bottom",
					relative = "editor",
				},
			},
		})

		require("config.keymap").M_fidget()
	end,
}
