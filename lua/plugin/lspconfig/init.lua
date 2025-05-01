return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/lazydev.nvim",
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	config = function()
		-- LSP keymaps and autocmds --
		-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L9
		local methods = vim.lsp.protocol.Methods

		---@param client vim.lsp.Client
		---@param bufnr integer
		local function on_attach(client, bufnr)
			-- Keymaps --

			-- Features: Highlight word under cursor
			-- source: https://github.com/dam9000/kickstart-modular.nvim/blob/master/lua/kickstart/plugins/lspconfig.lua#L125
			if client:supports_method(methods.textDocument_documentHighlight, bufnr) then
				local highlight_augroup = vim.api.nvim_create_augroup("user/lsp_highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("user/lsp_detach", { clear = true }),
					callback = function(_args)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = _args.buf })
					end,
				})
			end

			-- Features: Adding inlay hints command if supported
			-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/commands.lua#L6C1-L12C49
			-- tip: remmber to enable inlayhints in lsp server config
			if client:supports_method(methods.textDocument_inlayHint, bufnr) then
				vim.api.nvim_create_user_command("LspInlayHints", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))

					vim.notify(
						string.format("%s inlay-hints", vim.g.inlay_hints and "Enable" or "Disable"),
						vim.log.levels.INFO
					)
				end, { desc = "Toggle inlay hints", nargs = 0 })
			end
		end

		-- Update features when registering dynamic capbilities
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

		-- Call LSP features on current attach buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user/lsp_attach", { clear = true }),
			callback = function(args)
				print("LSP Attach")
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end

				on_attach(client, args.buf)
			end,
		})

		-- Enable LSP servers
		-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L243
		vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
			once = true, -- ensure cmd runs only once, then automatically removed
			callback = function()
				vim.lsp.enable(vim.tbl_keys(servers or {}))
			end,
		})

		-- Diagnostic config --
		require("plugin.core.lsp.diag")
	end,
}
