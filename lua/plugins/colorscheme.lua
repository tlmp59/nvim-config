return {
	{
		"RRethy/base16-nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("base16-default-dark")
			require("base16-colorscheme").with_config({
				telescope = true,
				indentblankline = true,
				cmp = true,
				-- need install dapui first
				-- dapui = true,
			})
		end,
	},
	-- open {} to add other colorschemes
	-- {
	-- 	"colorscheme_input",
	-- 	init = function()
	-- 		-- opt
	-- 	end
	-- },
}
