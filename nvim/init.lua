require('umod.lazy_plugins')
local funcs = require('umod.functions')

funcs.set_opts({
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  colorcolumn = '80',
  number = true,
  relativenumber = true,
  clipboard = 'unnamedplus',
  swapfile = false
})

funcs.set_colorscheme('rose-pine-moon', true)
require('umod.keybindings')
require('umod.commands')
