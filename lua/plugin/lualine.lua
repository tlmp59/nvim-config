-- [[ Description ]]

-- [[ Config ]]
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "base16",
				component_separators = "",
				section_separators = "",
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = {
					function()
						return string.upper(vim.api.nvim_get_mode().mode)
					end,
				},
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename" },
				lualine_x = { "diagnostics" },
				lualine_y = {
					"encoding",
					function()
						return vim.bo.filetype
					end,
					"progress",
				},
				lualine_z = { "location" },
			},
			extensions = { "fzf", "lazy", "mason" },
		})
	end,
}
