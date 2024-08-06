-- [[ Description ]]

-- [[ Config ]]
return {
	"stevearc/oil.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			--[[Options]]
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			use_default_keymaps = false,
			prompt_save_on_select_new_entry = true,
			view_options = {
				show_hidden = true,
			},

			--[[Keymaps]]
			keymaps = {
				["g?"] = "actions.show_help",
				["<cr>"] = "actions.select",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		})
	end,
}
