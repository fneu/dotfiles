return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "Issafalcon/neotest-dotnet",
        },
        ft = {"cs"},
        config = function()
            require("neotest").setup(
                {
                    adapters = {
                        require("neotest-dotnet")({
                            custom_attributes = {
                                xunit = { "TmxFact" }
                            }
                        })
                    },
                    highlights = {
                        adapter_name = "Comment",
                        dir = "Directory",
                        expand_marker = "Comment",
                        failed = "Error",
                        file = "Normal",
                        focused = "NvimTreeSpecialFile",
                        indent = "Comment",
                        marked = "Visual",
                        namespace = "Normal",
                        passed = "diffAdded",
                        running = "DiagnosticWarn",
                        select_win = "DiagnosticVirtualTextInfo",
                        skipped = "Commend",
                        target = "NvimTreeRootFolder",
                        test = "DiagnosticInfo",
                        unknown = "Comment"
                    },
                    icons = {

                        child_indent = " ",
                        child_prefix = " ",
                        collapsed = "",
                        expanded = "",
                        failed = "",
                        final_child_indent = " ",
                        final_child_prefix = " ",
                        non_collapsible = " ",
                        passed = "",
                        running = "",
                        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
                        skipped = "",
                        unknown = ""
                    },
                    summary = {
                        animated = true,
                        enabled = true,
                        expand_errors = true,
                        follow = true,
                        mappings = {
                            attach = "a",
                            clear_marked = "M",
                            clear_target = "T",
                            debug = "d",
                            debug_marked = "D",
                            expand = { "<CR>", "<2-LeftMouse>" },
                            expand_all = "e",
                            jumpto = "i",
                            mark = "m",
                            next_failed = "J",
                            output = "o",
                            prev_failed = "K",
                            run = "r",
                            run_marked = "R",
                            short = "O",
                            stop = "u",
                            target = "t"
                        },
                        open = "botright vsplit | vertical resize 50"
                    }
                }
            )
            vim.keymap.set( "n", "<leader>tr", function() require"neotest".run.run() end, { desc="[T]est: [R]un nearest" })
            vim.keymap.set( "n", "<leader>tR", function() require"neotest".summary.run_marked() end, { desc="[T]est: run [M]arked" })
            vim.keymap.set( "n", "<leader>tl", function() require"neotest".run.run_last() end, { desc="[T]est: run [L]ast" })
            vim.keymap.set( "n", "<leader>ts", function() require"neotest".summary.toggle() end, { desc="[T]est: open [S]ummary" })
            vim.keymap.set( "n", "<leader>to", function() require"neotest".output.open({enter=true}) end, { desc="[T]est: show [O]utput" })
            vim.keymap.set( "n", "<leader>tO", function() require"neotest".output.open({enter=true, short=true}) end, { desc="[T]est: show short [O]utput" })
            vim.keymap.set( "n", "]t", function() require("neotest").jump.prev({ status = "failed" }) end , { desc="next failed [T]est"})
            vim.keymap.set( "n", "[t]", function()require("neotest").jump.next({ status = "failed" }) end , { desc="next failed [T]est"})
        end
    }
}
