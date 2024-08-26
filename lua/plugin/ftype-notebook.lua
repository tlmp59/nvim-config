return {
	-- TODO: setup quarto with jupytertext to edit notebookfile in text form
	{
		"quarto-dev/quarto-nvim",
		ft = "quarto",
		dependencies = {
			{ "jmbuhr/otter.nvim", opts = {} },
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},
}
