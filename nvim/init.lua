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

-- reload config
vim.keymap.set('n', '<leader>ri', '<cmd>lua reload_config()<CR>', {desc = 'Reload init.lua'})

function _G.reload_config()
  -- all packages starting with 00- to 99- will be reloaded, and init.lua will be reread.
  -- this might fail to update some plugin configs as their packages will not be reloaded
  for name,_ in pairs(package.loaded) do
    if name:match('^%d%d%-') then
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
