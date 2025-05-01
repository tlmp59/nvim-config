local plugins = vim.iter(vim.api.nvim_get_runtime_file("lua/plugin/extra/*.lua", true))
	:map(function(file)
		return vim.fn.fnamemodify(file, ":t:r")
	end)
	:filter(function(name)
		return name ~= "init"
	end)
	:totable()

local M = {}
for _, v in ipairs(plugins) do
	table.insert(M, require("plugin.extra." .. v))
end

return M
