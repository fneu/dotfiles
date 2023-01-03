local ok = vim.g.loaded_fugitive == 1
if not ok then
    return
end


vim.keymap.set('n', '<leader>gg', ':G<cr>', {desc="[GG]it"})
vim.keymap.set('n', '<leader>gs', ':Git add %<cr>', {silent=true, desc="[G]it [S]tage"})
vim.keymap.set('n', '<leader>gS', ':Git add .<cr>', {silent=true, desc="[G]it [S]tage all"})
vim.keymap.set('n', '<leader>gu', ':silent Git reset -- %<cr>', {silent=true, desc="[G]it [U]nstage"})
vim.keymap.set('n', '<leader>gX', ':Gread<cr>:w<cr>', {desc="[G]it fugitive_[X] (discard changes)"})
vim.keymap.set('n', '<leader>gcc', ':Git commit<cr>', {desc="[G]it [CC]ommit"})
vim.keymap.set('n', '<leader>gp', ':Git pull<cr>', {desc="[G]it [P]ull"})
vim.keymap.set('n', '<leader>gP', ':Git push<cr>', {desc="[G]it [P]ush"})
vim.keymap.set('n', '<leader>grn', ':GRename ', {desc="[G]it [R]e[N]ame"})
vim.keymap.set('n', '<leader>gmv', ':GMove <C-r>%', {desc="[G]it [M]o[V]e"})
vim.keymap.set('n', '<leader>grm', ':GRemove<cr>', {desc="[G]it [R]e[M]ove"})
vim.keymap.set('n', '<leader>gw', ':Gwrite!<cr>', {desc="[G]it [W]rite"})
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<cr>', {desc="[G]it [D]iff"})

vim.keymap.set('n', '<leader>gD', ':Git difftool<cr>', {desc="[G]it [D]ifftool"})
vim.keymap.set('n', '<leader>gM', ':Git mergetool<cr>', {desc="[G]it [M]ergetool"})

