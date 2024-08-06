return {
	------------------------------------------------------------------------------
	--> [[ Git signatures: gitsigns ]]
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function M(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				----------------------------------------
				--- nagigation
				M("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next git [c]hange" })

				M("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous git [c]hange" })

				----------------------------------------
				--- visual
				M("v", "<leader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[G]it [s]tage hunk" })
				M("v", "<leader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[G]it [r]eset hunk" })

				----------------------------------------
				--- visual
				M("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[G]it [s]tage hunk" })
				M("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[G]it [r]eset hunk" })
				M("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[G]it [S]tage buffer" })
				M("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "[G]it [u]ndo stage hunk" })
				M("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[G]it [R]eset buffer" })
				M("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[G]it [p]review hunk" })
				M("n", "<leader>gb", gitsigns.blame_line, { desc = "[G]it [b]lame line" })
				M("n", "<leader>gd", gitsigns.diffthis, { desc = "[G]it [d]iff against index" })
				M("n", "<leader>gD", function()
					gitsigns.diffthis("@")
				end, { desc = "[G]it [D]iff against last commit" })

				----------------------------------------
				--- toggle
				M("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
				M("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
			end,
		},
	},
}
