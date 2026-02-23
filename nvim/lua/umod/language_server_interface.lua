local funcs = require('umod.functions')

local symbol_outline = {
  win = nil,
  outline_buf = nil,
  outline_detes = nil,
  source_buf = nil,
  source_win = nil,
  request_params = nil,
  hl_namespace = nil,
  augroup = nil,
  source_ft = ''
}



--- @param id_str string
local function is_valid_identifier(id_str)
  if type(id_str)~='string' then return false end
  if #id_str <= 0 then return false end

  local curbyte = id_str:byte(1,1)

  if curbyte~=95 then  -- 95 := string.byte('_', 1, 1)
    if curbyte > 90 then  -- 90 := string.byte('Z', 1, 1)
      curbyte = curbyte - 97  -- 97 := string.byte('a', 1, 1)
    else
      curbyte = curbyte - 65  -- 65 := string.byte('A', 1, 1)
    end
    if curbyte < 0 or curbyte > 25 then
      return false
    end
  end

  for i=2,#id_str, 1 do
    curbyte = id_str:byte(i,i)
    if curbyte < 65 then  -- 65 := string.byte('A', 1, 1)
      if curbyte < 48 or curbyte > 57 then  -- 48:=string.byte('0',1,1)
                                            -- 57:=string.byte('9',1,1)
        return false
      end
    elseif curbyte~=95 then  -- 95 := string.byte('_', 1, 1)
      if curbyte > 90 then  -- 90 := string.byte('Z', 1, 1)
        curbyte = curbyte - 97  -- 97 := string.byte('a', 1, 1)
      else
        curbyte = curbyte - 65  -- 65 := string.byte('A', 1, 1)
      end
      if curbyte < 0 or curbyte > 25 then
        return false
      end
    end
  end
  return true
end

--- @param outline umod.language_server_interface.symtable_outline.FlattenedSymtable
local function symbol_table_apply_colors(outline)
  local hl_groups = {
    [1]  = 'Module',  -- File
    [2]  = 'Module',  -- Module
    [3]  = 'Namespace',  -- Namespace
    [4]  = 'Module',  -- Package
    [5]  = 'Class',  -- Class
    [6]  = 'Function',  -- Method
    [7]  = 'Field',  -- Property
    [8]  = 'Field',  -- Field
    [9]  = 'Function',  -- Constructor
    [10] = 'Enum',  -- Enum
    [11] = 'Class',  -- Interface
    [12] = 'Function',  -- Function
    [13] = 'Variable',  -- Variable
    [14] = 'Constant',  -- Constant
    [15] = 'String',  -- String
    [16] = 'Number',  -- Number
    [17] = 'Boolean',  -- Boolean
    [18] = 'Array',  -- Array
    [19] = 'Object',  -- Object
    [20] = 'Key',  -- Key
    [21] = 'Null',  -- Null
    [22] = 'EnumMember',  -- EnumMember
    [23] = 'Class',  -- Struct
    [24] = 'EnumMember',  -- Event
    [25] = 'Operator',  -- Operator
    [26] = 'TypeParameter',  -- TypeParameter
  }
  for i,v in ipairs(outline.detes) do
--[[    local hl_group = 'Identifier'
    if v.kind == 12 or v.kind == 6 then hl_group = "Function"
    elseif v.kind == 5 or v.kind == 23 then hl_group = "Type"
    elseif v.kind == 13 then hl_group = "Variable"
    end  ]]--
    local hl_group = hl_groups[v.kind]
    if type(hl_group)~='string' then
      hl_group = 'Identifier'
    end
    vim.api.nvim_buf_set_extmark(
      symbol_outline.outline_buf,
      symbol_outline.hl_namespace,
      i-1, 0, {
        hl_group = hl_group,
        end_col = 2*v.depth+6
      })
--    vim.api.nvim_buf_add_highlight(symbol_outline.outline_buf, symbol_outline.hl_namespace, hl_group, i-1, 0, 2*v.depth+4)
  end
end

--- @param symbol_table lsp.DocumentSymbol[]
--- @param depth? number
--- @param lines? string[]
--- @param line_detes? umod.language_server_interface.symtable_outline.OutlineEntry[]
--- @return umod.language_server_interface.symtable_outline.FlattenedSymtable
local function symbol_table_flatten(symbol_table, depth, lines, line_detes)

  local symbol_kinds = {
    [1]  = "󰈙", -- File
    [2]  = "󰏗", -- Module
    [3]  = "󰅩", -- Namespace
    [4]  = "󰏖", -- Package
    [5]  = "󰌗", -- Class
    [6]  = "󰆧", -- Method
    [7]  = "󰜢", -- Property
    [8]  = "󰜢", -- Field
    [9]  = "󰆧", -- Constructor
    [10] = "󰒻", -- Enum
    [11] = "󰕘", -- Interface
    [12] = "󰊕", -- Function
    [13] = "󰫧", -- Variable
    [14] = "󰏿", -- Constant
    [15] = "󰀬", -- String
    [16] = "󰎠", -- Number
    [17] = "󰨙", -- Boolean
    [18] = "󰅪", -- Array
    [19] = "󰅩", -- Object
    [20] = "󰌆", -- Key
    [21] = "󰟢", -- Null
    [22] = "󰒻", -- EnumMember
    [23] = "󰙅", -- Struct
    [24] = "󱐋", -- Event
    [25] = "󰆕", -- Operator
    [26] = "󰬛", -- TypeParameter
  }

  table.sort(symbol_table, function(lhs, rhs)
    return lhs.kind < rhs.kind
  end)
  if lines==nil then
    lines = { }
  end
  if depth == nil then
    depth = 0
  end
  if line_detes==nil then
    line_detes = { }
  end
  local indent = ''
  for _=1,depth,1 do
    indent = '  ' .. indent
  end
  for _,v in ipairs(symbol_table) do
    if v==nil then
      goto continue
    end
    if symbol_kinds[v.kind] ~= nil then
      table.insert(lines, indent..'['..symbol_kinds[v.kind]..'] '..v.name)
    else
      table.insert(lines, indent..'['..tostring(v.kind)..'] '..v.name)
    end
    table.insert(line_detes, {name=v.name, kind=v.kind, depth=depth, position = v.range })
    if type(v.children)=='table' then
      symbol_table_flatten(v.children, depth+1, lines, line_detes)
    end

  ::continue::
  end
  return { lines = lines, detes = line_detes }
end


--- @param err lsp.ResponseError?
--- @param result any
local function symbol_table_request_cb(err, result, _, _)
  if err then
    vim.notify(err.message, vim.log.levels.ERROR)
    return
  elseif not result then
    vim.notify('Language Server request for symbol table yielded empty', vim.log.levels.INFO)
    return
  elseif type(result)~='table' then
    vim.notify('Language Server request for symbol table yielded \'' .. type(result) .. '. Expected table.', vim.log.levels.ERROR)
    return
  end
  local outline = symbol_table_flatten(result)
  vim.bo[symbol_outline.outline_buf].modifiable = true
  vim.api.nvim_buf_set_lines(symbol_outline.outline_buf, 0, -1, false, outline.lines)
  symbol_table_apply_colors(outline)

  symbol_outline.outline_detes = outline.detes
  vim.bo[symbol_outline.outline_buf].modifiable = false
end

--- @param color integer
--- @param percent_diff number
local function alter_color_hue(color, percent_diff)
  local r = bit.rshift(color, 16)
  local g = bit.band(bit.rshift(color, 8), 0xFF)
  local b = bit.band(color, 0xFF)
  local function adjust(value)
    return math.floor(math.max(0, math.min(255, value*(1+percent_diff))))
  end
  r,g,b = adjust(r), adjust(g), adjust(b)
  return bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b)
end

--- @param ns_id number
--- @param highlight_groups table
local function set_custom_hls(ns_id, highlight_groups)
  local highlight_define_fields = {
  bold = { "boolean" },
  standout = { "boolean" },
  strikethrough = { "boolean" },
  underline = { "boolean" },
  undercurl = { "boolean" },
  underdouble = { "boolean" },
  underdotted = { "boolean" },
  underdashed = { "boolean" },
  italic = { "boolean" },
  reverse = { "boolean" },
  altfont = { "boolean" },
  nocombine = { "boolean" },
  default = { "boolean" },
  cterm = { "number", "string" },
  foreground = { "number", "string" },
  fg = { "number", "string" },
  background = { "number", "string" },
  bg = { "number", "string" },
  ctermfg = { "number", "string" },
  ctermbg = { "number", "string" },
  special = { "number", "string" },
  sp = { "number", "string" },
  link = { "number", "string" },
  global_link = { "number", "string" },
  fallback = { "boolean" },
  blend = { "number" },
  fg_indexed = { "boolean" },
  bg_indexed = { "boolean" },
  force = { "boolean" },
  url = { "string" }
}
  local def_bg = vim.api.nvim_get_hl(ns_id, { name = 'Normal'}).bg
  local fg = 0
  local link = nil
  if type(def_bg)==nil then
    error('Could not get default bg color!')
  end
  for _,v in pairs(highlight_groups) do
    local existing_attrs = vim.api.nvim_get_hl(0, { name = v.name, create = false })
    if not vim.tbl_isempty(existing_attrs) then
      local attrs = {}
      for k1, v1 in pairs(existing_attrs) do
        local valid = false
        for _,t in ipairs(highlight_define_fields[k1]) do
          if type(v1) == t then
            valid = true
            break
          end
        end
        if valid then
          attrs[k1] = v1
        end
      end
      vim.api.nvim_set_hl(ns_id, v.name, attrs)
      goto continue
    end
    if type(v.opts.link) ~= 'string' then
      error('No pre-existing hl group link specified')
    end
    link = vim.api.nvim_get_hl(0, { create = false, name = v.opts.link })
    if type(link) ~= 'table' then
      error(
        'Cannot link custom hl group, \''
        ..v.name
        ..'\', to undefined hl group, \''
        ..v.opts.link
        ..'\'.')
    end
    fg = link.fg
    if type(fg) ~= 'number' then
      vim.notify(type(fg)..'~=\'number\''..'Therefore switching to default color')
      fg = 0x282827
    elseif type(v.opts.delta_hue)=='number' then
      fg = alter_color_hue(link.fg, v.opts.delta_hue)
    else
      fg = link.fg
    end
    local attrs = {
      fg = fg, bg = def_bg
    }
    --[[
    if type(v.attrs) == 'table' then
      for k1, v1 in pairs(v.attrs) do
        local valid = false
        if attrs[k1]==nil then
          for _,t in pairs(highlight_define_fields[k1]) do
            if type(v1) == t then
              valid = true
              break
            end
          end
        end
        if valid then
          attrs[k1] = v1
        end
      end
    end
    ]]--
    attrs.force = true
    vim.api.nvim_set_hl(ns_id, v.name, attrs)
    ::continue::
  end
end

--- @param highlight_groups umod.language_server_interface.custom_hl.DerivedHl[]
local function create_highlight_namespace(highlight_groups)
  local ret_ns = vim.api.nvim_create_namespace('lsp-symtable-outline')
  set_custom_hls(ret_ns, highlight_groups)

  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      set_custom_hls(ret_ns, highlight_groups)
    end,
  })
  return ret_ns
end
--[[
local function create_highlight_namespace(_)
  return vim.api.nvim_create_namespace('lsp-symtable-outline')
end
]]--




return {
  rename_prompt = function()
    local parent = funcs.save_current_context()
    local popup = funcs.popup_window_create({
      relative = 'cursor',
      width = 32,
      height = 1,
      row = 0,
      col = -16,
      anchor = 'SW',
      style = 'minimal',
      border = 'rounded',
      title = 'Rename',
      title_pos = 'center',
    })
    vim.api.nvim_set_current_win(popup.parent_window)
    vim.api.nvim_set_current_buf(popup.buffer_handle)
    vim.cmd([[startinsert]])
    vim.keymap.set(
      { 'n', 'i' },
      '<cr>',
      function()
        local lines = vim.api.nvim_buf_get_lines(popup.buffer_handle, 0, -1, false)
        local newname = lines[1] and lines[1]:gsub('%s+', '') or ''
        vim.api.nvim_win_close(popup.parent_window, true)
        vim.api.nvim_set_current_win(parent.win)
        vim.api.nvim_set_current_buf(parent.buf)
        if vim.api.nvim_get_mode().mode ~= 'n' then
          vim.api.nvim_win_set_cursor(parent.win, { parent.cursor[1], parent.cursor[2] + 1 })
          vim.cmd([[stopinsert]])
        else
          vim.api.nvim_win_set_cursor(parent.win, parent.cursor)
        end
        if is_valid_identifier(newname)  then
          vim.lsp.buf.rename(newname)
        elseif #newname <= 0 or type(newname)==nil then
          vim.notify('No identifier entered', vim.log.levels.WARN)
        else
          vim.notify('\'' .. newname .. '\' is not a valid identifier', vim.log.levels.WARN)
        end
      end,
      { buffer = popup.buffer_handle }
    )
  end,
  toggle_outline = function()
    local cur_code_buf = vim.api.nvim_get_current_buf()
    local params = vim.lsp.util.make_position_params(0, 'utf-16')
    if not symbol_outline.hl_namespace then
      symbol_outline.hl_namespace = create_highlight_namespace({
        {
          name = "Module",
          attrs = { bold = true },
          opts = { link = 'Identifier', delta_hue = -.45 }
        },
        {
          name = "Namespace",
          attrs = { bold = true },
          opts = { link = 'Identifier', delta_hue = -.50 }
        },
        {
          name = "Class",
          opts = { link = 'Type', delta_hue = -.25 }
        },
        {
          name = "Field",
          opts = { link = 'Identifier', delta_hue = -.35 }
        },
        {
          name = "Enum",
          opts = { link = 'Type', delta_hue = -.10 }
        },
        {
          name = "Variable",
          opts = { link = 'Identifier', delta_hue = -.25 }
        },
        {
          name = "Number",
          opts = { link = 'String', delta_hue = -.10 }
        },
        {
          name = "Boolean",
          opts = { link = 'String', delta_hue = -.05 }
        },
        {
          name = "Array",
          attrs = { bold=true },
          opts = { link = 'String', delta_hue = -.15 }
        },
        {
          name = "Object",
          attrs = {bold = true},
          opts = { link = 'String', delta_hue = -.15 }
        },
        {
          name = "Key",
          opts = { link = 'String' }
        },
        {
          name = "Null",
          attrs = { bold = true },
          opts = { link = 'String', delta_hue = .25 }
        },
        {
          name = "EnumMember",
          attrs = { bold = true },
          opts = { link = 'Constant', delta_hue = -.05 }
        },
        {
          name = "Operator",
          attrs = { italic = true },
          opts = { link = 'Function', delta_hue = 0.10 }
        },
        {
          name = "TypeParameter",
          attrs = { italic = true },
          opts = { link = 'Type', delta_hue = 0.05 }
        }
      })
    end
    if not symbol_outline.win or not vim.api.nvim_win_is_valid(symbol_outline.win) then
      symbol_outline.source_win = vim.api.nvim_get_current_win()
      local sidebar = funcs.open_sidebar_split()
      symbol_outline.win = sidebar.win
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(sidebar.win), -- Watch this specific window ID
        callback = function()
          symbol_outline.win = nil      -- Reset global/module variable
        end,
        once = true,             -- Don't keep this listener alive after it fires
      })
      -- 2. Setup the Window (View)
      funcs.set_win_attrs(sidebar.win, {
        number = false,
        relativenumber = false,
        wrap = false,
        signcolumn = "no", -- Hide the 'gutter' on the left for a cleaner look
      })
      vim.api.nvim_win_set_hl_ns(sidebar.win, symbol_outline.hl_namespace)
    else
      vim.api.nvim_win_close(symbol_outline.win, true)
      symbol_outline.win = nil
      vim.api.nvim_set_current_win(symbol_outline.source_win)
      symbol_outline.source_win = nil
      return
    end
    local buf = nil

    local outline_refresh_cb = function()
      if not symbol_outline.source_win or not vim.api.nvim_win_is_valid(symbol_outline.source_win) then return end
      if vim.api.nvim_win_get_buf(symbol_outline.source_win)~=symbol_outline.source_buf then
        symbol_outline.source_buf = vim.api.nvim_win_get_buf(symbol_outline.source_win)
        symbol_outline.request_params = vim.lsp.util.make_position_params(symbol_outline.source_win, 'utf-16')
      end
      vim.lsp.buf_request(symbol_outline.source_buf,
        'textDocument/documentSymbol',
      symbol_outline.request_params,
      symbol_table_request_cb)
    end
    if not symbol_outline.outline_buf or not vim.api.nvim_buf_is_valid(symbol_outline.outline_buf) then
      buf = vim.api.nvim_create_buf(false, true)
      symbol_outline.outline_buf = buf
      funcs.set_buf_attrs(buf, {
        buftype = 'nofile',
        bufhidden = 'hide',
        swapfile = false,
        modifiable = false,
        filetype = 'symbol-outline',
      })
      symbol_outline.source_buf = nil
      vim.keymap.set('n', 'r', outline_refresh_cb, {buffer = buf})
      vim.keymap.set(
        'n',
        '<cr>',
        function()
          local sympos = symbol_outline.outline_detes[vim.api.nvim_win_get_cursor(0)[1]].position.start
          if sympos==nil then return end
          vim.api.nvim_set_current_win(symbol_outline.source_win)
          vim.api.nvim_win_set_cursor(0, {sympos.line+1, sympos.character})
        end, { buffer = buf })
      vim.keymap.set('n', 'q', '<cmd>close<cr>', {buffer=buf})
      vim.keymap.set({'n','i'}, '<esc>', '<cmd>close<cr>', {buffer=buf})
      vim.keymap.set('n', '<space>o', '<cmd>close<cr>', {buffer=buf})
      vim.keymap.set(
        'n',
        'K', function()
          local outline_ent_no = vim.api.nvim_win_get_cursor(0)[1]
          local sympos = symbol_outline.outline_detes[outline_ent_no].position
          -- i stg whoever named a field in lsp.Range to 'end' needs to be 
          -- slapped lol both LuaJIT and lua_ls were wigging out at the
          -- keyword/table key collision
          local lines = vim.api.nvim_buf_get_lines(symbol_outline.source_buf, sympos.start.line, sympos['end'].line+1, false)
          local popup = funcs.popup_window_create({
            relative = 'cursor',
            width = 64,
            height = 16,
            row = 0,
            col = 0,
            anchor = 'NE',
            style = 'minimal',
            border = 'rounded',
            title = symbol_outline.outline_detes[outline_ent_no].name,
            title_pos = 'center',
          })

          vim.api.nvim_set_current_win(popup.parent_window)
          vim.api.nvim_set_current_buf(popup.buffer_handle)
          vim.bo[popup.buffer_handle].buftype = 'nofile'
          vim.bo[popup.buffer_handle].ft = vim.bo[symbol_outline.source_buf].ft
          vim.api.nvim_buf_set_lines(popup.buffer_handle, 0, table.maxn(lines), false, lines)
        end, { buffer = buf })
    end
    vim.api.nvim_win_set_buf(symbol_outline.win, symbol_outline.outline_buf)
    if cur_code_buf==symbol_outline.source_buf then
      return
    end

    if not symbol_outline.augroup then
      symbol_outline.augroup
        = vim.api.nvim_create_augroup(
          'lsp-symtable-outline-autos', {
            clear=true
          })
    else
      vim.api.nvim_clear_autocmds({group = symbol_outline.augroup})
    end
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        local parent_win = vim.api.nvim_get_current_win()
        local newbuf = vim.api.nvim_win_get_buf(parent_win)

        if vim.bo[newbuf].ft ~= symbol_outline.source_ft then
          if not vim.api.nvim_buf_is_valid(symbol_outline.source_buf) then
            vim.api.nvim_win_close(symbol_outline.win, true)
            if symbol_outline.win then
              symbol_outline.win = nil
            end
            symbol_outline.source_win = nil
          else
            return
          end
        end
        if newbuf == symbol_outline.source_buf then
          if symbol_outline.source_win ~= parent_win then
            symbol_outline.source_win = parent_win
          end
          return
        end
        if parent_win ~= symbol_outline.source_win then
          symbol_outline.source_win = parent_win
        end
        outline_refresh_cb()
      end,
      group = symbol_outline.augroup
    })

    symbol_outline.source_buf = cur_code_buf
    symbol_outline.source_ft = vim.bo[cur_code_buf].ft
    symbol_outline.request_params = params
    vim.lsp.buf_request(symbol_outline.source_buf,
      'textDocument/documentSymbol',
      params,
      symbol_table_request_cb)
  end,
  definition = function()
    local params = vim.lsp.util.make_position_params(0, 'utf-16')

    --- @param err lsp.ResponseError?
    --- @param result any
    local lsp_definition_handler_override = function(err, result, _, _)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if not result or vim.tbl_isempty(result) then
        vim.notify('No definition found', vim.log.levels.WARN)
        return
      end
    vim.lsp.util.show_document(result[1] or result, 'utf-16', {focus = true})
    end
    vim.lsp.buf_request(0, 'textDocument/definition', params, lsp_definition_handler_override)
  end
}


--- @class umod.language_server_interface.custom_hl.DerivedHlOpts
--- @field link string
--- @field delta_hue? number
--- @class umod.language_server_interface.custom_hl.DerivedHl
--- @field name string
--- @field opts umod.language_server_interface.custom_hl.DerivedHlOpts
--- @field attrs? vim.api.keyset.highlight
--- @class umod.language_server_interface.symtable_outline.OutlineEntry
--- @field name string
--- @field kind lsp.SymbolKind
--- @field depth integer
--- @field position lsp.Range

--- @class umod.language_server_interface.symtable_outline.FlattenedSymtable
--- @field lines string[]
--- @field detes umod.language_server_interface.symtable_outline.OutlineEntry[]

