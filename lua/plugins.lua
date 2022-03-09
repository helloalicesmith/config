return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'rose-pine/neovim', config = "vim.cmd('colorscheme rose-pine')"}
  use 'windwp/nvim-ts-autotag'
  use 'junegunn/vim-peekaboo'
  -- use 'ellisonleao/gruvbox.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
  use 'nvim-telescope/telescope.nvim'
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use 'nvim-lua/plenary.nvim'
  use 'windwp/nvim-autopairs'

  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use "jose-elias-alvarez/null-ls.nvim"
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  use "rktjmp/lush.nvim"
  -- use "ellisonleao/gruvbox.nvim"
  use "sainnhe/gruvbox-material"
  use "chentau/marks.nvim"
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use 'famiu/bufdelete.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
  }
  use "f-person/git-blame.nvim"
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }
  use 'norcalli/nvim-colorizer.lua'
end)

