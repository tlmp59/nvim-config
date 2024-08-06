return {
	------------------------------------------------------------------------------
	--> [[ Fuzzy finder: fzf-lua ]]
	{
		"ibhagwan/fzf-lua",
		event = "VimEnter",
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				defaults = {
					git_icons = false,
					file_icons = false,
					color_icons = false,
				},
			})

			local fzf = require("fzf-lua")
			local M = vim.keymap.set
			M("n", "<leader>fh", fzf.helptags, { desc = "[F]ind [H]elp" })
			M("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymaps" })
			M("n", "<leader>ff", fzf.files, { desc = "[F]ind [F]iles" })
			M("n", "<leader>fw", fzf.grep_cword, { desc = "[F]ind current [W]ord" })
			M("n", "<leader>fg", fzf.live_grep, { desc = "[F]ind by [G]rep" })
			M("n", "<leader>fd", fzf.diagnostics_workspace, { desc = "[F]ind workspace [D]iagnostics" })
			M("n", "<leader>fc", fzf.colorschemes, { desc = "[F]ind [C]olorschemes" })
			M("n", "<leader>fr", fzf.resume, { desc = "[F]ind [R]esume command/query" })
			M("n", "<leader>fo", fzf.oldfiles, { desc = '[F]ind [O]ld Recent Files ("." for repeat)' })
			M("n", "<leader>ft", fzf.tabs, { desc = "[F]ind [T]abs" })
			M("n", "<leader><leader>", fzf.buffers, { desc = "[ ] Find existing buffers" })

			M("n", "<leader>f/", function()
				fzf.live_grep({
					prompt = "Live Grep in Open Files > ",
					grep_opts = "--files-with-matches",
					rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case",
					actions = {
						["default"] = fzf.actions.file_edit_or_qf,
					},
				})
			end, { desc = "[F]ind [/] in Open Files" })

			M("n", "<leader>/", function()
				fzf.grep_curbuf({
					prompt = "Fuzzy Search in Current Buffer > ",
					winopts = {
						preview = {
							hidden = "hidden", -- Disable the preview window
						},
						height = 0.4, -- 40% height of the screen
						width = 0.9, -- 90% width of the screen
						row = 0.3, -- 30% from the top
						col = 0.5, -- Centered horizontally
					},
					fzf_opts = {
						["--layout"] = "reverse", -- Reverse the layout
						["--info"] = "inline", -- Show the match count inline
					},
				})
			end, { desc = "[/] Fuzzily search in current buffer" })
		end,
	},
}
