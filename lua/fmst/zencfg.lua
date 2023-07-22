vim.keymap.set('n', '<leader>zz', function()
	require('zen-mode').setup {
		window = {
			width = 120,
			options = {}
		},


	}

	require('zen-mode').toggle()
	vim.wo.wrap = false
	vim.wo.number = false
	-- relative numbers
	vim.wo.rnu = false
end)
