--
-- Bootstrap mini.deps
--

local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim",
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

--
-- General Options
--

vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.inccommand = "split"

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
    precedes = "‹",
}

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.updatetime = 250 -- CursorHold delay

vim.opt.wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__"

-- vim.opt.fileformats = "unix,dos"  -- prefer unix line endings

-- no folding by default, show start and end in foldtext
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.fillchars:append("fold: ")

-- powershell setup according to :h powershell
if vim.fn.has("win32") then
    vim.o.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.o.shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
end

--
-- Keymaps
--

vim.g.mapleader = " "

-- compensate for German keyboard layout,
-- use ä and ö for tpope/vim-unimpaired style paired mappings
vim.keymap.set({ "n", "x", "o" }, "ö", "[", { remap = true, desc = "pr[Ö]vious" })
vim.keymap.set({ "n", "x", "o" }, "ä", "]", { remap = true, desc = "n[Ä]xt" })

-- paired jumps
vim.keymap.set("n", "[q", ":cprev<CR>zz", { desc = "previous [Q]uickfix entry" })
vim.keymap.set("n", "]q", ":cnext<CR>zz", { desc = "next [Q]uickfix entry" })
vim.keymap.set("n", "[Q", ":cfirst<CR>zz", { desc = "first [Q]uickfix entry" })
vim.keymap.set("n", "]Q", ":clast<CR>zz", { desc = "last [Q]uickfix entry" })
vim.keymap.set("n", "[l", ":lprev<CR>zz", { desc = "previous [L]ocation entry" })
vim.keymap.set("n", "]l", ":lnext<CR>zz", { desc = "next [L]ocation entry" })
vim.keymap.set("n", "[L", ":lfirst<CR>zz", { desc = "first [L]ocation entry" })
vim.keymap.set("n", "]L", ":llast<CR>zz", { desc = "last [L]ocation entry" })

-- search and replace current word (case sensitive)
vim.keymap.set(
    "n",
    "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "[S]earch and replace current word" }
)

-- move selected lines up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- navigate single virtual lines if `wrap` is on
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- center after search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- reset highlight on esc in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- select recently pasted text
vim.keymap.set(
    "n",
    "gV",
    [['`[' . strpart(getregtype(), 0, 1) . '`]']],
    { expr = true, desc = "select last inserted/pasted text" }
)

-- escape the terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
-- TODO: are these necessary?
-- vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h")
-- vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j")
-- vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k")
-- vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- copy filepath
vim.keymap.set("n", "yp", ":let @+ = expand('%:p')<cr>", { desc = "[Y]ank file[P]ath" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show [D]iagnostic Message" })
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "buffer diagnostics to [L]oclist" })

-- Toggle stuff
local function opt_toggle(opt, on, off, name)
    local message = name
    if vim.opt[opt]:get() == off then
        vim.opt[opt] = on
        message = message .. " enabled"
    else
        vim.opt[opt] = off
        message = message .. " disabled"
    end
    vim.notify(message)
end

vim.keymap.set("n", "<leader>tn", function()
    opt_toggle("number", true, false, "Line Numbers")
end, { desc = "[T]oggle line [N]umbers" })
vim.keymap.set("n", "<leader>tr", function()
    opt_toggle("relativenumber", true, false, "Relative line Numbers")
end, { desc = "[T]oggle [R]elative line numbers" })
vim.keymap.set("n", "<leader>tw", function()
    opt_toggle("wrap", true, false, "Word wrap")
end, { desc = "[T]oggle [W]rap" })
vim.keymap.set("n", "<leader>tb", function()
    opt_toggle("background", "light", "dark", "Light")
end, { desc = "[T]oggle [B]ackground" })

--
-- Autocmds
--

-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = yankGrp,
    pattern = "*",
})

-- Local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end,
})
