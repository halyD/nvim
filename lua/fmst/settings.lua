vim.o.hidden = true
vim.cmd 'lua vim.wo.wrap = false'
vim.o.fileencoding   = "utf-8"
vim.o.tabstop        = 4
vim.o.shiftwidth     = 4
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


require('ayu').setup({
	mirage = true,
	overrides = {},
})

vim.cmd("colorscheme rose-pine")

-- vim.cmd("colorscheme palenightfall")
-- require('palenightfall').setup({ transparent = true, })
