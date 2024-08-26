return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		local oil_open_folder = function(path)
			require("oil").open(path)
		end
		require("config.autocmd").attach_file_browser("oil", oil_open_folder)
	end,
	keys = require("config.keymap").M_oil,
	cmd = "Oil",
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
			view_options = {
				show_hidden = true,
			},

			buf_options = {
				buflisted = false,
				bufhidden = "hide", -- wipe
			},

			columns = {
				"size",
				{ "icon", add_padding = true },
			},

			use_default_keymaps = false,
			keymaps = {
				["<esc>"] = function()
					local function no_buffers_worth_saving()
						for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
							if vim.bo[bufnr].buflisted and not vim.bo[bufnr].readonly then -- disregard unlisted buffers
								if vim.api.nvim_buf_get_name(bufnr) ~= "" then
									return false -- there is a buffer with a name
								end
								local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
								if #lines > 1 or (#lines == 1 and #lines[1] > 0) then
									return false -- there is a buffer with content
								end
							end
						end
						return true -- there are no listed, writable, named, nonempty buffers
					end

					if no_buffers_worth_saving() then
						-- vim.notify("Current no active buffers, choose a file to continue!", vim.log.levels.WARN)
						require("mini.starter").open()
						return
					else
						require("oil.actions").close.callback()
					end
				end,
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
		})
	end,
}
