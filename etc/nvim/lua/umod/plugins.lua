vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use) 
  use ('wbthomason/packer.nvim')
  use ({
    'nvim-tree/nvim-tree.lua',
    requires = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('extmod.ntree')
    end,
  })

  use ({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('extmod.treesitter')
    end,
  })

  use ('neovim/nvim-lspconfig')
  use ({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'l3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  })

  use ('EdenEast/nightfox.nvim')

  use ({'akinsho/toggleterm.nvim',
    tag = '*',
    config = function()
      require('toggleterm').setup()
    end,
  })
  

end)
