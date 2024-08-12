return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		local oil_open_folder = function(path)
			require("oil").open(path)
		end
		require("config.autocmd").attach_file_browser("oil", oil_open_folder)
	end,
	config = function()
		require("oil").setup({
			default_file_explorer = false,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
			view_options = {
				show_hidden = true,
			},

			buf_options = {
				buflisted = false,
			},

			columns = {
				{ "icon", add_padding = false },
			},

			use_default_keymaps = false,
			keymaps = {
				["<esc>"] = "actions.close",
				["<cr>"] = "actions.select",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
				["g?"] = "actions.show_help",
				["gs"] = "actions.change_sort",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},

			float = {
				padding = 2,
				max_width = 50,
				max_height = 50,
				border = "single",
				win_options = {
					winblend = 0,
				},
				override = function(conf)
					conf.row = 0
					conf.col = 0
					return conf
				end,
			},
		})
		require("config.keymap").M_oil()
	end,
}
