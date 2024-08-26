return {
	{
		"nvim-telescope/telescope.nvim",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
		},
		keys = require("config.keymap").M_telescope, --- use to trigger plugin when first press keybind
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				--- source: https://github.com/nvim-telescope/telescope.nvim/issues/848
				defaults = vim.tbl_extend(
					"force",
					require("telescope.themes").get_ivy({
						layout_strategy = "bottom_pane",
						layout_config = {
							height = 0.4,
							prompt_position = "top",
						},
					}),
					{
						preview = false,
						path_display = { "tail" },
						prompt_prefix = "Enter: ",
						sorting_strategy = "ascending",
						cache_picker = {
							num_pickers = 10,
						},
						mappings = {
							i = {
								["<c-enter>"] = "to_fuzzy_refine",
								["<C-j>"] = {
									actions.move_selection_next,
									type = "action",
									opts = { nowait = true, silent = true },
								},
								["<C-k>"] = {
									actions.move_selection_previous,
									type = "action",
									opts = { nowait = true, silent = true },
								},
								["<esc>"] = {
									actions.close,
									type = "action",
									opts = { nowait = true, silent = true },
								},
							},
						},
					}
				),

				picker = {
					current_buffer_fuzzy_find = {
						tiebreak = require("telescope.utils").line_tiebreak,
					},
				},

				extensions = {
					["ui-select"] = {},

					file_browser = {
						hijack_netrw = false,
						git_status = false,
						previewer = false,
					},

					fzf = {
						fuzzy = false, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
			})

			-- enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "file_browser")
		end,
	},
}
