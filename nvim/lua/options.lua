vim.o.tabstop=8                       -- size of actual tab chars
vim.o.softtabstop=4                   -- 'width' of a tab inserting operation
vim.o.shiftwidth=4                    -- 'width' of an indenting operation
vim.o.expandtab=true                  -- indent using spaces instead of tabs

vim.wo.foldmethod='expr'
vim.wo.foldexpr='nvim_treesitter#foldexpr()'

vim.opt.mouse="a"

-- see :help shell-powershell
vim.o.shell = 'powershell.exe'
vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
vim.o.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellquote=''
vim.o.shellxquote=''
