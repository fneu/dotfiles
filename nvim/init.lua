-- load files from /lua folder
-- they should start with a 2-digit number
-- lower numbers are loaded first
for _, path in pairs(vim.fn.glob(vim.fn.stdpath('config')..'/lua/*', 0, 1)) do
    filename, _ = path:gsub('\\', '/')
    filename = filename:match('.+/(%d%d%-.*).lua$')
    if filename then
        require(filename)
    end
end

vim.g.mapleader = " "

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
