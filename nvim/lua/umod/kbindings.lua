local vcmd_lambda = function(cmd_str)
  if type(cmd_str)~='string' then
    return function()
      error('vcmd_lambda(param) called with invalid param. Expected string, got ' .. type(cmd_str))
    end
  end
  return function() vim.cmd(cmd_str) end
end

local sogga_lambda = function(fn_name)
  if type(fn_name)~='string' then
    return function()
      error('saga_fn(fn_name) called with invalid param. Expected string got ' .. type(fn_name))
    end
  end
  return vcmd_lambda('Lspsaga '..fn_name)
end

local nmap = function(binding, callback, opts)
  vim.keymap.set('n', binding, callback, opts)
end



-- Terminals:
nmap('<space>tt', vcmd_lambda('ToggleTerm'), {})  -- ToggleTerm ; Buffered terminal
nmap('<space>ft', sogga_lambda('term_toggle'), {})  -- Lspsaga term_toggle ; Floating terminal by Lspsaga



-- Lspsaga Command Bindings
nmap('<space>ca', sogga_lambda('code_action'), {})
nmap(']e', sogga_lambda('diagnostic_jump_next'), {})
nmap('[e', sogga_lambda('diagnostic_jump_prev'), {})
nmap('K', sogga_lambda('hover_doc'), {})
nmap('<space>d', sogga_lambda('goto_definition'), {})
nmap('<space>D', sogga_lambda('goto_type_definition'), {})
nmap('<c-space>rn', sogga_lambda('rename'), {})

nmap('<space>td', sogga_lambda('peek_definition'), {})
nmap('<space>tD', sogga_lambda('peek_type_definition'), {})

nmap('<space>co', sogga_lambda('outgoing_calls'), {})
nmap('<space>ci', sogga_lambda('incoming_calls'), {})

nmap('<space>to', sogga_lambda('outline'), {})

-- Editor Navigation Accessory Bindings
nmap('<space>fe', vcmd_lambda('NvimTreeToggle'), {})
nmap('<C-h>', vcmd_lambda('BufferPrevious'), {})
nmap('<C-l>', vcmd_lambda('BufferNext'), {})
nmap('<space>j', vcmd_lambda('BufferMovePrevious'), {})
nmap('<space>k', vcmd_lambda('BufferMoveNext'), {})
nmap('<c-space>e', vcmd_lambda('BufferClose'), {})
nmap('<c-space>E', vcmd_lambda('BufferCloseAllButCurrent'), {})

vim.api.nvim_create_user_command('Tcolo',
  function(opts)
    require('umod.functions').transparent_colorscheme(opts.fargs[1])
  end, {
    nargs = 1,
    complete = 'color',
  }
)
Cursor_Location = 0
vim.api.nvim_create_user_command('Link',
  function(opts)
    Cursor_Location = vim.api.nvim_win_get_cursor(0)[1]
  end,
  {nargs=0}
)

vim.api.nvim_create_user_command('Jump',
  function(opts)
    vim.api.nvim_win_set_cursor(0, {Cursor_Location, 0})
  end, {nargs=0}
)

vim.api.nvim_create_user_command('SetIndent',
  function(opts)
    local num = tonumber(opts.fargs[1])
    vim.o.tabstop = num
    vim.o.softtabstop = num
    vim.o.shiftwidth = num
  end,
  {
    nargs=1,
  }
)



nmap('<C-space>r', vcmd_lambda('Jump'))
nmap('<C-space>l', vcmd_lambda('Link'))

nmap('<C-space>nd',
  function()
    local dname = vim.fn.input('Enter Dir Name: ', '', 'dir')
    if dname==nil or dname=='' then
      vim.notify('Invalid entry. No new directories created.')
      return
    end
    os.execute('mkdir -p '..dname)
  end)

nmap('<C-space>nf',
  function()
    vim.ui.input({prompt='Enter File Name: ', completion = 'file'},
      function(input)
        if input==nil or input == '' then
          vim.notify('Invalid entry. No new files created.')
          return
        end
        os.execute('touch '..input)
      end)
    end)
