vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
-- Partially removed to cmp config
-- vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-n>', ':lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-p>', ':lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
-- autocmd BufWritePre *.cpp <cmd>lua vim.lsp.buf.formatting_sync(nil, 100)
vim.cmd [[autocmd! BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 100)]]



local servers = { 'rust_analyzer', 'bashls', 'sumneko_lua', 'clangd' }

for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup {}

end


require 'lspconfig'.pyright.setup {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = 'off',
				useLibraryCodeForTypes = true,

			}
		}
	}
}
