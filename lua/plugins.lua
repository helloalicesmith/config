return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})
	use("windwp/nvim-ts-autotag")
	-- use("junegunn/vim-peekaboo")
	-- use 'ellisonleao/gruvbox.nvim'
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use("nvim-lua/plenary.nvim")
	use("windwp/nvim-autopairs")

	use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin

	use("jose-elias-alvarez/null-ls.nvim")

	use("rktjmp/lush.nvim")
	-- use("sainnhe/gruvbox-material")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- use({
	-- 	"goolord/alpha-nvim",
	-- 	requires = { "kyazdani42/nvim-web-devicons" },
	-- })
	-- use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
	-- use({
	-- 	"kyazdani42/nvim-tree.lua",
	-- 	requires = {
	-- 		"kyazdani42/nvim-web-devicons", -- optional, for file icon
	-- 	},
	-- })
	use("famiu/bufdelete.nvim")
	use("numToStr/Comment.nvim")
	use("norcalli/nvim-colorizer.lua")
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		-- tag = 'release' -- To use the latest release
	})
	use("tjdevries/cyclist.vim")
	use({
		"nvim-telescope/telescope-frecency.nvim",
		requires = { "tami5/sqlite.lua" },
	})
	use("nvim-telescope/telescope-project.nvim")
end)
