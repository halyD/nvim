local cmp = require('cmp')
local lspkind = require('lspkind')
lspkind.init {
	symbol_map = {
		Text = "",
		Method = "ƒ",
		Function = "ﬦ",
		Constructor = "",
		Variable = "",
		Class = "",
		Interface = "ﰮ",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "了",
		Keyword = "",
		Snippet = "﬌",
		Color = "",
		File = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
	},
}

cmp.setup {
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<C-e>"] = cmp.mapping.abort(),
		['<C-d>'] = cmp.mapping.scroll_docs(-5),
		['<C-f>'] = cmp.mapping.scroll_docs(5),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
	},

	sources = {
		{ name = 'nvim_lsp', keyword_length = 5 },
		{ name = 'nvim_lua' },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'buffer', keyword_length = 5 },
		-- { name = 'crates' },
	},

	formatting = {
		format = lspkind.cmp_format {
			with_text = true,
			menu = {
				buffer = "[Buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[API]",
				path = "[Path]",
				luasnip = "[Snip]",
			},
		},
	},

	experimental = {
		native_menu = false,
		ghost_text = true,
	},

}
