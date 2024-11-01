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
    'neovim/nvim-lspconfig',
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
    'EdenEast/nightfox.nvim',
  }

  use {
    'mrded/nvim-lsp-notify',
    requires = {
      'rcarriga/nvim-notify',
    },
    config = function()
      require('notify').setup({ background_colour='#282827' })
      vim.notify = require('notify')
      require('lsp-notify').setup({
        notify = require('notify').notify,
      })

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
    'm-demare/hlargs.nvim',
  }

  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  use {
    'ayu-theme/ayu-vim',
    config = function() require('extmod.ayucolor_cfg') end,
  }

  use {
    'uloco/bluloco.nvim',
    requires = {
      'rktjmp/lush.nvim',
    },
  }

  use {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
    end
  }


end)

