local option = vim.opt
local colors = { }
local rettable =
{
    SetDefOpts =
    function(colo_table)
        option.syntax        = 'on'
        option.number        = true
        option.colorcolumn   = '80'
        option.tabstop       = 4
        option.softtabstop   =4
        option.shiftwidth    = 4
        option.expandtab     = true
        option.termguicolors = true
        option.clipboard     = 'unnamedplus'
        option.signcolumn    = 'yes'
        option.swapfile      = false
        option.backup        = false
        option.writebackup   = false
        option.ttyfast       = true
        option.incsearch     = true
        option.wildmode      = {"longest", "list"}
        option.cursorline    = true
        if colo_table~=nil then
            colors.tty_colo = colo_table.tty_colo
            colors.emu_colo = colo_table.emu_colo
            if colo_table.transparent~=nil then
                colors.set_transparent = colo_table.transparent
            end
        else
            colors.tty_colo = 'torte'
            colors.emu_colo = 'carbonfox'
            colors.set_transparent = false
        end
   end,
    SetDefColorscheme =
    function()
        --[[
        -- 
        -- TTY, terminal_emulator colorscheme defaults I like:
        -- ron, nightfox
        -- pencil, carbonfox
        -- elflord, pencil
        -- torte, flattened_dark
        -- pablo, terafox
        -- 
        -- 
        --]]--
        require('usermod.functions').SetStartupColos(colors.tty_colo, colors.emu_colo, colors.set_transparent)
    end,
    CppFileOpts =
    function()
        option.tabstop     = 2
        option.shiftwidth  = 2
        option.softtabstop = 2
        option.expandtab   = true
    end,
    MakefileOpts =
    function()
        option.tabstop     = 4
        option.shiftwidth  = 4
        option.softtabstop = 4
        option.expandtab   = false
    end
}


return rettable
