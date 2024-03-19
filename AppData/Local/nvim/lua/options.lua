vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "light"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.inccommand = 'split'

vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.showbreak = "↳ "
vim.opt.list = true
vim.opt.listchars = {
    tab = "→ ",
    nbsp = "␣",
    trail = "·",
    extends = "›",
    precedes = "‹"
}

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.updatetime = 250 -- CursorHold delay
vim.opt.timeoutlen = 300 -- decrease mapped sequence timeout

vim.opt.wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__"

vim.opt.fileformats = "unix,dos"  -- prever unix line endings

-- no folding by default, show start and end in foldtext
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.fillchars:append("fold: ")

-- powershell setup according to :h powershell
if vim.fn.has("win32") then
    vim.o.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
    vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellquote = ''
    vim.o.shellxquote = ''
end

