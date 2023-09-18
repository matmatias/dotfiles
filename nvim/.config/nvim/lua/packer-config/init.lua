return require('packer').startup(function(use)
  -- plugin manager
  use 'wbthomason/packer.nvim'
  -- themes
  use 'ellisonleao/gruvbox.nvim'
  -- file tree
  use 'kyazdani42/nvim-tree.lua'
  -- autopairs
  use 'windwp/nvim-autopairs'
  -- which key
  use "folke/which-key.nvim"
  -- autocompletion icons
  use {
    'kyazdani42/nvim-web-devicons',
    'onsails/lspkind.nvim'
  }
  -- mason
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-dap",
    "jose-elias-alvarez/null-ls.nvim"
  }
  -- lspconfig
  use {
    'neovim/nvim-lspconfig',
    -- autocmp
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp'
  }
  -- status bar
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- snippets
  use {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip'
  }
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-refactor',
    'p00f/nvim-ts-rainbow',
    'windwp/nvim-ts-autotag',
    -- comment
    'JoosepAlviste/nvim-ts-context-commentstring',
    'numToStr/Comment.nvim',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
  }
  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    'sharkdp/fd',
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep'
  }
  use {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
  end
  }
end)
