-- LSP keymaps and autocmds --
-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L9
local methods = vim.lsp.protocol.Methods

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    -- Features: Highlight word under cursor
    -- source: https://github.com/dam9000/kickstart-modular.nvim/blob/master/lua/kickstart/plugins/lspconfig.lua#L125
    if client:supports_method(methods.textDocument_documentHighlight, bufnr) then
        local highlight_augroup = vim.api.nvim_create_augroup('user/lsp_highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('user/lsp_detach', { clear = true }),
            callback = function(_args)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = _args.buf }
            end,
        })
    end

    -- Features: Adding inlay hints command if supported
    -- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/commands.lua#L6C1-L12C49
    -- tip: remmber to enable inlayhints in lsp server config
    if client:supports_method(methods.textDocument_inlayHint, bufnr) then
        vim.api.nvim_create_user_command('LspInlayHints', function()
            local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
            vim.lsp.inlay_hint.enable(not enabled)

            vim.notify(string.format('%s inlay-hints', enabled and 'Disable' or 'Enable'), vim.log.levels.INFO)
        end, { desc = 'Toggle inlay hints', nargs = 0 })
    end
end

-- Update features when registering dynamic capbilities --
-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L216
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
        return
    end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

-- Call LSP features on current attach buffer --
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user/lsp_attach', { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})

-- Simple lsp progess notification
-- source: https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
vim.api.nvim_create_autocmd('LspProgress', {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(vim.lsp.status(), 'info', {
            id = 'lsp_progress',
            -- title = 'LSP Progress',
            opts = function(notif)
                notif.icon = ev.data.params.value.kind == 'end' and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

-- Enable LSP servers --
-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L243
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true, -- ensure cmd runs only once, then automatically removed
    callback = function()
        local server_configs = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ':t:r')
            end)
            :totable()
        vim.lsp.enable(server_configs)
    end,
})
