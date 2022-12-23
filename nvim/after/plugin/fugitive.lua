local ok = vim.g.loaded_fugitive == 1
if not ok then
    return
end

vim.keymap.set('n', '<leader>gg', ':G<cr>', {})
vim.keymap.set('n', '<leader>gr', ':GRename ', {})
vim.keymap.set('n', '<leader>gm', ':GMove <C-r>%', {})
vim.keymap.set('n', '<leader>gx', ':GRemove<cr>', {})
vim.keymap.set('n', '<leader>gw', ':Gwrite!<cr>', {})
vim.keymap.set('n', '<leader>gc', ':Git commit<cr>', {})
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<cr>', {})

vim.keymap.set('n', '<leader>gD', ':Git difftool<cr>', {})
vim.keymap.set('n', '<leader>gM', ':Git mergetool<cr>', {})

vim.keymap.set('n', '<leader>gp', ':Git pull<cr>', {})
vim.keymap.set('n', '<leader>gP', ':Git push<cr>', {})
