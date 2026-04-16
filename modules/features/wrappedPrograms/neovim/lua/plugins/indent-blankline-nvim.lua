return {
    "indent-blankline.nvim",
    after = function()
        require("ibl").setup {
        	exclude = {
        		filetypes = {
        			"dashboard",
        			"help",
        			"terminal",
        			"lazy",
        			"lspinfo",
        			"TelescopePrompt",
        			"TelescopeResults",
        			"mason",
        			"",
        		},
        	},
        }

    end
}
