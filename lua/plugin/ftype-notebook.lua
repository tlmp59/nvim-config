return {
	--> quarto
	{
		"quarto-dev/quarto-nvim",
		ft = "quarto",
		dependencies = {
			{ "jmbuhr/otter.nvim", opts = {} },
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},

	--> jupytertext
	-- require 'pip install jupytertext'
}
