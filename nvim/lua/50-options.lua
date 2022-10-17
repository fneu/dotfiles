vim.o.tabstop=8                       -- size of actual tab chars
vim.o.softtabstop=4                   -- 'width' of a tab inserting operation
vim.o.shiftwidth=4                    -- 'width' of an indenting operation
vim.o.expandtab=true                  -- indent using spaces instead of tabs

vim.wo.foldmethod='expr'
vim.wo.foldexpr='nvim_treesitter#foldexpr()'

vim.opt.mouse="a"
if vim.fn.has('win32') == 1 then
    vim.opt.shell='powershell.exe'
end
