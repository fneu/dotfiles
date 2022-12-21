local ok, lsp = pcall(require, "lsp-zero")
if not ok then
    return
end

lsp.preset('recommended')
lsp.ensure_installed({
    'marksman', -- markdown
    'pylsp', --python
    'omnisharp', --c_sharp
    'lemminx', --xml
    'sumneko_lua', --lua
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
