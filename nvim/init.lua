vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



vim.o.number = true
vim.o.clipboard = 'unnamedplus'

-- vim.cmd([[colorscheme rose-pine-moon]])

require('umod.plugins')
vim.o.termguicolors = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.showtabline = 2
vim.o.cc = '80'
require('umod.kbindings')
require('umod.filetypes')
--[[
if type(vim.g.cscheme)~='string' then
  vim.cmd.colorscheme('habamax')
else
  if type(vim.g.transparent_cscheme)~='number' then
    vim.cmd.colorscheme(vim.g.cscheme)
  elseif vim.g.transparent_cscheme~=0 then
    vim.cmd('Tcolo '..vim.g.cscheme)
  else
    vim.cmd.colorscheme(vim.g.cscheme)
  end
end
]]--
-- vim.cmd('Tcolo bluloco-dark')
-- vim.cmd.colorscheme('spaceduck')
-- vim.cmd('Tcolo flattened_darker')
vim.cmd('Tcolo monokai-pro-spectrum')
