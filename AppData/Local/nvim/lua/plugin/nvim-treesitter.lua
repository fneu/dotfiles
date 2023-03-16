return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context", -- function context at top, not required, maybe remove alltogether?
            "HiPhish/nvim-ts-rainbow2",
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        build = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
        config = function(_, _)
            require "nvim-treesitter.configs".setup {
                ensure_installed = { "c_sharp", "python", "lua", "vim", "json", "markdown", "help" },
                highlight = {
                    enable = true,
                    -- as there is no treesitter syntax for xml available yet,
                    -- this is necessary for xml folding
                    additional_vim_regex_highlighting = { "xml" }
                },
                incremental_selection = {
                    enable = true,
                    disable = { "help", "markdown" },
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<S-CR>",
                        scope_incremental = "<C-s>"
                    }
                },
                indent = {
                    enable = true
                },
                rainbow = {
                    enable = true,
                    query = {
                        'rainbow-parens',
                        c_sharp = 'rainbow-parens-custom',
                    },
                    hlgroups = {
                        "RainbowRose",
                        "RainbowWater",
                        "RainbowWood",
                        "RainbowLeaf",
                        "RainbowBlossom",
                        "RainbowSky",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["agc"] = "@comment.outer"
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                            ["]a"] = "@parameter.inner",
                            ["]gc"] = "@comment.outer"
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                            ["]A"] = "@parameter.inner",
                            ["]GC"] = "@comment.outer"
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                            ["[a"] = "@parameter.inner",
                            ["[gc"] = "@comment.outer"
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[C"] = "@class.outer",
                            ["[A"] = "@parameter.inner",
                            ["[GC"] = "@comment.outer"
                        }
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner"
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner"
                        }
                    }
                }
            }

            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        end
    }
}
