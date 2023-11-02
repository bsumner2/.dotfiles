local function new_file(fn)
  if fn==nil then
    print('No file name given.')
    return
  end
  
  os.execute('touch '..fn)
end

local function new_dir(dn)
  if dn==nil then
    print('No dir name given.')
    return
  end
  os.execute('mkdir -p '..dn)
end
return {
  setopts = function(optlist)
    for k, v in pairs(optlist) do
      vim.o[k] = v
    end
  end,

  prompt_new_item = function(isdir)
    vim.ui.input({
      prompt = isdir and 'Enter dir name: ' 
                     or 'Enter File name: ',
      completion = 'file',
    },
    isdir and new_dir or new_file)
  end,
  
}
