local M = vim.keymap.set

local function unM(mode, lhs, options)
	return pcall(vim.keymap.del, mode, lhs, options or {})
end

---@class UserKeymaps
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

	-- primeagen cool keymaps
	M("x", "<leader>p", [["_dP]])
	M({ "n", "v" }, "<leader>y", [["+y]])
	M("n", "<leader>Y", [["+Y]])
	M({ "n", "v" }, "<leader>dd", [["_d]])
end

------------------------------------------------------------------------------
function keymaps.M_buftabwin()
	M("n", "<Tab>", ":bn<cr>", { desc = "Last tab/buffer", noremap = true, silent = true })
	M("n", "<C-Tab>", ":bp<cr>", { desc = "First tab/buffer", noremap = true, silent = true })
	--------------------------------------------------------
	M("n", "<leader>tl", ":tabnext<cr>", { desc = "[T]ab next", noremap = true, silent = true })
	M("n", "<leader>th", ":tabprevious<cr>", { desc = "[T]ab previous", noremap = true, silent = true })
	M("n", "<leader>tj", ":tablast<cr>", { desc = "[T]ab last", noremap = true, silent = true })
	M("n", "<leader>tk", ":tabfirst<cr>", { desc = "[T]ab first", noremap = true, silent = true })
	M("n", "<leader>tn", ":tabnew<cr>", { desc = "[T]ab [N]ew", noremap = true, silent = true })
	M("n", "<leader>tc", ":tabclose<cr>", { desc = "[T]ab [C]lose", noremap = true, silent = true })
	M("n", "<leader>to", ":tabonly<cr>", { desc = "[T]ab [O]nly", noremap = true, silent = true })
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
	M("n", '<C-w>"', ":horizontal split<CR>", { desc = "Split window horizontally", silent = true })
	M("n", "<C-w>%", ":vertical split<CR>", { desc = "Split window vertically", silent = true })
	M("n", "<C-w>n", ":wincmd x<CR>", { desc = "Swap current window with [n]ext", silent = true })
	M("n", "<C-w>p", ":wincmd p<CR> :wincmd x<CR>", { desc = "Swap current window with [p]revious", silent = true })

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
		vim.notify(info())
	end, { silent = true, noremap = false, desc = "Get [I]nfomation" })
end

------------------------------------------------------------------------------
keymaps.M_oil = {
	{ "-", "<cmd>Oil .<cr>", "Open oil in parent dir" },
	{ "<leader>ed", "<cmd>Oil<cr>", "[ED]it explorer" },
}

------------------------------------------------------------------------------
function keymaps.M_picker()
	M("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "[F]ind [H]elp" })
	M("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "[F]ind [F]iles" })
	M("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "[F]ind by [G]rep" })
	M("n", "<leader>fr", "<cmd>Pick resume<cr>", { desc = "[F]ind [R]esume command/query" })
	M("n", "<leader><leader>", "<cmd>Pick buffers<cr>", { desc = "[F]ind existing [B]uffers" })
	M("n", "<leader>fk", "<cmd>Pick keymaps<cr>", { desc = "[F]ind [K]eymaps" })
	M("n", "<leader>fo", "<cmd>Pick oldfiles<cr>", { desc = '[F]ind [O]ld Recent Files ("." for repeat)' })
	M("n", "<leader>fe", "<cmd>Pick explorer<cr>", { desc = "[F]ind [E]xplorer" })

	local picker = require("mini.pick")
	vim.ui.select = picker.ui_select

	local hooks = {
		pre_hooks = {},
		post_hooks = {},
	}

	vim.api.nvim_create_autocmd("User", {
		pattern = "pickerStart",
		group = vim.api.nvim_create_augroup("minipick-pre-hooks", { clear = true }),
		desc = "Invoke pre_hook for specific picker based on source.name.",
		callback = function(...)
			local opts = picker.get_picker_opts() or {}
			local pre_hook = hooks.pre_hooks[opts.source.name] or function(...) end
			pre_hook(...)
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "pickerStop",
		group = vim.api.nvim_create_augroup("minipick-post-hooks", { clear = true }),
		desc = "Invoke post_hook for specific picker based on source.name.",
		callback = function(...)
			local opts = picker.get_picker_opts()
			if opts then
				local post_hook = hooks.post_hooks[opts.source.name] or function(...) end
				post_hook(...)
			else
				vim.notify("picker.get_picker_opts() returned nil")
			end
		end,
	})

	picker.registry.config = function()
		return picker.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
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

	picker.registry.colorschemes = function()
		local colorschemes = vim.fn.getcompletion("", "color")
		return picker.start({
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

	-- M("n", "<leader>fc", "<cmd>Pick colorschemes<cr>", { desc = "[F]ind [C]olorschemes" })
	M("n", "<leader>fc", ":colorscheme ", { desc = "[F]ind [C]olorschemes" })

	-- M("n", "<leader>fw", pick.grep_cword, { desc = "[F]ind current [W]ord" })
	-- M("n", "<leader>fd", pick.diagnostics_workspace, { desc = "[F]ind workspace [D]iagnostics" })
	-- M("n", "<leader>ft", pick.tabs, { desc = "[F]ind [T]abs" })
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
	-- M_local("<leader>ds", function()
	-- 	require("mini.extra").pickers.lsp({ scope = "document_symbol" })
	-- end, "[D]ocument [S]ymbols")
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
--> TODO: change this to return table as telescope should be load when trigger certain keybind

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
				require("telescope.builtin")[action_name]()
			elseif type(action_name) == "function" then
				return action_name()
			end
		end,
		desc = desc,
	}
end

keymaps.M_telescope = {
	M_lazy_telescope("<leader>ff", "find_files", "[F]ind [F]iles"),
	M_lazy_telescope("<leader>fh", "help_tags", "[F]ind [H]elp"),
	M_lazy_telescope("<leader>fk", "keymaps", "[F]ind [K]eymaps"),
	M_lazy_telescope("<leader>fs", "builtin", "[F]ind [F]elect Telescope"),
	M_lazy_telescope("<leader>fw", "grep_string", "[F]ind current [W]ord"),
	M_lazy_telescope("<leader>fg", "live_grep", "[F]ind by [G]rep"),
	M_lazy_telescope("<leader>fd", "diagnostics", "[F]ind [D]iagnostics"),
	M_lazy_telescope("<leader>fr", "resume", "[F]ind [R]esume"),
	M_lazy_telescope("<leader>fo", "oldfiles", '[F]ind [O]ld Recent Files ("." for repeat)'),
	M_lazy_telescope("<leader>fc", "colorscheme", "[F]ind [C]olorschemes"),
	M_lazy_telescope("<leader><leader>", "buffers", "[ ] Find existing buffers"),
	M_lazy_telescope("<leader>/", function()
		require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, "[/] Fuzzily search in current buffer"),
	M_lazy_telescope("<leader>f/", function()
		require("telescope.builtin").live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, "[F]ind [/] in Open Files"),
	M_lazy_telescope("<leader>fp", function()
		require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
	end, "[F]ind neovim [Plugins]"),
	M_lazy_telescope("<leader>ee", function()
		require("telescope").extensions.file_browser.file_browser({
			path = "%:p:h",
			select_buffer = true,
		})
	end, "Open explorer in current dir"),
}

------------------------------------------------------------------------------
function keymaps.M_obsidian()
	local obsidian = require("obsidian")
	M("n", "<leader>of", function()
		if obsidian.util.cursor_on_markdown_link() then
			return "<cmd>ObsidianFollowLink<cr>"
		else
			vim.notify("Not an obsidian link", vim.log.levels.WARN)
		end
	end, { noremap = true, silent = true, desc = "Obsidian follow link" })
	M(
		"n",
		"<leader>on",
		"<cmd>ObsidianNewFromTemplate<cr>",
		{ noremap = true, silent = true, desc = "Obsidian create new note from templates" }
	)
	M({ "n", "v" }, "<leader>oc", function()
		return obsidian.util.toggle_checkbox()
	end, { noremap = true, silent = true, desc = "Obsidian create new note from templates" })
end

return keymaps
