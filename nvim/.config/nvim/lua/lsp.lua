local lspconfig = require "lspconfig"

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
end

lspconfig.pyright.setup{
    on_attach = on_attach
}

lspconfig.emmet_ls.setup{
    on_attach = on_attach,
    filetypes = {
        'html',
        'typescriptreact',
        'javascriptreact',
        'css',
        'sass',
        'scss',
        'less',
        'jinja',
    },
}

lspconfig.tsserver.setup{}

lspconfig.svelte.setup{}
lspconfig.vala_ls.setup{}
