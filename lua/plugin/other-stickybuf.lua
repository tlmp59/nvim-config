return {
	"stevearc/stickybuf.nvim",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = {
		get_auto_pin = function(bufnr)
			-- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned.
			return require("stickybuf").should_auto_pin(bufnr)
		end,
	},
}
