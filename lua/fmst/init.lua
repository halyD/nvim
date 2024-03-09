---@diagnostic disable: 113
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

require("lazy").setup({
  -- "folke/which-key.nvim",
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- { 'akinsho/toggleterm.nvim', version = "*",     config = true },
  "mbbill/undotree",
  -- "rcarriga/nvim-notify",
  -- "ggandor/leap.nvim",
  "lalitmee/browse.nvim",
  "windwp/nvim-autopairs",
  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  "numToStr/Comment.nvim",
  -- "nvim-lualine/lualine.nvim",
  "ThePrimeagen/harpoon",
  "folke/zen-mode.nvim",
  --- Uncomment the two plugins below if you want to manage the language servers from neovim
  --- and read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  { "neovim/nvim-lspconfig" },
  -- extra for cmp plugins

  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/nvim-cmp" },
  { "L3MON4D3/LuaSnip" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
  },
  --[[
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},
	]]
  --
  -- linters
  { "mfussenegger/nvim-lint" },
  -- formatters
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  { "folke/neodev.nvim", opts = {} },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },
})

-- fidgets
require("fidget").setup({

  notification = {
    override_vim_notify = true,
  },
})
-- settings config
vim.opt.hidden = true
vim.cmd("lua vim.wo.wrap = false")
vim.opt.fileencoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.clipboard = "unnamedplus"
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.relativenumber = true

vim.opt.incsearch = true
vim.opt.scrolloff = 15
vim.opt.splitright = true
vim.opt.ignorecase = true

-- require('ayu').setup({
-- 	mirage = true,
-- 	overrides = {},
-- })

vim.cmd("colorscheme rose-pine")

vim.api.nvim_set_hl(0, "Cursor", { fg = "#00ff00" })
-- vim.cmd("colorscheme palenightfall")
-- require('palenightfall').setup({ transparent = true, })

--[[
if vim.fn.has('wsl') == 1 then
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe',
		},
		paste = {
			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end
]]
--

-- custom commands
vim.api.nvim_create_user_command("Configs", function(opts)
  vim.cmd("vnew")
  vim.cmd("e ~/.config/nvim/lua/fmst/init.lua")
end, { desc = "Open config files" })

-- autocmds
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = vim.lsp.buf.document_highlight,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = vim.lsp.buf.clear_references,
})

-- under development
vim.api.nvim_create_user_command("Install", function()
  local prompt = "Enter packages: "
  local default = ""
  vim.ui.input({ prompt = prompt, defualt = default }, function(input)
    if input == nil or input == "" then
      return
    end
    print("input := ", vim.fn.trim(input))
    local cmd = "sudo pacman -S " .. vim.fn.trim(input)
    print("cmd := ", cmd)
    os.execute(cmd)
  end)
end, { desc = "Install packages for the system" })

-- mappings config
-- nnoremap
local opt = { noremap = true, silent = true }
vim.g.mapleader = " "
-- update : move to harpoon settings
--[[ vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opt)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opt)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opt)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opt) ]]
-- vim.api.nvim_set_keymap('n', '<C-f>', ':Neotree toggle=true<cr>', opt)

-- vim.keymap.set("n", "<leader>a", vim.cmd.Ex)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.api.nvim_set_keymap("n", "<space>w", ":w<CR>", opt)
vim.api.nvim_set_keymap("n", "<space>q", ":q<CR>", opt)
-- vim.api.nvim_set_keymap("n", ";", ":", opt)

--inoremap
vim.api.nvim_set_keymap("i", "jk", "<ESC>", opt)
vim.api.nvim_set_keymap("i", "kj", "<ESC>", opt)

-- indent
vim.api.nvim_set_keymap("v", "<", "<gv", opt)
vim.api.nvim_set_keymap("v", ">", ">gv", opt)

-- original from ThePrimeagen
-- move by blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- half page jump but cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- override the clipboard
-- vim.keymap.set('x', '<leader>p', "\"_dP")

-- zen config
vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").setup({
    window = {
      width = 150,
      options = {},
    },
  })

  require("zen-mode").toggle()
  vim.wo.wrap = false
  vim.wo.number = true
  -- relative numbers
  vim.wo.rnu = false
end)

vim.keymap.set("n", "<leader>zZ", function()
  require("zen-mode").setup({
    window = {
      width = 90,
      options = {},
    },
  })

  require("zen-mode").toggle()
  vim.wo.wrap = false
  vim.wo.number = true
  vim.wo.rnu = true
end)

-- whichkey config
--[[
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
	b = {
		name = "browse",
		i = { "<cmd>browseinputsearch<cr>", "input search" },
		d = { "<cmd>browsedevdocssearch<cr>", "devdocs" },
		f = { "<cmd>browsedevdocsfiletypesearch<cr>", "devdocs filetype(lua)" },
		m = { "<cmd>browsemdnsearch<cr>", "mdn" },
		b = { "<cmd>browsebookmarks<cr>", "bookmarks" },
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
}

which_key.setup(setup)
which_key.register(mappings, opts)
]]
--

-- toggleterm config
-- local status_ok, toggleterm = pcall(require, "toggleterm")
-- if not status_ok then
-- 	return
-- end
--
-- toggleterm.setup({
-- 	-- size can be a number or function which is passed the current terminal
-- 	size = 22,
-- 	open_mapping = [[<c-\>]],
-- 	hide_numbers = true,   -- hide the number column in toggleterm buffers
-- 	shade_filetypes = {},
-- 	autochdir = false,     -- when neovim changes it current directory the terminal will change it's own when next it's opened
-- 	shade_terminals = false, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
-- 	start_in_insert = true,
-- 	insert_mappings = true, -- whether or not the open mapping applies in insert mode
-- 	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
-- 	persist_size = true,
-- 	persist_mode = true,   -- if set to true (default) the previous terminal mode will be remembered
-- 	direction = 'float',
-- 	close_on_exit = true,  -- close the terminal window when the process exits
-- 	shell = vim.o.shell,   -- change the default shell
-- 	auto_scroll = true,    -- automatically scroll to the bottom on terminal output
-- 	-- This field is only relevant if direction is set to 'float'
-- 	float_opts = {
-- 		-- The border key is *almost* the same as 'nvim_open_win'
-- 		-- see :h nvim_open_win for details on borders however
-- 		-- the 'curved' border is a custom border type
-- 		-- not natively supported but implemented in this plugin.
-- 		border = 'curved',
-- 		-- like `size`, width and height can be a number or function which is passed the current terminal
-- 		width = 200,
-- 		height = 50,
-- 		winblend = 3,
-- 	},
-- 	winbar = {
-- 		enabled = false,
-- 		name_formatter = function(term) --  term: Terminal
-- 			return term.name
-- 		end
-- 	},
-- })

-- LSP config
local lsp = require("lsp-zero")

lsp.preset({
  name = "recommended",
})

lsp.setup_servers({
  "clangd",
  "lua_ls",
  "pyright",
  "zls",
})

local opts = { buffer = bufnr, remap = false }
vim.keymap.set("n", "gd", function()
  vim.lsp.buf.definition()
end, opts)
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end, opts)
vim.keymap.set("n", "<leader>vws", function()
  vim.lsp.buf.workspace_symbol()
end, opts)
vim.keymap.set("n", "<leader>vd", function()
  vim.diagnostic.open_float()
end, opts)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_next()
end, opts)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_prev()
end, opts)
vim.keymap.set("n", "<leader>vca", function()
  vim.lsp.buf.code_action()
end, opts)
vim.keymap.set("n", "<leader>vrr", function()
  vim.lsp.buf.references()
end, opts)
vim.keymap.set("n", "<leader>vrn", function()
  vim.lsp.buf.rename()
end, opts)
vim.keymap.set("i", "<C-h>", function()
  vim.lsp.buf.signature_help()
end, opts)

-- autoformat
--[[
lsp.on_attach(function(client, bufnr)
	lsp.buffer_autoformat()
end)
]]
--

-- linter and formatter for python
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, bufopts)
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, bufopts)
  vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
  end, bufopts)
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, bufopts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
  end, bufopts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
  end, bufopts)
  vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
  end, bufopts)
  vim.keymap.set("n", "<leader>vrr", function()
    vim.lsp.buf.references()
  end, bufopts)
  vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
  end, bufopts)
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, bufopts)
end

lsp.setup()

require("mason").setup()
require("mason-lspconfig").setup()

-- original from KickStart.nvim configs
local servers = {
  clangd = {},
  -- gopls = {},
  pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
  zls = {},
}

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

-- lsp.setup()

-- cmps
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item({ select = true }),
    ["<C-n>"] = cmp.mapping.select_next_item({ select = true }),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    -- hot key interrupt with tmux
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
  }),
  formatting = lsp.cmp_format(),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

vim.diagnostic.config({
  -- virtual_text = true,
  signs = true,
  -- update_in_insert = true,
  -- underline = true,
  -- severity_sort = true,
  float = true,
})

-- telescope config
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
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
      },
    },
  },
})
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
-- vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>")

-- autopair config
-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup({
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
})

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

comment.setup({
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
    line = "gcc",
    ---Block-comment toggle keymap
    block = "gbc",
  },

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  opleader = {
    ---Line-comment keymap
    line = "gc",
    ---Block-comment keymap
    block = "gb",
  },

  ---LHS of extra mappings
  ---@type table
  extra = {
    ---Add comment on the line above
    above = "gcO",
    ---Add comment on the line below
    below = "gco",
    ---Add comment at the end of line
    eol = "gcA",
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
})

-- browse config
local status_ok, browse = pcall(require, "browse")
if not status_ok then
  return
end

browse.setup({
  provider = "google",
})

local bookmark = {
  "https://github.com/halyD",
  "https://github.com/halyD/nvim",
  "https://portal.nycu.edu.tw/#/",
  "https://drive.google.com/drive/u/0/my-drive",
  "https://www.youtube.com",
  "https://hackmd.io",
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

vim.keymap.set("n", "<leader>bb", vim.cmd.BrowseBookmarks)
vim.keymap.set("n", "<leader>bi", vim.cmd.BrowseInputSearch)
vim.keymap.set("n", "<leader>bd", vim.cmd.BrowseDevdocsSearch)
vim.keymap.set("n", "<leader>bf", vim.cmd.BrowseDevdocsFiletypeSearch)
vim.keymap.set("n", "<leader>bm", vim.cmd.BrowseMdnSearch)

-- harpoon config
local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
  return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>n", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>a", mark.add_file)

vim.keymap.set("n", "<leader>h", function()
  ui.nav_file(1)
end)
vim.keymap.set("n", "<leader>j", function()
  ui.nav_file(2)
end)
vim.keymap.set("n", "<leader>k", function()
  ui.nav_file(3)
end)
vim.keymap.set("n", "<leader>l", function()
  ui.nav_file(4)
end)

harpoon.setup({

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
  },
})

-- lualine config
--[[
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  --[[
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {
			{
				"buffers",
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
					TelescopePrompt = "Telescope",
					dashboard = "Dashboard",
					packer = "Packer",
					fzf = "FZF",
					alpha = "Alpha",
				}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
				symbols = {
					modified = " ●", -- Text to show when the buffer is modified
					alternate_file = "#", -- Text to show to identify the alternate file
					directory = "", -- Text to show when the buffer is a directory
				},
			},
		},
		lualine_y = {},
		lualine_z = {},
	},

  extensions = {},
})
]]
--

-- notify config
--[[
local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

require("telescope").load_extension("notify")

notify.setup({
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
})
]]
--

-- leap config
-- require("leap").add_default_mappings()

-- noice config
--[[
require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true,   -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false,     -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})
]]
--

-- conform
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "yapf" },
    cpp = { "clang_format" },
  },
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf, lsp_fallback = true })
  end,
})

-- linters
require("lint").linters_by_ft = {
  cpp = { "cpplint" },
  python = { "ruff" },
  lua = { "luacheck" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- treesitters
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  auto_install = true,
  sync_install = true,
  ensure_installed = {
    "c",
    "cpp",
    "python",
    "zig",
    "lua",
    "vim",
    "gitignore",
    "bash",
    "markdown",
    "make",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>", -- set to `false` to disable one of the mappings
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
        ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

        ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
        ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

        ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
        ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
        ["[C"] = { query = "@class.outer", desc = "Prev class end" },
        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
      },
    },
  },
})
