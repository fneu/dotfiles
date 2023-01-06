-- Install packer if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(
    function(use)
        use "wbthomason/packer.nvim"

        -- :Gui... commands for nvim-qt in ginit.vim
        -- this should be included with nvim-qt, but a manual install seems more reliable
        use "equalsraf/neovim-gui-shim"

        -- Theme
        use {
            "mcchrish/zenbones.nvim",
            requires = "rktjmp/lush.nvim"
        }
        use "p00f/nvim-ts-rainbow"
        use "brenoprata10/nvim-highlight-colors"
        use "lukas-reineke/indent-blankline.nvim"

        -- Editing
        use "ggandor/leap.nvim" -- jump movements like s..  dx..
        use "cshuaimin/ssr.nvim" -- structural search and replace <leader>sr

        -- Git
        use "tpope/vim-fugitive"
        use "rhysd/git-messenger.vim"

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
                "MunifTanjim/nui.nvim"
            }
        }

        use {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            requires = {
                "nvim-lua/plenary.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    run = "make" -- scoop install make mingw
                },
                {'nvim-telescope/telescope-ui-select.nvim' }
            }
        }

        use(
            {
                "nvim-treesitter/nvim-treesitter",
                requires = {
                    "nvim-treesitter/nvim-treesitter-context" -- function context at top, not required, maybe remove alltogether?
                },
                run = function()
                    local ts_update = require("nvim-treesitter.install").update({with_sync = true})
                    ts_update()
                end
            }
        )

        use {
            -- Additional text objects via treesitter
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter"
        }

        use {
            "VonHeikemen/lsp-zero.nvim",
            requires = {
                -- LSP Support
                {"neovim/nvim-lspconfig"},
                {"williamboman/mason.nvim"},
                {"williamboman/mason-lspconfig.nvim"},
                {"Issafalcon/lsp-overloads.nvim"}, -- show multiple constructors in signature help
                {"Hoffs/omnisharp-extended-lsp.nvim"}, -- go to definition in nugets/system dlls
                -- Autocompletion
                {"hrsh7th/nvim-cmp"},
                {"hrsh7th/cmp-buffer"},
                {"hrsh7th/cmp-path"},
                {"saadparwaiz1/cmp_luasnip"},
                {"hrsh7th/cmp-nvim-lsp"},
                {"hrsh7th/cmp-nvim-lua"},
                -- Snippets
                {"L3MON4D3/LuaSnip"}
                --{'rafamadriz/friendly-snippets'},
            }
        }

        -- lsp status
        use "j-hui/fidget.nvim"

        -- this supports block comments that mini.comment doesn't
        -- this supports i.e. word comments that mini.comment doesn't, useful for commenting out parameters with `gcaa` etc
        -- mini.comment includes a `gc` textobject that this doesn't
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }

        use {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup {}
            end
        }

        use(
            {
                "kylechui/nvim-surround",
                tag = "*", -- Use for stability; omit to use `main` branch for the latest features
                config = function()
                    require("nvim-surround").setup(
                        {
                            keymaps = {
                                insert = "<C-g>s",
                                normal = "ys",
                                normal_cur = "yss",
                                visual = "S",
                                delete = "ds",
                                change = "cs",
                                -- necessary for linewise addition of normal visual selection
                                insert_line = "<C-g>S",
                                normal_line = "yS",
                                normal_cur_line = "ySS",
                                visual_line = "gS"
                            }
                        }
                    )
                end
            }
        )

        if is_bootstrap then
            require("packer").sync()
        end
    end
)

-- filter qflist
vim.cmd 'packadd cfilter'
