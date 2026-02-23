local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local lazy_repo = 'http://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazy_repo,
    lazy_path
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'Errormsg' },
      { out, 'Warning Msg' },
      { '\nPress any key to exit...' }
    }, true, {})
vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazy_path)

vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

require('lazy').setup({
  spec = {
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      opts ={
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",},
       
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
       
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
       
        -- List of parsers to ignore installing (or "all")
       
        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
       
        highlight = {
          enable = true,
       
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
       
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      },
    },
    {
      'rose-pine/neovim',
      name = 'rose-pine'
    },
    {
      'neovim/nvim-lspconfig'
    },
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-vsnip' },
        { 'hrsh7th/vim-vsnip' },
      }
    },
    {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      config = function() require('extmod.lazy.eviline') end
    },
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
      },
      opts = { },
    },
    {
      'pineapplegiant/spaceduck',
      branch = 'main'
    },
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      opts = {}
    },
    {
      'EdenEast/nightfox.nvim',
    },
    {
      'mrded/nvim-lsp-notify',
      dependencies = {
        { 
          'rcarriga/nvim-notify',
          opts = {
            background_colour=string.format(
              '#%06X',
              vim.api.nvim_get_hl(
                0,
                {
                  name='Normal',
                  create=false
                }
              ).bg
    )
          },
        },
      },
      config = function() 
        require('lsp-notify').setup({ notify = require('notify').notify  })
        vim.notify = require('notify').notify 
      end
    },
    {
      'romgrk/barbar.nvim',
      dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        { 'lewis6991/gitsigns.nvim' },
      },
      opts = {},
    },
    {
      'iamcco/markdown-preview.nvim',
      build = function() vim.fn['mkdp#util#install']() end,
    },
    {
      'ayu-theme/ayu-vim',
      config = function() require('extmod.lazy.ayucolor') end,
    },
    {
      'loctvl842/monokai-pro.nvim',
      opts = {},
    },
  },
  install = { colorscheme = { 'habamax' }, },
  checker = { enable=true },
})
