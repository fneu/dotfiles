local PKGS = {
    'savq/paq-nvim';                  -- Let Paq manage itself
    'equalsraf/neovim-gui-shim';      -- gui commands for nvim-qt
    'EdenEast/nightfox.nvim';         -- colorscheme
}

-- bootstrap package manager if required
local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    paq_bootstrap = vim.fn.system { 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', path }
    vim.cmd('packadd paq-nvim')
end

-- load and optionally install
local paq = require('paq')
paq(PKGS)
if paq_bootstrap then
    paq.install()
end
