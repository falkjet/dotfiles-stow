local lspconfig = require "lspconfig"
local lspformat = require "lsp-format"

lspformat.setup {}

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

lspconfig.tailwindcss.setup{}

lspconfig.tsserver.setup{}

lspconfig.volar.setup{}

lspconfig.svelte.setup{}

lspconfig.clangd.setup{}

lspconfig.vala_ls.setup{}

lspconfig.rust_analyzer.setup{}

lspconfig.gopls.setup{ on_attach = lspformat.on_attach }
