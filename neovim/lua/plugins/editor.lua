-- lua/plugins/editor.lua
return {
	{
		"snacks.nvim",
		auto_enable = true,
		-- snacks makes a global, and then lazily loads itself
		lazy = false,
		-- priority only affects startup plugins
		-- unless otherwise specified by a particular handler
		priority = 1000,
		after = function(plugin)
			-- I also like this color
			vim.api.nvim_set_hl(0, "MySnacksIndent", { fg = "#32a88f" })
			require("snacks").setup({
				explorer = { replace_netrw = true },
				picker = {
					sources = {
						explorer = {
							auto_close = true,
							git = {},
							terminal = {},
							scope = {},
							indent = {
								scope = { hl = "MySnacksIndent" },
								chunk = { hl = "MySnacksIndent" },
							},
						},
					},
				},
				statuscolumn = {
					left = { "mark", "git" }, -- priority of signs on the left (high to low)
					right = { "sign", "fold" }, -- priority of signs on the right (high to low)
					folds = {
						open = false, -- show open fold icons
						git_hl = false, -- use Git Signs hl for fold icons
					},
					git = {
						-- patterns to match Git signs
						patterns = { "GitSign", "MiniDiffSign" },
					},
					refresh = 50, -- refresh at most every 50ms
				},
				-- make sure lazygit always reopens the correct program
				-- hopefully this can be removed one day
				lazygit = {
					config = {
						os = {
							editPreset = "nvim-remote",
							edit = vim.v.progpath
								.. [=[ --server "$NVIM" --remote-send '<cmd>lua nixInfo.lazygit_fix({{filename}})<CR>']=],
							editAtLine = vim.v.progpath
								.. [=[ --server "$NVIM" --remote-send '<cmd>lua nixInfo.lazygit_fix({{filename}}, {{line}})<CR>']=],
							openDirInEditor = vim.v.progpath
								.. [=[ --server "$NVIM" --remote-send '<cmd>lua nixInfo.lazygit_fix({{dir}})<CR>']=],
							-- this one isnt a remote command, make sure it gets our config regardless of if we name it nvim or not
							editAtLineAndWait = nixInfo(vim.v.progpath, "progpath") .. " +{{line}} {{filename}}",
						},
					},
				},
			})

			-- Handle the backend of those remote commands.
			-- hopefully this can be removed one day
			nixInfo.lazygit_fix = function(path, line)
				local prev = vim.fn.bufnr("#")
				local prev_win = vim.fn.bufwinid(prev)
				vim.api.nvim_feedkeys("q", "n", false)
				if line then
					vim.api.nvim_buf_call(prev, function()
						vim.cmd.edit(path)
						local buf = vim.api.nvim_get_current_buf()
						vim.schedule(function()
							if buf then
								vim.api.nvim_win_set_buf(prev_win, buf)
								vim.api.nvim_win_set_cursor(0, { line or 0, 0 })
							end
						end)
					end)
				else
					vim.api.nvim_buf_call(prev, function()
						vim.cmd.edit(path)
						local buf = vim.api.nvim_get_current_buf()
						vim.schedule(function()
							if buf then
								vim.api.nvim_win_set_buf(prev_win, buf)
							end
						end)
					end)
				end
			end

			-- NOTE: we aren't loading this lazily, and the keybinds already are so it is fine to just set these here
			vim.keymap.set("n", "-", function()
				Snacks.explorer.open()
			end, { desc = "Snacks file explorer" })
			vim.keymap.set("n", "<c-\\>", function()
				Snacks.terminal.open()
			end, { desc = "Snacks Terminal" })
			vim.keymap.set("n", "<leader>_", function()
				Snacks.lazygit.open()
			end, { desc = "Snacks LazyGit" })
			vim.keymap.set("n", "<leader>sf", function()
				Snacks.picker.smart()
			end, { desc = "Smart Find Files" })
			vim.keymap.set("n", "<leader><leader>s", function()
				Snacks.picker.buffers()
			end, { desc = "Search Buffers" })
			-- find
			vim.keymap.set("n", "<leader>ff", function()
				Snacks.picker.files()
			end, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fg", function()
				Snacks.picker.git_files()
			end, { desc = "Find Git Files" })
			-- Grep
			vim.keymap.set("n", "<leader>sb", function()
				Snacks.picker.lines()
			end, { desc = "Buffer Lines" })
			vim.keymap.set("n", "<leader>sB", function()
				Snacks.picker.grep_buffers()
			end, { desc = "Grep Open Buffers" })
			vim.keymap.set("n", "<leader>sg", function()
				Snacks.picker.grep()
			end, { desc = "Grep" })
			vim.keymap.set({ "n", "x" }, "<leader>sw", function()
				Snacks.picker.grep_word()
			end, { desc = "Visual selection or ord" })
			-- search
			vim.keymap.set("n", "<leader>sd", function()
				Snacks.picker.diagnostics()
			end, { desc = "Diagnostics" })
			vim.keymap.set("n", "<leader>sD", function()
				Snacks.picker.diagnostics_buffer()
			end, { desc = "Buffer Diagnostics" })
			vim.keymap.set("n", "<leader>sh", function()
				Snacks.picker.help()
			end, { desc = "Help Pages" })
			vim.keymap.set("n", "<leader>sj", function()
				Snacks.picker.jumps()
			end, { desc = "Jumps" })
			vim.keymap.set("n", "<leader>sk", function()
				Snacks.picker.keymaps()
			end, { desc = "Keymaps" })
			vim.keymap.set("n", "<leader>sl", function()
				Snacks.picker.loclist()
			end, { desc = "Location List" })
			vim.keymap.set("n", "<leader>sm", function()
				Snacks.picker.marks()
			end, { desc = "Marks" })
			vim.keymap.set("n", "<leader>sM", function()
				Snacks.picker.man()
			end, { desc = "Man Pages" })
			vim.keymap.set("n", "<leader>sq", function()
				Snacks.picker.qflist()
			end, { desc = "Quickfix List" })
			vim.keymap.set("n", "<leader>sR", function()
				Snacks.picker.resume()
			end, { desc = "Resume" })
			vim.keymap.set("n", "<leader>su", function()
				Snacks.picker.undo()
			end, { desc = "Undo History" })
		end,
	},
	{
		"nvim-surround",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(plugin)
			require("nvim-surround").setup()
		end,
	},
	{
		"gitsigns.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(plugin)
			require("gitsigns").setup({
				-- See `:help gitsigns.txt`
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = " " },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map({ "n", "v" }, "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Jump to next hunk" })

					map({ "n", "v" }, "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Jump to previous hunk" })

					-- Actions
					-- visual mode
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "stage git hunk" })
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "reset git hunk" })
					-- normal mode
					map("n", "<leader>gs", gs.stage_hunk, { desc = "git stage hunk" })
					map("n", "<leader>gr", gs.reset_hunk, { desc = "git reset hunk" })
					map("n", "<leader>gS", gs.stage_buffer, { desc = "git Stage buffer" })
					map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
					map("n", "<leader>gR", gs.reset_buffer, { desc = "git Reset buffer" })
					map("n", "<leader>gp", gs.preview_hunk, { desc = "preview git hunk" })
					map("n", "<leader>gb", function()
						gs.blame_line({ full = false })
					end, { desc = "git blame line" })
					map("n", "<leader>gd", gs.diffthis, { desc = "git diff against index" })
					map("n", "<leader>gD", function()
						gs.diffthis("~")
					end, { desc = "git diff against last commit" })

					-- Toggles
					map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
					map("n", "<leader>gtd", gs.toggle_deleted, { desc = "toggle git show deleted" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
				end,
			})
			vim.cmd([[hi GitSignsAdd guifg=#04de21]])
			vim.cmd([[hi GitSignsChange guifg=#83fce6]])
			vim.cmd([[hi GitSignsDelete guifg=#fa2525]])
		end,
	},
	{
		"which-key.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(plugin)
			require("which-key").setup({})
			require("which-key").add({
				{ "<leader><leader>", group = "buffer commands" },
				{ "<leader><leader>_", hidden = true },
				{ "<leader>c", group = "[c]ode" },
				{ "<leader>c_", hidden = true },
				{ "<leader>d", group = "[d]ocument" },
				{ "<leader>d_", hidden = true },
				{ "<leader>g", group = "[g]it" },
				{ "<leader>g_", hidden = true },
				{ "<leader>m", group = "[m]arkdown" },
				{ "<leader>m_", hidden = true },
				{ "<leader>r", group = "[r]ename" },
				{ "<leader>r_", hidden = true },
				{ "<leader>s", group = "[s]earch" },
				{ "<leader>s_", hidden = true },
				{ "<leader>t", group = "[t]oggles" },
				{ "<leader>t_", hidden = true },
				{ "<leader>w", group = "[w]orkspace" },
				{ "<leader>w_", hidden = true },
			})
		end,
	},
}
