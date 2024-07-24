local M = vim.keymap.set
local function unM(mode, lhs)
	return vim.keymap.set(mode, lhs, "<Nop>", { noremap = true, silent = true })
end

--------------------------------------------------------
--> [[ Nice to have ]]
--  disable space to use it as leader key
unM({ "n", "v" }, "<Space>")

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

--  quickly change colorscheme
M("n", "<leader>fc", ":Telescope colorscheme", { desc = "[F]ind [C]olorscheme" })

--------------------------------------------------------
--> [[ Buffers/Tabs ]]
-- seemlessly navigate between buffers/tabs
M("n", "tk", ":bl<cr>", { noremap = false, silent = true })
M("n", "tj", ":bf<cr>", { noremap = false, silent = true })
M("n", "th", ":bp<cr>", { noremap = false, silent = true })
M("n", "tl", ":bn<cr>", { noremap = false, silent = true })
M("n", "td", ":bd<cr>", { noremap = false, silent = true })

--------------------------------------------------------
--> [[ Windows ]]
--  seemlessly navigate between split windows
M("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
M("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
M("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
M("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

--  windows size adjustment
M("n", "<leader><left>", ":vertical resize +10<CR>", { silent = true })
M("n", "<leader><right>", ":vertical resize -10<CR>", { silent = true })
M("n", "<leader><up>", ":resize +10<CR>", { silent = true })
M("n", "<leader><down>", ":resize -10<CR>", { silent = true })

--  windows manipulations
M("n", '<C-w>"', ":horizontal split<CR>", { desc = "Split window horizontally", silent = true })
M("n", "<C-w>%", ":vertical split<CR>", { desc = "Split window vertically", silent = true })
M("n", "<C-w><left>", ":wincmd H<CR>", { desc = "Move window to far left", silent = true })
M("n", "<C-w><right>", ":wincmd L<CR>", { desc = "Move window to far right", silent = true })
M("n", "<C-w><up>", ":wincmd K<CR>", { desc = "Move window to top", silent = true })
M("n", "<C-w><bottom>", ":wincmd J<CR>", { desc = "Move window to bottom", silent = true })
M("n", "<C-w>n", ":wincmd x<CR>", { desc = "Swap current window with [n]ext", silent = true })
M("n", "<C-w>p", ":wincmd p<CR> :wincmd x<CR>", { desc = "Swap current window with [p]revious", silent = true })

--  window equalize, maximize on height/width
--   <C-w> = for equalize
unM({ "n", "i", "v" }, "<C-w>_")
unM({ "n", "i", "v" }, "<C-w>|")
M("n", "<C-w>mh", ":resize<CR>", { desc = "Max out [h]eight", silent = true })
M("n", "<C-w>mw", ":vertical resize<CR>", { desc = "Max out [w]idth", silent = true })

--  replace <C-w>o with <C-w>x to match with tmux
unM({ "n", "i", "v" }, "<C-w>o")
unM({ "n", "i", "v" }, "<C-w>x")
M("n", "<C-w>x", ":only<CR>", { desc = "Close all other windows", silent = true })

--  disable some unuse keymaps
unM({ "n", "i", "v" }, "<C-w>s")
unM({ "n", "i", "v" }, "<C-w>v")
unM({ "n", "i", "v" }, "<C-w>H")
unM({ "n", "i", "v" }, "<C-w>J")
unM({ "n", "i", "v" }, "<C-w>K")
unM({ "n", "i", "v" }, "<C-w>L")
unM({ "n", "i", "v" }, "<C-w>T")
unM({ "n", "i", "v" }, "<C-w>q")
unM({ "n", "i", "v" }, "<C-w><")
unM({ "n", "i", "v" }, "<C-w>>")
unM({ "n", "i", "v" }, "<C-w>+")
unM({ "n", "i", "v" }, "<C-w>-")

--------------------------------------------------------
--> [[ Telescope ]]

--------------------------------------------------------
--> [[ LSP ]]

--------------------------------------------------------
--> [[ Trouble ]]

--------------------------------------------------------
--> [[ Surround ]]
