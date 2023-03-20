-- Written by Burton O Sumner
local vimap  = vim.keymap.set

vim.g.mapleader = ' '


-- [BINDING]: Create new dir.
--      [n][d]: Prompt user for name of new directory and creates it.
vimap('n', '<leader>nd',
    function()
        local dirname = vim.fn.input("Enter directory name: ", "", "file")
        os.execute('mkdir -p ./'..dirname)
    end
)

-- [BINDING]: Create new file.
--      [n][f]: Prompt user for name of new file and creates it.
vimap('n', '<leader>nf',
    function()
        local filename = vim.fn.input("Enter file name: ", "", "file")
        os.execute('touch ./'..filename)
    end
)

-- [BINDING]: Go to line number.
--      [(typed number)]<leader>[j][t]: Go to line number entered before pressing 'gt'
vimap('n', '<leader>jt', function()
    vim.cmd(''..vim.v.count)
end
)


-- [BINDING]: Open my Neovim's custom default file explorer: NvimTree.
--      [f][e]: Opens NvimTree
vimap('n', 'fe',
    function()
        require('nvim-tree.api').tree.toggle()
    end
)


-- [BINDING]: Quickchange Colorscheme (W/ Transparent bg)
--      [<leader>][c][s][t]: Prompt to change colorscheme
vimap('n', '<leader>cst',
    function()
        vim.ui.input(
            { prompt = 'Enter colorscheme name: ', completion = 'color'},
            function(input)
                require('usermod.functions').ColorSchemeTransparent(input)
            end
        )
    end
)

-- [BINDING]: Quickchange Colorscheme 
--      [<leader>][c][s]: Prompt to change colorscheme
vimap('n', '<leader>cs',
    function()
        vim.ui.input(
            {
                prompt = 'Enter colorscheme name: ',
                completion = 'color'

            },
            function(input)
                require('usermod.functions').ColorSchemeNormal(input)
            end
        )
    end
)

-- [BINDING]: Make current bg transparent
--      [<leader>][t][b][g]: Make bg transparent.
vimap('n', '<leader>tbg',
    function()
        require('usermod.functions').SetCurrentBGTransparent()
    end
)

vimap('n', '<leader>tso',
    function()
        vim.cmd('SymbolsOutline')
    end
)

vimap('n', '<C-l>',
    function()
        vim.cmd('BufferNext')
    end
)

vimap('n', '<C-h>',
    function()
        vim.cmd('BufferPrevious')
    end
)

vimap('n', '<leader>tt',
    function()
        vim.cmd('ToggleTerm')
    end
 )



--[[ TEST
vimap('n', '<leader>tst', 
    function()
        vim.ui.select(
            {'heck', 'hecky', 'heckington'}, 
            {
                prompt = 'Choose wisely!~', 
                format_item = function(item)
                    return 'Choice: ' ..item
                end,
            }, 
            function(choice)
                print(choice)
            end
        )
    end
)
]]--
