vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



vim.o.number = true


require('umod.plugins')
vim.o.termguicolors = true
vim.cmd.colorscheme('spaceduck')
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.showtabline = 2
require('umod.kbindings')
