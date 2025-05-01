-- Diagnostic Config --
-- See :help vim.diagnostic.Opts
-- source: https://github.com/dam9000/kickstart-modular.nvim/blob/master/lua/kickstart/plugins/lspconfig.lua#L168
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "E ",
			[vim.diagnostic.severity.WARN] = "W ",
			[vim.diagnostic.severity.INFO] = "I ",
			[vim.diagnostic.severity.HINT] = "H ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

-- Prioritize servere diagnostic to show first
-- source: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L184
local show_handler = vim.diagnostic.handlers.virtual_text.show
assert(show_handler)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide
vim.diagnostic.handlers.virtual_text = {
	show = function(ns, bufnr, diagnostics, opts)
		table.sort(diagnostics, function(diag1, diag2)
			return diag1.severity > diag2.severity
		end)
		return show_handler(ns, bufnr, diagnostics, opts)
	end,
	hide = hide_handler,
}

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
	return hover({
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
	})
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
	return signature_help({
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
	})
end
