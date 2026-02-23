local cursor_location = 0
vim.api.nvim_create_user_command('Link',
  function()
    cursor_location = vim.api.nvim_win_get_cursor(0)[1]
  end,
  {nargs=0}
)

vim.api.nvim_create_user_command('Jump',
  function()
    vim.api.nvim_win_set_cursor(0, {cursor_location, 0})
  end,
  {nargs=0}
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
