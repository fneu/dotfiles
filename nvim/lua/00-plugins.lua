local PKGS = {
    'savq/paq-nvim';                  -- let Paq manage itself
    'equalsraf/neovim-gui-shim';      -- reliably load :Gui... commands on nvim-qt
    'mcchrish/zenbones.nvim';         -- colorscheme
    'rktjmp/lush.nvim';               -- customize zenbones
    'ggandor/leap.nvim';              -- movement
    'brenoprata10/nvim-highlight-colors';
    'p00f/nvim-ts-rainbow';           -- colored parentheses
    'tpope/vim-fugitive';
    {'nvim-treesitter/nvim-treesitter', run=TSUpdate};
    {'nvim-neo-tree/neo-tree.nvim', branch='v2.x'};
    'nvim-lua/plenary.nvim';
    'kyazdani42/nvim-web-devicons';
    'MunifTanjim/nui.nvim';
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
    ensure_installed = {"c_sharp", "python", "lua", "json", "markdown"},
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
    },
    rainbow = {
        enable = true,
        colors = {
            '#A8334C', '#4F6C31', '#944927', '#286486',
            '#88507D', '#3B8992', '#2C363C', '#94253E',
            '#3F5A22', '#803D1C', '#1D5573', '#7B3B70',
            '#2B747C', '#4F5E68'
        }
    }
}
