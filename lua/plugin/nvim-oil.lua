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
			prompt_save_on_select_new_entry = true,
			view_options = {
				show_hidden = true,
			},

			columns = {
				{ "icon", add_padding = false },
			},

			--[[Keymaps]]
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
				max_width = 0,
				max_height = 0,
				border = "single",
				win_options = {
					winblend = 0,
				},
			},
		})

		vim.keymap.set("n", "-", "<cmd>Oil<cr>", { noremap = true, silent = true, desc = "Open oil in parent dir" })
		vim.keymap.set("n", "<leader>e", function()
			require("oil").open(vim.fn.getcwd())
		end, { desc = "Open oil in current working dir", noremap = true, silent = true })
	end,
}
