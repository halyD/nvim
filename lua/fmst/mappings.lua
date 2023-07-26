-- nnoremap
opt = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opt)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opt)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opt)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opt)
-- vim.api.nvim_set_keymap('n', '<C-f>', ':NvimTreeToggle<cr>', opt)

vim.keymap.set('n', '<leader>a', vim.cmd.Ex)
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)


--inoremap
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', opt)
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', opt)

-- indent
vim.api.nvim_set_keymap('v', '<', '<gv', opt)
vim.api.nvim_set_keymap('v', '>', '>gv', opt)

-- original from ThePrimeagen
-- move by blocks
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', "mzJ`z")

-- half page jump but cursor in the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- search in the middle
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")

-- override the clipboard
-- vim.keymap.set('x', '<leader>p', "\"_dP")
