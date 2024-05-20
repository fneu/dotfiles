vim.g.mapleader = " "

-- compensate for German keyboard layout,
-- use ä and ö for tpope/vim-unimpaired style paired mappings
-- and ü to jump directly to marks
vim.keymap.set({"n", "x", "o"}, "ö", "[", {remap = true, desc = "pr[Ö]vious"})
vim.keymap.set({"n", "x", "o"}, "ä", "]", {remap = true, desc = "n[Ä]xt"})
vim.keymap.set({"n", "x", "o"}, "ü", "`", {remap = true, desc = "jump to mark"})

-- paired jumps
vim.keymap.set("n", "[q", ":cprev<CR>zz", {desc = "previous [Q]uickfix entry"})
vim.keymap.set("n", "]q", ":cnext<CR>zz", {desc = "next [Q]uickfix entry"})
vim.keymap.set("n", "[l", ":lprev<CR>zz", {desc = "previous [L]ocation entry"})
vim.keymap.set("n", "]l", ":lnext<CR>zz", {desc = "next [L]ocation entry"})

-- search and replace current word (case sensitive)
vim.keymap.set(
    "n",
    "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    {desc = "[S]earch and replace current word"}
)

-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "move selection down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "move selection up"})

-- deal with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

-- center after search
vim.keymap.set("n", "n", "nzzzv", {desc = "search [N]ext and center"})
vim.keymap.set("n", "N", "Nzzzv", {desc = "search previous and center"})

-- reset highlight on esc in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- pasting
vim.keymap.set("x", "<leader>p", '"_dP', {desc = "[P]aste without altering registers"})
vim.keymap.set(
    "n",
    "gV",
    [['`[' . strpart(getregtype(), 0, 1) . '`]']],
    {expr = true, desc = "select last inserted/pasted text"}
)

-- use alt + hjkl to resize windows
-- vim.keymap.set("n", "<M-j>", "<cmd>resize -2<CR>")
-- vim.keymap.set("n", "<M-k>", "<cmd>resize +2<CR>")
-- vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -2<CR>")
-- vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +2<CR>")

-- edit and apply config
vim.keymap.set("n", "<leader>cc", ":e $MYVIMRC<cr>", {desc = "edit [C]onfig"})
vim.keymap.set("n", "<leader>rs", load_snippets, {desc = "[R]eload [S]nippets"})

-- make terminal mode and movement less weird
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- copy filepath
vim.keymap.set("n", "yp", ":let @+ = expand('%:p')<cr>", {desc = "[Y]ank file[P]ath"})

-- Diagnostic keymaps
vim.keymap.set( "n", "öd", vim.diagnostic.goto_prev, {buffer = bufnr, desc = "pr[Ö]vious [D]iagnostic"})
vim.keymap.set("n", "äd", vim.diagnostic.goto_next, {buffer = bufnr, desc = "n[Ä]xt [D]iagnostic"})
vim.keymap.set( "n", "<leader>d", vim.diagnostic.open_float, {buffer = bufnr, desc = "Show [D]iagnostic Message"})
vim.keymap.set( "n", "<leader>l", vim.diagnostic.setloclist, {buffer = bufnr, desc = "buffer diagnostics to [L]oclist"})


-- Keybinds to make split navigation easier.
-- DISABLED BECAUSE OF COPILOT
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
