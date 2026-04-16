return {
    "which-key.nvim",
    after = function()
        require("which-key").setup({
        	preset = "helix",
        	delay = 200,
        	-- Window
        	win = {
        		border = "single",
        		padding = { 1, 2 },
        		wo = {
        			winblend = 5,
        		},
        	},
        	-- Layout
        	layout = {
        		width = { min = 50 },
        		spacing = 3,
        	},
        	-- Custom key symbols
        	icons = {
        		breadcrumb = "›",
        		separator = "→",
        		group = "",
        		ellipsis = "…",
        		mappings = false,
        		rules = false,
        		colors = false,
        		keys = {
        			Up = "↑",
        			Down = "↓",
        			Left = "←",
        			Right = "→",
        			C = "⌃",
        			M = "⌥",
        			D = "⌘",
        			S = "⇧",
        			CR = "⏎",
        			Esc = "⎋",
        			Space = "␣",
        			Tab = "⇥",
        			BS = "⌫",
        			NL = "⏎",
        			ScrollWheelUp = "↑",
        			ScrollWheelDown = "↓",
        			F1 = "ƒ1",
        			F2 = "ƒ2",
        			F3 = "ƒ3",
        			F4 = "ƒ4",
        			F5 = "ƒ5",
        			F6 = "ƒ6",
        			F7 = "ƒ7",
        			F8 = "ƒ8",
        			F9 = "ƒ9",
        			F10 = "ƒ10",
        			F11 = "ƒ11",
        			F12 = "ƒ12",
        		},
        	},
        })
        
        -- --- Group Definitions ---
        require("which-key").add({
        	-- Core groups
        	{ "<leader>a", group = "◈ Yazi" },
        	{ "<leader>b", group = "⎕ Buffer" },
        	{ "<leader>c", group = "⍝ Comment" },
        	{ "<leader>d", group = "‼ Diagnostic" },
        	{ "<leader>e", group = "∆ Edit" },
        	{ "<leader>f", group = "⌆ Find" },
        	{ "<leader>g", group = "⠮ Git" },
        	{ "<leader>h", group = "⊰ Harpoon" },
        	{ "<leader>i", group = "↦ Indent" },
        	{ "<leader>j", group = "⟐ Jump" },
        	{ "<leader>l", group = "ψ LSP" },
        	{ "<leader>m", group = "⠿ Multicursor" },
        	{ "<leader>o", group = "◫ Outline" },
        	{ "<leader>p", group = "† Pins" },
        	{ "<leader>r", group = "⍋ Replace" },
        	{ "<leader>s", group = "⌽ Sort" },
        	{ "<leader>t", group = "♰ Trouble" },
        	{ "<leader>x", group = "✕ Noice" },
        	{ "<leader>z", group = "± Fold" },
        	{ "<leader><space>", group = "⊑ Toggle" },
        
        	-- Toggle subgroups
        	{ "<leader><space>n", desc = "№ Toggle line numbers" },
        	{ "<leader><space>v", desc = "⊞ Toggle visual line movement" },
        	{ "<leader><space>z", desc = "⊡ Toggle zen mode" },
        
        	-- Buffer subgroups
        	{ "<leader>bc", group = "⊗ Close" },
        	{ "<leader>bg", group = "⊙ Group" },
        	{ "<leader>bm", group = "⊚ Move" },
        	{ "<leader>bs", group = "⊛ Sort" },
        
        	-- Comment subgroups
        	{ "<leader>cs", group = "⇄ Swap" },
        
        	-- Noice subgroup
        	{ "<leader>xn", group = "◊ Noice" },
        
        	-- Non-leader groups for navigation
        	{ "]", group = "⇢ Next" },
        	{ "[", group = "⇠ Prev" },
        	{ "g", group = "⟐ Go" },
        	{ "g[", group = "⇤ First" },
        	{ "g]", group = "⇥ Last" },
        
        	-- Flash
        	{ "s", desc = "⊡ Flash jump", mode = { "n", "x", "o" } },
        	{ "S", desc = "⌲ Flash treesitter", mode = { "n", "x", "o" } },
        	{ "r", desc = "⊙ Remote flash", mode = "o" },
        	{ "R", desc = "⌕ Treesitter search", mode = { "o", "x" } },
        	{ "<c-s>", desc = "⊞ Toggle flash search", mode = "c" },
        
        	-- FtPlugin
        	{ ";", group = "◈ FileType" },
        })
        
        -- --- Individual Keybind Descriptions ---
        require("which-key").add({
        	-- General
        	{ "<Esc>", desc = "⊘ Clear search highlight" },
        	{ "<leader>D", desc = "⊖ Delete entire buffer" },
        	{ "<leader>n", desc = "№ Toggle line numbers" },
        	{ "<leader>y", desc = "⊕ Copy entire buffer" },
        
        	-- Yazi
        	{ "<leader>ac", desc = "◈ Open on current directory" },
        	{ "<leader>aw", desc = "◉ Open on working directory" },
        
        	-- Outline/Aerial
        	{ "<leader>oA", desc = "◬ Toggle navigation" },
        	{ "<leader>oa", desc = "◫ Toggle sidebar" },
        	{ "<leader>of", desc = "◪ Focus sidebar" },
        	{ "{", desc = "∧ Next symbol" },
        	{ "}", desc = "∨ Previous symbol" },
        
        	-- Comment
        	{ "<leader>cA", desc = "≡ Comment all lines" },
        	{ "<leader>cD", desc = "☑ Insert DONE" },
        	{ "<leader>ca", desc = "⊡ Append comment" },
        	{ "<leader>cc", desc = "≈ Toggle line/count" },
        	{ "<leader>cd", desc = "⊙ Insert DOCS" },
        	{ "<leader>ce", desc = "⊝ Insert TEST" },
        	{ "<leader>cf", desc = "✗ Insert FIX" },
        	{ "<leader>ch", desc = "⊡ Insert HACK" },
        	{ "<leader>cl", desc = "≣ List buffer TODOs" },
        	{ "<leader>cn", desc = "※ Insert NOTE" },
        	{ "<leader>cp", desc = "⊕ Insert PERF" },
        	{ "<leader>csd", desc = "⇄ Toggle TODO/DONE" },
        	{ "<leader>ct", desc = "✓ Insert TODO" },
        	{ "<leader>cw", desc = "⚠ Insert WARN" },
        	{ "<leader>ch", desc = "⊟ Insert comment header" },
        
        	-- --- Edit ---
        	{ "<leader>er", desc = "⊹ Replace buffer with clipboard" },
        
        	-- --- Indents ---
        	{ "<leader>ii", desc = "→ Smart indent" },
        	{ "<leader>io", desc = "← Smart outdent" },
        
        	-- --- Lsp Actions ---
        	{ "<leader>la", desc = "⌥ Code actions" },
        	{ "<leader>lf", desc = "⌘ Format (Conform)" },
        	{ "<leader>lh", desc = "◈ Show hover" },
        	{ "<leader>lr", desc = "⊛ Rename symbol" },
        
        	-- --- Lsp Navigation ---
        	{ "gd", desc = "◆ Go to definition" },
        	{ "gi", desc = "◊ Go to implementation" },
        	{ "gr", desc = "◇ Go to references" },
        	{ "gt", desc = "○ Go to type definition" },
        
        	-- --- Replace (smart) ---
        	{ "<leader>rr", desc = "⍎ Replace smartly with prompt", mode = { "n", "v" } },
        
        	-- --- Replace (spectre) ---
        	{ "<leader>rf", desc = "◐ Search in current file" },
        	{ "<leader>rt", desc = "◎ Toggle Spectre" },
        	{ "<leader>rw", desc = "◉ Search current word" },
        
        	-- --- Diagnostics ---
        	{ "<leader>db", desc = "≣ Show buffer diagnostics" },
        	{ "<leader>dl", desc = "≡ Show line diagnostics" },
        	{ "<leader>dv", desc = "◫ Toggle virtual text" },
        	{ "[d", desc = "◂ Previous diagnostic" },
        	{ "[e", desc = "◃ Previous error" },
        	{ "]d", desc = "▸ Next diagnostic" },
        	{ "]e", desc = "▹ Next error" },
        
        	-- --- Find/search ---
        	{ "<leader>fD", desc = "⊗ Diagnostics (all)" },
        	{ "<leader>fH", desc = "⍉ Search history" },
        	{ "<leader>fS", desc = "◉ Symbols (workspace)" },
        	{ "<leader>fb", desc = "⊞ Buffers" },
        	{ "<leader>fc", desc = "⌘ Command history" },
        	{ "<leader>fd", desc = "⊖ Diagnostics (current)" },
        	{ "<leader>ff", desc = "⊡ Files" },
        	{ "<leader>fg", desc = "⊙ Live grep with args" },
        	{ "<leader>fh", desc = "◊ Help" },
        	{ "<leader>fk", desc = "⌨ Keymaps" },
        	{ "<leader>fo", desc = "⊙ Options" },
        	{ "<leader>fp", desc = "◉ Project files" },
        	{ "<leader>fr", desc = "↺ Recent (Frecency)" },
        	{ "<leader>fs", desc = "◈ Symbols (document)" },
        	{ "<leader>ft", desc = "✓ TODOs with priority" },
        	{ "<leader>fw", desc = "⊛ Word under cursor" },
        
        	-- --- Git ---
        	{ "<leader>gb", desc = "⌥ Branches" },
        	{ "<leader>gc", desc = "◎ Commits" },
        	{ "<leader>gs", desc = "≡ Status" },
        
        	-- --- Harpoon ---
        	{ "<leader>ha", desc = "⊕ Add file to marks" },
        	{ "<leader>hh", desc = "⊡ Toggle menu" },
        	{ "<leader>h1", desc = "① Jump to mark 1" },
        	{ "<leader>h2", desc = "② Jump to mark 2" },
        	{ "<leader>h3", desc = "③ Jump to mark 3" },
        	{ "<leader>h4", desc = "④ Jump to mark 4" },
        	{ "<leader>hn", desc = "▷ Next mark" },
        	{ "<leader>hp", desc = "◁ Previous mark" },
        	{ "<leader>hc", desc = "⊗ Clear all marks" },
        	{ "<leader>hr", desc = "⊖ Remove current file" },
        	{ "<M-h>", desc = "⊰ Quick mark 1" },
        	{ "<M-j>", desc = "⊰ Quick mark 2" },
        	{ "<M-k>", desc = "⊰ Quick mark 3" },
        	{ "<M-l>", desc = "⊰ Quick mark 4" },
        	{ "]h", desc = "⇢ Next Harpoon mark" },
        	{ "[h", desc = "⇠ Previous Harpoon mark" },
        
        	-- Jump (Flash)
        	{ "<leader>jl", desc = "⎯ Jump to line", mode = { "n", "x", "o" } },
        	{ "<leader>jw", desc = "◈ Jump to word beginning", mode = { "n", "x", "o" } },
        	{ "<leader>j.", desc = "↺ Continue last flash", mode = { "n", "x", "o" } },
        	{ "<leader>jf", desc = "→ Flash forward only", mode = { "n", "x", "o" } },
        	{ "<leader>jb", desc = "← Flash backward only", mode = { "n", "x", "o" } },
        	{ "<leader>jW", desc = "◉ Flash select word", mode = { "x", "o" } },
        
        	-- --- Marks ---
        	{ "<leader>pa", desc = "Set mark (wait for letter)" },
        	{ "<leader>p,", desc = "Set next available mark" },
        	{ "<leader>p;", desc = "Toggle mark at line" },
        	{ "<leader>p<space>", desc = "Delete mark on line" },
        	{ "<leader>pD", desc = "Delete all marks in buffer" },
        	{ "<leader>p]", desc = "Next mark" },
        	{ "<leader>p[", desc = "Previous mark" },
        	{ "<leader>p:", desc = "Preview mark" },
        	{ "<leader>pd", desc = "Delete mark (wait for letter)" },
        	{ "]m", desc = "▸ Next mark" },
        	{ "[m", desc = "◂ Previous mark" },
        
        	-- --- Trouble ---
        	{ "<leader>tb", desc = "◉ Buffer diagnostics" },
        	{ "<leader>tc", desc = "⊗ Close all" },
        	{ "<leader>td", desc = "◆ LSP definitions" },
        	{ "<leader>ti", desc = "◊ LSP implementations" },
        	{ "<leader>tl", desc = "○ Location list" },
        	{ "<leader>tq", desc = "◊ Quickfix list" },
        	{ "<leader>tr", desc = "◇ LSP references" },
        	{ "<leader>ts", desc = "⊛ Document symbols" },
        	{ "<leader>tt", desc = "◈ Toggle diagnostics" },
        
        	-- Trouble Navigation
        	{ "[T", desc = "◁ Previous trouble item" },
        	{ "]T", desc = "▷ Next trouble item" },
        	{ "g[T", desc = "⇤ First trouble item" },
        	{ "g]T", desc = "⇥ Last trouble item" },
        
        	-- --- Treesitter ---
        	{ "<leader>z", desc = "± Toggle treesitter folding" },
        
        	-- --- Buffers ---
        	{ "<leader>b1", desc = "① Go to buffer 1" },
        	{ "<leader>b2", desc = "② Go to buffer 2" },
        	{ "<leader>b3", desc = "③ Go to buffer 3" },
        	{ "<leader>b4", desc = "④ Go to buffer 4" },
        	{ "<leader>b5", desc = "⑤ Go to buffer 5" },
        	{ "<leader>b6", desc = "⑥ Go to buffer 6" },
        	{ "<leader>b7", desc = "⑦ Go to buffer 7" },
        	{ "<leader>b8", desc = "⑧ Go to buffer 8" },
        	{ "<leader>b9", desc = "⑨ Go to buffer 9" },
        	{ "<leader>bP", desc = "⊡ Toggle pin" },
        	{ "<leader>bcl", desc = "◀ Close to left" },
        	{ "<leader>bco", desc = "◉ Close others" },
        	{ "<leader>bcp", desc = "◎ Pick to close" },
        	{ "<leader>bcr", desc = "▶ Close to right" },
        	{ "<leader>bgd", desc = "⊟ Toggle Docs group" },
        	{ "<leader>bgt", desc = "⊞ Toggle Tests group" },
        	{ "<leader>bmn", desc = "▷ Move next" },
        	{ "<leader>bmp", desc = "◁ Move prev" },
        	{ "<leader>bp", desc = "⊙ Pick buffer" },
        	{ "<leader>bsd", desc = "◫ Sort by directory" },
        	{ "<leader>bse", desc = "◬ Sort by extension" },
        	{ "<leader>bst", desc = "◪ Sort by tabs" },
        	{ "<leader>q", desc = "✗ Close without saving" },
        	{ "<leader>w", desc = "✓ Save and close" },
        	{ "<M-s>", desc = "▶ Next buffer", mode = { "n", "v" } },
        	{ "<M-S>", desc = "◀ Previous buffer", mode = { "n", "v" } },
        
        	-- TODOs Navigation
        	{ "[t", desc = "◂ Previous todo comment" },
        	{ "]t", desc = "▸ Next todo comment" },
        	{ "]T", desc = "▸ Next task (priority)" },
        
        	-- Multicursor
        	{ "<C-a>", desc = "⊛ Find all", mode = "n" },
        	{ "<C-n>", desc = "⇢ Find next", mode = "n" },
        	{ "<C-p>", desc = "⇠ Find prev", mode = "n" },
        	{ "<C-x>", desc = "⤴ Skip current", mode = "n" },
        	{ "<Esc>", desc = "⊗ Exit multicursor", mode = "n" },
        	{ ",", desc = "⊗ Clear others", mode = "n" },
        	{ "a", desc = "⊕ Append mode", mode = "n" },
        	{ "c", desc = "⊘ Change mode", mode = "n" },
        	{ "d", desc = "⊖ Delete", mode = "n" },
        	{ "e", desc = "⊡ Extend mode", mode = "n" },
        	{ "gc", desc = "⍝ Comment", mode = "n" },
        	{ "gU", desc = "⇧ Uppercase", mode = "n" },
        	{ "gu", desc = "⇩ Lowercase", mode = "n" },
        	{ "i", desc = "⊙ Insert mode", mode = "n" },
        	{ "n", desc = "▷ Find next", mode = "n" },
        	{ "p", desc = "⊞ Paste after", mode = "n" },
        	{ "y", desc = "⊕ Yank", mode = "n" },
        	{ "~", desc = "⌘ Toggle case", mode = "n" },
        	{ "<", desc = "↤ Indent left", mode = "n" },
        	{ ">", desc = "↦ Indent right", mode = "n" },
        	{ "=", desc = "⊞ Align", mode = "n" },
        
        	-- Noice
        	{ "<S-Enter>", desc = "⤴ Redirect cmdline", mode = "c" },
        	{ "<c-b>", desc = "↑ Scroll backward", mode = { "i", "n", "s" } },
        	{ "<c-f>", desc = "↓ Scroll forward", mode = { "i", "n", "s" } },
        	{ "<leader>xna", desc = "≡ All messages" },
        	{ "<leader>xnd", desc = "⊗ Dismiss all" },
        	{ "<leader>xnh", desc = "🝮 History" },
        	{ "<leader>xnl", desc = "◊ Last message" },
        	{ "<leader>xnt", desc = "⊙ Picker" },
        
        	-- Sort
        	{ "<leader>sa", desc = "⇈ Sort alphabetically", mode = "v" },
        	{ "<leader>si", desc = "⇕ Sort case-insensitive", mode = "v" },
        	{ "<leader>sn", desc = "⇳ Sort numerically", mode = "v" },
        	{ "<leader>sr", desc = "⇊ Sort reverse", mode = "v" },
        
        	-- Motions
        	{ "<A-Down>", desc = "↓ Move line down" },
        	{ "<A-Up>", desc = "↑ Move line up" },
        	{ "<CR>", desc = "⏎ Insert line below" },
        	{ "<S-CR>", desc = "⇧⏎ Insert line above" },
        })
        
        -- Highlight settings
        vim.api.nvim_set_hl(0, "WhichKeyNormal", {
        	bg = "#090E13",
        })
        vim.api.nvim_set_hl(0, "WhichKeyBorder", {
        	fg = "#22262D",
        	bg = "#090E13",
        })
        vim.api.nvim_set_hl(0, "WhichKeyTitle", {
        	bg = "#090E13",
        })
        
        -- Add filetype-specific group names
        local FILETYPE_ICON = "☠"
        
        vim.api.nvim_create_autocmd("FileType", {
        	pattern = {
        		"bash",
        		"c",
        		"clojure",
        		"commonlisp",
        		"css",
        		"csv",
        		"cuda",
        		"dart",
        		"dockerfile",
        		"elisp",
        		"elixir",
        		"elm",
        		"erlang",
        		"fennel",
        		"fortran",
        		"gleam",
        		"go",
        		"graphql",
        		"haskell",
        		"hcl",
        		"html",
        		"http",
        		"hyprlang",
        		"ini",
        		"java",
        		"javascript",
        		"js",
        		"json",
        		"julia",
        		"kdl",
        		"kotlin",
        		"latex",
        		"lisp",
        		"lua",
        		"luadoc",
        		"make",
        		"makefile",
        		"markdown",
        		"md",
        		"nix",
        		"nu",
        		"ocaml",
        		"odin",
        		"perl",
        		"php",
        		"py",
        		"python",
        		"r",
        		"rasi",
        		"rb",
        		"regex",
        		"rs",
        		"ruby",
        		"rust",
        		"scss",
        		"sh",
        		"solidity",
        		"sql",
        		"ssh_config",
        		"svelte",
        		"swift",
        		"sxhkdrc",
        		"terraform",
        		"tex",
        		"tf",
        		"tmux",
        		"toml",
        		"ts",
        		"tsv",
        		"tsx",
        		"typescript",
        		"typst",
        		"vim",
        		"vimdoc",
        		"vue",
        		"xml",
        		"yaml",
        		"yml",
        		"yuck",
        		"zathurarc",
        		"zig",
        	},
        	callback = function(ev)
        		local ft_names = {
        			-- Shell
        			bash = FILETYPE_ICON .. " Bash",
        			sh = FILETYPE_ICON .. " Shell",
        
        			-- Systems
        			c = FILETYPE_ICON .. " C",
        			cuda = FILETYPE_ICON .. " CUDA",
        			fortran = FILETYPE_ICON .. " Fortran",
        			rs = FILETYPE_ICON .. " Rust",
        			rust = FILETYPE_ICON .. " Rust",
        			zig = FILETYPE_ICON .. " Zig",
        
        			-- Lisps
        			clojure = FILETYPE_ICON .. " Clojure",
        			commonlisp = FILETYPE_ICON .. " Common Lisp",
        			elisp = FILETYPE_ICON .. " Emacs Lisp",
        			fennel = FILETYPE_ICON .. " Fennel",
        			lisp = FILETYPE_ICON .. " Lisp",
        
        			-- Web
        			css = FILETYPE_ICON .. " CSS",
        			html = FILETYPE_ICON .. " HTML",
        			javascript = FILETYPE_ICON .. " JavaScript",
        			js = FILETYPE_ICON .. " JavaScript",
        			scss = FILETYPE_ICON .. " SCSS",
        			svelte = FILETYPE_ICON .. " Svelte",
        			ts = FILETYPE_ICON .. " TypeScript",
        			tsx = FILETYPE_ICON .. " TSX",
        			typescript = FILETYPE_ICON .. " TypeScript",
        			vue = FILETYPE_ICON .. " Vue",
        
        			-- Data
        			csv = FILETYPE_ICON .. " CSV",
        			ini = FILETYPE_ICON .. " INI",
        			json = FILETYPE_ICON .. " JSON",
        			kdl = FILETYPE_ICON .. " KDL",
        			toml = FILETYPE_ICON .. " TOML",
        			tsv = FILETYPE_ICON .. " TSV",
        			xml = FILETYPE_ICON .. " XML",
        			yaml = FILETYPE_ICON .. " YAML",
        			yml = FILETYPE_ICON .. " YAML",
        
        			-- Languages
        			dart = FILETYPE_ICON .. " Dart",
        			elixir = FILETYPE_ICON .. " Elixir",
        			elm = FILETYPE_ICON .. " Elm",
        			erlang = FILETYPE_ICON .. " Erlang",
        			gleam = FILETYPE_ICON .. " Gleam",
        			go = FILETYPE_ICON .. " Go",
        			haskell = FILETYPE_ICON .. " Haskell",
        			java = FILETYPE_ICON .. " Java",
        			julia = FILETYPE_ICON .. " Julia",
        			kotlin = FILETYPE_ICON .. " Kotlin",
        			lua = FILETYPE_ICON .. " Lua",
        			luadoc = FILETYPE_ICON .. " LuaDoc",
        			ocaml = FILETYPE_ICON .. " OCaml",
        			odin = FILETYPE_ICON .. " Odin",
        			perl = FILETYPE_ICON .. " Perl",
        			php = FILETYPE_ICON .. " PHP",
        			py = FILETYPE_ICON .. " Python",
        			python = FILETYPE_ICON .. " Python",
        			r = FILETYPE_ICON .. " R",
        			rb = FILETYPE_ICON .. " Ruby",
        			ruby = FILETYPE_ICON .. " Ruby",
        			solidity = FILETYPE_ICON .. " Solidity",
        			swift = FILETYPE_ICON .. " Swift",
        
        			-- Markup & Docs
        			latex = FILETYPE_ICON .. " LaTeX",
        			markdown = FILETYPE_ICON .. " Markdown",
        			md = FILETYPE_ICON .. " Markdown",
        			tex = FILETYPE_ICON .. " LaTeX",
        			typst = FILETYPE_ICON .. " Typst",
        
        			-- Config & Build
        			dockerfile = FILETYPE_ICON .. " Dockerfile",
        			hcl = FILETYPE_ICON .. " HCL",
        			make = FILETYPE_ICON .. " Makefile",
        			makefile = FILETYPE_ICON .. " Makefile",
        			nix = FILETYPE_ICON .. " Nix",
        			terraform = FILETYPE_ICON .. " Terraform",
        			tf = FILETYPE_ICON .. " Terraform",
        
        			-- Vim
        			vim = FILETYPE_ICON .. " Vim",
        			vimdoc = FILETYPE_ICON .. " VimDoc",
        
        			-- Tools & Misc
        			graphql = FILETYPE_ICON .. " GraphQL",
        			http = FILETYPE_ICON .. " HTTP",
        			regex = FILETYPE_ICON .. " Regex",
        			sql = FILETYPE_ICON .. " SQL",
        			ssh_config = FILETYPE_ICON .. " SSH Config",
        			tmux = FILETYPE_ICON .. " Tmux",
        
        			-- WM & System
        			hyprlang = FILETYPE_ICON .. " Hyprlang",
        			rasi = FILETYPE_ICON .. " Rasi",
        			sxhkdrc = FILETYPE_ICON .. " SXHKD",
        			yuck = FILETYPE_ICON .. " Yuck",
        			zathurarc = FILETYPE_ICON .. " Zathura",
        
        			-- Shell alternatives
        			nu = FILETYPE_ICON .. " Nushell",
        		}
        		local ft = vim.bo[ev.buf].filetype
        		if ft_names[ft] then
        			require("which-key").add({
        				{ ";", group = ft_names[ft], buffer = ev.buf },
        			})
        		end
        	end,
        })

    end
}
