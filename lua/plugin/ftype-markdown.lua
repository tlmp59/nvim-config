local vault_path = "/mnt/d/Home/Documents/obsidian/"
return {
	"epwalsh/obsidian.nvim",
	version = "*",
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		--- primary workspace each represent a vault
		workspaces = {
			{
				name = "personal",
				path = vault_path,
			},
		},
		log_level = vim.log.levels.INFO,
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "telescope.nvim",
			mappings = {},
		},
		mappings = {
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		--- where to put new notes, valid options are
		---  * "current_dir" - put new notes in same directory as the current buffer.
		---  * "notes_subdir" - put new notes in the default notes subdirectory.
		new_notes_location = "current_dir",

		--- custom note IDs
		---@param title string|?
		---@return string
		note_id_func = function(title)
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. "-" .. suffix
		end,
		wiki_link_func = "prepend_note_id",

		--- follow url
		---@param url string
		follow_url_func = function(url)
			vim.fn.jobstart({ "wsl-open", url })
			-- vim.ui.open(url) -- need Neovim 0.10.0+
		end,

		ui = {
			enable = false,
		},

		templates = {
			subdir = "_storage/template",
			date_format = "%Y-%m-%d",
			time_format = "%H:%m",
		},
		attachments = {
			img_folder = "_storage/attachments",
		},
	},
	config = function(_, opts)
		require("obsidian").setup(opts)
		require("config.keymap").M_obsidian()
	end,
}
