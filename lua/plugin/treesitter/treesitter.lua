return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate", -- command to run when treesitter is installed or updated
		opts = {
			auto_install = false,
			ensure_installed = {
				-- list of parsers to install
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"yaml",
			},

			highlight = {
				enable = true,

				-- disable treesitter on large file
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					---@diagnostic disable-next-line: undefined-field
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},
}
