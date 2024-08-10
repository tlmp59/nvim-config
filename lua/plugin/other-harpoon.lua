-- [[ Description ]]

-- [[ Config ]]
return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local M = vim.keymap.set
		-- compare with a list of unwanted filetype to be loaded in harpoon?
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
			harpoon.ui:toggle_quick_menu(harpoon:list())
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
	end,
}
