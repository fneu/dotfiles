vim.g.mapleader = " "

vim.keymap.set('n', '<leader>ri', '<cmd>lua reload_config()<CR>', {desc = 'Reload init.lua'})


vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {desc = 'Exit terminal-mode'})
