vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use {'wbthomason/packer.nvim'}

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('extmod.treesitter')
    end,
  }

  use {
    'rose-pine/neovim',
    as = 'rose-pine',
  }

  use {
    'neovim/nvim-lspconfig'
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    }
  }

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function()
      require('extmod.eviline')
    end,
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('extmod.ntree')
    end,
  }

  use {
    'pineapplegiant/spaceduck',
    branch = 'main',
  }

  use {
    'akinsho/toggleterm.nvim',
    tag='*',
    config = function()
      require('toggleterm').setup()
    end,
  }

  use {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        lightbulb = {
          sign=false,
        },

      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  }

  use {
    'EdenEast/nightfox.nvim'
  }

  use {
    'rcarriga/nvim-notify'
  }

  use {
    'mrded/nvim-lsp-notify',
    config = function()
      require('lsp-notify').setup({})
    end,
  }

  use {
    'romgrk/barbar.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
    },
    config = function()
      require('barbar').setup()
    end,
  }


  use {
    'ellisonleao/gruvbox.nvim'
  }



end)

