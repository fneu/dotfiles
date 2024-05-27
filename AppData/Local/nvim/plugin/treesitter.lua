MiniDeps.later(function()
    MiniDeps.add({
        source = "nvim-treesitter/nvim-treesitter-textobjects",
        depends = {
            {
                source = "nvim-treesitter/nvim-treesitter",
                hooks = {
                    post_checkout = function()
                        vim.cmd("TSUpdate")
                    end,
                },
            },
        },
    })

    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "c_sharp",
            "css",
            "diff",
            "haskell",
            "html",
            "lua",
            "lua",
            "markdown",
            "python",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        indent = { enable = true },
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            disable = { "help", "markdown" },
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<BS>",
                scope_incremental = "<C-s>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["agc"] = "@comment.outer",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                    ["]a"] = "@parameter.inner",
                    ["]gc"] = "@comment.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                    ["]A"] = "@parameter.inner",
                    ["]GC"] = "@comment.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                    ["[a"] = "@parameter.inner",
                    ["[gc"] = "@comment.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                    ["[A"] = "@parameter.inner",
                    ["[GC"] = "@comment.outer",
                },
            },
        },
    })
end)
