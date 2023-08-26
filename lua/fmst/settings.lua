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

require('ayu').setup({
	mirage = true,
	overrides = {},
})

vim.cmd("colorscheme rose-pine")

-- vim.cmd("colorscheme palenightfall")
-- require('palenightfall').setup({ transparent = true, })
