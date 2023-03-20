--  SLIGHTLY MODIFIED BUT OTHERWISE UNEDITED VERSION OF
--  THEPRIMEAGEN'S LSP-ZERO CONFIG LUA FILE
-- CREDIT REFERENCE: https://www.youtube.com/watch?v=w7i4amO_zaE


local sign_opts = {}

if os.getenv("TERM") == 'linux' then
    sign_opts =
    {
        error = 'E',
        warn  = '!',
        hint  = '~',
        info  = 'i'
    }
else
    sign_opts =
    {
        error = '',
        warn =  '',
        hint =  '',
        info =  ''
    }
end

local lsp = require('lsp-zero')

lsp.preset(
{
    name = 'recommended',
    sign_icons = sign_opts,
    manage_nvim_cmp = true
})


lsp.ensure_installed(
{
    'lua_ls',
    --"rust_analyzer",
    'clangd'
})

local cmp = require('cmp')
cmp.register_source('nvim_lsp_signature_help', require('pluginmod.cmp_nvim_lsp_signature_help').new())

local cmp_select =
{
    behavior = cmp.SelectBehavior.Select
}

local cmp_mappings = lsp.defaults.cmp_mappings(
{
    ['<C-b>']     = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
    ['<C-Enter>'] = cmp.mapping.confirm({select = true}),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
})

lsp.setup_nvim_cmp(
{
    mapping = cmp_mappings,
    formatting = {
        -- changing the order of fields so the icon is the first
        fields = {'menu', 'abbr', 'kind'},
        -- here is where the change happens
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
                nvim_lua = 'Π',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lsp_signature_help'},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2},
    }

})





lsp.on_attach(
    function(client, bufnr)
        local opts = {buffer = bufnr, remap = false}

        local map =
            function(keys, cb)
                vim.keymap.set('n', keys, function() cb() end, opts)
            end
        if client.server_capabilities["documentSymbolProvider"] then
            require("nvim-navic").attach(client, bufnr)
        end
        local lsbuf = vim.lsp.buf
        local dgnstic = vim.diagnostic

        map('<leader>sd', lsbuf.definition)
        map('<leader>sm', lsbuf.hover)
        map('<leader>vws', lsbuf.workspace_symbol)
        map('<leader>vd', dgnstic.open_float)
        map('[d', dgnstic.goto_prev)
        map(']d', dgnstic.goto_next)
        map('<leader>vca', lsbuf.code_action)
        map('<leader>vrr', lsbuf.references)
        map('<leader>vrn', lsbuf.rename)
        vim.keymap.set('i', '<C-h>', function() lsbuf.signature_help() end, opts)
    end)

if string.sub(vim.api.nvim_buf_get_name(0), 1, 25)  == '/home/burton/.config/nvim' then
    lsp.nvim_workspace()
end


vim.diagnostic.config(
    {
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = true,
    })

lsp.setup()


