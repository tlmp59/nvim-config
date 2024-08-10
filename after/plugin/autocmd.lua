--> [[ Autocommand ]]
-- see :help lua-guide-autocommands

local autocmd = vim.api.nvim_create_autocmd

--  highlight when yanking (copying) text
--   try it with `yap` in normal mode
--   see `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--  add new autocommands here:
--> unlisted all unnamed buffers
local unlist_unnamed = function(data)
	local buf = data.buf
	if not (vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].buflisted) then
		return
	end
	vim.bo[buf].buflisted = false
end

local unlist_unnamed_all = function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		unlist_unnamed({ buf = buf })
	end
end

autocmd({ "BufAdd", "BufFilePost" }, { callback = unlist_unnamed })
autocmd({ "VimEnter" }, { callback = unlist_unnamed_all })

--> when escape oil buffer without having any other open buffers rather than no name return to starter
local no_buffers_open = function()
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })
	return #buffers == 0
end

autocmd("BufLeave", {
	pattern = "oil://*",
	desc = "Open starter when leave oil with no buffer",
	callback = function()
		if no_buffers_open() then
			vim.schedule(function()
				require("mini.starter").open()
				-- require("alpha").start()
				-- vim.cmd("Dashboard")
			end)
		end
	end,
})
