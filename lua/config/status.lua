local M = {}

-- assign global module name
_G.status = M

local modes = {
	["n"] = "-- NORMAL --",
	["no"] = "-- NORMAL --",
	["v"] = "-- VISUAL --",
	["V"] = "-- VISUAL LINE --",
	[""] = "-- VISUAL BLOCK --",
	["s"] = "-- SELECT --",
	["S"] = "-- SELECT LINE --",
	[""] = "-- SELECT BLOCK --",
	["i"] = "-- INSERT --",
	["ic"] = "-- INSERT --",
	["R"] = "-- REPLACE --",
	["Rv"] = "-- VISUAL REPLACE --",
	["c"] = "-- COMMAND --",
	["cv"] = "-- VIM EX --",
	["ce"] = "-- EX --",
	["r"] = "-- PROMPT --",
	["rm"] = "-- MOAR --",
	["r?"] = "-- CONFIRM --",
	["!"] = "-- SHELL --",
	["t"] = "-- TERMINAL --",
}

local mode = function()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local filepath = function()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

M.active = function()
	return table.concat({
		mode(),
		filepath(),
		filename(),
	})
end

M.inactive = function()
	return " %F"
end

-- thanks to idea from: https://github.com/echasnovski/mini.statusline/blob/main/lua/mini/statusline.lua
function M.get_winbar()
	vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
		pattern = "*",
		desc = "Get winbar status for each buffers",
		callback = vim.schedule_wrap(function()
			local cur_win_id = vim.api.nvim_get_current_win()
			for _, win_id in ipairs(vim.api.nvim_list_wins()) do
				local buf_id = vim.api.nvim_win_get_buf(win_id)

				if not vim.bo[buf_id].buflisted then
					vim.wo[win_id].winbar = nil
				else
					vim.wo[win_id].winbar = (win_id == cur_win_id) and "%{%v:lua.status.active()%}"
						or "%{%v:lua.status.inactive()%}"
				end
			end
		end),
	})
end

return M
