return {
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			italic_comments = true,
			underline_links = true,
		},
		init = function()
			vim.cmd.colorscheme("vscode")
		end,
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		transparent = true,
	-- 		style = "storm", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
	-- 		styles = {
	-- 			comments = { italic = true },
	-- 			keywords = { italic = true },
	-- 			functions = {},
	-- 			variables = {},
	-- 			-- Background styles. Can be "dark", "transparent" or "normal"
	-- 			sidebars = "transparent",
	-- 			floats = "transparent",
	-- 			plugins = {
	-- 				all = package.loaded.lazy == nil,
	-- 				auto = true,
	-- 			},
	-- 		},
	-- 		on_highlights = function(hl, c)
	-- 			hl.WinBar = {
	-- 				bg = "NONE",
	-- 				fg = c.fg,
	-- 				bold = true,
	-- 			}
	-- 			hl.WinBarNC = {
	-- 				bg = "NONE",
	-- 				fg = c.fg_dark,
	-- 			}
	--
	-- 			hl.TreesitterContext = {
	-- 				bg = "NONE",
	-- 			}
	-- 			hl.TreesitterContextBottom = {
	-- 				underline = true,
	-- 			}
	-- 			hl.TreesitterContextLineNumberBottom = {
	-- 				underline = true,
	-- 			}
	--
	-- 			hl.WinSeparator = {
	-- 				fg = c.fg_dark,
	-- 			}
	-- 		end,
	-- 	},
	-- 	init = function()
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },
}
