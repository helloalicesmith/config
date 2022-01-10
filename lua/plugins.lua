local use = require('packer').use

require('packer').startup(function()
  use 'junegunn/vim-peekaboo'
  use 'ellisonleao/gruvbox.nvim'
  use 'nvim-treesitter/nvim-treesitter'
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

  use "tpope/vim-commentary"

  use "rktjmp/lush.nvim"
  -- use "ellisonleao/gruvbox.nvim"
  use "sainnhe/gruvbox-material"
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
end)

require('lualine').setup {
  sections = {
    lualine_a = {
      {
        'filename',
        file_status = true,      -- Displays file status (readonly status, modified status)
        path = 1,                -- 0: Just the filename
      }
    },
  },
}
