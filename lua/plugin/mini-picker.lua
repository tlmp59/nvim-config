return {
	--> [[ Fuzzy searching: mini-picker ]]
	"echasnovski/mini.pick",
	version = "*",
	event = "VimEnter",
	dependencies = { "echasnovski/mini.extra", version = "*", opts = {} },
	config = function()
		local pick = require("mini.pick")
		pick.setup({
			mappings = {
				move_down = "<C-j>",
				move_up = "<C-k>",
				move_start = "<C-g>",

				scroll_down = "<C-d>",
				scroll_left = "<C-u>",
				scroll_right = "<C-l>",
				scroll_up = "<C-k>",

				stop = "<Esc>",
			},

			options = {
				use_cache = true,
				content_from_bottom = true,
			},
		})

		local M = vim.keymap.set
		M("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "[F]ind [H]elp" })
		M("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "[F]ind [F]iles" })
		M("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "[F]ind by [G]rep" })
		M("n", "<leader>fr", "<cmd>Pick resume<cr>", { desc = "[F]ind [R]esume command/query" })
		M("n", "<leader><leader>", "<cmd>Pick buffers<cr>", { desc = "[F]ind existing [B]uffers" })

		vim.ui.select = MiniPick.ui_select

		local hooks = {
			pre_hooks = {},
			post_hooks = {},
		}

		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "MiniPickStart",
			group = vim.api.nvim_create_augroup("minipick-pre-hooks", { clear = true }),
			desc = "Invoke pre_hook for specific picker based on source.name.",
			callback = function(...)
				local opts = MiniPick.get_picker_opts() or {}
				local pre_hook = hooks.pre_hooks[opts.source.name] or function(...) end
				pre_hook(...)
			end,
		})

		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "MiniPickStop",
			group = vim.api.nvim_create_augroup("minipick-post-hooks", { clear = true }),
			desc = "Invoke post_hook for specific picker based on source.name.",
			callback = function(...)
				local opts = MiniPick.get_picker_opts()
				if opts then
					local post_hook = hooks.post_hooks[opts.source.name] or function(...) end
					post_hook(...)
				else
					vim.notify("MiniPick.get_picker_opts() returned nil")
				end
			end,
		})

		MiniPick.registry.config = function()
			return MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
		end

		M("n", "<leader>fn", "<cmd>Pick config<cr>", { desc = "[F]ind [N]eovim config" })

		local selected_colorscheme
		hooks.pre_hooks.Colorschemes = function()
			selected_colorscheme = vim.g.colors_name
		end
		hooks.post_hooks.Colorschemes = function()
			vim.schedule(function()
				vim.cmd("colorscheme " .. selected_colorscheme)
			end)
		end

		MiniPick.registry.colorschemes = function()
			local colorschemes = vim.fn.getcompletion("", "color")
			return MiniPick.start({
				source = {
					name = "Colorschemes",
					items = colorschemes,
					choose = function(item)
						selected_colorscheme = item
					end,
					preview = function(buf_id, item)
						vim.cmd("colorscheme " .. item)
						vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
					end,
				},
			})
		end

		M("n", "<leader>fc", "<cmd>Pick colorschemes<cr>", { desc = "[F]ind [C]olorschemes" })

		M("n", "<leader>fk", "<cmd>Pick keymaps<cr>", { desc = "[F]ind [K]eymaps" })
		M("n", "<leader>fo", "<cmd>Pick oldfiles<cr>", { desc = '[F]ind [O]ld Recent Files ("." for repeat)' })
		-- M("n", "<leader>fw", pick.grep_cword, { desc = "[F]ind current [W]ord" })
		-- M("n", "<leader>fd", pick.diagnostics_workspace, { desc = "[F]ind workspace [D]iagnostics" })
		-- M("n", "<leader>ft", pick.tabs, { desc = "[F]ind [T]abs" })
	end,
}
