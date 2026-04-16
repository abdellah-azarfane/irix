return {
	"dashboard-nvim",
	after = function()
		local dirs = {
			projects = vim.fn.expand("$HOME/projects"),
			vaults = vim.fn.expand("$HOME/vaults"),
			irix = vim.fn.expand("$HOME/dev/irix"),
		}

		local function get_logo()
			local logo = [[
             ███╗   ██╗██╗██╗   ██╗███████╗██╗  ██╗
             ████╗  ██║██║██║   ██║██╔════╝╚██╗██╔╝
             ██╔██╗ ██║██║██║   ██║█████╗   ╚███╔╝ 
             ██║╚██╗██║██║╚██╗ ██╔╝██╔══╝   ██╔██╗ 
             ██║ ╚████║██║ ╚████╔╝ ███████╗██╔╝ ██╗
             ╚═╝  ╚═══╝╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝
        ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			return vim.split(logo, "\n")
		end

		local function touch_file()
			vim.cmd("enew")
			vim.bo.buftype = ""
			vim.bo.bufhidden = "wipe"
			print("New file created. Use :w <path> to save or :q! to discard")
		end

		local function make_directory()
			vim.ui.input({ prompt = "Directory path: " }, function(input)
				if input and input ~= "" then
					local path = vim.fn.expand(input)
					vim.fn.mkdir(path, "p")
					print("Created directory: " .. path)
				end
			end)
		end

		local function make_project()
			vim.ui.input({ prompt = "Project path: " }, function(input)
				if input and input ~= "" then
					local path = vim.fn.expand(input)
					vim.fn.mkdir(path, "p")
					vim.cmd("cd " .. path)
					vim.ui.select({ "Yes", "No" }, { prompt = "Initialize git repository?" }, function(choice)
						if choice == "Yes" then
							vim.fn.system("git init " .. path)
							print("Created project with git at: " .. path)
						else
							print("Created project at: " .. path)
						end
					end)
				end
			end)
		end

		local function quick_note()
			local notes_dir = vim.fn.expand("$HOME/pendings")
			vim.fn.mkdir(notes_dir, "p")
			local timestamp = os.date("%Y%m%d_%H%M%S")
			local filename = notes_dir .. "/quick_note_" .. timestamp .. ".md"
			vim.cmd("edit " .. filename)
			vim.api.nvim_buf_set_lines(0, 0, 0, false, {
				"# Quick Note - " .. os.date("%Y-%m-%d %H:%M:%S"),
				"",
				"",
			})
			vim.cmd("normal! 3G")
		end

		local function open_picker(open)
			return function()
				open()
			end
		end

		vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
			callback = function()
				local buffers = vim.fn.getbufinfo({ buflisted = 1 })
				local non_dashboard_buffers = vim.tbl_filter(function(buf)
					return vim.bo[buf.bufnr].filetype ~= "dashboard"
				end, buffers)

				if #non_dashboard_buffers == 0 then
					vim.defer_fn(function()
						if vim.fn.exists("$NVIM_LISTEN_ADDRESS") == 1 or vim.fn.exists("$NVIM") == 1 then
							require("dashboard"):open()
						end
					end, 50)
				end
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dashboard",
			callback = function()
				vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })
				vim.keymap.set("n", "/", "<Nop>", { buffer = true, silent = true })

				vim.keymap.set("n", "ft", touch_file, { buffer = true, silent = true, desc = "Touch File" })
				vim.keymap.set("n", "fn", quick_note, { buffer = true, silent = true, desc = "Quick Note" })
				vim.keymap.set("n", "fd", make_directory, { buffer = true, silent = true, desc = "Make Directory" })
				vim.keymap.set("n", "fp", make_project, { buffer = true, silent = true, desc = "Make Project" })

				vim.keymap.set("n", "fr", open_picker(function()
					require("snacks").picker.files({ cwd = dirs.irix, title = "Irix" })
				end), { buffer = true, silent = true, desc = "Files Irix" })

				vim.keymap.set("n", "fR", open_picker(function()
					require("snacks").picker.recent({ title = "Recent Files" })
				end), { buffer = true, silent = true, desc = "Files Recent" })

				vim.keymap.set("n", "fa", open_picker(function()
					require("snacks").picker.files({ hidden = true, ignored = true, title = "All Files" })
				end), { buffer = true, silent = true, desc = "Files All" })

				vim.keymap.set("n", "zp", open_picker(function()
					require("snacks").explorer({ cwd = dirs.projects, title = "Projects" })
				end), { buffer = true, silent = true, desc = "Z Project" })

				vim.keymap.set("n", "zv", open_picker(function()
					require("snacks").explorer({ cwd = dirs.vaults, title = "Vaults" })
				end), { buffer = true, silent = true, desc = "Z Vault" })

				vim.keymap.set("n", "hc", ":checkhealth<CR>", { buffer = true, silent = true, desc = "Health Check" })

				vim.keymap.set("n", "?", function()
					local keybindings = {
						"File Operations:",
						"  [ft] Touch File       - Create new file",
						"  [fn] Quick Note       - Create timestamped note",
						"  [fd] Make Directory   - Create new directory",
						"  [fp] Make Project     - Create project with optional git",
						"  [fr] Files Irix       - Find files in ~/dev/irix",
						"  [fR] Files Recent     - Recent files",
						"  [fa] Files All        - Find all files (includes hidden/ignored)",
						"",
						"Navigation:",
						"  [zp] Z Project        - Open ~/projects in Snacks explorer",
						"  [zv] Z Vault          - Open ~/vaults in Snacks explorer",
						"",
						"Other:",
						"  [hc] Health Check     - Run :checkhealth",
						"  [q]  Quit             - Exit Neovim",
						"  [?]  Help             - Show this menu",
					}

					vim.ui.select(keybindings, { prompt = "Dashboard Shortcuts" })
				end, { buffer = true, silent = true, desc = "Show dashboard keybindings" })
			end,
		})

		require("dashboard").setup({
			theme = "doom",
			hide = {
				statusline = false,
				tabline = true,
				winbar = true,
			},
			config = {
				header = get_logo(),
				center = {
					{ action = touch_file, desc = " Touch File", icon = "⊹ ", key = "ft" },
					{ action = quick_note, desc = " Quick Note", icon = "⊹ ", key = "fn" },
					{ action = open_picker(function()
						require("snacks").picker.files({ cwd = dirs.irix, title = "Irix" })
					end), desc = " Files Irix", icon = "⊹ ", key = "fr" },
					{ action = open_picker(function()
						require("snacks").picker.recent({ title = "Recent Files" })
					end), desc = " Files Recent", icon = "⊹ ", key = "fR" },
					{ action = open_picker(function()
						require("snacks").picker.files({ hidden = true, ignored = true, title = "All Files" })
					end), desc = " Files All", icon = "⊹ ", key = "fa" },
					{ action = open_picker(function()
						require("snacks").explorer({ cwd = dirs.projects, title = "Projects" })
					end), desc = " Z Project", icon = "⊹ ", key = "zp" },
					{ action = open_picker(function()
						require("snacks").explorer({ cwd = dirs.vaults, title = "Vaults" })
					end), desc = " Z Vault", icon = "⊹ ", key = "zv" },
					{ action = "checkhealth", desc = " Health Check", icon = "⊹ ", key = "hc" },
					{
						action = function()
							local keybindings = {
								"File Operations:",
								"  [ft] Touch File       - Create new file",
								"  [fn] Quick Note       - Create timestamped note",
								"  [fd] Make Directory   - Create new directory",
								"  [fp] Make Project     - Create project with optional git",
								"  [fr] Files Irix      - Find files in ~/dev/irix",
								"  [fR] Files Recent     - Recent files",
								"  [fa] Files All        - Find all files (includes hidden/ignored)",
								"",
								"Navigation:",
								"  [zp] Z Project        - Open ~/projects in Snacks explorer",
								"  [zv] Z Vault          - Open ~/vaults in Snacks explorer",
								"",
								"Other:",
								"  [hc] Health Check     - Run :checkhealth",
								"  [q]  Quit             - Exit Neovim",
								"  [?]  Help             - Show this menu",
							}

							vim.ui.select(keybindings, { prompt = "Dashboard Shortcuts" })
						end,
						desc = " Help",
						icon = "⊹ ",
						key = "?",
					},
				},
			},
		})
	end,
}
