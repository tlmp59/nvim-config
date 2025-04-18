local api = vim.api

---@class UserAutoCmds
---@field group_id integer
local autocmds = {
	group_id = api.nvim_create_augroup("UserAutoCmds", { clear = true }),
}

------------------------------------------------------------------------------
function autocmds.hl_yanked_text()
	api.nvim_create_autocmd("TextYankPost", {
		group = autocmds.group_id,
		desc = "Highlight when yanking (copying) text",
		callback = function()
			vim.highlight.on_yank()
		end,
	})
end

------------------------------------------------------------------------------
function autocmds.hide_unnamed_buf_on_startup()
	local unlist_unnamed = function(data)
		local buf = data.buf
		if not (vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].buflisted) then
			return
		end
		vim.bo[buf].buflisted = false
		vim.bo[buf].bufhidden = "wipe"
	end

	local unlist_unnamed_all = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			unlist_unnamed({ buf = buf })
		end
	end

	api.nvim_create_autocmd({ "BufAdd", "BufFilePost" }, {
		group = autocmds.group_id,
		callback = unlist_unnamed,
	})
	api.nvim_create_autocmd({ "VimEnter" }, {
		group = autocmds.group_id,
		callback = unlist_unnamed_all,
	})
end

------------------------------------------------------------------------------
--> restore the cursor to its last position when reopening the buffer
function autocmds.restore_cursor_position_in_file()
	vim.cmd([[
    autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
  ]])
end

------------------------------------------------------------------------------
--> underline word under cursor
function autocmds.underline_word_under_cursor(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = event.buf,
			group = autocmds.group_id,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = event.buf,
			group = autocmds.group_id,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = autocmds.group_id,
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
			end,
		})
	end
end

------------------------------------------------------------------------------
function autocmds.disable_autoformat()
	api.nvim_create_autocmd("FileType", {
		pattern = "*",
		desc = "Disable autoformat for all filetype",
		callback = function()
			vim.b.autoformat = false
		end,
	})
end

------------------------------------------------------------------------------
function autocmds.resize_splits_after_win_resize()
	api.nvim_create_autocmd("FileType", {
		pattern = "*",
		group = autocmds.group_id,
		desc = "Auto resize splits after window resize",
		command = "wincmd =",
	})
end

------------------------------------------------------------------------------
function autocmds.testing()
	api.nvim_create_autocmd("FileType", {
		pattern = "*",
		desc = "This is a test function",
	})
end
------------------------------------------------------------------------------
return autocmds
