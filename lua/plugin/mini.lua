-- [[ Description ]]mini

-- [[ Config ]]
return {
	--> around & inside
	{
		"echasnovski/mini.ai",
		version = "*",
		opts = {
			n_lines = 500,
		},
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
	},

	-->  surroudings
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {},
		-- Example:
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
	},

	-->  clue
	{
		"echasnovski/mini.clue",
		version = "*",
		event = "VimEnter",
		opts = {
			triggers = {
				{ mode = "n", keys = "<Leader>" },
				{ mode = "n", keys = "s" },
				{ mode = "n", keys = "t" },

				{ mode = "n", keys = "<C-w>" },
				{ mode = "x", keys = "<C-w>" },
			},
			window = {
				config = { anchor = "SE", row = "auto", col = "auto", width = "auto", border = "rounded" },
				delay = 0,
			},
		},
	},

	-->  notify
	{
		"echasnovski/mini.notify",
		version = "*",
		event = "VimEnter",
		config = function()
			vim.notify = require("mini.notify").make_notify()
			require("mini.notify").setup({
				config = {},
				window = {
					config = {
						-- relative = "win",
						border = "rounded",
					},
					max_width_share = 1,
					windblend = 0,
				},
				lsp_progress = {
					duration_last = 1500,
				},
				content = {
					format = function(notif)
						-- is there a way to combine repeated message?
						return string.format("%s | %s", notif.level, notif.msg)
					end,
				},
			})
		end,
	},

	--> tabline
	{
		"echasnovski/mini.tabline",
		version = "*",
		opts = {
			format = function(buf_id, label)
				local suffix = vim.bo[buf_id].modified and "[+]" or ""
				return string.format(" %s%s ", label, suffix)
			end,
			show_icons = false,
			set_vim_settings = true,
			-- One of 'left', 'right', 'none'.
			tabpage_section = "none",
		},
	},
}
