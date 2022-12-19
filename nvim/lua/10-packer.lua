-- Install packer if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    -- :Gui... commands for nvim-qt in ginit.vim
    -- this should be included with nvim-qt, but a manual install seems more reliable
    use 'equalsraf/neovim-gui-shim';

    -- Theme
    use {
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim"
    }
    use 'p00f/nvim-ts-rainbow';
    use 'brenoprata10/nvim-highlight-colors';
    use 'lukas-reineke/indent-blankline.nvim';

    -- Editing
    use 'ggandor/leap.nvim' -- jump movements like s..  dx..
    use 'cshuaimin/ssr.nvim' -- structural search and replace <leader>sr

    -- Git
    use 'tpope/vim-fugitive';
    use 'rhysd/git-messenger.vim';

    -- Navigation
    -- alternative file trees:
    --  - nvim-tree: slow/hangs (windows), can't copy multiple files, less clear git status
    --  - netrw/vinegar: needs setup to copy on windows
    --  - dirbuf: great, but too simple, cannot copy to different folder. Maybe in addition?
    --  - telescope-file-browser: need to check it out again, copying was complicated
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = 
        {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make' -- scoop install make mingw
            }
        }
    }

    use({
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "nvim-treesitter/nvim-treesitter-context", -- function context at top, not required, maybe remove alltogether?
        },
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    })

    if is_bootstrap then
        require("packer").sync()
    end
end)
