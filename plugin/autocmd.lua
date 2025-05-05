vim.api.nvim_create_autocmd('BufHidden', {
    desc = 'Delete [No Name] buffers',
    callback = function(event)
        if event.file == '' and vim.bo[event.buf].buftype == '' and not vim.bo[event.buf].modified then
            vim.schedule(function()
                pcall(vim.api.nvim_buf_delete, event.buf, {})
            end)
        end
    end,
})
