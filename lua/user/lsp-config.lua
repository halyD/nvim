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
-- local navic = require("nvim-navic")

for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup {
		-- on_attach = function(client, bufnr)
		-- 	navic.attach(client, bufnr)
		-- end
	}

end

require 'lspconfig'.pyright.setup {
	-- on_attach = function(client, bufnr)
	-- 	navic.attach(client, bufnr)
	-- end,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = 'off',
				useLibraryCodeForTypes = true,

			}
		}
	}
}

require('rust-tools').setup {
	-- on_attach = function(client, bufnr)
	-- 	navic.attach(client, bufnr)
	-- end,
	tools = {
		pattern = "*.rs",
		inlayHints = {
			-- Only show inlay hints for the current line
			only_current_line = false,
			auto = false,

			-- Event which triggers a refersh of the inlay hints.
			-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
			-- not that this may cause higher CPU usage.
			-- This option is only respected when only_current_line and
			-- autoSetHints both are true.
			only_current_line_autocmd = "CursorHold",

			-- whether to show parameter hints with the inlay hints or not
			-- default: true
			show_parameter_hints = false,

			-- whether to show variable name before type hints with the inlay hints or not
			-- default: false
			show_variable_name = false,

			-- prefix for parameter hints
			-- default: "<-"
			parameter_hints_prefix = "<- ",

			-- prefix for all the other hints (type, chaining)
			-- default: "=>"
			other_hints_prefix = "=> ",

			-- whether to align to the lenght of the longest line in the file
			max_len_align = false,

			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,

			-- whether to align to the extreme right or not
			right_align = false,

			-- padding from the right if right_align is true
			right_align_padding = 7,

			-- The color of the hints
			highlight = "Comment",
		},
	},
}
