local M = {}

M.setup = function(parsers)
    return {
        auto_install = false,
        ensure_installed = parsers,
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
        indent = { enable = true, disable = { 'ruby' } },
    }
end

return M
