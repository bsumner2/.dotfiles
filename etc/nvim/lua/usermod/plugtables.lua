local def_github_theme_opts =
{
    comment_style = 'bold',
    dark_float = true,
    dev = false,
    dark_sidebar = true,
    transparent = false,
    hide_end_of_buffer = true,
    theme_style = 'dark'
}


local ret =
{
    github_opts = function(dark, transparency)
        local return_table = def_github_theme_opts
        return_table.transparent = transparency
        return_table.theme_style = dark and 'dark' or 'light'
        return return_table
    end,
    gruvbox_opts = function(dark, transparent)
        local ret = { }
        ret.undercurl = true
        ret.underline = true
        ret.bold = true
        ret.italic = true
        ret.strikethroug = true
        ret.invert_selection = true
        ret.invert_signs = true
        ret.invert_tabline = false
        ret.invert_intend_guides = false
        ret.inverse = true
        ret.contrast = 'hard'
        ret.palette_overrides = {}
        ret.overrides = {}
        vim.o.background = dark and 'dark' or 'light'
        ret.dim_inactive = true
        ret.transparent_mode = transparent
        return ret
    end

}


return ret

