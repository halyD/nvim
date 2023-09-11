-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	"folke/which-key.nvim",
	{ 'rose-pine/neovim',        name = 'rose-pine' },
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ 'akinsho/toggleterm.nvim', version = "*",     config = true },
	'mbbill/undotree',
	'rcarriga/nvim-notify',
	'ggandor/leap.nvim',
	'lalitmee/browse.nvim',
	'windwp/nvim-autopairs',
	"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	'numToStr/Comment.nvim',
	'nvim-lualine/lualine.nvim',
	'ThePrimeagen/harpoon',
	'folke/zen-mode.nvim',
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },    -- Required
			{ 'williamboman/mason.nvim' },  -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		}
	},
	'nvim-treesitter/nvim-treesitter',
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}
})

-- settings config
vim.o.hidden = true
vim.cmd 'lua vim.wo.wrap = false'
vim.o.fileencoding   = "utf-8"
vim.o.tabstop        = 4
vim.o.shiftwidth     = 4
vim.opt.softtabstop  = 4
vim.o.mouse          = "a"
vim.o.number         = true
vim.o.cursorline     = true
vim.o.ruler          = true
vim.o.clipboard      = "unnamedplus"
vim.o.smarttab       = true
vim.o.smartindent    = true
vim.o.autoindent     = true
vim.o.background     = "dark"
vim.o.termguicolors  = true
vim.o.hlsearch       = false
vim.o.relativenumber = true
vim.opt.guicursor    = {
	"n-v:block",
	"i-c-ci-ve:ver25",
	"r-cr:hor20",
	"o:hor50",
	"i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait175-blinkoff150-blinkon175",
}
vim.opt.incsearch    = true
vim.opt.scrolloff    = 15

-- require('ayu').setup({
-- 	mirage = true,
-- 	overrides = {},
-- })

vim.cmd("colorscheme rose-pine")

-- vim.cmd("colorscheme palenightfall")
-- require('palenightfall').setup({ transparent = true, })

-- mappings config
-- nnoremap
opt = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opt)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opt)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opt)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opt)
vim.api.nvim_set_keymap('n', '<C-f>', ':Neotree toggle=true<cr>', opt)

vim.keymap.set('n', '<leader>a', vim.cmd.Ex)
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)


--inoremap
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', opt)
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', opt)

-- indent
vim.api.nvim_set_keymap('v', '<', '<gv', opt)
vim.api.nvim_set_keymap('v', '>', '>gv', opt)

-- original from ThePrimeagen
-- move by blocks
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', "mzJ`z")

-- half page jump but cursor in the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- search in the middle
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")

-- override the clipboard
-- vim.keymap.set('x', '<leader>p', "\"_dP")

-- zen config
vim.keymap.set('n', '<leader>zz', function()
	require('zen-mode').setup {
		window = {
			width = 120,
			options = {}
		},
	}

	require('zen-mode').toggle()
	vim.wo.wrap = false
	vim.wo.number = true
	-- relative numbers
	vim.wo.rnu = false
end)

vim.keymap.set('n', '<leader>zZ', function()
	require('zen-mode').setup {
		window = {
			width = 90,
			options = {}
		},
	}

	require('zen-mode').toggle()
	vim.wo.wrap = false
	vim.wo.number = true
	vim.wo.rnu = true
end)

-- which-key config
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
			z = true,   -- bindings for folds, spelling and others prefixed with z
			g = true,   -- bindings for prefixed with g
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
		border = "single",  -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0
	},
	layout = {
		height = { min = 4, max = 25 },                                        -- min and max height of the columns
		width = { min = 20, max = 50 },                                        -- min and max width of the columns
		spacing = 3,                                                           -- spacing between columns
		align = "left",                                                        -- align columns left, center or right
	},
	ignore_missing = false,                                                    -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true,                                                          -- show help message on the command line when the popup is visible
	triggers = "auto",                                                         -- automatically setup triggers
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
	mode = "n",  -- NORMAL mode
	prefix = " ",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	--	h = { ":BufferLineCyclePrev<CR>", "BufferPrev" },
	--	l = { ":BufferLineCycleNext<CR>", "BufferNext" },
	b = {
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
	},
	t = {
		name = "Terminals",
		f = { ":ToggleTerm direction=float<cr>", "Float" },
		h = { ":ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { ":ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
	h = {
		name = "Harpoon",
	},
	s = {
		name = "Shell",
		x = { "<cmd>!chmod +x %<CR>", "add exec" },
	}
}

which_key.setup(setup)
which_key.register(mappings, opts)

-- toggleterm config
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	-- size can be a number or function which is passed the current terminal
	size = 22,
	open_mapping = [[<c-\>]],
	hide_numbers = true,   -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	autochdir = false,     -- when neovim changes it current directory the terminal will change it's own when next it's opened
	shade_terminals = false, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	persist_mode = true,   -- if set to true (default) the previous terminal mode will be remembered
	direction = 'float',
	close_on_exit = true,  -- close the terminal window when the process exits
	shell = vim.o.shell,   -- change the default shell
	auto_scroll = true,    -- automatically scroll to the bottom on terminal output
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = 'curved',
		-- like `size`, width and height can be a number or function which is passed the current terminal
		width = 200,
		height = 50,
		winblend = 3,
	},
	winbar = {
		enabled = false,
		name_formatter = function(term) --  term: Terminal
			return term.name
		end
	},
})

-- LSP config
local lsp = require('lsp-zero')

lsp.preset({
	name = 'recommended',
	set_lsp_keymaps = true,
	suggest_lsp_servers = false,
})

lsp.ensure_installed({
	'clangd',
	'lua_ls',
	'pyright',
	'bashls'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-y>'] = cmp.mapping.confirm(cmp_select),
	['<C-e>'] = cmp.mapping.abort(),
})

lsp.default_keymaps({
	preserve_mappings = false
})

lsp.on_attach(function(client, bufnr)
	local opt = { buffer = bufnr, remap = false }
	lsp.buffer_autoformat()
end)

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	sources = {
		{ name = 'nvim_lsp', keyword_length = 5 },
		{ name = 'nvim_lua' },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'buffer',   keyword_length = 5 },
	}
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = true,
})

lsp.setup()

-- telescope config
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require "telescope.actions"

telescope.setup {
	defaults = {
		path_display = { "smart" },
		selection_caret = " ",

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default,
			},
			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
			}
		}
	}

}

-- autopair config
-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

npairs.setup {
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt" },
	fast_wrap = {
		-- alt - e,
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
}

--[[ local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } }) ]]

-- comment config
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end


comment.setup {
	---Add a space b/w comment and the line
	---@type boolean|fun():boolean
	padding = true,

	---Whether the cursor should stay at its position
	---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
	---@type boolean
	sticky = true,

	---Lines to be ignored while comment/uncomment.
	---Could be a regex string or a function that returns a regex string.
	---Example: Use '^$' to ignore empty lines
	---@type string|fun():string
	ignore = nil,

	---LHS of toggle mappings in NORMAL + VISUAL mode
	---@type table
	toggler = {
		---Line-comment toggle keymap
		line = 'gcc',
		---Block-comment toggle keymap
		block = 'gbc',
	},

	---LHS of operator-pending mappings in NORMAL + VISUAL mode
	---@type table
	opleader = {
		---Line-comment keymap
		line = 'gc',
		---Block-comment keymap
		block = 'gb',
	},

	---LHS of extra mappings
	---@type table
	extra = {
		---Add comment on the line above
		above = 'gcO',
		---Add comment on the line below
		below = 'gco',
		---Add comment at the end of line
		eol = 'gcA',
	},

	---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
	---NOTE: If `mappings = false` then the plugin won't create any mappings
	---@type boolean|table
	mappings = {
		---Operator-pending mapping
		---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
		---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
		basic = true,
		---Extra mapping
		---Includes `gco`, `gcO`, `gcA`
		extra = true,
		---Extended mapping
		---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
		extended = false,
	},

	---Pre-hook, called before commenting the line
	---@type fun(ctx: CommentCtx):string
	pre_hook = nil,

	---Post-hook, called after commenting is done
	---@type fun(ctx: CommentCtx)
	post_hook = nil,
}

-- browse config
local status_ok, browse = pcall(require, "browse")
if not status_ok then
	return
end

browse.setup {
	provider = "google",
}

local bookmark = {
	"https://github.com/halyD",
	"https://www.youtube.com",
	"https://doc.rust-lang.org/book/",
	"https://hackmd.io",
	"https://github.com/christianchiarulli",
	"https://doc.rust-lang.org/cargo",
	"https://portal.nycu.edu.tw/#/"
}


function command(name, rhs, opts)
	opts = opts or {}
	vim.api.nvim_create_user_command(name, rhs, opts)
end

command("BrowseInputSearch", function()
	browse.input_search()
end, {})

command("Browse", function()
	browse.browse({ bookmarks = bookmark })
end, {})

command("BrowseBookmarks", function()
	browse.open_bookmarks({ bookmarks = bookmark })
end, {})

command("BrowseDevdocsSearch", function()
	browse.devdocs.search()
end, {})

command("BrowseDevdocsFiletypeSearch", function()
	browse.devdocs.search_with_filetype()
end, {})

command("BrowseMdnSearch", function()
	browse.mdn.search()
end, {})

-- harpoon config
local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
	return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>hn', ui.toggle_quick_menu)
vim.keymap.set('n', '<leader>ha', mark.add_file)

vim.keymap.set('n', '<leader>hh', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>hj', function() ui.nav_file(2) end)
vim.keymap.set('n', '<leader>hk', function() ui.nav_file(3) end)
vim.keymap.set('n', '<leader>hl', function() ui.nav_file(4) end)

harpoon.setup {

	global_settings = {
		-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
		save_on_toggle = false,
		-- saves the harpoon file upon every change. disabling is unrecommended.
		save_on_change = true,
		-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
		enter_on_sendcmd = false,
		-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
		tmux_autoclose_windows = false,
		-- filetypes that you want to prevent from adding to the harpoon list menu.
		excluded_filetypes = { "harpoon" },
		-- set marks specific to each git branch inside git repository
		mark_branch = false,
	}
}

-- lualine config
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'location' },
		lualine_z = { 'progress' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {
			{
				'buffers',
				show_filename_only = true, -- Shows shortened relative path when set to false.
				hide_filename_extension = false, -- Hide filename extension when set to true.
				show_modified_status = true, -- Shows indicator when the buffer is modified.
				mode = 1,            -- 0: Shows buffer name
				-- 1: Shows buffer index
				-- 2: Shows buffer name + buffer index
				-- 3: Shows buffer number
				-- 4: Shows buffer name + buffer number

				max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
				-- it can also be a function that returns
				-- the value of `max_length` dynamically.
				filetype_names = {
					TelescopePrompt = 'Telescope',
					dashboard = 'Dashboard',
					packer = 'Packer',
					fzf = 'FZF',
					alpha = 'Alpha'
				}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
				symbols = {
					modified = ' ●', -- Text to show when the buffer is modified
					alternate_file = '#', -- Text to show to identify the alternate file
					directory = '', -- Text to show when the buffer is a directory
				},
			},
		},
		lualine_y = {},
		lualine_z = {}
	},
	extensions = {}
}

-- notify config
local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

require("telescope").load_extension("notify")

notify.setup {
	-- Animation style (see below for details)
	stages = "fade",

	-- Function called when a new window is opened, use for changing win settings/config
	on_open = nil,

	-- Function called when a window is closed
	on_close = nil,

	-- Render function for notifications. See notify-render()
	render = "default",

	-- Default timeout for notifications
	timeout = 1000,

	-- For stages that change opacity this is treated as the highlight behind the window
	-- Set this to either a highlight group or an RGB hex value e.g. "#000000"
	background_colour = "Normal",

	-- Minimum width for notification windows
	minimum_width = 10,

	-- Icons for the different levels
	-- icons = {
	--   ERROR = icons.diagnostics.Error,
	--   WARN = icons.diagnostics.Warning,
	--   INFO = icons.diagnostics.Information,
	--   DEBUG = icons.ui.Bug,
	--   TRACE = icons.ui.Pencil,
	-- },
}

-- neotree
vim.fn.sign_define("DiagnosticSignError",
	{ text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
	{ text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
	{ text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
	{ text = "󰌵", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	enable_normal_mode_for_inputs = false,                          -- Enable normal mode for input dialogs.
	open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
	sort_case_insensitive = false,                                  -- used when sorting files and directories in the tree
	sort_function = nil,                                            -- use a custom function for sorting files and directories in the tree
	-- sort_function = function (a,b)
	--       if a.type == b.type then
	--           return a.path > b.path
	--       else
	--           return a.type > b.type
	--       end
	--   end , -- this sorts files and directories descendantly
	default_component_configs = {
		container = {
			enable_character_fade = true
		},
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "󰜌",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon"
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted   = "✖", -- this can only be used in the git_status source
				renamed   = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored   = "",
				unstaged  = "󰄱",
				staged    = "",
				conflict  = "",
			}
		},
		-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
		file_size = {
			enabled = true,
			required_width = 64, -- min width of window required to show this column
		},
		type = {
			enabled = true,
			required_width = 122, -- min width of window required to show this column
		},
		last_modified = {
			enabled = true,
			required_width = 88, -- min width of window required to show this column
		},
		created = {
			enabled = true,
			required_width = 110, -- min width of window required to show this column
		},
		symlink_target = {
			enabled = false,
		},
	},
	-- A list of functions, each representing a global custom command
	-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
	-- see `:h neo-tree-custom-commands-global`
	commands = {},
	window = {
		position = "left",
		width = 40,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
			},
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["<esc>"] = "cancel", -- close preview or floating neo-tree window
			["P"] = { "toggle_preview", config = { use_float = true } },
			["l"] = "focus_preview",
			["S"] = "open_split",
			["s"] = "open_vsplit",
			-- ["S"] = "split_with_window_picker",
			-- ["s"] = "vsplit_with_window_picker",
			["t"] = "open_tabnew",
			-- ["<cr>"] = "open_drop",
			-- ["t"] = "open_tab_drop",
			["w"] = "open_with_window_picker",
			--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
			["C"] = "close_node",
			-- ['C'] = 'close_all_subnodes',
			["z"] = "close_all_nodes",
			--["Z"] = "expand_all_nodes",
			["a"] = {
				"add",
				-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "none" -- "none", "relative", "absolute"
				}
			},
			["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
			-- ["c"] = {
			--  "copy",
			--  config = {
			--    show_path = "none" -- "none", "relative", "absolute"
			--  }
			--}
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
			["i"] = "show_file_details",
		}
	},
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				--"node_modules"
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				--".gitignored",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				--".DS_Store",
				--"thumbs.db"
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		follow_current_file = {
			enabled = false,              -- This will find and focus the file in the active buffer every time
			--               -- the current file is changed while the tree is open.
			leave_dirs_open = false,      -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		group_empty_dirs = false,         -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- window like netrw would, regardless of window.position
		-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				-- ["D"] = "fuzzy_sorter_directory",
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
				["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["og"] = { "order_by_git_status", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-n>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-p>"] = "move_cursor_up",
			},
		},

		commands = {} -- Add a custom command or override a global one using the same function name
	},
	buffers = {
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
			--              -- the current file is changed while the tree is open.
			leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			}
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"]  = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
				["o"]  = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			}
		}
	}
})
