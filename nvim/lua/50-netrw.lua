-- comfort keymaps to open/close netrw
vim.keymap.set('n', '-', 
	':Neotree toggle<CR>', 
	{desc = "Open Neotree at the current file's directory"})
