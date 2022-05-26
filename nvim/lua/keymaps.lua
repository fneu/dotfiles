vim.g.mapleader = " "

vim.keymap.set('n', '<leader>ri', '<cmd>lua reload_config()<CR>', {desc = 'Reload init.lua'})


-- Terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {desc = 'Exit terminal-mode'})
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h', {desc = 'Move away from terminal'})
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j', {desc = 'Move away from terminal'})
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k', {desc = 'Move away from terminal'})
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l', {desc = 'Move away from terminal'})
