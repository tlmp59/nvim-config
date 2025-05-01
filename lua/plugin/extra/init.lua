local pconf = "plugin/extra"
local pfiles = vim.api.nvim_get_runtime_file("lua/plugin/extra/*.lua", true)

return {
	-- vim.iter(pfiles):map(function(file)
	-- 	require(file)
	-- end),
}
