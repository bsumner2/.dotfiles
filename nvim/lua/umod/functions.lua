
return {
  set_opts = function(opts_table)
    for k,v in pairs(opts_table) do
      if type(vim.o[k]) == type(v) then
        vim.o[k] = v
      elseif type(vim.opt[k]) == type(v) then
        vim.opt[k] = v
      end
    end
  end,
  set_colorscheme = function(colorscheme_name, transparent)
    if type(colorscheme_name) ~= 'string' then
      return
    end
    vim.cmd.colorscheme(colorscheme_name)
    if type(transparent) ~= 'boolean' then return end
    if transparent then
      vim.api.nvim_set_hl(0, 'Normal', {bg = 'none'})
      vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'none'})
    end
  end,
  --- @param win_opts vim.api.keyset.win_config Map defining the window configuration.
  --- @param ini_text? string[]
  --- @return umod.functions.PopupWindow
  popup_window_create = function(win_opts, ini_text)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, win_opts)
    if type(ini_text)=='table' then
      local bvalid = true
      for _,v in ipairs(ini_text) do
        if type(v) ~= 'string' then
          bvalid = false
          break
        end
      end
      if bvalid then
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, ini_text)
      end
    end
    vim.api.nvim_create_autocmd("WinClosed", {
      pattern = tostring(win), -- Watch this specific window ID
      callback = function()
        vim.api.nvim_buf_delete(buf, {force=true})
      end,
      once = true,             -- Don't keep this listener alive after it fires
    })
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {buffer=buf})
    return {
      parent_window = win,
      buffer_handle = buf
    }
  end,
  --- @param buf number
  --- @param attrs table
  set_buf_attrs = function(buf, attrs)
    if vim.bo[buf]==nil then return end
    for k, v in pairs(attrs) do
      -- pcall (protected call) catches errors if the option name is invalid
      local status, err = pcall(vim.api.nvim_set_option_value, k, v, { buf = buf })
      if not status then
        vim.notify("Failed to set buffer option '" .. k .. "': " .. err, vim.log.levels.ERROR)
      end
    end
  end,
  --- @param win number
  --- @param attrs table
  set_win_attrs = function(win, attrs)
    if not vim.api.nvim_win_is_valid(win) then return end
    for k, v in pairs(attrs) do
      local status, err = pcall(vim.api.nvim_set_option_value, k, v, { win = win })
      if not status then
        vim.notify("Failed to set window option '" .. k .. "': " .. err, vim.log.levels.ERROR)
      end
    end
  end,
  --- @param cmd_str string
  vcmd_lambda = function(cmd_str)
    if type(cmd_str)~='string' then
      return function()
        error('vcmd_lambda(param) called with invalid param. Expected string, got ' .. type(cmd_str))
      end
    end
    return '<cmd>' .. cmd_str .. '<cr>'
  end,
  save_current_context = function()
    return {
      win = vim.api.nvim_get_current_win(),
      buf = vim.api.nvim_get_current_buf(),
      cursor = vim.api.nvim_win_get_cursor(0)
    }
  end,
  --- @param buf? number
  open_sidebar_split = function(buf)
    vim.cmd([[botright 30vsplit]])
    local win = vim.api.nvim_get_current_win()
    if buf ~= nil then
      vim.api.nvim_win_set_buf(win, buf)
    else
      buf = vim.api.nvim_get_current_buf()
    end
    return { win = win, buf = buf }
  end
}


--- @class umod.functions.PopupWindow
--- @field parent_window integer
--- @field buffer_handle integer
