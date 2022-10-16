-- theme
require('nightfox').setup({
    options = {
        styles = {
            comments="italic"
	}
    }
})
vim.cmd("colorscheme nightfox")
vim.opt.guifont="MonoLisa:h10"

-- behaviour

vim.wo.foldmethod='expr'
vim.wo.foldexpr='nvim_treesitter#foldexpr()'

vim.opt.mouse="a"
if vim.fn.has('win32') == 1 then
    vim.opt.shell='powershell.exe'
end
