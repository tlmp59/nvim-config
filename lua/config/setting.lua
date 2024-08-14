--- [vim.g] :help vim.g for more information
local g = vim.g
--- [vim.opt] :help vim.opt for more information
local opt = vim.opt
--- [vim.o] :help vim.o for more information
local o = vim.o

--- @class UserSetting
local setting = {}

------------------------------------------------------------------------------
function setting.opt_global()
	-- leader must be set before loading any plugins
	g.mapleader = " "
	g.maplocalleader = " "

	--  set to true if have nerdfont installedsplit
	g.have_nerd_font = true
	--  disable unused default plugin
	local disabled_built_ins = {
		"netrw",
		"netrwPlugin",
		"netrwSettings",
		"netrwFileHandlers",
		"gzip",
		"zip",
		"zipPlugin",
		"tar",
		"tarPlugin",
		"getscript",
		"getscriptPlugin",
		"vimball",
		"vimballPlugin",
		"2html_plugin",
		"logipat",
		"rrhelper",
		"spellfile_plugin",
		"matchit",
		"python3_provider",
	}
	for _, plugin in pairs(disabled_built_ins) do
		vim.g["loaded_" .. plugin] = 1
	end

	-- hide nonexist line indicator
	opt.fillchars:append({ eob = " " })

	--  number col
	opt.number = true
	opt.relativenumber = true

	--  set mouse mode
	opt.mouse = "" -- other option: "a" all, "n" normal, "i" insert, "v" visual

	--  enable yank in system clipboard
	--   sync clipboard between OS and Neovim, schedule the setting after 'UiEnter' because it can increase startup time
	vim.schedule(function()
		opt.clipboard = "unnamedplus"
	end)

	--  toggle word wrap
	opt.wrap = false
	opt.breakindent = true -- require wrap = true for this to take effect, this allow to preserve the indentaion of a line when it wraps to the next line
	-- opt.breakindent = "list:-1"
	-- opt.breakindentopt = "shift:2"
	-- opt.linebreak = true

	--  autoindent
	opt.autoindent = true --> copy indent from current line when starting new one

	--  option with searching
	opt.ignorecase = true --> case insensitive searching if set to true
	opt.smartcase = true --> works along side with ignorecase, if search pattern contains an uppercase letter, the search become case sensitive

	--  option for signcolumn
	opt.signcolumn = "yes" --> a vertical area on the left side of the editor window, typically used to show various indicators or symbols

	--  configure on Vim wait time for certain sequences
	opt.updatetime = 250 --> how long Vim waits after stop typing before trigger certain events
	opt.timeoutlen = 500 -- other options: "no", "auto", "number"
	--> how long Vim waits for a mapped sequence to complete if not completed within time Vim will execute the partial mapping or key code

	--  configure how new splits should be opened
	opt.splitright = true
	opt.splitbelow = true

	--  preview command execution live
	opt.inccommand = "split" -- other opts: 'split', ''

	--  show which line the cursor is on
	opt.cursorline = false

	--  configure backup option
	opt.swapfile = false
	opt.backup = false
	opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
	opt.undofile = true

	--  searching options
	opt.hlsearch = true --> highlight search set to false won't keep all matches highlighted after a search
	opt.incsearch = true --> automatic jump to the first partially matches with inputs

	--  enable termguicolors
	opt.termguicolors = true

	--  configure conceallevel
	opt.conceallevel = 2 --> "conceal" is a way to simplify the visual presentation of text while preserving the full content in the file

	-- optiont tab indent
	opt.tabstop = 4
	opt.softtabstop = 4
	opt.shiftwidth = 4
	opt.expandtab = true --> instead of inserting a single tab character set this to true will instead insert an equivalent number of space characters

	--  minimal number fo screen lines to keep above and below cursor
	opt.scrolloff = 10
	opt.sidescrolloff = 8

	--  sets how neovim will display certain whitespace characters in the editor.
	--   see `:help 'list'`and `:help 'listchars'`
	opt.list = true
	opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }

	--  disable show the mode, since it's already in the status line
	opt.showmode = false

	--  make sure that statusline is comletely disable
	opt.statusline = "%#Normal#"

	--  dsiable statusline on startup
	o.laststatus = 0

	--  configure how completion menus behave
	o.completeopt = "menuone,noselect" --> show popup menu even there is only one match and do not select anything from there

	--  hide tabline
	o.showtabline = 0

	--  hide statusline
	o.laststatus = 0

	--  hide command line
	o.cmdheight = 1
end

------------------------------------------------------------------------------
function setting.opt_local()
	--  tweaking winbar
	local opts = "%f"
	require("config.autocmd").local_winbar(opts)
end

------------------------------------------------------------------------------
return setting
