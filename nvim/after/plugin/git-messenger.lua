local ok = vim.g.loaded_git_messenger == 1
if not ok then
    return
end

vim.cmd("let g:git_messenger_floating_win_opts = { 'border': 'single',}")
vim.g.git_messenger_no_default_mappings = true
vim.keymap.set('n', '<leader>gk', '<Plug>(git-messenger)', {})

-- set in telescope.lua:
-- <leader>gb -> search/checkout brances
-- <leader>gs -> search/apply stashes (stash in fugitive via czz)
