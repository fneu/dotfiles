local PKGS = {
    'savq/paq-nvim';                  -- let Paq manage itself
    'equalsraf/neovim-gui-shim';      -- reliably load :Gui... commands on nvim-qt
    'mcchrish/zenbones.nvim';         -- colorscheme
    'rktjmp/lush.nvim';               -- customize zenbones
    'ggandor/leap.nvim';              -- movement
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
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
        },
    },
    indent = {
        enable = true
    }
}
