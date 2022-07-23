local cmp = require "cmp"
local luasnip = require "luasnip"

local next_item = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end, {"i", "s"})

local prev_item = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end, {"i", "s"})

cmp.setup{
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm{ select = true },
        ["<tab>"] = next_item,
        ["<s-tab>"] = prev_item,
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'vsnip'},
    }, {
        {name = 'buffer'},
    })
}


