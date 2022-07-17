local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)

	use 'wbthomason/packer.nvim'
	use 'kyazdani42/nvim-tree.lua'
	use "tpope/vim-surround"
	use 'terryma/vim-multiple-cursors'
	use 'windwp/nvim-autopairs'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'onsails/lspkind-nvim'
	use { 'nvim-treesitter/nvim-treesitter',
		run = 'TSUpdate'
	}
	use 'karb94/neoscroll.nvim'
	use 'folke/tokyonight.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'akinsho/toggleterm.nvim'
	use 'BurntSushi/ripgrep'
	-- use 'akinsho/bufferline.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'folke/todo-comments.nvim'
	use 'folke/which-key.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'rcarriga/nvim-notify'
	use {
		'luukvbaal/stabilize.nvim',
		config = function() require("stabilize").setup() end
	}
	use 'ahmedkhalf/project.nvim'
	use 'ggandor/lightspeed.nvim'
	-- use 'saecki/crates.nvim'
	use "lalitmee/browse.nvim"
	use 'matbme/JABS.nvim'

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
