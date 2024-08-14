return {
	--> starter
	"echasnovski/mini.starter",
	version = false,
	event = "VimEnter",
	config = function()
		local starter = require("mini.starter")
		local H = {}

		starter.setup({
			autoopen = true,
			evaluate_single = true,
			query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
			header = function()
				local banner = [[

      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████

  ]]
				local greeting = H.greeting()
				local date = H.getdate()
				local n = math.floor((65 - greeting:len()) / 2)
				local m = math.floor((68 - date:len()) / 2)
				return banner .. H.pad(greeting, n) .. "\n" .. H.pad(date, m)
			end,

			items = {
				starter.sections.recent_files(5, false, false),
				{
					{ name = "Mason", action = "Mason", section = "Managers" },
					{ name = "Lazy", action = "Lazy", section = "Managers" },
				},
			},

			content_hooks = {
				starter.gen_hook.adding_bullet(),
				starter.gen_hook.aligning("center", "center"),
				starter.gen_hook.indexing("sections"),
			},

			footer = "",
		})

		H.pad = function(str, n)
			return string.rep(" ", n) .. str
		end

		H.greeting = function()
			local hour = tonumber(vim.fn.strftime("%H"))
			local part_id = math.floor((hour + 4) / 8) + 1
			local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
			local username = "ov3ipo"

			return ("Good %s, %s"):format(day_part, username)
		end

		H.getdate = function()
			local date = vim.fn.strftime("%d-%m-%Y")
			return ("%s"):format(date)
		end
	end,
}
