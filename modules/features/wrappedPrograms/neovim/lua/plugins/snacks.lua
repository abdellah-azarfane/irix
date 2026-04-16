return {
    "snacks.nvim",
    after = function()
        require("snacks").setup({
        	bigfile = { enabled = true },
        	notifier = { enabled = true },
        	quickfile = { enabled = true },
        	words = { enabled = true },
        
        	dashboard = { enabled = false },
	        explorer = { enabled = true },
        	image = { enabled = false },
        	input = { enabled = false },
        	lazygit = { enabled = false },
	        picker = { enabled = true },
        	scope = { enabled = false },
        	scroll = { enabled = false },
        	statuscolumn = { enabled = false },
        	terminal = { enabled = true },
        })

    end
}
