vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt_list = {
  number = true,
  expandtab = true,
  swapfile = false,
  backup = false,
  clipboard = 'unnamedplus',
  autoindent = true,
  smartindent = true,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  colorcolumn='80',
  termguicolors = true,
}



local fns = require('umod.functions')
require('umod.plugins')
fns.setopts(opt_list)

vim.cmd.colorscheme('nightfox')
