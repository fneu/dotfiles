vim.g.mapleader = " "

-- compensate for German keyboard layout,
-- use ä and ö for tpope/vim-unimpaired style paired mappings
vim.keymap.set({'n', 'x', 'o'}, 'ö', '[', {remap=true, desc="pr[Ö]vious"})
vim.keymap.set({'n', 'x', 'o'}, 'ä', ']', {remap=true, desc="n[Ä]xt"})

-- paired jumps
vim.keymap.set('n', '[q', ':cprev<CR>zz', {desc="previous [Q]uickfix entry"})
vim.keymap.set('n', ']q', ':cnext<CR>zz', {desc="next [Q]uickfix entry"})
vim.keymap.set('n', '[l', ':lprev<CR>zz', {desc="previous [L]ocation entry"})
vim.keymap.set('n', ']l', ':lnext<CR>zz', {desc="next [L]ocation entry"})

-- search and replace current word (case sensitive)
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', {desc="[S]earch and replace current word"})

-- move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", {desc="move selection down"})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", {desc="move selection up"})
vim.keymap.set('v', '<', "<gv", {desc="unindent selection"})
vim.keymap.set('v', '>', ">gv", {desc="indent selection"})

-- deal with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- center after search
vim.keymap.set('n', 'n', 'nzzzv', {desc="search [N]ext and center"})
vim.keymap.set('n', 'N', 'Nzzzv', {desc="search previous and center"})

-- pasting
vim.keymap.set('x', '<leader>p', '\"_dP', {desc="[P]aste without altering registers"})

-- edit and apply config in dotfiles repo
vim.keymap.set('n', '<leader>ei', '<cmd>e '..find_dotfiles()..'\\nvim<CR>', {desc="[E]dit [I]nit.lua"})
vim.keymap.set('n', '<leader>ii', '<cmd>lua copy_config()<CR>', {desc="[I]nstall [I]nit.lua"})

-- make terminal mode and movement less weird
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l')

