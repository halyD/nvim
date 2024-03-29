local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = '<c-d>', -- binding to scroll down inside the popup
		scroll_up = '<c-u>', -- binding to scroll up inside the popup
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = " ",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	--	h = { ":BufferLineCyclePrev<CR>", "BufferPrev" },
	--	l = { ":BufferLineCycleNext<CR>", "BufferNext" },
	q = { ":q<CR>", "Quit" },
	w = { ":w<CR>", "Save" },
	Q = { ":wq<CR>", "Save & Quit" },
	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
	B = {
		name = "Browse",
		i = { "<cmd>BrowseInputSearch<cr>", "Input Search" },
		d = { "<cmd>BrowseDevdocsSearch<cr>", "Devdocs" },
		f = { "<cmd>BrowseDevdocsFiletypeSearch<cr>", "Devdocs Filetype(LUA)" },
		m = { "<cmd>BrowseMdnSearch<cr>", "Mdn" },
		b = { "<cmd>BrowseBookmarks<cr>", "bookmarks" },
	},
	T = {
		name = "Treesitter",
		h = { ":TSToggle highlight<cr>", "Highlight" },
		r = { ":TSToggle rainbow<cr>", "Rainbow" },
		p = { ":TSToggle playground<cr>", "Playground" },
		u = { ":TSUpdate<cr>", "Update" },
	},
	r = {
		name = "Rust Tools",
		i = { ":RustToggleInlayHints<cr>", "Toggle Inlay hints" },
		c = { ":RustOpenCargo<cr>", "Open rust toml" },
		-- samw with lsp key mapping support
		-- h = { ":RustHoverActions<cr>", "Rust Hover Actions" },
		p = { ":RustParentModule<cr>", "Parent Module" },
	},
	-- o = {
	-- 	name = "Outline",
	-- 	O = { ":SymbolsOutline<cr>", "Toggle Symbols Outline" },
	-- },
	L = {
		name = 'LSPs',
		r = { ":LspRestart<cr>", "Restart" },
		i = { ":LspInfo<cr>", "INFOS" },
		l = { ":LspLog<cr>", "LOGS" },
		b = { ":LspStart<cr>", "Starting" },
		e = { ":LspStop<cr>", "Stop" },
	},
	f = {
		name = "Find",
		f = { ":Telescope find_files<cr>", "Files" },
		g = { ":Telescope live_grep<cr>", "Greps" },
		b = { ":Telescope buffers<cr>", "Buffers" },
		h = { ":Telescope help_tags<cr>", "Tags" },
		n = { ":Telescope notify<cr>", "Notifications" },
		t = { ":TodoTelescope<cr>", "TODOs" },
		p = { ":Telescope projects<CR>", "Projects" },
	},
	t = {
		name = "Terminals",
		f = { ":ToggleTerm direction=float<cr>", "Float" },
		h = { ":ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { ":ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	}
}

which_key.setup(setup)
which_key.register(mappings, opts)
