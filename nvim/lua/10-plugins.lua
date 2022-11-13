local PKGS = {
    -- the Paq package manager itself
    'savq/paq-nvim';
    -- :Gui... commands for nvim-qt
    -- this should be included, but manually install seems more reliable
    'equalsraf/neovim-gui-shim';
    -- Colorscheme
    'mcchrish/zenbones.nvim';
    -- Zenbones customization
    'rktjmp/lush.nvim';
    -- Jump movements
    -- s..
    -- dx..
    'ggandor/leap.nvim';
    -- show hex and rgb colors in their respective color
    'brenoprata10/nvim-highlight-colors';
    -- color matching parentheses.
    -- supported by zenbones
    'p00f/nvim-ts-rainbow';
    -- git
    'tpope/vim-fugitive';
    -- git blame popup
    'rhysd/git-messenger.vim';
    -- language understanding through syntax trees
    -- integrates with multiple other plugins
    {'nvim-treesitter/nvim-treesitter', run=TSUpdate};
    -- File tree
    -- TODO: decide between this, netrw, vinegar, and maybe telescope-something?
    -- this copys and pastes easy, which netrw cannot do without customization on windows
    -- git support is mediocre, cannot show new unstanged changes in a staged file
    {'nvim-neo-tree/neo-tree.nvim', branch='v2.x'};
    -- necessary for neotree
    'MunifTanjim/nui.nvim';
    -- necessary lua functions for neotree and telescope
    'nvim-lua/plenary.nvim';
    -- icons, need modified 'nerd font' 
    'kyazdani42/nvim-web-devicons';
    -- extensible fuzzy finder
    {'nvim-telescope/telescope.nvim', branch='0.1.x'};
    -- faster filtering for telescope
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }; -- scoop install make mingw
    -- structural search and replace
    'cshuaimin/ssr.nvim';
    -- vertical indentation guides
    'lukas-reineke/indent-blankline.nvim';
}

-- bootstrap package manager if required
local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    paq_bootstrap = vim.fn.system { 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', path }
    vim.cmd('packadd paq-nvim')
end

-- load and optionally install
local paq = require('paq'):setup({verbose=true})
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
        enable = true
    }
}
