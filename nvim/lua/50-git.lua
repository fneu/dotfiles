-- fugitive
vim.keymap.set('n', '<leader>gg', ':G<cr>', {})
vim.keymap.set('n', '<leader>gr', ':GRename ', {})
vim.keymap.set('n', '<leader>gm', ':GMove <C-r>%', {})
vim.keymap.set('n', '<leader>gx', ':GRemove<cr>', {})
vim.keymap.set('n', '<leader>gw', ':GWrite<cr>', {})
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<cr>', {})

vim.keymap.set('n', '<leader>gD', ':Git difftool<cr>', {})
vim.keymap.set('n', '<leader>gM', ':Git mergetool<cr>', {})

-- GitMessenger
vim.g.git_messenger_no_default_mappings = true
vim.keymap.set('n', '<leader>gk', '<Plug>(git-messenger)', {})

-- set in telescope.lua:
-- <leader>gb -> search/checkout brances
-- <leader>gs -> search/apply stashes (stash in fugitive via czz)
