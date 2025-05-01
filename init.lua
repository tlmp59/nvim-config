vim.loader.enable()

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable nerd font support
vim.g.have_nerd_font = true

-- Import config modules
vim.iter(vim.api.nvim_get_runtime_file("lua/*.lua", true)):map(function(file)
	require(vim.fn.fnamemodify(file, ":t:r"))
end)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- Put lazy into the runtimepath(rtp) for neovim
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup('plugin', {
	change_detection = { notify = false },
	rocks = { enabled = false },
})
