return {
	"RRethy/base16-nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		vim.cmd.colorscheme("base16-nord")
	end,
	config = function()
		require("base16-colorscheme").with_config({
			telescope = false,
		})
	end,
}
