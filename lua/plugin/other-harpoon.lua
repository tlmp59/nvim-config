return {
	"ThePrimeagen/harpoon",
	event = { "BufReadPre", "BufNewFile" },
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup({
			exclude_filetypes = { "harpoon", "oil", "ministarter" },
		})
		require("config.keymap").M_harpoon()
	end,
}
