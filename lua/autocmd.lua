--> [[ Autocommand ]]
-- see :help lua-guide-autocommands

--  highlight when yanking (copying) text
--   try it with `yap` in normal mode
--   see `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--  add new autocommands here:
