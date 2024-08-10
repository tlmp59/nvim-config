return {
	-->  notify
	"echasnovski/mini.notify",
	version = "*",
	config = function()
		vim.notify = require("mini.notify").make_notify()
		require("mini.notify").setup({
			config = {},
			window = {
				config = {
					relative = "editor",
					border = "single",
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
					return string.format(" %s | %s ", notif.level, notif.msg)
				end,
			},
		})
	end,
}
