-- comfort keymaps to open/close netrw
vim.keymap.set('n', '-', 
	':Ex<CR>', 
	{desc = "Open netrw at the current file's directory"})

vim.keymap.set('n', '_', 
	':Rex<CR>', 
	{desc = "Toggle between netrw and previous buffer"})

vim.keymap.set('n', '<leader>-', 
	":exe 'Explore' getcwd()<CR>", 
	{desc = "Open netrw at pwd"})

-- Open previous buffer, i.e. "quit netrw" after
-- opening a file in another split with 'v' or 'o'
local netrwGrp = vim.api.nvim_create_augroup("Netrw", { clear = true })
vim.api.nvim_create_autocmd(
    "filetype", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set('n', 'o', ':call <SNR>27_NetrwSplit(3)<CR><C-w><C-w>:Rex<CR>', {remap=true, buffer=true})
        vim.keymap.set('n', 'v', ':call <SNR>27_NetrwSplit(5)<CR><C-w><C-w>:Rex<CR>', {remap=true, buffer=true})
    end,
    group = netrwGrp,
})
