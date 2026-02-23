local funcs = require('umod.functions')
local lsp_funcs = require('umod.language_server_interface')
--[[
local popup_demo = function()
  local popup = user_funcs.popup_window_create({
    relative='cursor',
    width = 32, height = 4,
    row = 0, col = -16, anchor='SW',
    style='minimal', border='rounded',
    title = 'Demo',
    title_pos = 'center',
  })

  vim.keymap.set(
    'i',
    '<cr>',
    function()
      for k,v in
          pairs(vim.api.nvim_buf_get_lines(popup.buffer_handle, 0, -1, false))
          do
        vim.notify('buf.lines['..k..'] = ' .. tostring(v))
      end
    end,
    {buffer = popup.buffer_handle})
end
]] --

vim.keymap.set('n', '<C-space>q', funcs.vcmd_lambda('BufferClose'))
vim.keymap.set('n', '<C-h>', funcs.vcmd_lambda('BufferPrev'))
vim.keymap.set('n', '<C-l>', funcs.vcmd_lambda('BufferNext'))
vim.keymap.set('n', '<C-space>Q', funcs.vcmd_lambda('BufferCloseAllButVisible'))
vim.keymap.set('n', '<space>fe', funcs.vcmd_lambda('NvimTreeToggle'))
vim.keymap.set('n', '<space>tt', funcs.vcmd_lambda('ToggleTerm'))

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<space>D', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<space>d', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<C-space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<space>r', lsp_funcs.rename_prompt, opts)
    vim.keymap.set('n', '<space>o', lsp_funcs.toggle_outline, opts)
    vim.keymap.set('n', '<space>d', lsp_funcs.definition, opts)
  end,
})
