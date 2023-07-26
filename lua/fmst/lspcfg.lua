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
