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
