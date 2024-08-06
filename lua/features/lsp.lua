return {
	------------------------------------------------------------------------------
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},

	------------------------------------------------------------------------------
	--> [[ Lsp: nvim-lspconfig ]]
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			----------------------------------------
			--- language servers installer using mason
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},

		config = function()
			----------------------------------------
			--- basic setup
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					----------------------------------------
					--- keymaps
					local M = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					M("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
					M("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
					M("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
					M("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
					M("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
					M("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
					M("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					M("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					M("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					----------------------------------------
					--- autocommand for underline word under cursor
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			----------------------------------------
			--- incorporating cmp_nvim_lsp capabilities into LSP configuration
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			----------------------------------------
			--- language servers & tools management
			require("mason").setup()

			local servers = {
				-- add other servers here
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				-- add other tools here
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			----------------------------------------
			--- language servers setup tool
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
