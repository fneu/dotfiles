-- theme
require('nightfox').setup({
    options = {
        styles = {
            comments="italic"
	}
    }
})
vim.cmd("colorscheme nightfox")

-- behaviour
vim.opt.mouse="a"
if vim.fn.has('win32') == 1 then
    vim.opt.shell='powershell.exe'
end
