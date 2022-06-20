local PKGS = {
    'savq/paq-nvim';                  -- Let Paq manage itself
    'equalsraf/neovim-gui-shim';      -- gui commands for nvim-qt
    'EdenEast/nightfox.nvim';         -- colorscheme
    {'nvim-treesitter/nvim-treesitter', run=TSUpdate};
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

-- treesitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {"c_sharp", "python", "lua"},
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = true
    }
}
