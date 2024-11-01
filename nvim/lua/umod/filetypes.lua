vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern={'*.s'},
  callback=function()
    vim.o.syntax = 'armasm'
    vim.cmd([[SetIndent 4]])
  end
})
