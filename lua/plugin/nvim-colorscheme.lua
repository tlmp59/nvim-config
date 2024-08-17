return {
	-- {
	-- 	"RRethy/base16-nvim",
	-- 	priority = 1000, -- Make sure to load this before all the other start plugins.
	-- 	init = function()
	-- 		-- vim.cmd.colorscheme("base16-default-dark")
	-- 		vim.cmd.colorscheme("base16-catppuccin-frappe")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin-frappe")
		end,
	},
}
