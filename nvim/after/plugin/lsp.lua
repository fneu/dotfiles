local ok, lsp = pcall(require, "lsp-zero")
if not ok then
    return
end

lsp.preset('recommended')
lsp.ensure_installed({
    'pyright',
    'omnisharp',
    'sumneko_lua',
})
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'}
            }
        }
    }
})

lsp.setup()
