local M = {}

-- assign global module name
_G.status = M

-- most of these options are from https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html#org4e437d4
local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["r"] = "PROMPT",
	["ce"] = "EX",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local mode = function()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local black = "#1F1F28"
local darkred = "#C34043"
local darkgreen = "#76946A"
local darkblue = "#658594"
local darkpurple = "#938AA9"
local darkyellow = "#DCA561"
local sumiInk0 = "#16161D"

-- custom color hl
vim.api.nvim_set_hl(0, "NormalColor", { bg = darkblue, fg = black })
vim.api.nvim_set_hl(0, "InsertColor", { bg = darkgreen, fg = black })
vim.api.nvim_set_hl(0, "ReplaceColor", { bg = darkred, fg = black })
vim.api.nvim_set_hl(0, "VisualColor", { bg = darkpurple, fg = black })
vim.api.nvim_set_hl(0, "GitSignsWinbarAdd", { fg = darkgreen, bg = sumiInk0 })
vim.api.nvim_set_hl(0, "GitSignsWinbarChange", { fg = darkyellow, bg = sumiInk0 })
vim.api.nvim_set_hl(0, "GitSignsWinbarDelete", { fg = darkred, bg = sumiInk0 })
vim.api.nvim_set_hl(0, "DimBackground", { bg = sumiInk0 })

local function update_mode_colors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = ""
	if current_mode == "n" then
		mode_color = "%#NormalColor#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#InsertColor#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#VisualColor#"
	elseif current_mode == "R" then
		mode_color = "%#ReplaceColor#"
	elseif current_mode == "c" then
		mode_color = "%#ReplaceColor#"
	elseif current_mode == "t" then
		mode_color = "%#InsertColor#"
	end
	return mode_color
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

local vcs = function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#GitSignsWinbarAdd#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#GitSignsWinbarChange#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#GitSignsWinbarDelete#-" .. git_info.removed .. " ") or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat({
		" ",
		added,
		changed,
		removed,
		" ",
		"%#GitSignsWinbarAdd# ",
		git_info.head,
		" %#DimBackground#",
	})
end

M.active = function()
	return table.concat({
		"%#NormalColor#",
		update_mode_colors(),
		mode(),
		"%#DimBackground#",
		filepath(),
		filename(),
		"%=",
		vcs(),
	})
end

M.inactive = function()
	return "%F"
end

-- thanks to idea from: https://github.com/echasnovski/mini.statusline/blob/main/lua/mini/statusline.lua
M.get_winbar = function()
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
