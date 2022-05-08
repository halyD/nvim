
-- nnoremap
opt = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<C-f>', ':NvimTreeToggle<CR>', opt)
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>;', ":TodoLocList<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', ":TodoTelescope<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<space>f', 'gg=G', { noremap = true, silent = true })



--inoremap
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', opt)
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', opt)
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', opt)

-- indent
vim.api.nvim_set_keymap('v', '<', '<gv', opt)
vim.api.nvim_set_keymap('v', '>', '>gv', opt)
