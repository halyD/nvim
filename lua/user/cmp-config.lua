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
			 ["<C-e>"] = cmp.mapping({
				  i = cmp.mapping.abort(),
				  c = cmp.mapping.close(),
			 }),
				['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
				['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
				['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
				['<C-y>'] = cmp.config.disable,

		},

		sources = {
				{ name = 'nvim_lsp', keyword_length = 5 },
				{ name = 'nvim_lua' },
				{ name = 'path' },
				{ name = 'luasnip' },
				{ name = 'buffer', keyword_length = 5 },
		},

		formatting = {
				format = lspkind.cmp_format {
						with_text = true,
						menu = {
								buffer = "[buf]",
								nvim_lsp = "[LSP]",
								path = "[path]",
								luasnip = "[snip]",
						},
				},
		},

		experimental = {
				native_menu = false,
				ghost_text = true,
		},

}
