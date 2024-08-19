return {
	------------------------------------------------------------------------------
	{
		"folke/lazydev.nvim",
		ft = "lua",
		dependencies = {
			"Bilal2453/luvit-meta",
			lazy = true,
		},
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	------------------------------------------------------------------------------
	--- never lazy load nvim-lsp
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			--- language servers installer using mason
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},

		config = function()
			--- basic setup
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					--- keymaps
					require("config.keymap").M_lsp(event)

					--- autocommand for underline word under cursor
					require("config.autocmd").underline_word_under_cursor(event)
				end,
			})

			--- incorporating cmp_nvim_lsp capabilities into LSP configuration
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

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
