local M = vim.keymap.set

local function unM(mode, lhs, options)
	return pcall(vim.keymap.del, mode, lhs, options or {})
end

local keymaps = {}

------------------------------------------------------------------------------
function keymaps.M_unused()
	unM({ "n", "v" }, "<Space>")
	unM({ "n", "v", "x" }, "-")
	unM({ "n", "i", "v" }, "<C-w>_")
	unM({ "n", "i", "v" }, "<C-w>|")
	unM({ "n", "i", "v" }, "<C-w>o")
	unM({ "n", "i", "v" }, "<C-w>s")
	unM({ "n", "i", "v" }, "<C-w>v")
	unM({ "n", "i", "v" }, "<C-w>T")
	unM({ "n", "i", "v" }, "<C-w>q")
	unM({ "n", "i", "v" }, "<C-w><")
	unM({ "n", "i", "v" }, "<C-w>>")
	unM({ "n", "i", "v" }, "<C-w>+")
	unM({ "n", "i", "v" }, "<C-w>-")
	unM({ "n", "i", "v" }, "<C-w>r")
	unM({ "n" }, "Q")
end

------------------------------------------------------------------------------
function keymaps.M_utils()
	--  set highlight on search, remove on pressing <Esc> in normal mode
	M("n", "<Esc>", "<cmd>nohlsearch<CR>")

	--  disable arrow key
	M("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
	M("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
	M("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
	M("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

	--  dealing with word wrap
	M("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	M("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	--  keep screen centered when moving around
	M("n", "*", "*zzzv")
	M("n", "#", "#zzzv")
	M("n", ",", ",zzzv")
	M("n", ";", ";zzzv")
	M("n", "n", "nzzzv")
	M("n", "N", "Nzzzv")

	--  keep highlighted after moving with < and >
	M("v", "<", "<gv")
	M("v", ">", ">gv")

	--  move selected up and down
	M("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
	M("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
end

------------------------------------------------------------------------------
function keymaps.M_buftabwin()
	M("n", "gb", "<cmd>bn<cr>", { desc = "[G]o to next buffer", noremap = true, silent = true })
	M("n", "gB", "<cmd>bp<cr>", { desc = "[G]o to prev buffer", noremap = true, silent = true })
	--------------------------------------------------------
	--  seemlessly navigate between split windows
	M("n", "<C-h>", ":wincmd h<cr>", { desc = "Move focus to the left window" })
	M("n", "<C-l>", ":wincmd l<cr>", { desc = "Move focus to the right window" })
	M("n", "<C-j>", ":wincmd j<cr>", { desc = "Move focus to the lower window" })
	M("n", "<C-k>", ":wincmd k<cr>", { desc = "Move focus to the upper window" })

	--  change window postision
	M("n", "<C-w>h", ":wincmd H<CR>", { desc = "Change window position to far left" })
	M("n", "<C-w>l", ":wincmd L<CR>", { desc = "Change window position to far right" })
	M("n", "<C-w>j", ":wincmd J<CR>", { desc = "Change window position to far bottom" })
	M("n", "<C-w>k", ":wincmd K<CR>", { desc = "Change window position to far top" })

	--  windows size adjustment
	M("n", "<C-Left>", ":vertical resize +10<CR>", { silent = true })
	M("n", "<C-Right>", ":vertical resize -10<CR>", { silent = true })
	M("n", "<C-Up>", ":resize +10<CR>", { silent = true })
	M("n", "<C-Down>", ":resize -10<CR>", { silent = true })

	--  windows manipulations
	M("n", '<C-w>"', "<cmd>split<cr>", { noremap = true, desc = "Split window horizontally", silent = true })
	M("n", "<C-w>%", "<cmd>vsplit<cr>", { noremap = true, desc = "Split window vertically", silent = true })
	M("n", "<C-w>n", "<cmd>wincmd x<cr>", { desc = "Swap current window with [n]ext", silent = true })
	M("n", "<C-w>p", "<cmd>wincmd p | wincmd x<cr>", { desc = "Swap current window with [p]revious", silent = true })

	--  window equalize, maximize on height/width
	M("n", "<C-w>mh", ":resize<CR>", { desc = "Max out [h]eight", silent = true })
	M("n", "<C-w>mw", ":vertical resize<CR>", { desc = "Max out [w]idth", silent = true })

	--  replace <C-w>o with <C-w>x to match with tmux
	M("n", "<C-w>x", "<CMD>only<CR>", { desc = "Close all other windows", silent = true })
end

------------------------------------------------------------------------------key
--- WARN: another rabbit hole
--- TODO: press <c-g> to print out information related to current buffer
function keymaps.M_info()
	local function filename()
		return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	end

	local function filetype()
		return vim.bo.filetype
	end

	local function fileencoding()
		return vim.bo.fileencoding
	end

	local function fileformat()
		return vim.bo.fileformat
	end

	-- PROBLEM: print out too much messages that can be annoying when you want to see other messages
	local function info()
		return string.format("%s | %s | %s | %s ", filetype(), filename(), fileencoding(), fileformat())
	end

	M("n", "<C-g>i", function()
		vim.notify(info(), vim.log.levels.INFO)
	end, { silent = true, noremap = false, desc = "Get [I]nfomation" })
end

------------------------------------------------------------------------------
function keymaps.M_harpoon()
	local harpoon = require("harpoon")

	M("n", "<leader>ha", function()
		if vim.bo.filetype ~= "oil" then
			harpoon:list():add()
		end
	end, { desc = "[H]arpoon [A]dd" })

	M("n", "<leader>hr", function()
		harpoon:list():remove()
	end, { desc = "[H]arpoon [R]emove" })

	M("n", "<leader>hp", function()
		harpoon:list():prev()
	end, { desc = "[H]arpoon [P]revious" })
	M("n", "<leader>hn", function()
		harpoon:list():next()
	end, { desc = "[H]arpoon [N]ext" })

	M("n", "<leader>hm", function()
		if vim.bo.filetype ~= "minifiles" then
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end
	end, { desc = "[H]arpoon [M]enu" })

	M("n", "<Space>h1", function()
		harpoon:list():select(1)
	end, { desc = "[H]arpoon buffer [1]" })
	M("n", "<Space>h2", function()
		harpoon:list():select(2)
	end, { desc = "[H]arpoon buffer [2]" })
	M("n", "<Space>h3", function()
		harpoon:list():select(3)
	end, { desc = "[H]arpoon buffer [3]" })
	M("n", "<Space>h4", function()
		harpoon:list():select(4)
	end, { desc = "[H]arpoon buffer [4]" })
	M("n", "<Space>h5", function()
		harpoon:list():select(5)
	end, { desc = "[H]arpoon buffer [5]" })
	M("n", "<Space>h6", function()
		harpoon:list():select(6)
	end, { desc = "[H]arpoon buffer [6]" })
end

------------------------------------------------------------------------------
function keymaps.M_gitsigns(bufnr)
	local gitsigns = require("gitsigns")

	local function M_local(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	----------------------------------------
	M_local("n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "Jump to next git [c]hange" })

	M_local("n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "Jump to previous git [c]hange" })

	----------------------------------------
	M_local("v", "<leader>gs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "[G]it [s]tage hunk" })
	M_local("v", "<leader>gr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "[G]it [r]eset hunk" })

	----------------------------------------
	M_local("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[G]it [s]tage hunk" })
	M_local("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[G]it [r]eset hunk" })
	M_local("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[G]it [S]tage buffer" })
	M_local("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "[G]it [u]ndo stage hunk" })
	M_local("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[G]it [R]eset buffer" })
	M_local("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[G]it [p]review hunk" })
	M_local("n", "<leader>gb", gitsigns.blame_line, { desc = "[G]it [b]lame line" })
	M_local("n", "<leader>gd", gitsigns.diffthis, { desc = "[G]it [d]iff against index" })
	M_local("n", "<leader>gD", function()
		gitsigns.diffthis("@")
	end, { desc = "[G]it [D]iff against last commit" })

	----------------------------------------
	M_local("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
	M_local("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
end

------------------------------------------------------------------------------
function keymaps.M_lsp(event)
	local M_local = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
	end

	M_local("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	M_local("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	M_local("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
	M_local("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	M_local("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	M_local("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
	M_local("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	M_local("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	M_local("<leader>ds", function()
		require("telescope.builtin").lsp_document_symbols(require("telescope.themes").get_ivy({
			border = false,
			layout_config = {
				height = function(_, _, rows)
					return rows
				end,
				width = function(_, cols, _)
					return cols
				end,
			},
		}))
	end, "[D]ocument [S]ymbols")
	M_local("K", vim.lsp.buf.hover, "Code hover")
end

------------------------------------------------------------------------------
keymaps.M_trouble = {
	{ "<leader>qx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
	{ "<leader>qb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
	{ "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
	{
		"<leader>ql",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		desc = "LSP Definitions / references / ... (Trouble)",
	},
	{ "<leader>qd", "<cmd>Trouble loclist toggle<cr>", desc = "Destination List (Trouble)" },
	{ "<leader>qf", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
}

------------------------------------------------------------------------------
function keymaps.M_bufmanage()
	M("n", "<leader>bm", function()
		require("buffer_manager.ui").toggle_quick_menu()
	end, { desc = "Buffer menu", noremap = true })
end

------------------------------------------------------------------------------
function keymaps.M_undotree()
	M("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
end

------------------------------------------------------------------------------
function keymaps.M_tscontext()
	M("n", "[c", function()
		require("treesitter-context").go_to_context(vim.v.count1)
	end, { silent = true })
end

------------------------------------------------------------------------------
function keymaps.M_fidget()
	M("n", "<C-g>a", "<cmd>Fidget history<cr>", { noremap = true, silent = true, desc = "[G]et [A]ll history" })
	M(
		"n",
		"<C-g>n",
		"<cmd>Fidget history --group_key Notification<cr>",
		{ noremap = true, silent = true, desc = "[G]et [N]otifications history" }
	)
	M(
		"n",
		"<C-g>w",
		"<cmd>Fidget history --group_key WARN<cr>",
		{ noremap = true, silent = true, desc = "[G]et [W]arning history" }
	)
	M("n", "<C-g>c", "<cmd>Fidget clear_history<cr>", { noremap = true, silent = true, desc = "[C]lear history" })
end

------------------------------------------------------------------------------
-- load plugin on key bind
---@param key string
---@param desc string
---@param action_name any
---@return table
local function M_lazy_telescope(key, action_name, desc)
	return {
		key,
		function()
			if type(action_name) == "string" then
				require("telescope.builtin")[action_name]({
					prompt_title = desc,
				})
			elseif type(action_name) == "function" then
				return action_name()
			end
		end,
		desc = desc,
	}
end

keymaps.M_telescope = {
	M_lazy_telescope("<leader>ff", "find_files", "[F]ind [F]iles"),
	M_lazy_telescope("<leader>fw", "grep_string", "[F]ind current [W]ord"),
	M_lazy_telescope("<leader>fg", "live_grep", "[F]ind by [G]rep"),
	M_lazy_telescope("<leader>fd", "diagnostics", "[F]ind [D]iagnostics"),
	M_lazy_telescope("<leader>fr", "resume", "[F]ind [R]esume"),
	M_lazy_telescope("<leader>fo", "oldfiles", '[F]ind [O]ld Recent Files ("." for repeat)'),
	M_lazy_telescope("<leader>fc", "colorscheme", "[F]ind [C]olorschemes"),
	M_lazy_telescope("<leader><leader>", "buffers", "[ ] Find existing buffers"),

	M_lazy_telescope("<leader>fs", function()
		require("telescope.builtin").builtin(require("telescope.themes").get_ivy({
			border = false,
			layout_config = {
				height = function(_, _, rows)
					return rows
				end,
				width = function(_, cols, _)
					return cols
				end,
			},
		}))
	end, "[F]ind [F]elect Telescope"),

	M_lazy_telescope("<leader>fk", function()
		require("telescope.builtin").keymaps(require("telescope.themes").get_ivy({
			border = false,
			layout_config = {
				height = function(_, _, rows)
					return rows
				end,
				width = function(_, cols, _)
					return cols
				end,
			},
		}))
	end, "[F]ind [K]eymaps"),

	M_lazy_telescope("<leader>fh", function()
		--- overide default ui setting
		require("telescope.builtin").help_tags(require("telescope.themes").get_ivy({
			preview = true,
			border = false,
			layout_config = {
				height = function(_, _, rows)
					return rows
				end,
				width = function(_, cols, _)
					return cols
				end,
				preview_width = 0.6,
			},
		}))
	end, "[F]ind [H]elp"),

	M_lazy_telescope("<leader>/", function()
		require("telescope.builtin").current_buffer_fuzzy_find()
	end, "[/] Fuzzily search in current buffer"),

	M_lazy_telescope("<leader>f/", function()
		require("telescope.builtin").live_grep({
			grep_open_files = true,
			prompt_title = "[F]ind [/] in Open Files",
		})
	end, "[F]ind [/] in Open Files"),

	M_lazy_telescope("<leader>fp", function()
		require("telescope.builtin").find_files({
			cwd = vim.fn.stdpath("config"),
			prompt_title = "[F]ind [P]lugins",
		})
	end, "[F]ind [P]lugins"),

	M_lazy_telescope("<leader>ft", function()
		require("telescope.builtin").treesitter(require("telescope.themes").get_ivy({
			preview = true,
			border = false,
			layout_config = {
				height = function(_, _, rows)
					return rows
				end,
				width = function(_, cols, _)
					return cols
				end,
			},
		}))
	end, "[F]ind [T]reesiter"),
}

------------------------------------------------------------------------------
keymaps.M_yazi = {
	{ "-", "<cmd>Yazi<cr>", "Toggle file explorer" },
	{ "<leader>e", "<cmd>Yazi cwd<cr>", "Toggle file explorer in cwd" },
}

------------------------------------------------------------------------------
return keymaps
