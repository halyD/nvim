local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
	'clangd',
	'lua_ls',
	'pyright',
	'zls',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.on_attach(function(client, bufnr)
	local opt = {buffer = bufnr, remap = false}

	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opt)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opt)
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.reference() end, opt)
end)

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})


lsp.setup()