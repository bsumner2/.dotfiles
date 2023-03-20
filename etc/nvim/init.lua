-- Written by Burton O Sumner

require('usermod.plugins')

require('nvim-tree').setup()
require('usermod.ntreefix')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require('usermod.vimopts').SetDefOpts(
    {
	tty_colo = 'gruvbox',
	emu_colo = 'challenger_deep',
    transparent = false,
    })



require('pluginmod.nvim-treesitter')
require('pluginmod.barbar_conf')
require('pluginmod.hlargs')
require('usermod.kbindings')
UserFuncts = require('usermod.functions')

UserFuncts.SetAutoConfigureByFileType(require('usermod.filetypes'))
