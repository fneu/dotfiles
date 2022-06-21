require('fne.options')
require('fne.plugins')
require('fne.netrw')


vim.g.mapleader = " "

-- reload config
vim.keymap.set('n', '<leader>ri', '<cmd>lua reload_config()<CR>', {desc = 'Reload init.lua'})

function _G.reload_config()
  for name,_ in pairs(package.loaded) do
    if name:match('^fne') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("init.lua reloaded!", vim.log.levels.INFO)
end

-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
})

-- TERMINAL
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {desc = 'Exit terminal-mode'})
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h', {desc = 'Move away from terminal'})
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j', {desc = 'Move away from terminal'})
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k', {desc = 'Move away from terminal'})
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l', {desc = 'Move away from terminal'})

-- Keep active term windows in insert mode
local termGrp = vim.api.nvim_create_augroup("TermInsert", { clear = true })
vim.api.nvim_create_autocmd(
    {"TermOpen", "BufEnter", "WinEnter"}, {
    pattern = "term://*",
    command = "startinsert",
    group = termGrp,
})

-- Open all folds on buffer entry
local foldGrp = vim.api.nvim_create_augroup("OpenFolds", { clear = true })
vim.api.nvim_create_autocmd(
    {"BufWinEnter"}, {
    command = "normal zR",
    group = foldGrp,
})
