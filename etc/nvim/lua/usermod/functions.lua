local coloset = vim.cmd.colorscheme
local function set_trans_hl(field)
    if field == nil then
        print('Field passed through as nil. Default to normal.')
        field = 'Normal'
    end
    vim.api.nvim_set_hl(0, field, {bg = 'none'})
end

-- Global filetype function
function SetIndent(size, exp_as_spaces)
    vim.o.tabstop = size
    vim.o.shiftwidth = size
    vim.o.softtabstop = size
    vim.o.expandtab = exp_as_spaces
end

local ret =
{
    --[[
    -- Color Schemes that look great with transparent BG:
    -- > slate
    -- > habamax
    -- > lunaperche
    --]]--
    ColorSchemeTransparent =
    function(color)
        if os.getenv('TERM') == 'linux' then
            print('TTY cannot be made transparent.')
            return
        end
        if color==nil then
            print('Colorscheme passed through as nil value. Default to slate')
            color = 'slate'
        elseif color=='blue' then
            print('Blue doesn\'t cooperate with transparent. Default to slate')
            color = 'slate'
        elseif color=='murphy' then
            print('Murphy doesn\'t cooperate with transparent. Default to slate')
            color = 'slate'
        elseif color=='industry' then
            print('Industry doesn\'t cooperate with transparent. Default to slate')
            color = 'slate'
        end
        coloset(color)
        set_trans_hl('Normal')
        set_trans_hl('NormalFloat')
    end,
    ColorSchemeNormal =
    function(color)
        coloset(color)
    end,
    SetCurrentBGTransparent =
    function()
        set_trans_hl('Normal')
        set_trans_hl('NormalFloat')
    end,
    SetStartupColos =
    function(tty, normal, transparent_flag)
        if os.getenv('TERM') == 'linux' then
        	vim.cmd.colorscheme(tty)
        else
            vim.cmd.colorscheme(normal)
            if transparent_flag then
                set_trans_hl('Normal')
                set_trans_hl('NormalFloat')
            end
        end
    end,
    SetAutoConfigureByFileType =
        function(table_of_funcs)
            for i = 1, table.maxn(table_of_funcs) do
                vim.api.nvim_create_autocmd('BufEnter',
                {
                    pattern = table_of_funcs[i].pattern,
                    command = table_of_funcs[i].command,
                })
        end
    end
}


return ret
