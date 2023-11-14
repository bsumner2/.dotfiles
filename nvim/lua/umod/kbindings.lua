local vcmd_lambda = function(cmd_str)
  if type(cmd_str)~='string' then
    return function()
      error('vcmd_lambda(param) called with invalid param. Expected string, got ' .. type(cmd_str))
    end
  end
  return function() vim.cmd(cmd_str) end
end

local saga_fn = function(fn_name)
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
nmap('<space>ft', saga_fn('term_toggle'), {})  -- Lspsaga term_toggle ; Floating terminal by Lspsaga

-- Lspsaga Command Bindings
nmap('<space>ca', saga_fn('code_action'), {})
nmap(']e', saga_fn('diagnostic_jump_next'), {})
nmap('[e', saga_fn('diagnostic_jump_prev'), {})
nmap('K', saga_fn('hover_doc'), {})
nmap('<space>d', saga_fn('goto_definition'), {})
nmap('<space>D', saga_fn('goto_type_definition'), {})

nmap('<space>td', saga_fn('peek_definition'), {})
nmap('<space>tD', saga_fn('peek_type_definition'), {})

nmap('<space>co', saga_fn('outgoing_calls'), {})
nmap('<space>ci', saga_fn('incoming_calls'), {})

nmap('<space>to', saga_fn('outline'), {})

-- Editor Navigation Accessory Bindings
nmap('<space>fe', vcmd_lambda('NvimTreeToggle'), {})
nmap('<space>h', vcmd_lambda('BufferPrevious'), {})
nmap('<space>l', vcmd_lambda('BufferNext'), {})
nmap('<space>j', vcmd_lambda('BufferMovePrevious'), {})
nmap('<space>k', vcmd_lambda('BufferMoveNext'), {})
nmap('<c-space>e', vcmd_lambda('BufferClose'), {})
nmap('<c-space>E', vcmd_lambda('BufferCloseAllButCurrent'), {})

