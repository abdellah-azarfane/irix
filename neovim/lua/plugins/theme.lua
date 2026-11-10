-- lua/plugins/theme.lua
return {
	{
		"trigger_colorscheme",
		event = "VimEnter",
		load = function(_name)
			vim.schedule(function()
				vim.cmd.colorscheme(nixInfo("onedark_dark", "settings", "colorscheme"))
				vim.schedule(function()
					vim.cmd([[hi LineNr guifg=#bb9af7]])
				end)
			end)
		end,
	},
	{
		"onedarkpro.nvim",
		auto_enable = true,
		colorscheme = { "onedark", "onedark_dark", "onedark_vivid", "onelight" },
	},
	{
		"vim-moonfly-colors",
		auto_enable = true,
		colorscheme = "moonfly",
	},
}
