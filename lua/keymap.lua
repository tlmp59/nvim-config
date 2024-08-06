local M = vim.keymap.set

-- function to safely delete default keymaps
local function unM(mode, lhs, options)
	return pcall(vim.keymap.del, mode, lhs, options or {})
end

--------------------------------------------------------
--> [[ Nice to have ]]
-- disable <space> for leader key
unM({ "n", "v" }, "<Space>")
unM({ "n", "v", "x" }, "-")
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

--------------------------------------------------------
--> [[ Buffers, Tabs, Windows ]]
M("n", "<Tab>", ":bn<cr>", { desc = "Last tab/buffer", noremap = true, silent = true })
M("n", "<C-Tab>", ":bp<cr>", { desc = "First tab/buffer", noremap = true, silent = true })

--------------------------------------------------------
--> [[ Tabs ]]
M("n", "<leader>tl", ":tabnext<cr>", { desc = "[T]ab next", noremap = true, silent = true })
M("n", "<leader>th", ":tabprevious<cr>", { desc = "[T]ab previous", noremap = true, silent = true })
M("n", "<leader>tj", ":tablast<cr>", { desc = "[T]ab last", noremap = true, silent = true })
M("n", "<leader>tk", ":tabfirst<cr>", { desc = "[T]ab first", noremap = true, silent = true })
M("n", "<leader>tn", ":tabnew<cr>", { desc = "[T]ab [N]ew", noremap = true, silent = true })
M("n", "<leader>tc", ":tabclose<cr>", { desc = "[T]ab [C]lose", noremap = true, silent = true })
M("n", "<leader>to", ":tabonly<cr>", { desc = "[T]ab [O]nly", noremap = true, silent = true })

--------------------------------------------------------
--> [[ Windows ]]
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
--   <C-w> = for equalize
unM({ "n", "i", "v" }, "<C-w>_")
unM({ "n", "i", "v" }, "<C-w>|")
M("n", "<C-w>mh", ":resize<CR>", { desc = "Max out [h]eight", silent = true })
M("n", "<C-w>mw", ":vertical resize<CR>", { desc = "Max out [w]idth", silent = true })

--  replace <C-w>o with <C-w>x to match with tmux
unM({ "n", "i", "v" }, "<C-w>o")
M("n", "<C-w>x", "<CMD>only<CR>", { desc = "Close all other windows", silent = true })

--------------------------------------------------------
--> [[ Disable unused keymaps ]]
unM({ "n", "i", "v" }, "<C-w>s")
unM({ "n", "i", "v" }, "<C-w>v")
unM({ "n", "i", "v" }, "<C-w>T")
unM({ "n", "i", "v" }, "<C-w>q")
unM({ "n", "i", "v" }, "<C-w><")
unM({ "n", "i", "v" }, "<C-w>>")
unM({ "n", "i", "v" }, "<C-w>+")
unM({ "n", "i", "v" }, "<C-w>-")

--------------------------------------------------------
--> [[ Oil ]]
M("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

--------------------------------------------------------
