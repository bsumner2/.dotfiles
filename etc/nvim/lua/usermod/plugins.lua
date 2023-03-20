vim.cmd('packadd packer.nvim')

return require('packer').startup(
    function(use)

        use 'wbthomason/packer.nvim' -- Package manager can manage itself

        use
        {
            'nvim-lualine/lualine.nvim', -- Status bar
            requires =
            {
                'kyazdani42/nvim-web-devicons', opt = true
            }
        }

        use
        {
            'nvim-telescope/telescope.nvim', -- Fuzzy Finder
            tag = '0.1.1',
            --[[ OR:
            , branch = '0.1.x', ]]--
            requires =
            {
                'nvim-lua/plenary.nvim'
            }
        }


        use 'nvim-tree/nvim-web-devicons'

        use
        {
            'nvim-tree/nvim-tree.lua', -- Replacement for shitty NetRW
            requires =
            {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
            tag = 'nightly' -- optional, updated every week. (see issue #1193)
        }


        use
        {
            'nvim-treesitter/nvim-treesitter', -- Extra syntax highlighting lang parser
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }
        use
        {
            'm-demare/hlargs.nvim', -- Adds syntax highlighting for arguments/parameters in funcs/methods
            requires =
            {
                'nvim-treesitter/nvim-treesitter' -- Highlight Args Dependency
            }
        }

        use 'mfussenegger/nvim-jdtls'

        use
        {
            'VonHeikemen/lsp-zero.nvim', -- Config helper/wrapper for Nvim's built-in LSP.
            branch = 'v1.x',
            requires =
            {
                -- LSP Support
                {'neovim/nvim-lspconfig'},              -- Required
                {'williamboman/mason.nvim'},            -- Optional
                {'williamboman/mason-lspconfig.nvim'},  -- Optional

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},           -- Required
                {'hrsh7th/cmp-nvim-lsp'},       -- Required
                {'hrsh7th/cmp-buffer'},         -- Optional
                {'hrsh7th/cmp-path'},           -- Optional
                {'saadparwaiz1/cmp_luasnip'},   -- Optional
                {'hrsh7th/cmp-nvim-lua'},       -- Optional

                -- Snippets
                {'L3MON4D3/LuaSnip'},               -- Required
                {'rafamadriz/friendly-snippets'},   -- Optional
                {'folke/lsp-colors.nvim'},          -- Added by me. (Optional)
                {'simrat39/symbols-outline.nvim'},  -- Added by me. (Optional)
            }
        }


        use
        {
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig",
            config = function()
                vim.api.nvim_create_autocmd('BufWinEnter', {
                    callback = function(tbl)
                    if vim.bo[tbl.buf].filetype == 'NvimTree' then
                        require'bufferline.api'.set_offset(31, 'FileTree')
                    end
                end})

                vim.api.nvim_create_autocmd({'BufWinLeave', 'BufWipeout'},
                {
                    callback = function(tbl)
                    if vim.bo[tbl.buf].filetype == 'NvimTree' then
                        require'bufferline.api'.set_offset(0)
                    end
                end})
            end
        }




        use 'EdenEast/nightfox.nvim'

        use
        {
            'ellisonleao/gruvbox.nvim',

            config = function()
                require('gruvbox').setup(require('usermod.plugtables').gruvbox_opts(true, false))
            end
        }

        --[[use
        {
            'kartikp10/noctis.nvim',
            requires = { 'rktjmp/lush.nvim' },
            config = function()
                require('usermod.vimopts').SetDefColorscheme()
            end
        }]]--

    	use 'sainnhe/sonokai'

        use
        {
            'projekt0n/github-nvim-theme', tag = 'v0.0.7',
            -- or                            branch = '0.0.x'
            config = function()
                require('github-theme').setup(require('usermod.plugtables').github_opts(true, false))
                require('usermod.vimopts').SetDefColorscheme()
            end
        }

        use
        {
            "akinsho/toggleterm.nvim", tag = '*', config = function()
                require("toggleterm").setup()
            end
        }

        use
        {
            "utilyre/barbecue.nvim",
            tag = "*",
            requires = {
                "SmiteshP/nvim-navic",
                "nvim-tree/nvim-web-devicons", -- optional dependency
            },
            after = "nvim-web-devicons", -- keep this if you're using NvChad
            config = function()
                require("barbecue").setup({attach_navic = false})
            end,
        }


        use
        {
            'akinsho/bufferline.nvim',
            tag = "v3.*",
            requires = 'nvim-web-devicons',
            config = function()
                require('bufferline').setup()
            end
        }

        use
        {
            'romgrk/barbar.nvim', requires = 'nvim-web-devicons',
            config = function()
                require('pluginmod.barbar_conf')
            end
        }

    end
)
