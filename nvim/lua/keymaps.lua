vim.g.mapleader = " "

-- compensate for German keyboard layout,
-- use ä and ö for tpope/vim-unimpaired style paired mappings
vim.keymap.set({'n', 'x', 'o'}, 'ö', '[', {remap=true, desc="pr[Ö]vious"})
vim.keymap.set({'n', 'x', 'o'}, 'ä', ']', {remap=true, desc="n[Ä]xt"})

-- move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", {desc="move selection down"})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", {desc="move selection up"})

--center after search
vim.keymap.set('n', 'n', 'nzz', {desc="search [N]ext and center"})
vim.keymap.set('n', 'N', 'Nzz', {desc="search previous and center"})

-- edit and apply config in dotfiles repo
vim.keymap.set('n', '<leader>ei', '<cmd>e '..find_dotfiles()..'\\nvim<CR>', {desc="[E]dit [I]nit.lua"})
vim.keymap.set('n', '<leader>ii', '<cmd>lua copy_config()<CR>', {desc="[I]nstall [I]nit.lua"})

-- TERMINAL
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l')
