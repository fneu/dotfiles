vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background="light"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.showbreak = "↳ "
vim.opt.list = true
vim.opt.listchars = {
    tab = "→ ",
    nbsp = "+",
    trail = "·",
    extends = "›",
    precedes = "‹",
}

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.updatetime = 500 -- CursorHold delay

vim.opt.wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__"

-- no folding by default, show start and end in foldtext
vim.opt.foldlevel       = 99
vim.opt.foldtext      = [[substitute(getline(v:foldstart),'\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.fillchars:append("fold: ")

-- powershell setup according to :h powershell
if vim.fn.has("win32") then
    vim.o.shell = 'powershell.exe'
    vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.o.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
    vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellquote=''
    vim.o.shellxquote=''
end
