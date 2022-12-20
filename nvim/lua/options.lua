vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 8                       -- size of actual tab chars
vim.opt.softtabstop = 4                   -- 'width' of a tab inserting operation
vim.opt.shiftwidth = 4                    -- 'width' of an indenting operation
vim.opt.expandtab = true                       -- indent using spaces instead of tabs
vim.opt.smartindent = true  -- improved autoindent in places

vim.opt.ignorecase = true                      -- case insensitive search ...
vim.opt.smartcase = true                      -- ... unless pattern contains capitals

vim.opt.wrap = false -- no linewrap by default

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.background="light"

vim.opt.scrolloff = 8                     -- always show n lines above/below cursor
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 500  -- time in ms to CursorHold event

vim.opt.wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__"

vim.opt.showbreak = "↳ "  -- start of lines that have been wrapped
vim.opt.listchars = {
    tab = "→ ",
    nbsp = "+",
    trail = "·",
    extends = "›",
    precedes = "‹",
}

vim.opt.list = true                            -- highlight above chars respectively

-- no folding by default, show start and end in foldtext
-- https://www.reddit.com/r/neovim/comments/njew3z/comment/hgvb6n7
vim.opt.fillchars       = "fold: "
vim.opt.foldlevel       = 99
vim.opt.foldtext      = [[substitute(getline(v:foldstart),'\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

-- see :help shell-powershell
vim.o.shell = 'powershell.exe'
vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
vim.o.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellquote=''
vim.o.shellxquote=''
